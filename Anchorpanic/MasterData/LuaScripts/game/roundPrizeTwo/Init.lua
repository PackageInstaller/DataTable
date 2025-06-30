roundPrizeTwo = {}

roundPrizeTwo.RoundPrizeTwoPanel = "game/roundPrizeTwo/view/RoundPrizeTwoPanel"
roundPrizeTwo.RoundPrizeRuleTwoPanel = "game/roundPrizeTwo/view/RoundPrizeRuleTwoPanel"
roundPrizeTwo.RoundPrizeShopTwoPanel = "game/roundPrizeTwo/view/RoundPrizeShopTwoPanel"

roundPrizeTwo.RoundPrizeShowAwardTwoPanel = require('game/roundPrizeTwo/view/RoundPrizeShowAwardTwoPanel')

roundPrizeTwo.RoundPrizeProbabilityTwoConfigVo = require("game/roundPrizeTwo/manager/vo/RoundPrizeProbabilityTwoConfigVo")
roundPrizeTwo.RoundPrizeTwoManager = require("game/roundPrizeTwo/manager/RoundPrizeTwoManager").new()
roundPrizeTwo.RoundPrizeTwoController = require('game/roundPrizeTwo/controller/RoundPrizeTwoController').new(roundPrizeTwo.RoundPrizeTwoManager)

local module = {roundPrizeTwo.RoundPrizeTwoController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
