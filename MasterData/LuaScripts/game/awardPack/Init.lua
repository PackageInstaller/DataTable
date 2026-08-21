
AwardPackConst = require("game/awardPack/manager/AwardPackConst")
AwardPackConfigVo = require("game/awardPack/manager/AwardPackConfigVo")
AwardPackManager = require("game/awardPack/manager/AwardPackManager").new()
AwardPackController = require("game/awardPack/controller/AwardPackController").new(AwardPackManager)

local module = {}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
