dormitory = {}

dormitory.DormitoryMainUI = "game/dormitory/view/DormitoryMainUI"
dormitory.DormitoryJoystickView = require("game/dormitory/view/DormitoryJoystickView")
dormitory.DormitorySettledHeroView = "game/dormitory/view/DormitorySettledHeroView"
dormitory.DormitoryInfoPanel = "game/dormitory/view/DormitoryInfoPanel"
dormitory.DormitoryLivePanel = "game/dormitory/view/DormitoryLivePanel"
dormitory.DormitorySettledHeroItem = require("game/dormitory/view/item/DormitorySettledHeroItem")
dormitory.DormitoryFurnitureItem = require("game/dormitory/view/item/DormitoryFurnitureItem")
dormitory.DormitoryHeroInfoItem = require("game/dormitory/view/item/DormitoryHeroInfoItem")
dormitory.DormitoryTabItem = require("game/dormitory/view/item/DormitoryTabItem")

dormitory.DormitoryEditorSaveSuitView = "game/dormitory/view/DormitoryEditorSaveSuitView"

dormitory.DormitoryBStar = require("game/dormitory/utils/DormitoryBStar")
dormitory.DormitoryLiveThing = require("game/dormitory/view/DormitoryLiveThing")

dormitory.DormitoryObject = require("game/dormitory/utils/DormitoryObject")
dormitory.DormitoryObject01 = require("game/dormitory/utils/DormitoryObject01")
dormitory.DormitoryObject02 = require("game/dormitory/utils/DormitoryObject02")
dormitory.DormitoryScene = require("game/dormitory/utils/DormitoryScene")
dormitory.DormitoryTile = require("game/dormitory/utils/DormitoryTile")
dormitory.DormitoryCamera = require("game/dormitory/utils/DormitoryCamera")

dormitory.DormitoryBaseVo = require("game/dormitory/manager/vo/DormitoryBaseVo")
dormitory.DormitoryFurnitureVo = require("game/dormitory/manager/vo/DormitoryFurnitureVo")
dormitory.DormitoryMenuVo = require("game/dormitory/manager/vo/DormitoryMenuVo")
dormitory.DormitoryWallVo = require("game/dormitory/manager/vo/DormitoryWallVo")

dormitory.DormitoryManager = require("game/dormitory/manager/DormitoryManager").new()
dormitory.DormitoryAIManager = require("game/dormitory/manager/DormitoryAIManager").new()
dormitory.DormitoryConst = require("game/dormitory/manager/DormitoryConst")
dormitory.DormitoryBaseAI = require("game/dormitory/manager/ai/DormitoryBaseAI")

dormitory.DormitoryController = require("game/dormitory/controller/DormitoryController").new(dormitory.DormitoryManager)
dormitory.DormitorySceneController = require("game/dormitory/controller/DormitorySceneController").new()

local module = {dormitory.DormitoryController, dormitory.DormitorySceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
