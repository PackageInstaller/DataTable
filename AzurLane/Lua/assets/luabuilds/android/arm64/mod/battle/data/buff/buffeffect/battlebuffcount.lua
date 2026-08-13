ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleAttr

class = var_0_10003

local var_0_3 = var_0_10003("BattleBuffCount", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffCount = var_0_3
var_0_3.__name = "BattleBuffCount"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_COUNTER
end

function var_0_3.Repeater(arg_3_0)
	return arg_3_0._keepRestCount
end

function var_0_3.SetArgs(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if not arg_4_0._tempData.arg_list.countTarget then
		var_4_0 = 1
	end

	arg_4_0._countTarget = var_4_0
	arg_4_0._countType = var_3.countType
	arg_4_0._weaponType = var_3.weaponType
	arg_4_0._index = var_3.index

	local var_4_1

	if not var_3.maxHPRatio then
		var_4_1 = 0
	end

	arg_4_0._maxHPRatio = var_4_1

	local var_4_2

	if not var_3.casterMaxHPRatio then
		var_4_2 = 0
	end

	arg_4_0._casterMaxHPRatio = var_4_2
	arg_4_0._clock = arg_4_0._tempData.arg_list.clock
	arg_4_0._interrupt = arg_4_0._tempData.arg_list.interrupt

	local var_4_3

	if not arg_4_0._tempData.arg_list.iconType then
		var_4_3 = 1
	end

	arg_4_0._iconType = var_4_3
	arg_4_0._gunnerBonus = var_3.gunnerBonus
	arg_4_0._keepRestCount = var_3.keep

	arg_4_0:ResetCount()

	if arg_4_0._clock then
		arg_4_1:DispatchCastClock(true, arg_4_0, arg_4_0._iconType, arg_4_0._interrupt)
	end

	return
end

function var_0_3.onRemove(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._clock then
		local var_5_0

		if arg_5_0._interrupt then
			var_5_0 = arg_5_0._count < arg_5_0._countTarget
		end

		arg_5_1:DispatchCastClock(false, arg_5_0, nil, var_5_0)
	end

	return
end

function var_0_3.onTrigger(arg_6_0, arg_6_1, arg_6_2)
	var_0_3.super.onTrigger(arg_6_0, arg_6_1, arg_6_2)

	arg_6_0._count = arg_6_0._count + 1

	arg_6_0:checkCount(arg_6_1)

	return
end

function var_0_3.onFire(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0:equipIndexRequire(arg_7_3.equipIndex) then
		return
	end

	arg_7_0._count = arg_7_0._count + 1

	arg_7_0:checkModCount(arg_7_1)

	return
end

function var_0_3.onUpdate(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_3.timeStamp
	local var_8_1

	if not arg_8_0._lastTriggerTime then
		var_8_1 = arg_8_2:GetBuffStartTime()
	end

	arg_8_0._count = var_8_0 - var_8_1

	if arg_8_0._count >= arg_8_0._countTarget then
		arg_8_0._lastTriggerTime = var_8_0

		arg_8_0:ResetCount()
		arg_8_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_8_0
		})
	end

	return
end

function var_0_3.onTakeDamage(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0:damageCheck(arg_9_3) then
		local var_9_0 = arg_9_3.damage

		arg_9_0._count = arg_9_0._count + var_9_0

		arg_9_0:checkHPCount(arg_9_1)
	end

	return
end

function var_0_3.onTakeHealing(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_3.damage

	arg_10_0._count = arg_10_0._count + var_10_0

	arg_10_0:checkHPCount(arg_10_1)

	return
end

function var_0_3.onHPRatioUpdate(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	math = var_1_10004

	local var_11_0 = var_1_10004.abs(arg_11_3.validDHP)

	arg_11_0._count = arg_11_0._count + var_11_0

	arg_11_0:checkHPCount(arg_11_1)

	return
end

function var_0_3.onStack(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._count = arg_12_2:GetStack()

	arg_12_0:checkCount(arg_12_1)

	return
end

function var_0_3.onBulletHit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0:equipIndexRequire(arg_13_3.equipIndex) then
		return
	end

	arg_13_0._count = arg_13_0._count + arg_13_3.damage

	arg_13_0:checkCount(arg_13_1)

	return
end

function var_0_3.checkCount(arg_14_0, arg_14_1)
	if arg_14_0._count >= arg_14_0._countTarget then
		arg_14_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_14_0
		})
	end

	return
end

function var_0_3.checkModCount(arg_15_0, arg_15_1)
	if arg_15_0._count >= arg_15_0:getCount(arg_15_1) then
		arg_15_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_15_0
		})
	end

	return
end

function var_0_3.getCount(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._countTarget
	local var_16_1 = var_0_2.GetCurrent(arg_16_1, "barrageCounterMod")

	if arg_16_0._gunnerBonus then
		math = var_4
		var_16_0 = var_4.ceil(var_16_0 / var_16_1)
	end

	return var_16_0
end

function var_0_3.checkHPCount(arg_17_0, arg_17_1)
	if not arg_17_0._hpCountTarget then
		arg_17_0:calcHPCount(arg_17_1)
	end

	if arg_17_0._count >= arg_17_0._hpCountTarget then
		arg_17_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_17_0
		})
	end

	return
end

function var_0_3.calcHPCount(arg_18_0, arg_18_1)
	local var_18_0, var_18_1 = arg_18_1:GetHP()
	local var_18_2 = arg_18_0._caster
	local var_18_3, var_18_4 = var_4.GetHP(var_18_2)

	math = var_18_2
	arg_18_0._hpCountTarget = var_18_2.floor(arg_18_0._casterMaxHPRatio * var_18_4 + arg_18_0._maxHPRatio * var_18_1 + arg_18_0._countTarget)

	return
end

function var_0_3.GetCountType(arg_19_0)
	return arg_19_0._countType
end

function var_0_3.GetCountProgress(arg_20_0)
	local var_20_0

	if not arg_20_0._hpCountTarget then
		var_20_0 = arg_20_0._countTarget
	end

	return arg_20_0._count / var_20_0
end

function var_0_3.SetCount(arg_21_0, arg_21_1)
	arg_21_0._count = arg_21_1

	return
end

function var_0_3.ResetCount(arg_22_0)
	arg_22_0._count = 0

	return
end

function var_0_3.ConsumeCount(arg_23_0)
	local var_23_0

	if not arg_23_0._hpCountTarget then
		var_23_0 = arg_23_0._countTarget
	end

	math = var_1_10002
	arg_23_0._count = var_1_10002.max(arg_23_0._count - var_23_0)

	return
end

return
