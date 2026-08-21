ranking = {}

--vo
ranking.RankingAreaConfigVo = require("game/ranking/manager/vo/RankingAreaConfigVo")
ranking.RankingDupConfigVo = require("game/ranking/manager/vo/RankingDupConfigVo")
ranking.RankingRewardConfigVo = require("game/ranking/manager/vo/RankingRewardConfigVo")
ranking.RankingStarConfigVo = require("game/ranking/manager/vo/RankingStarConfigVo")
ranking.RankingThingConfigVo = require("game/ranking/manager/vo/RankingThingConfigVo")

----UI
ranking.RankingDupPanel = "game/ranking/view/RankingDupPanel"
ranking.RankingSceneUI = "game/ranking/view/RankingSceneUI"
ranking.RankingSettlementPanel = "game/ranking/view/RankingSettlementPanel"
ranking.RankingStageMainUI = "game/ranking/view/RankingStageMainUI"
ranking.RankingStarAwardView = "game/ranking/view/RankingStarAwardView"
ranking.RankingTeachingView = "game/ranking/view/RankingTeachingView"

ranking.RankingStarAwardItem = require("game/ranking/view/item/RankingStarAwardItem")

--管理器
ranking.RankingManager = require("game/ranking/manager/RankingManager").new()
ranking.RankingController = require("game/ranking/controller/RankingController").new(ranking.RankingManager)

local module = {ranking.RankingController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
