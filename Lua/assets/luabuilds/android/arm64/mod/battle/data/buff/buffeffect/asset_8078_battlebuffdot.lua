ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleAttr
local var_0_2 = ys.Battle.BattleFormulas

ys.Battle.BattleBuffDOT = class("BattleBuffDOT", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffDOT.__name = "BattleBuffDOT"

local var_0_4 = ys.Battle.BattleBuffDOT

ys.Battle.BattleBuffDOT.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_DOT

function ys.Battle.BattleBuffDOT.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffDOT.GetEffectType(arg_2_0)
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_DOT
end

function ys.Battle.BattleBuffDOT:SetArgs(arg_3_1, arg_3_2)
	self._number = self._tempData.arg_list.number or 0
	self._time = self._tempData.arg_list.time or 0
	self._nextEffectTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._time
	self._maxHPRatio = self._tempData.arg_list.maxHPRatio or 0
	self._currentHPRatio = self._tempData.arg_list.currentHPRatio or 0
	self._minRestHPRatio = self._tempData.arg_list.minRestHPRatio or 0
	self._randExtraRange = self._tempData.arg_list.randExtraRange or 0
	self._cloakExpose = self._tempData.arg_list.cloakExpose or 0
	self._exposeGroup = self._tempData.arg_list._exposeGroup or arg_3_2:GetID()
	self._level = self._level or 0
	self._metaDot = self._tempData.arg_list.metaDot

	arg_3_2:SetOrbDuration((not self._metaDot or nil) and var_0_2.CaclulateDOTDuration(self._tempData, self._orb, arg_3_1))

	if self._tempData.arg_list.WorldBossDotDamage then
		self._igniteDMG = (var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData()[self._tempData.arg_list.WorldBossDotDamage.useGlobalAttr] or pg.bfConsts.NUM0) * ((not self._tempData.arg_list.WorldBossDotDamage.paramA or nil) and pg.bfConsts.NUM1)
	elseif self._orb then
		self._igniteAttr = self._tempData.arg_list.attr
		self._igniteCoefficient = self._tempData.arg_list.k
		self._igniteDMG = var_0_2.CalculateIgniteDamage(self._orb, self._igniteAttr, self._igniteCoefficient)
	else
		self._igniteDMG = self._infection and self._infection or 0
	end

	if self._cloakExpose and self._cloakExpose > 0 then
		arg_3_1:CloakExpose(self._cloakExpose)
	end

	self._infective = self._tempData.arg_list.infective
	self._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleBuffDOT.onStack(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.BattleBuffDOT:onUpdate(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.timeStamp >= self._nextEffectTime then
		self:doDamage(arg_5_1, arg_5_2)

		if arg_5_1:IsAlive() then
			self._nextEffectTime = self._nextEffectTime + self._time
		end
	end

	return
end

function ys.Battle.BattleBuffDOT:onSink(arg_6_1, arg_6_2, arg_6_3)
	self:handleInfect(arg_6_1, arg_6_2)

	return
end

function ys.Battle.BattleBuffDOT:onRemove(arg_7_1, arg_7_2)
	self:doDamage(arg_7_1, arg_7_2)

	return
end

function ys.Battle.BattleBuffDOT:doDamage(arg_8_1, arg_8_2)
	self._proxy:HandleDirectDamage(arg_8_1, (self:CalcNumber(arg_8_1, arg_8_2)))

	if not arg_8_1:IsAlive() and arg_8_1:IsAlive() then
		self:handleInfect(arg_8_1, arg_8_2)
	end

	return
end

function ys.Battle.BattleBuffDOT:handleInfect(arg_9_1, arg_9_2)
	if not self._infective then
		return
	end

	for iter_9_0, iter_9_1 in ipairs((self:getTargetList(arg_9_1, self._infective.target_choise, self._infective.arg_list, {}))) do
		local var_9_0 = var_0_0.Battle.BattleBuffUnit.New(arg_9_2:GetID(), arg_9_2:GetLv())

		var_9_0:SetInfection(self._igniteDMG)
		iter_9_1:AddBuff(var_9_0)
	end

	return
end

function ys.Battle.BattleBuffDOT:CalcNumber(arg_10_1, arg_10_2)
	if self._metaDot then
		local var_10_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData()

		return (var_0_2.CaclulateMetaDotaDamage(var_10_0.bossConfigId, var_10_0.bossLevel))
	else
		local var_10_1 = var_0_2.CaclulateDOTDamageEnhanceRate(self._tempData, self._orb, arg_10_1)
		local var_10_2, var_10_3 = arg_10_1:GetHP()
		local var_10_4 = var_10_2 * self._currentHPRatio + var_10_3 * self._maxHPRatio + self._number + self._igniteDMG

		if self._randExtraRange > 0 then
			var_10_4 = var_10_4 + math.random(0, self._randExtraRange)
		end

		return math.max(0, math.floor(math.min(var_10_2 - var_10_3 * self._minRestHPRatio, var_10_4 * (1 + var_10_1) * arg_10_2._stack * var_0_1.GetCurrent(arg_10_1, "repressReduce"))))
	end

	return
end

function ys.Battle.BattleBuffDOT:SetOrb(arg_11_1, arg_11_2, arg_11_3)
	self._orb = arg_11_2
	self._level = arg_11_3

	arg_11_1:SetOrbLevel(self._level)

	return
end

function ys.Battle.BattleBuffDOT.SetInfection(arg_12_0, arg_12_1)
	arg_12_0._infection = arg_12_1

	return
end

function ys.Battle.BattleBuffDOT:UpdateCloakLock()
	local var_13_0 = 0
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs((self:GetBuffList())) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1._effectList) do
			if iter_13_3:GetEffectType() == var_0_4.FX_TYPE then
				local var_13_2 = var_13_1[iter_13_3._exposeGroup] or 0

				if var_13_2 < iter_13_3._cloakExpose then
					var_13_0 = var_13_0 + iter_13_3._cloakExpose - var_13_2
					var_13_2 = iter_13_3._cloakExpose
				end

				var_13_1[iter_13_3._exposeGroup] = var_13_2
			end
		end
	end

	self:CloakOnFire(var_13_0)

	return
end

return
