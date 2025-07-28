sandPlay = {}

--configVo
sandPlay.SandPlaySceneConfigVo = require("game/sandPlay/manager/configVo/SandPlaySceneConfigVo")
sandPlay.SandPlayNPCConfigVo = require("game/sandPlay/manager/configVo/SandPlayNPCConfigVo")
sandPlay.SandPlayEventConfigVo = require("game/sandPlay/manager/configVo/SandPlayEventConfigVo")
sandPlay.SandPlayHeroConfigVo = require("game/sandPlay/manager/configVo/SandPlayHeroConfigVo")
sandPlay.SandPlayHeroSkillConfigVo = require("game/sandPlay/manager/configVo/SandPlayHeroSkillConfigVo")
sandPlay.SandPlayFishBaitConfigVo = require("game/sandPlay/manager/configVo/SandPlayFishBaitConfigVo")
sandPlay.SandPlayFishConfigVo = require("game/sandPlay/manager/configVo/SandPlayFishConfigVo")
sandPlay.SandPlayFishRewardConfigVo = require("game/sandPlay/manager/configVo/SandPlayFishRewardConfigVo")
sandPlay.SandPlayFishTaskConfigVo = require("game/sandPlay/manager/configVo/SandPlayFishTaskConfigVo")
sandPlay.SandPlayStageConfigVo = require("game/sandPlay/manager/configVo/SandPlayStageConfigVo")

----UI
sandPlay.SandPlaySceneUI = "game/sandPlay/view/SandPlaySceneUI"
sandPlay.SandPlayMapPanel = "game/sandPlay/view/SandPlayMapPanel"

sandPlay.SandPlayFishingUI = "game/sandPlay/view/SandPlayFishingUI"
sandPlay.SandPlayFishingTeachingView = "game/sandPlay/view/SandPlayFishingTeachingView"
sandPlay.SandPlayDupInfoPanel = "game/sandPlay/view/SandPlayDupInfoPanel"

sandPlay.SandPlayFishingAtlasPanel = "game/sandPlay/view/SandPlayFishingAtlasPanel"
sandPlay.SandPlayFishingResultPanel = "game/sandPlay/view/SandPlayFishingResultPanel"

sandPlay.SandPlayJoystickView = require("game/sandPlay/view/SandPlayJoystickView")
sandPlay.SandPlayMinMap = require("game/sandPlay/view/SandPlayMinMap")
sandPlay.SandPlayFishingBaitItem = require("game/sandPlay/view/item/SandPlayFishingBaitItem")
sandPlay.SandPlayFishRewardItem = require("game/sandPlay/view/item/SandPlayFishRewardItem")
sandPlay.SandPlayFishAchieveItem = require("game/sandPlay/view/item/SandPlayFishAchieveItem")

sandPlay.SandPlayFishingAwardTab = require("game/sandPlay/view/tab/SandPlayFishingAwardTab")
sandPlay.SandPlayFishingAchieveTab = require("game/sandPlay/view/tab/SandPlayFishingAchieveTab")
sandPlay.SandPlayFishingAtlasTab = require("game/sandPlay/view/tab/SandPlayFishingAtlasTab")

--场景模型
sandPlay.SandPlayNPCModel = require("game/sandPlay/manager/model/SandPlayNPCModel")
sandPlay.SandPlayPlayerModel = require("game/sandPlay/manager/model/SandPlayPlayerModel")

sandPlay.SandPlayBaseThing = require("game/sandPlay/manager/thing/SandPlayBaseThing")
sandPlay.SandPlayNPCThing = require("game/sandPlay/manager/thing/SandPlayNPCThing")
sandPlay.SandPlayRoleNPCThing = require("game/sandPlay/manager/thing/SandPlayRoleNPCThing")
sandPlay.SandPlayOtherNPCThing = require("game/sandPlay/manager/thing/SandPlayOtherNPCThing")
sandPlay.SandPlayTreasureBoxThing = require("game/sandPlay/manager/thing/SandPlayTreasureBoxThing")
sandPlay.SandPlayDoorThing = require("game/sandPlay/manager/thing/SandPlayDoorThing")

sandPlay.SandPlayPlayerThing = require("game/sandPlay/manager/thing/SandPlayPlayerThing")

--管理器
sandPlay.SandPlayCamera = require("game/sandPlay/manager/SandPlayCamera")
sandPlay.SandPlayFishingUtil = require("game/sandPlay/manager/SandPlayFishingUtil")
sandPlay.SandPlay_effect = require("game/sandPlay/manager/SandPlay_effect")

sandPlay.SandPlayConst = require("game/sandPlay/manager/SandPlayConst")
sandPlay.SandPlayManager = require("game/sandPlay/manager/SandPlayManager").new()
sandPlay.SandPlayController = require("game/sandPlay/controller/SandPlayController").new(sandPlay.SandPlayManager)
sandPlay.SandPlaySceneController = require("game/sandPlay/controller/SandPlaySceneController").new()

local module = {sandPlay.SandPlayController, sandPlay.SandPlaySceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
