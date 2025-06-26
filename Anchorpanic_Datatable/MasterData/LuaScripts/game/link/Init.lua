link = {}

link.NavigationLink = require('game/link/view/NavigationLink')

link.NavigationConfigVo = require('game/link/manager/vo/NavigationConfigVo')
link.LinkConfigVo = require('game/link/manager/vo/LinkConfigVo')
link.LinkConst = require('game/link/manager/LinkConst')
link.LinkManager = require('game/link/manager/LinkManager').new()

local _c = require('game/link/controller/LinkController').new(link.LinkManager)

local module = { _c }
return module

--[[ 替换语言包自动生成，请勿修改！
]]