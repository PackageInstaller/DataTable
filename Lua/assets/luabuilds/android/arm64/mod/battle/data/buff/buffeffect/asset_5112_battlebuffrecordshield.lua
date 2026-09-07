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

function ys.Battle.BattleBuffRecordShield:GetEffectAttachData()
	return self._shieldValue
end

function ys.Battle.BattleBuffRecordShield:SetArgs(arg_3_1, arg_3_2)
	self._damageAttrRequire = self._tempData.arg_list.damageAttr
	self._damageSrcTagRequire = self._tempData.arg_list.srcTag
	self._convertRate = self._tempData.arg_list.convertRate
	self._shieldDuration = self._tempData.arg_list.shield_duration
	self._recordDuration = self._tempData.arg_list.record_duration
	self._exhaustRemove = self._tempData.arg_list.exhaust_remove
	self._shieldValue = 0
	self._recordDamage = 0
	self._shieldStartTimeStamp = 0
	self._recordStartTimeStamp = 0
	self._unit = arg_3_1
	self._fxName = self._tempData.arg_list.effect
	self._effectIndex = "BattleBuffRecordShield" .. arg_3_2:GetID()

	self:switchMode(var_0_1.MODE_RECORD)

	return
end

function ys.Battle.BattleBuffRecordShield:onUpdate(arg_4_1, arg_4_2)
	local var_4_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if self._buffMode == var_0_1.MODE_SHIELD then
		if self._shieldDuration and var_4_0 - self._shieldStartTimeStamp > self._shieldDuration or self._shieldValue <= 0 then
			self:handleShieldExhaust(arg_4_2)
		end
	elseif self._buffMode == var_0_1.MODE_RECORD and self._recordDuration and var_4_0 - self._recordStartTimeStamp > self._recordDuration then
		self:switchMode(var_0_1.MODE_SHIELD)
	end

	return
end

function ys.Battle.BattleBuffRecordShield:handleShieldExhaust(arg_5_1)
	if self._exhaustRemove then
		arg_5_1:SetToCancel()
	else
		self:switchMode(var_0_1.MODE_RECORD)
	end

	return
end

function ys.Battle.BattleBuffRecordShield:switchMode(arg_6_1)
	self._buffMode = arg_6_1

	local var_6_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_6_1 == var_0_1.MODE_SHIELD then
		self._shieldStartTimeStamp = var_6_0
		self._shieldValue = self:calcNumber()
		self.onTakeDamage = var_0_1.__shieldTakeDamage

		self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
			index = self._effectIndex,
			effect = self._fxName
		}))
	elseif arg_6_1 == var_0_1.MODE_RECORD then
		self._recordStartTimeStamp = var_6_0
		self._recordDamage = 0
		self._shieldValue = 0
		self.onTakeDamage = var_0_1.__recordDamage

		self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
			index = self._effectIndex
		}))
	end

	return
end

function ys.Battle.BattleBuffRecordShield:__shieldTakeDamage(arg_7_1, arg_7_2, arg_7_3)
	if self:damageCheck(arg_7_3) then
		self._shieldValue = self._shieldValue - arg_7_3.damage

		if self._shieldValue > 0 then
			arg_7_3.damage = 0
		else
			arg_7_3.damage = -self._shieldValue

			self:handleShieldExhaust(arg_7_2)
		end
	end

	return
end

function ys.Battle.BattleBuffRecordShield:__recordDamage(arg_8_1, arg_8_2, arg_8_3)
	if not self:damageCheck(arg_8_3) then
		return
	end

	if not self:DamageSourceRequire(arg_8_3.damageSrc) then
		return
	end

	self._recordDamage = self._recordDamage + arg_8_3.damage

	if not self._recordDuration and self:calcNumber() >= 1 then
		self:switchMode(var_0_1.MODE_SHIELD)
	end

	return
end

function ys.Battle.BattleBuffRecordShield:calcNumber()
	return (math.max(0, math.floor(self._recordDamage * self._convertRate)))
end

function ys.Battle.BattleBuffRecordShield:Clear()
	self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
		index = self._effectIndex
	}))
	var_0_1.super.Clear(self)

	return
end

return
