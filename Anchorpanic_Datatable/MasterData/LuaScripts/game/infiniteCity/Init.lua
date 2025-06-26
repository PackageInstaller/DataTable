infiniteCity = {}

infiniteCity.InfiniteCitydupItem = require("game/infiniteCity/view/item/InfiniteCityDupItem")
infiniteCity.InfiniteCityDisaterItem = require("game/infiniteCity/view/item/InfiniteCityDisasterItem")
infiniteCity.InfiniteCitySupplyItem = require("game/infiniteCity/view/item/InfiniteCitySupplyItem")
infiniteCity.InfiniteCityDisasterDetailItem = require("game/infiniteCity/view/item/InfiniteCityDisasterDetailItem")
infiniteCity.InfiniteCityTrophyShowItem = require("game/infiniteCity/view/item/InfiniteCityTrophyShowItem")
infiniteCity.InfiniteCityTrophySelectItem = require("game/infiniteCity/view/item/InfiniteCityTrophySelectItem")
infiniteCity.InfiniteCityRankItem = require("game/infiniteCity/view/item/InfiniteCityRankItem")
infiniteCity.InfiniteCityTargetItem = require("game/infiniteCity/view/item/InfiniteCityTargetItem")
infiniteCity.InfiniteCityShopItem = require("game/infiniteCity/view/item/InfiniteCityShopItem")

infiniteCity.InfiniteCityMainPanel = "game/infiniteCity/view/InfiniteCityMainPanel"
infiniteCity.InfiniteCityDupPanel = "game/infiniteCity/view/InfiniteCityDupPanel"
infiniteCity.InfiniteCityPrepPanel = "game/infiniteCity/view/InfiniteCityPrepPanel"
infiniteCity.InfiniteCityDupInfoView = "game/infiniteCity/view/InfiniteCityDupInfoView"
infiniteCity.InfiniteCitySupplyView = "game/infiniteCity/view/InfiniteCitySupplyView"
infiniteCity.InfiniteCityDisasterDetailView = "game/infiniteCity/view/InfiniteCityDisasterDetailView"
infiniteCity.InfiniteCityTrophyShowView = "game/infiniteCity/view/InfiniteCityTrophyShowView"
infiniteCity.InfiniteCityTrophySelectView = "game/infiniteCity/view/InfiniteCityTrophySelectView"
infiniteCity.InfiniteCityRankPanel = "game/infiniteCity/view/InfiniteCityRankPanel"
infiniteCity.InfiniteCityTargetView = "game/infiniteCity/view/InfiniteCityTargetView"
infiniteCity.ActivityTargetPanel = "game/infiniteCity/view/ActivityTargetPanel"
infiniteCity.InfiniteCityShopPanel = "game/infiniteCity/view/InfiniteCityShopPanel"

infiniteCity.InfiniteCityDupVo = require("game/infiniteCity/manager/vo/InfiniteCityDupVo")
infiniteCity.InfiniteCityDisasterVo = require("game/infiniteCity/manager/vo/InfiniteCityDisasterVo")
infiniteCity.InfiniteCitySupplyVo = require("game/infiniteCity/manager/vo/InfiniteCitySupplyVo")
infiniteCity.InfiniteCityTrophyVo = require("game/infiniteCity/manager/vo/InfiniteCityTrophyVo")
infiniteCity.InfiniteCityRankVo = require("game/infiniteCity/manager/vo/InfiniteCityRankVo")
infiniteCity.InfiniteCityTargetVo = require("game/infiniteCity/manager/vo/InfiniteCityTargetVo")

infiniteCity.InfiniteCityManager = require("game/infiniteCity/manager/InfiniteCityManager").new()
infiniteCity.InfiniteCityController = require("game/infiniteCity/controller/InfiniteCityController").new(infiniteCity.InfiniteCityManager)

local module = { infiniteCity.InfiniteCityController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
