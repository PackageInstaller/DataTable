teaching = {}

teaching.TeachingPanel = "game/teaching/view/TeachingPanel"
teaching.TeachingTipsView = "game/teaching/view/TeachingTipsView"

teaching.TeachingFormationItem = require("game/teaching/view/item/TeachingFormationItem")
teaching.TeachingHeadItem = require("game/teaching/view/item/TeachingHeadItem")

teaching.TeachingBaseVo = require("game/teaching/manager/vo/TeachingBaseVo")
teaching.TeachingManager = require("game/teaching/manager/TeachingManager").new()

teaching.TeachingController = require("game/teaching/controller/TeachingController").new(teaching.TeachingManager)

local module = { teaching.TeachingController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
