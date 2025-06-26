
equip = {}

equip.EquipSkillBuffConfigVo = require('game/equip/manager/vo/EquipSkillBuffConfigVo')
equip.EquipSkillManager = require("game/equip/manager/EquipSkillManager").new()

equip.EquipConfigVo = require('game/equip/manager/vo/EquipConfigVo')
props.EquipVo = require('game/equip/manager/vo/EquipVo')
equip.EquipManager = require("game/equip/manager/EquipManager").new()

equip.EquipSuitConfigVo = require('game/equip/manager/vo/EquipSuitConfigVo')
equip.EquipSuitManager = require("game/equip/manager/EquipSuitManager").new()

equip.EquipController = require("game/equip/controller/EquipController").new()
local module = {equip.EquipController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
