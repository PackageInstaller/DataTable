pickGold = {}

--vo
pickGold.PickGoldAreaConfigVo = require("game/pickGold/manager/vo/PickGoldAreaConfigVo")
pickGold.PickGoldDupConfigVo = require("game/pickGold/manager/vo/PickGoldDupConfigVo")
pickGold.PickGoldRewardConfigVo = require("game/pickGold/manager/vo/PickGoldRewardConfigVo")
pickGold.PickGoldGridConfigVo = require("game/pickGold/manager/vo/PickGoldGridConfigVo")

----UI
pickGold.PickGoldDupPanel = "game/pickGold/view/PickGoldDupPanel"
pickGold.PickGoldSceneUI = "game/pickGold/view/PickGoldSceneUI"
pickGold.PickGoldSettlementPanel = "game/pickGold/view/PickGoldSettlementPanel"
pickGold.PickGoldStageMainUI = "game/pickGold/view/PickGoldStageMainUI"
pickGold.PickGoldStarAwardView = "game/pickGold/view/PickGoldStarAwardView"
pickGold.PickGoldTeachingView = "game/pickGold/view/PickGoldTeachingView"
pickGold.PickGoldRankPanel = "game/pickGold/view/PickGoldRankPanel"

pickGold.PickGoldStarAwardItem = require("game/pickGold/view/item/PickGoldStarAwardItem")
pickGold.PickGoldRankItem = require("game/pickGold/view/item/PickGoldRankItem")


--管理器
pickGold.PickGoldManager = require("game/pickGold/manager/PickGoldManager").new()
pickGold.PickGoldController = require("game/pickGold/controller/PickGoldController").new(pickGold.PickGoldManager)

local module = {pickGold.PickGoldController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
