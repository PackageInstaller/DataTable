ys = ys or {}

local var_0_1 = ys.Battle.BattleAttr
local var_0_2 = class("BattleBuffCount", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCount = var_0_2
var_0_2.__name = "BattleBuffCount"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_COUNTER
end

function var_0_2.Repeater(arg_3_0)
	return arg_3_0._keepRestCount
end

function var_0_2.SetArgs(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._countTarget = arg_4_0._tempData.arg_list.countTarget or 1
	arg_4_0._countType = arg_4_0._tempData.arg_list.countType
	arg_4_0._weaponType = arg_4_0._tempData.arg_list.weaponType
	arg_4_0._index = arg_4_0._tempData.arg_list.index
	arg_4_0._maxHPRatio = arg_4_0._tempData.arg_list.maxHPRatio or 0
	arg_4_0._casterMaxHPRatio = arg_4_0._tempData.arg_list.casterMaxHPRatio or 0
	arg_4_0._clock = arg_4_0._tempData.arg_list.clock
	arg_4_0._interrupt = arg_4_0._tempData.arg_list.interrupt
	arg_4_0._iconType = arg_4_0._tempData.arg_list.iconType or 1
	arg_4_0._gunnerBonus = arg_4_0._tempData.arg_list.gunnerBonus
	arg_4_0._keepRestCount = arg_4_0._tempData.arg_list.keep

	arg_4_0:ResetCount()

	if arg_4_0._clock then
		arg_4_1:DispatchCastClock(true, arg_4_0, arg_4_0._iconType, arg_4_0._interrupt)
	end

	return
end

function var_0_2.onRemove(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._clock then
		local var_5_0 = arg_5_0._interrupt and arg_5_0._count < arg_5_0._countTarget

		arg_5_1:DispatchCastClock(false, arg_5_0, nil, var_5_0)
	end

	return
end

function var_0_2.onTrigger(arg_6_0, arg_6_1, arg_6_2)
	var_0_2.super.onTrigger(arg_6_0, arg_6_1, arg_6_2)

	arg_6_0._count = arg_6_0._count + 1

	arg_6_0:checkCount(arg_6_1)

	return
end

function var_0_2.onFire(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0:equipIndexRequire(arg_7_3.equipIndex) then
		return
	end

	arg_7_0._count = arg_7_0._count + 1

	arg_7_0:checkModCount(arg_7_1)

	return
end

function var_0_2.onUpdate(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0._lastTriggerTime or arg_8_2:GetBuffStartTime()

	arg_8_0._count = arg_8_3.timeStamp - var_8_0

	if arg_8_0._count >= arg_8_0._countTarget then
		arg_8_0._lastTriggerTime = arg_8_3.timeStamp

		arg_8_0:ResetCount()
		arg_8_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_8_0
		})
	end

	return
end

function var_0_2.onTakeDamage(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0:damageCheck(arg_9_3) then
		arg_9_0._count = arg_9_0._count + arg_9_3.damage

		arg_9_0:checkHPCount(arg_9_1)
	end

	return
end

function var_0_2.onTakeHealing(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._count = arg_10_0._count + arg_10_3.damage

	arg_10_0:checkHPCount(arg_10_1)

	return
end

function var_0_2.onHPRatioUpdate(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._count = arg_11_0._count + math.abs(arg_11_3.validDHP)

	arg_11_0:checkHPCount(arg_11_1)

	return
end

function var_0_2.onStack(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._count = arg_12_2:GetStack()

	arg_12_0:checkCount(arg_12_1)

	return
end

function var_0_2.onBulletHit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0:equipIndexRequire(arg_13_3.equipIndex) then
		return
	end

	arg_13_0._count = arg_13_0._count + arg_13_3.damage

	arg_13_0:checkCount(arg_13_1)

	return
end

function var_0_2.checkCount(arg_14_0, arg_14_1)
	if arg_14_0._count >= arg_14_0._countTarget then
		arg_14_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_14_0
		})
	end

	return
end

function var_0_2.checkModCount(arg_15_0, arg_15_1)
	if arg_15_0._count >= arg_15_0:getCount(arg_15_1) then
		arg_15_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = arg_15_0
		})
	end

	return
end

function var_0_2.getCount(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._countTarget

	if arg_16_0._gunnerBonus then
		var_16_0 = math.ceil(var_16_0 / var_0_1.GetCurrent(arg_16_1, "barrageCounterMod"))
	end

	return var_16_0
end

function var_0_2.checkHPCount(arg_17_0, arg_17_1)
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

function var_0_2.calcHPCount(arg_18_0, arg_18_1)
	local var_18_0, var_18_1 = arg_18_1:GetHP()
	local var_18_2, var_18_3 = arg_18_0._caster:GetHP()

	arg_18_0._hpCountTarget = math.floor(arg_18_0._casterMaxHPRatio * var_18_3 + arg_18_0._maxHPRatio * var_18_1 + arg_18_0._countTarget)

	return
end

function var_0_2.GetCountType(arg_19_0)
	return arg_19_0._countType
end

function var_0_2.GetCountProgress(arg_20_0)
	local var_20_0 = arg_20_0._hpCountTarget or arg_20_0._countTarget

	return arg_20_0._count / var_20_0
end

function var_0_2.SetCount(arg_21_0, arg_21_1)
	arg_21_0._count = arg_21_1

	return
end

function var_0_2.ResetCount(arg_22_0)
	arg_22_0._count = 0

	return
end

function var_0_2.ConsumeCount(arg_23_0)
	local var_23_0 = arg_23_0._hpCountTarget or arg_23_0._countTarget

	arg_23_0._count = math.max(arg_23_0._count - var_23_0)

	return
end

return
