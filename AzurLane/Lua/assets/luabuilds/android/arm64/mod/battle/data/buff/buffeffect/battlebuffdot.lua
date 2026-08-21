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

function ys.Battle.BattleBuffDOT.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._number = arg_3_0._tempData.arg_list.number or 0
	arg_3_0._time = arg_3_0._tempData.arg_list.time or 0
	arg_3_0._nextEffectTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_3_0._time
	arg_3_0._maxHPRatio = arg_3_0._tempData.arg_list.maxHPRatio or 0
	arg_3_0._currentHPRatio = arg_3_0._tempData.arg_list.currentHPRatio or 0
	arg_3_0._minRestHPRatio = arg_3_0._tempData.arg_list.minRestHPRatio or 0
	arg_3_0._randExtraRange = arg_3_0._tempData.arg_list.randExtraRange or 0
	arg_3_0._cloakExpose = arg_3_0._tempData.arg_list.cloakExpose or 0
	arg_3_0._exposeGroup = arg_3_0._tempData.arg_list._exposeGroup or arg_3_2:GetID()
	arg_3_0._level = arg_3_0._level or 0
	arg_3_0._metaDot = arg_3_0._tempData.arg_list.metaDot

	local var_3_0 = 0

	if not arg_3_0._metaDot then
		var_3_0 = var_0_2.CaclulateDOTDuration(arg_3_0._tempData, arg_3_0._orb, arg_3_1)
	end

	arg_3_2:SetOrbDuration(var_3_0)

	if arg_3_0._tempData.arg_list.WorldBossDotDamage then
		local var_3_1 = var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData()[arg_3_0._tempData.arg_list.WorldBossDotDamage.useGlobalAttr] or pg.bfConsts.NUM0
		local var_3_2 = arg_3_0._tempData.arg_list.WorldBossDotDamage.paramA or pg.bfConsts.NUM1

		arg_3_0._igniteDMG = var_3_1 * var_3_2
	elseif arg_3_0._orb then
		arg_3_0._igniteAttr = arg_3_0._tempData.arg_list.attr
		arg_3_0._igniteCoefficient = arg_3_0._tempData.arg_list.k
		arg_3_0._igniteDMG = var_0_2.CalculateIgniteDamage(arg_3_0._orb, arg_3_0._igniteAttr, arg_3_0._igniteCoefficient)
	else
		arg_3_0._igniteDMG = arg_3_0._infection and arg_3_0._infection or 0
	end

	if arg_3_0._cloakExpose and arg_3_0._cloakExpose > 0 then
		arg_3_1:CloakExpose(arg_3_0._cloakExpose)
	end

	arg_3_0._infective = arg_3_0._tempData.arg_list.infective
	arg_3_0._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleBuffDOT.onStack(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.BattleBuffDOT.onUpdate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.timeStamp >= arg_5_0._nextEffectTime then
		arg_5_0:doDamage(arg_5_1, arg_5_2)

		if arg_5_1:IsAlive() then
			arg_5_0._nextEffectTime = arg_5_0._nextEffectTime + arg_5_0._time
		end
	end

	return
end

function ys.Battle.BattleBuffDOT.onSink(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:handleInfect(arg_6_1, arg_6_2)

	return
end

function ys.Battle.BattleBuffDOT.onRemove(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:doDamage(arg_7_1, arg_7_2)

	return
end

function ys.Battle.BattleBuffDOT.doDamage(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._proxy:HandleDirectDamage(arg_8_1, (arg_8_0:CalcNumber(arg_8_1, arg_8_2)))

	if not arg_8_1:IsAlive() and arg_8_1:IsAlive() then
		arg_8_0:handleInfect(arg_8_1, arg_8_2)
	end

	return
end

function ys.Battle.BattleBuffDOT.handleInfect(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._infective then
		return
	end

	for iter_9_0, iter_9_1 in ipairs((arg_9_0:getTargetList(arg_9_1, arg_9_0._infective.target_choise, arg_9_0._infective.arg_list, {}))) do
		local var_9_0 = var_0_0.Battle.BattleBuffUnit.New(arg_9_2:GetID(), arg_9_2:GetLv())

		var_9_0:SetInfection(arg_9_0._igniteDMG)
		iter_9_1:AddBuff(var_9_0)
	end

	return
end

function ys.Battle.BattleBuffDOT.CalcNumber(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._metaDot then
		local var_10_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData()

		return (var_0_2.CaclulateMetaDotaDamage(var_10_0.bossConfigId, var_10_0.bossLevel))
	else
		local var_10_1 = var_0_2.CaclulateDOTDamageEnhanceRate(arg_10_0._tempData, arg_10_0._orb, arg_10_1)
		local var_10_2, var_10_3 = arg_10_1:GetHP()
		local var_10_4 = var_10_2 * arg_10_0._currentHPRatio + var_10_3 * arg_10_0._maxHPRatio + arg_10_0._number + arg_10_0._igniteDMG

		if arg_10_0._randExtraRange > 0 then
			var_10_4 = var_10_4 + math.random(0, arg_10_0._randExtraRange)
		end

		return math.max(0, math.floor(math.min(var_10_2 - var_10_3 * arg_10_0._minRestHPRatio, var_10_4 * (1 + var_10_1) * arg_10_2._stack * var_0_1.GetCurrent(arg_10_1, "repressReduce"))))
	end

	return
end

function ys.Battle.BattleBuffDOT.SetOrb(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._orb = arg_11_2
	arg_11_0._level = arg_11_3

	arg_11_1:SetOrbLevel(arg_11_0._level)

	return
end

function ys.Battle.BattleBuffDOT.SetInfection(arg_12_0, arg_12_1)
	arg_12_0._infection = arg_12_1

	return
end

function ys.Battle.BattleBuffDOT.UpdateCloakLock(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs((arg_13_0:GetBuffList())) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1._effectList) do
			if iter_13_3:GetEffectType() == var_0_4.FX_TYPE then
				local var_13_1 = ({})[iter_13_3._exposeGroup]

				if not ({})[iter_13_3._exposeGroup] then
					var_13_1 = 0
				end

				if var_13_1 < iter_13_3._cloakExpose then
					var_13_0 = var_13_0 + iter_13_3._cloakExpose - var_13_1
					var_13_1 = iter_13_3._cloakExpose
				end

				;({})[iter_13_3._exposeGroup] = var_13_1
			end
		end
	end

	arg_13_0:CloakOnFire(var_13_0)

	return
end

return
