equipBuild = {}

--base
require("game/equipBuild/manager/EquipBuildConst")
equipBuild.EquipBuildManager = require("game/equipBuild/manager/EquipBuildManager").new()
equipBuild.EquipBuildPanel = require("game/equipBuild/view/EquipBuildPanel")
equipBuild.EquipBuildController = require("game/equipBuild/controller/EquipBuildController").new(equipBuild.EquipBuildManager)
equipBuild.EquipMaterialItem = require("game/equipBuild/view/item/EquipMaterialItem")
equipBuild.EquipMaterialPanel = require("game/equipBuild/view/EquipMaterialPanel")

-- 芯片强化 和 芯片突破
equipBuild.EquipAttrsTabView = require("game/equipBuild/view/tab/EquipAttrsTabView")

equipBuild.EquipStrengthenManager = require("game/equipBuild/manager/EquipStrengthenManager").new()
--equipBuild.EquipStrengthenTabView = require("game/equipBuild/view/tab/EquipStrengthenTabView")
equipBuild.EquipStrengthenTabView = require("game/equipBuild/view/tab/EquipStrengthenTabViewNew")
equipBuild.EquipStrengthenController = require("game/equipBuild/controller/EquipStrengthenController").new(equipBuild.EquipStrengthenManager)
equipBuild.EquipStrengthenConfigVo = require("game/equipBuild/manager/vo/EquipStrengthenConfigVo")
equipBuild.EquipStrengthenSelectItem = require("game/equipBuild/view/item/EquipStrengthenSelectItem")
equipBuild.EquipStrengthenShowltem = require("game/equipBuild/view/item/EquipStrengthenShowltem")

equipBuild.EquipBreakUpConfigVo = require("game/equipBuild/manager/vo/EquipBreakUpConfigVo")
equipBuild.EquipBreakUpSucPanel = require("game/equipBuild/view/suc/EquipBreakUpSucPanel")
equipBuild.EquipStrengthenUpView = require("game/equipBuild/view/EquipStrengthenUpView")
equipBuild.EquipBreakUpSucUnlockAttrPanel = require("game/equipBuild/view/suc/EquipBreakUpSucUnlockAttrPanel")
equipBuild.EquipStrengthenSucPanel = require("game/equipBuild/view/suc/EquipStrengthenSucPanel")

-- 芯片改造
equipBuild.EquipRemakeShowDataVo = require("game/equipBuild/manager/vo/EquipRemakeShowDataVo")
equipBuild.EquipRemakeUpAgentView = require("game/equipBuild/view/EquipRemakeUpAgentView")

equipBuild.EquipRemakeVo = require('rodata/EquipRemakeDataRo')
equipBuild.EquipRemakeManager = require("game/equipBuild/manager/EquipRemakeManager").new()
equipBuild.EquipRemakeController = require("game/equipBuild/controller/EquipRemakeController").new(equipBuild.EquipRemakeManager)
equipBuild.EquipRemakeTabView = require("game/equipBuild/view/tab/EquipRemakeTabView")
equipBuild.EquipRemakeSelectItem = require("game/equipBuild/view/item/EquipRemakeSelectItem")
equipBuild.EquipRemakeSucPanel = require("game/equipBuild/view/suc/EquipRemakeSucPanel")
equipBuild.EquipRemakeInfoItem = require("game/equipBuild/view/item/EquipRemakeInfoItem")
equipBuild.EquipRemakeUpView = require("game/equipBuild/view/EquipRemakeUpView")
equipBuild.EquipRemakeMaterialItem = require("game/equipBuild/view/item/EquipRemakeMaterialItem")

equipBuild.EquipRemakeUpTargetView = require("game/equipBuild/view/EquipRemakeUpTargetView")
equipBuild.EquipRemakeMaterialAgentItem = require("game/equipBuild/view/item/EquipRemakeMaterialAgentItem")

equipBuild.EquipRemakeUpAgentOptView = require("game/equipBuild/view/EquipRemakeUpAgentOptView")

-- 芯片重构
equipBuild.EquipReconstructVo = require('rodata/EquipReconstructDataRo')
equipBuild.EquipRestructureManager = require("game/equipBuild/manager/EquipRestructureManager").new()
equipBuild.EquipRestructureController = require("game/equipBuild/controller/EquipRestructureController").new(equipBuild.EquipRestructureManager)
equipBuild.EquipRestructureTabView = require("game/equipBuild/view/tab/EquipRestructureTabView")
equipBuild.EquipRestructureSelectItem = require("game/equipBuild/view/item/EquipRestructureSelectItem")
equipBuild.EquipRestructureSucPanel = require("game/equipBuild/view/suc/EquipRestructureSucPanel")
equipBuild.EquipRestructureDetailPanel = require("game/equipBuild/view/EquipRestructureDetailPanel")

-- 模组方案
equipBuild.EquipPlanManager = require("game/equipBuild/manager/EquipPlanManager").new()
equipBuild.EquipPlanController = require("game/equipBuild/controller/EquipPlanController").new(equipBuild.EquipPlanManager)
equipBuild.EquipPlanPanel = require("game/equipBuild/view/EquipPlanPanel")
equipBuild.EquipPlanScrollItem = require("game/equipBuild/view/item/EquipPlanScrollItem")
equipBuild.EquipPlanChangeNamePanel = require("game/equipBuild/view/EquipPlanChangeNamePanel")
equipBuild.EquipPlanWearTipPanel = require("game/equipBuild/view/EquipPlanWearTipPanel")
equipBuild.EquipPlanVo = require("game/equipBuild/manager/vo/EquipPlanVo")
-- tip
equipBuild.EquipInfoTipsItem = require('game/equipBuild/view/item/EquipInfoTipsItem')

local module = {equipBuild.EquipBuildController, equipBuild.EquipStrengthenController, equipBuild.EquipRemakeController, equipBuild.EquipRestructureController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
