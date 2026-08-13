ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffRecordShield = var_0_10002("BattleBuffRecordShield", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffRecordShield.__name = "BattleBuffRecordShield"

local var_0_2 = var_0.Battle.BattleBuffRecordShield

var_0_2.MODE_RECORD = "record"
var_0_2.MODE_SHIELD = "shield"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.GetEffectAttachData(arg_2_0)
	return arg_2_0._shieldValue
end

function var_0_2.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._damageAttrRequire = arg_3_0._tempData.arg_list.damageAttr
	arg_3_0._damageSrcTagRequire = var_3.srcTag
	arg_3_0._convertRate = var_3.convertRate
	arg_3_0._shieldDuration = var_3.shield_duration
	arg_3_0._recordDuration = var_3.record_duration
	arg_3_0._exhaustRemove = var_3.exhaust_remove
	arg_3_0._shieldValue = 0
	arg_3_0._recordDamage = 0
	arg_3_0._shieldStartTimeStamp = 0
	arg_3_0._recordStartTimeStamp = 0
	arg_3_0._unit = arg_3_1
	arg_3_0._fxName = var_3.effect
	arg_3_0._effectIndex = "BattleBuffRecordShield" .. arg_3_2:GetID()

	arg_3_0:switchMode(var_0_2.MODE_RECORD)

	return
end

function var_0_2.onUpdate(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.TimeMgr.GetInstance()
	local var_4_1 = var_3.GetCombatTime(var_4_0)

	if arg_4_0._buffMode == var_0_2.MODE_SHIELD then
		if arg_4_0._shieldDuration and var_4_1 - arg_4_0._shieldStartTimeStamp > arg_4_0._shieldDuration or arg_4_0._shieldValue <= 0 then
			arg_4_0:handleShieldExhaust(arg_4_2)
		end
	elseif arg_4_0._buffMode == var_0_2.MODE_RECORD and arg_4_0._recordDuration and var_4_1 - arg_4_0._recordStartTimeStamp > arg_4_0._recordDuration then
		arg_4_0:switchMode(var_0_2.MODE_SHIELD)
	end

	return
end

function var_0_2.handleShieldExhaust(arg_5_0, arg_5_1)
	if arg_5_0._exhaustRemove then
		arg_5_1:SetToCancel()
	else
		arg_5_0:switchMode(var_0_2.MODE_RECORD)
	end

	return
end

function var_0_2.switchMode(arg_6_0, arg_6_1)
	arg_6_0._buffMode = arg_6_1
	pg = var_1_10002

	local var_6_0 = var_1_10002.TimeMgr.GetInstance()
	local var_6_1 = var_2.GetCombatTime(var_6_0)

	if arg_6_1 == var_0_2.MODE_SHIELD then
		arg_6_0._shieldStartTimeStamp = var_6_1
		arg_6_0._shieldValue = arg_6_0:calcNumber()
		arg_6_0.onTakeDamage = var_0_2.__shieldTakeDamage

		local var_6_2 = {
			index = arg_6_0._effectIndex,
			effect = arg_6_0._fxName
		}
		local var_6_3 = arg_6_0._unit

		var_4.DispatchEvent(var_6_3, var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, var_6_2))
	elseif arg_6_1 == var_0_2.MODE_RECORD then
		arg_6_0._recordStartTimeStamp = var_6_1
		arg_6_0._recordDamage = 0
		arg_6_0._shieldValue = 0
		arg_6_0.onTakeDamage = var_0_2.__recordDamage

		local var_6_4 = arg_6_0._unit

		var_3.DispatchEvent(var_6_4, var_0.Event.New(var_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
			index = arg_6_0._effectIndex
		}))
	end

	return
end

function var_0_2.__shieldTakeDamage(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0:damageCheck(arg_7_3) then
		local var_7_0 = arg_7_3.damage

		arg_7_0._shieldValue = arg_7_0._shieldValue - var_7_0

		if arg_7_0._shieldValue > 0 then
			arg_7_3.damage = 0
		else
			arg_7_3.damage = -arg_7_0._shieldValue

			arg_7_0:handleShieldExhaust(arg_7_2)
		end
	end

	return
end

function var_0_2.__recordDamage(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:damageCheck(arg_8_3) then
		return
	end

	if not arg_8_0:DamageSourceRequire(arg_8_3.damageSrc) then
		return
	end

	arg_8_0._recordDamage = arg_8_0._recordDamage + arg_8_3.damage

	if not arg_8_0._recordDuration and arg_8_0:calcNumber() >= 1 then
		arg_8_0:switchMode(var_0_2.MODE_SHIELD)
	end

	return
end

function var_0_2.calcNumber(arg_9_0)
	math = var_1_10001

	local var_9_0 = var_1_10001.max
	local var_9_1 = 0

	math = var_1_10003

	return (var_9_0(var_9_1, var_1_10003.floor(arg_9_0._recordDamage * arg_9_0._convertRate)))
end

function var_0_2.Clear(arg_10_0)
	local var_10_0 = arg_10_0._unit

	var_1.DispatchEvent(var_10_0, var_0.Event.New(var_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
		index = arg_10_0._effectIndex
	}))
	var_0_2.super.Clear(arg_10_0)

	return
end

return
