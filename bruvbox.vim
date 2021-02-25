" -----------------------------------------------------------------------------
" File: bruvbox.vim
" Description: Low contrast, desaturated clone of gruvbox with greener greens.
" Author: stevensonmt
" Source: 
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='bruvbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:bruvbox_bold')
  let g:bruvbox_bold=1
endif
if !exists('g:bruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:bruvbox_italic=1
  else
    let g:bruvbox_italic=0
  endif
endif
if !exists('g:bruvbox_undercurl')
  let g:bruvbox_undercurl=1
endif
if !exists('g:bruvbox_underline')
  let g:bruvbox_underline=1
endif
if !exists('g:bruvbox_inverse')
  let g:bruvbox_inverse=1
endif

if !exists('g:bruvbox_guisp_fallback') || index(['fg', 'bg'], g:bruvbox_guisp_fallback) == -1
  let g:bruvbox_guisp_fallback='NONE'
endif

if !exists('g:bruvbox_improved_strings')
  let g:bruvbox_improved_strings=0
endif

if !exists('g:bruvbox_improved_warnings')
  let g:bruvbox_improved_warnings=0
endif

if !exists('g:bruvbox_termcolors')
  let g:bruvbox_termcolors=256
endif

if !exists('g:bruvbox_invert_indent_guides')
  let g:bruvbox_invert_indent_guides=0
endif

if exists('g:bruvbox_contrast')
  echo 'g:bruvbox_contrast is deprecated; use g:bruvbox_contrast_light and g:bruvbox_contrast_dark instead'
endif

if !exists('g:bruvbox_contrast_dark')
  let g:bruvbox_contrast_dark='medium'
endif

if !exists('g:bruvbox_contrast_light')
  let g:bruvbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#bb5a6c', 167]     " 251-73-52
let s:gb.bright_green   = ['#5da958', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#f7f581', 214]     " 250-189-47
let s:gb.bright_blue    = ['#7387a9', 109]     " 131-165-152
let s:gb.bright_purple  = ['#a973a1', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#73a9a8', 108]     " 142-192-124
let s:gb.bright_orange  = ['#e1b95a', 208]     " 254-128-25

let s:gb.neutral_red    = ['#bb7985', 124]     " 204-36-29
let s:gb.neutral_green  = ['#83a980', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#f7f6bc', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#8e98a9', 66]      " 69-133-136
let s:gb.neutral_purple = ['#a98ea5', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#8ea9a9', 72]      " 104-157-106
let s:gb.neutral_orange = ['#e1c37c', 166]     " 214-93-14

let s:gb.faded_red      = ['#bb999f', 88]      " 157-0-6
let s:gb.faded_green    = ['#96a995', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#f7f7da', 136]     " 181-118-20
let s:gb.faded_blue     = ['#a2a5a9', 24]      " 7-102-120
let s:gb.faded_purple   = ['#a99ba7', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#9ba9a9', 66]      " 66-123-88
let s:gb.faded_orange   = ['#e1cd9d', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:bruvbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:bruvbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:bruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:bruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:bruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:bruvbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:bruvbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:bruvbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:bruvbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:bruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:bruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:bruvbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:bruvbox_number_column')
  let s:number_column = get(s:gb, g:bruvbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:bruvbox_sign_column')
    let s:sign_column = get(s:gb, g:bruvbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:bruvbox_color_column')
  let s:color_column = get(s:gb, g:bruvbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:bruvbox_vert_split')
  let s:vert_split = get(s:gb, g:bruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:bruvbox_invert_signs')
  if g:bruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:bruvbox_invert_selection')
  if g:bruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:bruvbox_invert_tabline')
  if g:bruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:bruvbox_italicize_comments')
  if g:bruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:bruvbox_italicize_strings')
  if g:bruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:bruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:bruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Bruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('BruvboxFg0', s:fg0)
call s:HL('BruvboxFg1', s:fg1)
call s:HL('BruvboxFg2', s:fg2)
call s:HL('BruvboxFg3', s:fg3)
call s:HL('BruvboxFg4', s:fg4)
call s:HL('BruvboxGray', s:gray)
call s:HL('BruvboxBg0', s:bg0)
call s:HL('BruvboxBg1', s:bg1)
call s:HL('BruvboxBg2', s:bg2)
call s:HL('BruvboxBg3', s:bg3)
call s:HL('BruvboxBg4', s:bg4)

call s:HL('BruvboxRed', s:red)
call s:HL('BruvboxRedBold', s:red, s:none, s:bold)
call s:HL('BruvboxGreen', s:green)
call s:HL('BruvboxGreenBold', s:green, s:none, s:bold)
call s:HL('BruvboxYellow', s:yellow)
call s:HL('BruvboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('BruvboxBlue', s:blue)
call s:HL('BruvboxBlueBold', s:blue, s:none, s:bold)
call s:HL('BruvboxPurple', s:purple)
call s:HL('BruvboxPurpleBold', s:purple, s:none, s:bold)
call s:HL('BruvboxAqua', s:aqua)
call s:HL('BruvboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('BruvboxOrange', s:orange)
call s:HL('BruvboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('BruvboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('BruvboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('BruvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('BruvboxBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('BruvboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('BruvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('BruvboxOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/bruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg4, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText BruvboxBg2
hi! link SpecialKey BruvboxBg2

call s:HL('Visual',    s:none,  s:bg4, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory BruvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title BruvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg BruvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg BruvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question BruvboxOrangeBold
" Warning messages
hi! link WarningMsg BruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:bruvbox_improved_strings == 0
  hi! link Special BruvboxOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement BruvboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional BruvboxRed
" for, do, while, etc.
hi! link Repeat BruvboxRed
" case, default, etc.
hi! link Label BruvboxRed
" try, catch, throw
hi! link Exception BruvboxRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword BruvboxRed

" Variable name
hi! link Identifier BruvboxBlue
" Function name
hi! link Function BruvboxGreenBold

" Generic preprocessor
hi! link PreProc BruvboxAqua
" Preprocessor #include
hi! link Include BruvboxAqua
" Preprocessor #define
hi! link Define BruvboxAqua
" Same as Define
hi! link Macro BruvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit BruvboxAqua

" Generic constant
hi! link Constant BruvboxPurple
" Character constant: 'c', '/n'
hi! link Character BruvboxPurple
" String constant: "this is a string"
if g:bruvbox_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean BruvboxPurple
" Number constant: 234, 0xff
hi! link Number BruvboxPurple
" Floating point constant: 2.3e10
hi! link Float BruvboxPurple

" Generic type
hi! link Type BruvboxYellow
" static, register, volatile, etc
hi! link StorageClass BruvboxOrange
" struct, union, enum, etc.
hi! link Structure BruvboxAqua
" typedef
hi! link Typedef BruvboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:bruvbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:bruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd BruvboxGreenSign
hi! link GitGutterChange BruvboxAquaSign
hi! link GitGutterDelete BruvboxRedSign
hi! link GitGutterChangeDelete BruvboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile BruvboxGreen
hi! link gitcommitDiscardedFile BruvboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd BruvboxGreenSign
hi! link SignifySignChange BruvboxAquaSign
hi! link SignifySignDelete BruvboxRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign BruvboxRedSign
hi! link SyntasticWarningSign BruvboxYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   BruvboxBlueSign
hi! link SignatureMarkerText BruvboxPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl BruvboxBlueSign
hi! link ShowMarksHLu BruvboxBlueSign
hi! link ShowMarksHLo BruvboxBlueSign
hi! link ShowMarksHLm BruvboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch BruvboxYellow
hi! link CtrlPNoEntries BruvboxRed
hi! link CtrlPPrtBase BruvboxBg2
hi! link CtrlPPrtCursor BruvboxBlue
hi! link CtrlPLinePre BruvboxBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket BruvboxFg3
hi! link StartifyFile BruvboxFg1
hi! link StartifyNumber BruvboxBlue
hi! link StartifyPath BruvboxGray
hi! link StartifySlash BruvboxGray
hi! link StartifySection BruvboxYellow
hi! link StartifySpecial BruvboxBg2
hi! link StartifyHeader BruvboxOrange
hi! link StartifyFooter BruvboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign BruvboxRedSign
hi! link ALEWarningSign BruvboxYellowSign
hi! link ALEInfoSign BruvboxBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail BruvboxAqua
hi! link DirvishArg BruvboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir BruvboxAqua
hi! link netrwClassify BruvboxAqua
hi! link netrwLink BruvboxGray
hi! link netrwSymLink BruvboxFg1
hi! link netrwExe BruvboxYellow
hi! link netrwComment BruvboxGray
hi! link netrwList BruvboxBlue
hi! link netrwHelpCmd BruvboxAqua
hi! link netrwCmdSep BruvboxFg3
hi! link netrwVersion BruvboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir BruvboxAqua
hi! link NERDTreeDirSlash BruvboxAqua

hi! link NERDTreeOpenable BruvboxOrange
hi! link NERDTreeClosable BruvboxOrange

hi! link NERDTreeFile BruvboxFg1
hi! link NERDTreeExecFile BruvboxYellow

hi! link NERDTreeUp BruvboxGray
hi! link NERDTreeCWD BruvboxGreen
hi! link NERDTreeHelp BruvboxFg1

hi! link NERDTreeToggleOn BruvboxGreen
hi! link NERDTreeToggleOff BruvboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign BruvboxRedSign
hi! link CocWarningSign BruvboxOrangeSign
hi! link CocInfoSign BruvboxYellowSign
hi! link CocHintSign BruvboxBlueSign
hi! link CocErrorFloat BruvboxRed
hi! link CocWarningFloat BruvboxOrange
hi! link CocInfoFloat BruvboxYellow
hi! link CocHintFloat BruvboxBlue
hi! link CocDiagnosticsError BruvboxRed
hi! link CocDiagnosticsWarning BruvboxOrange
hi! link CocDiagnosticsInfo BruvboxYellow
hi! link CocDiagnosticsHint BruvboxBlue

hi! link CocSelectedText BruvboxRed
hi! link CocCodeLens BruvboxGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded BruvboxGreen
hi! link diffRemoved BruvboxRed
hi! link diffChanged BruvboxAqua

hi! link diffFile BruvboxOrange
hi! link diffNewFile BruvboxYellow

hi! link diffLine BruvboxBlue

" }}}
" Html: {{{

hi! link htmlTag BruvboxBlue
hi! link htmlEndTag BruvboxBlue

hi! link htmlTagName BruvboxAquaBold
hi! link htmlArg BruvboxAqua

hi! link htmlScriptTag BruvboxPurple
hi! link htmlTagN BruvboxFg1
hi! link htmlSpecialTagName BruvboxAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar BruvboxOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag BruvboxBlue
hi! link xmlEndTag BruvboxBlue
hi! link xmlTagName BruvboxBlue
hi! link xmlEqual BruvboxBlue
hi! link docbkKeyword BruvboxAquaBold

hi! link xmlDocTypeDecl BruvboxGray
hi! link xmlDocTypeKeyword BruvboxPurple
hi! link xmlCdataStart BruvboxGray
hi! link xmlCdataCdata BruvboxPurple
hi! link dtdFunction BruvboxGray
hi! link dtdTagName BruvboxPurple

hi! link xmlAttrib BruvboxAqua
hi! link xmlProcessingDelim BruvboxGray
hi! link dtdParamEntityPunct BruvboxGray
hi! link dtdParamEntityDPunct BruvboxGray
hi! link xmlAttribPunct BruvboxGray

hi! link xmlEntity BruvboxOrange
hi! link xmlEntityPunct BruvboxOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation BruvboxOrange
hi! link vimBracket BruvboxOrange
hi! link vimMapModKey BruvboxOrange
hi! link vimFuncSID BruvboxFg3
hi! link vimSetSep BruvboxFg3
hi! link vimSep BruvboxFg3
hi! link vimContinue BruvboxFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword BruvboxBlue
hi! link clojureCond BruvboxOrange
hi! link clojureSpecial BruvboxOrange
hi! link clojureDefine BruvboxOrange

hi! link clojureFunc BruvboxYellow
hi! link clojureRepeat BruvboxYellow
hi! link clojureCharacter BruvboxAqua
hi! link clojureStringEscape BruvboxAqua
hi! link clojureException BruvboxRed

hi! link clojureRegexp BruvboxAqua
hi! link clojureRegexpEscape BruvboxAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen BruvboxFg3
hi! link clojureAnonArg BruvboxYellow
hi! link clojureVariable BruvboxBlue
hi! link clojureMacro BruvboxOrange

hi! link clojureMeta BruvboxYellow
hi! link clojureDeref BruvboxYellow
hi! link clojureQuote BruvboxYellow
hi! link clojureUnquote BruvboxYellow

" }}}
" C: {{{

hi! link cOperator BruvboxPurple
hi! link cStructure BruvboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin BruvboxOrange
hi! link pythonBuiltinObj BruvboxOrange
hi! link pythonBuiltinFunc BruvboxOrange
hi! link pythonFunction BruvboxAqua
hi! link pythonDecorator BruvboxRed
hi! link pythonInclude BruvboxBlue
hi! link pythonImport BruvboxBlue
hi! link pythonRun BruvboxBlue
hi! link pythonCoding BruvboxBlue
hi! link pythonOperator BruvboxRed
hi! link pythonException BruvboxRed
hi! link pythonExceptions BruvboxPurple
hi! link pythonBoolean BruvboxPurple
hi! link pythonDot BruvboxFg3
hi! link pythonConditional BruvboxRed
hi! link pythonRepeat BruvboxRed
hi! link pythonDottedName BruvboxGreenBold

" }}}
" CSS: {{{

hi! link cssBraces BruvboxBlue
hi! link cssFunctionName BruvboxYellow
hi! link cssIdentifier BruvboxOrange
hi! link cssClassName BruvboxGreen
hi! link cssColor BruvboxBlue
hi! link cssSelectorOp BruvboxBlue
hi! link cssSelectorOp2 BruvboxBlue
hi! link cssImportant BruvboxGreen
hi! link cssVendor BruvboxFg1

hi! link cssTextProp BruvboxAqua
hi! link cssAnimationProp BruvboxAqua
hi! link cssUIProp BruvboxYellow
hi! link cssTransformProp BruvboxAqua
hi! link cssTransitionProp BruvboxAqua
hi! link cssPrintProp BruvboxAqua
hi! link cssPositioningProp BruvboxYellow
hi! link cssBoxProp BruvboxAqua
hi! link cssFontDescriptorProp BruvboxAqua
hi! link cssFlexibleBoxProp BruvboxAqua
hi! link cssBorderOutlineProp BruvboxAqua
hi! link cssBackgroundProp BruvboxAqua
hi! link cssMarginProp BruvboxAqua
hi! link cssListProp BruvboxAqua
hi! link cssTableProp BruvboxAqua
hi! link cssFontProp BruvboxAqua
hi! link cssPaddingProp BruvboxAqua
hi! link cssDimensionProp BruvboxAqua
hi! link cssRenderProp BruvboxAqua
hi! link cssColorProp BruvboxAqua
hi! link cssGeneratedContentProp BruvboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces BruvboxFg1
hi! link javaScriptFunction BruvboxAqua
hi! link javaScriptIdentifier BruvboxRed
hi! link javaScriptMember BruvboxBlue
hi! link javaScriptNumber BruvboxPurple
hi! link javaScriptNull BruvboxPurple
hi! link javaScriptParens BruvboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport BruvboxAqua
hi! link javascriptExport BruvboxAqua
hi! link javascriptClassKeyword BruvboxAqua
hi! link javascriptClassExtends BruvboxAqua
hi! link javascriptDefault BruvboxAqua

hi! link javascriptClassName BruvboxYellow
hi! link javascriptClassSuperName BruvboxYellow
hi! link javascriptGlobal BruvboxYellow

hi! link javascriptEndColons BruvboxFg1
hi! link javascriptFuncArg BruvboxFg1
hi! link javascriptGlobalMethod BruvboxFg1
hi! link javascriptNodeGlobal BruvboxFg1
hi! link javascriptBOMWindowProp BruvboxFg1
hi! link javascriptArrayMethod BruvboxFg1
hi! link javascriptArrayStaticMethod BruvboxFg1
hi! link javascriptCacheMethod BruvboxFg1
hi! link javascriptDateMethod BruvboxFg1
hi! link javascriptMathStaticMethod BruvboxFg1

" hi! link javascriptProp BruvboxFg1
hi! link javascriptURLUtilsProp BruvboxFg1
hi! link javascriptBOMNavigatorProp BruvboxFg1
hi! link javascriptDOMDocMethod BruvboxFg1
hi! link javascriptDOMDocProp BruvboxFg1
hi! link javascriptBOMLocationMethod BruvboxFg1
hi! link javascriptBOMWindowMethod BruvboxFg1
hi! link javascriptStringMethod BruvboxFg1

hi! link javascriptVariable BruvboxOrange
" hi! link javascriptVariable BruvboxRed
" hi! link javascriptIdentifier BruvboxOrange
" hi! link javascriptClassSuper BruvboxOrange
hi! link javascriptIdentifier BruvboxOrange
hi! link javascriptClassSuper BruvboxOrange

" hi! link javascriptFuncKeyword BruvboxOrange
" hi! link javascriptAsyncFunc BruvboxOrange
hi! link javascriptFuncKeyword BruvboxAqua
hi! link javascriptAsyncFunc BruvboxAqua
hi! link javascriptClassStatic BruvboxOrange

hi! link javascriptOperator BruvboxRed
hi! link javascriptForOperator BruvboxRed
hi! link javascriptYield BruvboxRed
hi! link javascriptExceptions BruvboxRed
hi! link javascriptMessage BruvboxRed

hi! link javascriptTemplateSB BruvboxAqua
hi! link javascriptTemplateSubstitution BruvboxFg1

" hi! link javascriptLabel BruvboxBlue
" hi! link javascriptObjectLabel BruvboxBlue
" hi! link javascriptPropertyName BruvboxBlue
hi! link javascriptLabel BruvboxFg1
hi! link javascriptObjectLabel BruvboxFg1
hi! link javascriptPropertyName BruvboxFg1

hi! link javascriptLogicSymbols BruvboxFg1
hi! link javascriptArrowFunc BruvboxYellow

hi! link javascriptDocParamName BruvboxFg4
hi! link javascriptDocTags BruvboxFg4
hi! link javascriptDocNotation BruvboxFg4
hi! link javascriptDocParamType BruvboxFg4
hi! link javascriptDocNamedParamType BruvboxFg4

hi! link javascriptBrackets BruvboxFg1
hi! link javascriptDOMElemAttrs BruvboxFg1
hi! link javascriptDOMEventMethod BruvboxFg1
hi! link javascriptDOMNodeMethod BruvboxFg1
hi! link javascriptDOMStorageMethod BruvboxFg1
hi! link javascriptHeadersMethod BruvboxFg1

hi! link javascriptAsyncFuncKeyword BruvboxRed
hi! link javascriptAwaitFuncKeyword BruvboxRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword BruvboxAqua
hi! link jsExtendsKeyword BruvboxAqua
hi! link jsExportDefault BruvboxAqua
hi! link jsTemplateBraces BruvboxAqua
hi! link jsGlobalNodeObjects BruvboxFg1
hi! link jsGlobalObjects BruvboxFg1
hi! link jsFunction BruvboxAqua
hi! link jsFuncParens BruvboxFg3
hi! link jsParens BruvboxFg3
hi! link jsNull BruvboxPurple
hi! link jsUndefined BruvboxPurple
hi! link jsClassDefinition BruvboxYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved BruvboxAqua
hi! link typeScriptLabel BruvboxAqua
hi! link typeScriptFuncKeyword BruvboxAqua
hi! link typeScriptIdentifier BruvboxOrange
hi! link typeScriptBraces BruvboxFg1
hi! link typeScriptEndColons BruvboxFg1
hi! link typeScriptDOMObjects BruvboxFg1
hi! link typeScriptAjaxMethods BruvboxFg1
hi! link typeScriptLogicSymbols BruvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects BruvboxFg1
hi! link typeScriptParens BruvboxFg3
hi! link typeScriptOpSymbols BruvboxFg3
hi! link typeScriptHtmlElemProperties BruvboxFg1
hi! link typeScriptNull BruvboxPurple
hi! link typeScriptInterpolationDelimiter BruvboxAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword BruvboxAqua
hi! link purescriptModuleName BruvboxFg1
hi! link purescriptWhere BruvboxAqua
hi! link purescriptDelimiter BruvboxFg4
hi! link purescriptType BruvboxFg1
hi! link purescriptImportKeyword BruvboxAqua
hi! link purescriptHidingKeyword BruvboxAqua
hi! link purescriptAsKeyword BruvboxAqua
hi! link purescriptStructure BruvboxAqua
hi! link purescriptOperator BruvboxBlue

hi! link purescriptTypeVar BruvboxFg1
hi! link purescriptConstructor BruvboxFg1
hi! link purescriptFunction BruvboxFg1
hi! link purescriptConditional BruvboxOrange
hi! link purescriptBacktick BruvboxOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp BruvboxFg3
hi! link coffeeSpecialOp BruvboxFg3
hi! link coffeeCurly BruvboxOrange
hi! link coffeeParen BruvboxFg3
hi! link coffeeBracket BruvboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter BruvboxGreen
hi! link rubyInterpolationDelimiter BruvboxAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier BruvboxRed
hi! link objcDirective BruvboxBlue

" }}}
" Go: {{{

hi! link goDirective BruvboxAqua
hi! link goConstants BruvboxPurple
hi! link goDeclaration BruvboxRed
hi! link goDeclType BruvboxBlue
hi! link goBuiltins BruvboxOrange

" }}}
" Lua: {{{

hi! link luaIn BruvboxRed
hi! link luaFunction BruvboxAqua
hi! link luaTable BruvboxOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp BruvboxFg3
hi! link moonExtendedOp BruvboxFg3
hi! link moonFunction BruvboxFg3
hi! link moonObject BruvboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation BruvboxBlue
hi! link javaDocTags BruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen BruvboxFg3
hi! link javaParen1 BruvboxFg3
hi! link javaParen2 BruvboxFg3
hi! link javaParen3 BruvboxFg3
hi! link javaParen4 BruvboxFg3
hi! link javaParen5 BruvboxFg3
hi! link javaOperator BruvboxOrange

hi! link javaVarArg BruvboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter BruvboxGreen
hi! link elixirInterpolationDelimiter BruvboxAqua

hi! link elixirModuleDeclaration BruvboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition BruvboxFg1
hi! link scalaCaseFollowing BruvboxFg1
hi! link scalaCapitalWord BruvboxFg1
hi! link scalaTypeExtension BruvboxFg1

hi! link scalaKeyword BruvboxRed
hi! link scalaKeywordModifier BruvboxRed

hi! link scalaSpecial BruvboxAqua
hi! link scalaOperator BruvboxFg1

hi! link scalaTypeDeclaration BruvboxYellow
hi! link scalaTypeTypePostDeclaration BruvboxYellow

hi! link scalaInstanceDeclaration BruvboxFg1
hi! link scalaInterpolation BruvboxAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 BruvboxGreenBold
hi! link markdownH2 BruvboxGreenBold
hi! link markdownH3 BruvboxYellowBold
hi! link markdownH4 BruvboxYellowBold
hi! link markdownH5 BruvboxYellow
hi! link markdownH6 BruvboxYellow

hi! link markdownCode BruvboxAqua
hi! link markdownCodeBlock BruvboxAqua
hi! link markdownCodeDelimiter BruvboxAqua

hi! link markdownBlockquote BruvboxGray
hi! link markdownListMarker BruvboxGray
hi! link markdownOrderedListMarker BruvboxGray
hi! link markdownRule BruvboxGray
hi! link markdownHeadingRule BruvboxGray

hi! link markdownUrlDelimiter BruvboxFg3
hi! link markdownLinkDelimiter BruvboxFg3
hi! link markdownLinkTextDelimiter BruvboxFg3

hi! link markdownHeadingDelimiter BruvboxOrange
hi! link markdownUrl BruvboxPurple
hi! link markdownUrlTitleDelimiter BruvboxGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType BruvboxYellow
" hi! link haskellOperators BruvboxOrange
" hi! link haskellConditional BruvboxAqua
" hi! link haskellLet BruvboxOrange
"
hi! link haskellType BruvboxFg1
hi! link haskellIdentifier BruvboxFg1
hi! link haskellSeparator BruvboxFg1
hi! link haskellDelimiter BruvboxFg4
hi! link haskellOperators BruvboxBlue
"
hi! link haskellBacktick BruvboxOrange
hi! link haskellStatement BruvboxOrange
hi! link haskellConditional BruvboxOrange

hi! link haskellLet BruvboxAqua
hi! link haskellDefault BruvboxAqua
hi! link haskellWhere BruvboxAqua
hi! link haskellBottom BruvboxAqua
hi! link haskellBlockKeywords BruvboxAqua
hi! link haskellImportKeywords BruvboxAqua
hi! link haskellDeclKeyword BruvboxAqua
hi! link haskellDeriving BruvboxAqua
hi! link haskellAssocType BruvboxAqua

hi! link haskellNumber BruvboxPurple
hi! link haskellPragma BruvboxPurple

hi! link haskellString BruvboxGreen
hi! link haskellChar BruvboxGreen

" }}}
" Json: {{{

hi! link jsonKeyword BruvboxGreen
hi! link jsonQuote BruvboxGreen
hi! link jsonBraces BruvboxFg1
hi! link jsonString BruvboxFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! BruvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! BruvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
