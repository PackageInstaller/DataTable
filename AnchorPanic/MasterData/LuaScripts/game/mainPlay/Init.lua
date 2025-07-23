mainPlay = {}

mainPlay.MainPlayConst = require("game/mainPlay/manager/MainPlayConst")
mainPlay.MainPlayDupConst = require("game/mainPlay/manager/MainPlayDupConst")

mainPlay.MainPlayView = require("game/mainPlay/view/MainPlayView")
mainPlay.MainPlayDupView = require("game/mainPlay/view/MainPlayDupView")

mainPlay.MainPlayManager = require("game/mainPlay/manager/MainPlayManager").new()
local _c = require('game/mainPlay/controller/MainPlayController').new(mainPlay.MainPlayManager)
local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
