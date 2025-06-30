mining = {}

mining.MiningDupPanel = "game/mining/view/MiningDupPanel"
mining.MiningDupInfoView = "game/mining/view/MiningDupInfoView"
mining.MiningResultView = "game/mining/view/MiningResultView"
mining.MiningStarAwardView = "game/mining/view/MiningStarAwardView"
mining.MiningTaskView = "game/mining/view/MiningTaskView"
mining.MiningRankPanel = "game/mining/view/MiningRankPanel"

mining.MiningScenePanel = "game/mining/view/MiningScenePanel"

mining.MiningDupItem = require("game/mining/view/item/MiningDupItem")
mining.MiningStarAwardItem = require("game/mining/view/item/MiningStarAwardItem")
mining.MiningRankItem = require("game/mining/view/item/MiningRankItem")
mining.MiningTaskItem = require("game/mining/view/item/MiningTaskItem")

mining.MiningAi = require("game/mining/manager/ai/MiningAi")
mining.MiningLivething = require("game/mining/manager/MiningLivething")

mining.MiningDupVo = require("game/mining/manager/vo/MiningDupVo")
mining.MiningWaveVo = require("game/mining/manager/vo/MiningWaveVo")
mining.MiningEventVo = require("game/mining/manager/vo/MiningEventVo")
mining.MiningStarVo = require("game/mining/manager/vo/MiningStarVo")
mining.MiningSkillVo = require("game/mining/manager/vo/MiningSkillVo")
mining.MiningTaskVo = require("game/mining/manager/vo/MiningTaskVo")
mining.MiningRewardVo = require("game/mining/manager/vo/MiningRewardVo")

mining.MiningManager = require("game/mining/manager/MiningManager").new()

mining.MiningController = require("game/mining/controller/MiningController").new(mining.MiningManager)

local module = { mining.MiningController }
return module