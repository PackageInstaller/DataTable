ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleAttr
local BattleBuffCount = class("BattleBuffCount", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCount = BattleBuffCount
BattleBuffCount.__name = "BattleBuffCount"

function BattleBuffCount:Ctor(arg_1_1)
	BattleBuffCount.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffCount:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_COUNTER
end

function BattleBuffCount:Repeater()
	return self._keepRestCount
end

function BattleBuffCount:SetArgs(arg_4_1, arg_4_2)
	self._countTarget = self._tempData.arg_list.countTarget or 1
	self._countType = self._tempData.arg_list.countType
	self._weaponType = self._tempData.arg_list.weaponType
	self._index = self._tempData.arg_list.index
	self._maxHPRatio = self._tempData.arg_list.maxHPRatio or 0
	self._casterMaxHPRatio = self._tempData.arg_list.casterMaxHPRatio or 0
	self._clock = self._tempData.arg_list.clock
	self._interrupt = self._tempData.arg_list.interrupt
	self._iconType = self._tempData.arg_list.iconType or 1
	self._gunnerBonus = self._tempData.arg_list.gunnerBonus
	self._keepRestCount = self._tempData.arg_list.keep

	self:ResetCount()

	if self._clock then
		arg_4_1:DispatchCastClock(true, self, self._iconType, self._interrupt)
	end

	return
end

function BattleBuffCount:onRemove(arg_5_1, arg_5_2)
	if self._clock then
		arg_5_1:DispatchCastClock(false, self, nil, self._interrupt and self._count < self._countTarget)
	end

	return
end

function BattleBuffCount:onTrigger(arg_6_1, arg_6_2)
	BattleBuffCount.super.onTrigger(self, arg_6_1, arg_6_2)

	self._count = self._count + 1

	self:checkCount(arg_6_1)

	return
end

function BattleBuffCount:onFire(arg_7_1, arg_7_2, arg_7_3)
	if not self:equipIndexRequire(arg_7_3.equipIndex) then
		return
	end

	self._count = self._count + 1

	self:checkModCount(arg_7_1)

	return
end

function BattleBuffCount:onUpdate(arg_8_1, arg_8_2, arg_8_3)
	self._count = arg_8_3.timeStamp - (self._lastTriggerTime or arg_8_2:GetBuffStartTime())

	if self._count >= self._countTarget then
		self._lastTriggerTime = arg_8_3.timeStamp

		self:ResetCount()
		arg_8_1:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = self
		})
	end

	return
end

function BattleBuffCount:onTakeDamage(arg_9_1, arg_9_2, arg_9_3)
	if self:damageCheck(arg_9_3) then
		self._count = self._count + arg_9_3.damage

		self:checkHPCount(arg_9_1)
	end

	return
end

function BattleBuffCount:onTakeHealing(arg_10_1, arg_10_2, arg_10_3)
	self._count = self._count + arg_10_3.damage

	self:checkHPCount(arg_10_1)

	return
end

function BattleBuffCount:onHPRatioUpdate(arg_11_1, arg_11_2, arg_11_3)
	self._count = self._count + math.abs(arg_11_3.validDHP)

	self:checkHPCount(arg_11_1)

	return
end

function BattleBuffCount:onStack(arg_12_1, arg_12_2, arg_12_3)
	self._count = arg_12_2:GetStack()

	self:checkCount(arg_12_1)

	return
end

function BattleBuffCount:onBulletHit(arg_13_1, arg_13_2, arg_13_3)
	if not self:equipIndexRequire(arg_13_3.equipIndex) then
		return
	end

	self._count = self._count + arg_13_3.damage

	self:checkCount(arg_13_1)

	return
end

function BattleBuffCount:checkCount(arg_14_1)
	if self._count >= self._countTarget then
		arg_14_1:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = self
		})
	end

	return
end

function BattleBuffCount:checkModCount(arg_15_1)
	if self._count >= self:getCount(arg_15_1) then
		arg_15_1:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = self
		})
	end

	return
end

function BattleBuffCount:getCount(arg_16_1)
	local var_16_0 = self._countTarget

	if self._gunnerBonus then
		var_16_0 = math.ceil(var_16_0 / var_0_2.GetCurrent(arg_16_1, "barrageCounterMod"))
	end

	return var_16_0
end

function BattleBuffCount:checkHPCount(arg_17_1)
	if not self._hpCountTarget then
		self:calcHPCount(arg_17_1)
	end

	if self._count >= self._hpCountTarget then
		arg_17_1:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BATTLE_BUFF_COUNT, {
			buffFX = self
		})
	end

	return
end

function BattleBuffCount:calcHPCount(arg_18_1)
	local var_18_0, var_18_1 = arg_18_1:GetHP()
	local var_18_2, var_18_3 = self._caster:GetHP()

	self._hpCountTarget = math.floor(self._casterMaxHPRatio * var_18_3 + self._maxHPRatio * var_18_1 + self._countTarget)

	return
end

function BattleBuffCount:GetCountType()
	return self._countType
end

function BattleBuffCount:GetCountProgress()
	return self._count / (self._hpCountTarget or self._countTarget)
end

function BattleBuffCount:SetCount(arg_21_1)
	self._count = arg_21_1

	return
end

function BattleBuffCount:ResetCount()
	self._count = 0

	return
end

function BattleBuffCount:ConsumeCount()
	self._count = math.max(self._count - (self._hpCountTarget or self._countTarget))

	return
end

return
