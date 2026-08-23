local var_0_0 = math.floor
local var_0_1 = math.max
local var_0_2 = math.random
local var_0_3 = math.clamp
local OutpostAttrType = require("app.view.module.outpost.simulationWorld.fight.OutpostAttrType")
local var_0_5 = g.core.const.ConstMgr.outpostConst
local var_0_6 = g.core.config.outpost_battle_parameter_info
local var_0_7 = {
	formula0 = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
		return
	end
}
local var_0_8 = g.core.config.outpost_battle_parameter_info.get(g.core.const.ConstMgr.outpostConst.WorldParam.HitMin)
local var_0_9 = (var_0_8.value_sign == 1 and -1 or 1) * var_0_8.value
local var_0_10 = g.core.config.outpost_battle_parameter_info.get(g.core.const.ConstMgr.outpostConst.WorldParam.HitMax)
local var_0_11 = (var_0_10.value_sign == 1 and -1 or 1) * var_0_10.value

function var_0_7.rangeHitRate(arg_2_0)
	return var_0_3(arg_2_0, var_0_9, var_0_11)
end

local var_0_12 = var_0_6.get(var_0_5.WorldParam.CritRateMin)
local var_0_13 = (var_0_12.value_sign == 1 and -1 or 1) * var_0_12.value
local var_0_14 = var_0_6.get(var_0_5.WorldParam.CritRateMax)
local var_0_15 = (var_0_14.value_sign == 1 and -1 or 1) * var_0_14.value

function var_0_7.rangeCritRate(arg_3_0)
	return var_0_3(arg_3_0, var_0_13, var_0_15)
end

local var_0_16 = var_0_6.get(var_0_5.WorldParam.CritDamageMin)
local var_0_17 = (var_0_16.value_sign == 1 and -1 or 1) * var_0_16.value
local var_0_18 = var_0_6.get(var_0_5.WorldParam.CritDamageMax)
local var_0_19 = (var_0_18.value_sign == 1 and -1 or 1) * var_0_18.value

function var_0_7.rangeCritDamage(arg_4_0)
	return var_0_3(arg_4_0, var_0_17, var_0_19)
end

local var_0_20 = var_0_6.get(var_0_5.WorldParam.BlockRateMin)
local var_0_21 = (var_0_20.value_sign == 1 and -1 or 1) * var_0_20.value
local var_0_22 = var_0_6.get(var_0_5.WorldParam.BlockRateMax)
local var_0_23 = (var_0_22.value_sign == 1 and -1 or 1) * var_0_22.value

function var_0_7.rangeBlockRate(arg_5_0)
	return var_0_3(arg_5_0, var_0_21, var_0_23)
end

local var_0_24 = var_0_6.get(var_0_5.WorldParam.BlockDamageMin)
local var_0_25 = (var_0_24.value_sign == 1 and -1 or 1) * var_0_24.value
local var_0_26 = var_0_6.get(var_0_5.WorldParam.BlockDamageMax)
local var_0_27 = (var_0_26.value_sign == 1 and -1 or 1) * var_0_26.value

function var_0_7.rangeBlockDamage(arg_6_0)
	return var_0_3(arg_6_0, var_0_25, var_0_27)
end

local var_0_28 = var_0_6.get(var_0_5.WorldParam.DamageAddMin)
local var_0_29 = (var_0_28.value_sign == 1 and -1 or 1) * var_0_28.value
local var_0_30 = var_0_6.get(var_0_5.WorldParam.DamageAddMax)
local var_0_31 = (var_0_30.value_sign == 1 and -1 or 1) * var_0_30.value

function var_0_7.rangeDamageAdd(arg_7_0)
	return var_0_3(arg_7_0, var_0_29, var_0_31)
end

function var_0_7:formula1(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_1 = arg_8_1:getAttr()
	local var_8_2 = arg_8_2:getAttr()
	local var_8_3 = var_0_1(var_8_1:getAtk() - var_8_2:getDef(), var_8_1:getAtk() * 0.05 + 10) * arg_8_3 * 0.001 + arg_8_4 * 0.001

	if not self.fightSystem:bingo((var_0_7.rangeHitRate(1000 + var_8_1:getAttr(OutpostAttrType.hitRate) - var_8_2:getAttr(OutpostAttrType.dodgeRate)))) then
		var_8_3 = 0
		self.effectValue = 0
		self.isDodge = true

		return
	end

	if self.fightSystem:bingo((var_0_7.rangeCritRate(var_8_1:getAttr(OutpostAttrType.critRate) - var_8_2:getAttr(OutpostAttrType.critResistRate)))) then
		self.isCrit = true
		var_8_3 = var_8_3 * (1500 + var_0_7.rangeCritDamage(var_8_1:getAttr(OutpostAttrType.critStrength) - var_8_2:getAttr(OutpostAttrType.critReduce))) * 0.001
	end

	if self.fightSystem:bingo((var_0_7.rangeBlockRate(var_8_2:getAttr(OutpostAttrType.blockRate) - var_8_1:getAttr(OutpostAttrType.penetrateBlockRate)))) then
		self.isBlock = true
		var_8_3 = var_8_3 * (700 + var_0_7.rangeBlockDamage(var_8_1:getAttr(OutpostAttrType.blockReduce) - var_8_2:getAttr(OutpostAttrType.blockStrength))) * 0.001
	end

	self.effectValue = var_0_0(var_8_3 * (1000 + var_0_7.rangeDamageAdd(var_8_1:getAttr(OutpostAttrType.damageAdd) - var_8_2:getAttr(OutpostAttrType.damageReduce))) * 0.001 * var_0_2(950, 1050) * 0.001)
end

function var_0_7:formula2(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_1 = arg_9_1:getAttr()
	local var_9_2 = var_9_1:getAtk() * arg_9_3 * 0.001 + arg_9_4 * 0.001

	if self.fightSystem:bingo((var_0_7.rangeCritRate(var_9_1:getAttr(OutpostAttrType.critRate) / 2))) then
		self.isCrit = true
		var_9_2 = var_9_2 * (1500 + var_0_7.rangeCritDamage(var_9_1:getAttr(OutpostAttrType.critStrength) / 2)) * 0.001
	end

	self.effectValue = var_0_0(var_9_2 * var_0_2(950, 1050) * 0.001)
end

return var_0_7
