roundPrize = {}

roundPrize.RoundPrizePanel = "game/roundPrize/view/RoundPrizePanel"
roundPrize.RoundPrizeRulePanel = "game/roundPrize/view/RoundPrizeRulePanel"
roundPrize.RoundPrizeShopPanel = "game/roundPrize/view/RoundPrizeShopPanel"

roundPrize.RoundPrizeShowAwardPanel = require('game/roundPrize/view/RoundPrizeShowAwardPanel')

roundPrize.RoundPrizeProbabilityConfigVo = require("game/roundPrize/manager/vo/RoundPrizeProbabilityConfigVo")
roundPrize.RoundPrizeManager = require("game/roundPrize/manager/RoundPrizeManager").new()
roundPrize.RoundPrizeController = require('game/roundPrize/controller/RoundPrizeController').new(roundPrize.RoundPrizeManager)

local module = {roundPrize.RoundPrizeController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
