ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffRecordShield = class("BattleBuffRecordShield", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffRecordShield.__name = "BattleBuffRecordShield"

local var_0_1 = ys.Battle.BattleBuffRecordShield

ys.Battle.BattleBuffRecordShield.MODE_RECORD = "record"
ys.Battle.BattleBuffRecordShield.MODE_SHIELD = "shield"

function ys.Battle.BattleBuffRecordShield.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffRecordShield.GetEffectAttachData(arg_2_0)
	return arg_2_0._shieldValue
end

function ys.Battle.BattleBuffRecordShield.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._damageAttrRequire = arg_3_0._tempData.arg_list.damageAttr
	arg_3_0._damageSrcTagRequire = arg_3_0._tempData.arg_list.srcTag
	arg_3_0._convertRate = arg_3_0._tempData.arg_list.convertRate
	arg_3_0._shieldDuration = arg_3_0._tempData.arg_list.shield_duration
	arg_3_0._recordDuration = arg_3_0._tempData.arg_list.record_duration
	arg_3_0._exhaustRemove = arg_3_0._tempData.arg_list.exhaust_remove
	arg_3_0._shieldValue = 0
	arg_3_0._recordDamage = 0
	arg_3_0._shieldStartTimeStamp = 0
	arg_3_0._recordStartTimeStamp = 0
	arg_3_0._unit = arg_3_1
	arg_3_0._fxName = arg_3_0._tempData.arg_list.effect
	arg_3_0._effectIndex = "BattleBuffRecordShield" .. arg_3_2:GetID()

	arg_3_0:switchMode(var_0_1.MODE_RECORD)

	return
end

function ys.Battle.BattleBuffRecordShield.onUpdate(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_4_0._buffMode == var_0_1.MODE_SHIELD then
		if arg_4_0._shieldDuration and var_4_0 - arg_4_0._shieldStartTimeStamp > arg_4_0._shieldDuration or arg_4_0._shieldValue <= 0 then
			arg_4_0:handleShieldExhaust(arg_4_2)
		end
	elseif arg_4_0._buffMode == var_0_1.MODE_RECORD and arg_4_0._recordDuration and var_4_0 - arg_4_0._recordStartTimeStamp > arg_4_0._recordDuration then
		arg_4_0:switchMode(var_0_1.MODE_SHIELD)
	end

	return
end

function ys.Battle.BattleBuffRecordShield.handleShieldExhaust(arg_5_0, arg_5_1)
	if arg_5_0._exhaustRemove then
		arg_5_1:SetToCancel()
	else
		arg_5_0:switchMode(var_0_1.MODE_RECORD)
	end

	return
end

function ys.Battle.BattleBuffRecordShield.switchMode(arg_6_0, arg_6_1)
	arg_6_0._buffMode = arg_6_1

	local var_6_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_6_1 == var_0_1.MODE_SHIELD then
		arg_6_0._shieldStartTimeStamp = var_6_0
		arg_6_0._shieldValue = arg_6_0:calcNumber()
		arg_6_0.onTakeDamage = var_0_1.__shieldTakeDamage

		arg_6_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
			index = arg_6_0._effectIndex,
			effect = arg_6_0._fxName
		}))
	elseif arg_6_1 == var_0_1.MODE_RECORD then
		arg_6_0._recordStartTimeStamp = var_6_0
		arg_6_0._recordDamage = 0
		arg_6_0._shieldValue = 0
		arg_6_0.onTakeDamage = var_0_1.__recordDamage

		arg_6_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
			index = arg_6_0._effectIndex
		}))
	end

	return
end

function ys.Battle.BattleBuffRecordShield.__shieldTakeDamage(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0:damageCheck(arg_7_3) then
		arg_7_0._shieldValue = arg_7_0._shieldValue - arg_7_3.damage

		if arg_7_0._shieldValue > 0 then
			arg_7_3.damage = 0
		else
			arg_7_3.damage = -arg_7_0._shieldValue

			arg_7_0:handleShieldExhaust(arg_7_2)
		end
	end

	return
end

function ys.Battle.BattleBuffRecordShield.__recordDamage(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:damageCheck(arg_8_3) then
		return
	end

	if not arg_8_0:DamageSourceRequire(arg_8_3.damageSrc) then
		return
	end

	arg_8_0._recordDamage = arg_8_0._recordDamage + arg_8_3.damage

	if not arg_8_0._recordDuration and arg_8_0:calcNumber() >= 1 then
		arg_8_0:switchMode(var_0_1.MODE_SHIELD)
	end

	return
end

function ys.Battle.BattleBuffRecordShield.calcNumber(arg_9_0)
	return (math.max(0, math.floor(arg_9_0._recordDamage * arg_9_0._convertRate)))
end

function ys.Battle.BattleBuffRecordShield.Clear(arg_10_0)
	arg_10_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
		index = arg_10_0._effectIndex
	}))
	var_0_1.super.Clear(arg_10_0)

	return
end

return
