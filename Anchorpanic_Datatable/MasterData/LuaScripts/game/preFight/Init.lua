preFight = {}

-- 展示相关
preFight.ShowManager = require('game/preFight/base/preFightShow/manager/PreFightShowManager').new()
preFight.ShowController = require('game/preFight/base/preFightShow/controller/PreFightShowController').new()
preFight.ShowItem = require('game/preFight/base/preFightShow/view/PreFightShowItem')

--base
require('game/preFight/base/manager/PreFightConst')
preFight.ModelShowVo = require('game/preFight/base/manager/vo/ModelShowVo')
preFight.BaseManager = require('game/preFight/base/manager/PreFightBaseManager')
preFight.BaseController = require('game/preFight/base/controller/PreFightBaseController')
preFight.BaseItem = require('game/preFight/base/view/item/PreFightBaseItem')
preFight.BasePanel = require('game/preFight/base/view/PreFightBasePanel')

--MainMapStage
preFight.PreFightMainMapStageManager = require('game/preFight/mainMapStage/manager/PreFightMainMapStageManager').new()
preFight.PreFightMainMapStageItem = require('game/preFight/mainMapStage/view/item/PreFightMainMapStageItem')
preFight.PreFightMainMapStagePanel = require('game/preFight/mainMapStage/view/PreFightMainMapStagePanel')
local mainMapController = require('game/preFight/mainMapStage/controller/PreFightMainMapStageController').new()

--DupClimbTower
preFight.PreFightDupClimbTowerManager = require('game/preFight/dup_climb_tower/manager/PreFightDupClimbTowerManager').new()
preFight.PreFightDupClimbTowerItem = require('game/preFight/dup_climb_tower/view/item/PreFightDupClimbTowerItem')
preFight.PreFightDupClimbTowerPanel = require('game/preFight/dup_climb_tower/view/PreFightDupClimbTowerPanel')
local dupTowerController = require('game/preFight/dup_climb_tower/controller/PreFightDupClimbTowerController').new()

--DupMoney
preFight.PreFightDupMoneyManager = require('game/preFight/dup_money/manager/PreFightDupMoneyManager').new()
preFight.PreFightDupMoneyItem = require('game/preFight/dup_money/view/item/PreFightDupMoneyItem')
preFight.PreFightDupMoneyPanel = require('game/preFight/dup_money/view/PreFightDupMoneyPanel')
local dupMoneyController = require('game/preFight/dup_money/controller/PreFightDupMoneyController').new()

--DupMoney
preFight.PreFightDupExpManager = require('game/preFight/dup_exp/manager/PreFightDupExpManager').new()
preFight.PreFightDupExpItem = require('game/preFight/dup_exp/view/item/PreFightDupExpItem')
preFight.PreFightDupExpPanel = require('game/preFight/dup_exp/view/PreFightDupExpPanel')
local dupExpController = require('game/preFight/dup_exp/controller/PreFightDupExpController').new()

--DupOldEquip
preFight.PreFightDupOldEquipManager = require('game/preFight/dup_old_equip/manager/PreFightDupOldEquipManager').new()
preFight.PreFightDupOldEquipItem = require('game/preFight/dup_old_equip/view/item/PreFightDupOldEquipItem')
preFight.PreFightDupOldEquipPanel = require('game/preFight/dup_old_equip/view/PreFightDupOldEquipPanel')
local dupOldEquipController = require('game/preFight/dup_old_equip/controller/PreFightDupOldEquipController').new()

--DupEquip
preFight.PreFightDupEquipManager = require('game/preFight/dup_equip/manager/PreFightDupEquipManager').new()
preFight.PreFightDupEquipItem = require('game/preFight/dup_equip/view/item/PreFightDupEquipItem')
preFight.PreFightDupEquipPanel = require('game/preFight/dup_equip/view/PreFightDupEquipPanel')
local dupEquipController = require('game/preFight/dup_equip/controller/PreFightDupEquipController').new()

--DupEquipTupo
preFight.PreFightDupEquipTupoManager = require('game/preFight/dup_equip_tupo/manager/PreFightDupEquipTupoManager').new()
preFight.PreFightDupEquipTupoItem = require('game/preFight/dup_equip_tupo/view/item/PreFightDupEquipTupoItem')
preFight.PreFightDupEquipTupoPanel = require('game/preFight/dup_equip_tupo/view/PreFightDupEquipTupoPanel')
local dupEquipTupoController = require('game/preFight/dup_equip_tupo/controller/PreFightDupEquipTupoController').new()

--test
-- preFight.TestManager = require('game/preFight/test/manager/PreFightTestManager').new()
-- preFight.TestController = require('game/preFight/test/controller/PreFightTestController').new()
-- preFight.TestItem = require('game/preFight/test/view/item/PreFightTestItem')
-- preFight.TestPanel = require('game/preFight/test/view/PreFightTestPanel')
local module = { mainMapController, dupTowerController, dupMoneyController, dupExpController, dupOldEquipController, dupEquipController, dupEquipTupoController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
