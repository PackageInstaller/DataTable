branchStory = {}

branchStory.BranchStoryConst = require("game/branchStory/manager/BranchStoryConst")
branchStory.BranchStoryPanel = require("game/branchStory/view/BranchStoryPanel")
branchStory.BranchStoryManager = require("game/branchStory/manager/BranchStoryManager").new()
branchStory.BranchStoryController = require("game/branchStory/controller/BranchStoryController").new(branchStory.BranchStoryManager)

--支线-战场异闻
branchStory.BranchMainManager = require("game/branchStory/manager/BranchMainManager").new()
branchStory.BranchMainTabView = require("game/branchStory/view/tab/BranchMainTabView")
branchStory.BranchMainStageListPanel = require("game/branchStory/view/BranchMainStageListPanel")
branchStory.BranchMainChapterVo = require("game/branchStory/manager/vo/BranchMainChapterVo")
branchStory.BranchMainStageVo = require("game/branchStory/manager/vo/BranchMainStageVo")
branchStory.BranchMainStageItem = require("game/branchStory/view/item/BranchMainStageItem")

branchStory.BranchMainChapterItem = require("game/branchStory/view/item/BranchMainChapterItem")

-- 备战训练
branchStory.BranchEquipChapterVo = require("game/branchStory/manager/vo/BranchEquipChapterVo")
branchStory.BranchEquipStageVo = require("game/branchStory/manager/vo/BranchEquipStageVo")
branchStory.BranchEquipTabView = require("game/branchStory/view/tab/BranchEquipTabView")
branchStory.BranchEquipChapterItem = require("game/branchStory/view/item/BranchEquipChapterItem")
branchStory.BranchEquipStageItem = require("game/branchStory/view/item/BranchEquipStageItem")
branchStory.BranchEquipStageListPanel = require("game/branchStory/view/BranchEquipStageListPanel")

--支线-战术训练

branchStory.BranchTactivsManager = require("game/branchStory/manager/BranchTactivsManager").new()
branchStory.BranchTactivsTabView = require("game/branchStory/view/tab/BranchTactivsTabView")
branchStory.BranchTactivsStageListPanel = require("game/branchStory/view/BranchTactivsStageListPanel")
branchStory.BranchTactivsChapterVo = require("game/branchStory/manager/vo/BranchTactivsChapterVo")
branchStory.BranchTactivsStageVo = require("game/branchStory/manager/vo/BranchTactivsStageVo")
branchStory.BranchTactivsStageItem = require("game/branchStory/view/item/BranchTactivsStageItem")
branchStory.BranchTactivsChapterItem = require("game/branchStory/view/item/BranchTactivsChapterItem")

--支线-能源力场
branchStory.BranchPowerManager = require("game/branchStory/manager/BranchPowerManager").new()
branchStory.BranchPowerTabView = require("game/branchStory/view/tab/BranchPowerTabView")

branchStory.BranchPowerChapterVo =  require("game/branchStory/manager/vo/BranchPowerChapterVo")

branchStory.BranchPowerChapterItem = require("game/branchStory/view/item/BranchPowerChapterItem")




local module = {branchStory.BranchStoryController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
