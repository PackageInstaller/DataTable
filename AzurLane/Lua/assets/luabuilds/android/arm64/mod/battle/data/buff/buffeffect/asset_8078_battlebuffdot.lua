ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleAttr
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleConfig
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleBuffDOT = var_0_10005("BattleBuffDOT", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffDOT.__name = "BattleBuffDOT"

local var_0_5 = var_0.Battle.BattleBuffDOT

var_0_5.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_DOT

function var_0_5.Ctor(arg_1_0, arg_1_1)
	var_0_5.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_5.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_DOT
end

function var_0_5.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0._tempData.arg_list.number then
		var_3_0 = 0
	end

	arg_3_0._number = var_3_0

	local var_3_1

	if not arg_3_0._tempData.arg_list.time then
		var_3_1 = 0
	end

	arg_3_0._time = var_3_1
	pg = var_3_1

	local var_3_2 = var_3_1.TimeMgr.GetInstance()

	arg_3_0._nextEffectTime = var_3.GetCombatTime(var_3_2) + arg_3_0._time

	local var_3_3

	if not arg_3_0._tempData.arg_list.maxHPRatio then
		var_3_3 = 0
	end

	arg_3_0._maxHPRatio = var_3_3

	local var_3_4

	if not arg_3_0._tempData.arg_list.currentHPRatio then
		var_3_4 = 0
	end

	arg_3_0._currentHPRatio = var_3_4

	local var_3_5

	if not arg_3_0._tempData.arg_list.minRestHPRatio then
		var_3_5 = 0
	end

	arg_3_0._minRestHPRatio = var_3_5

	local var_3_6

	if not arg_3_0._tempData.arg_list.randExtraRange then
		var_3_6 = 0
	end

	arg_3_0._randExtraRange = var_3_6

	local var_3_7

	if not arg_3_0._tempData.arg_list.cloakExpose then
		var_3_7 = 0
	end

	arg_3_0._cloakExpose = var_3_7

	local var_3_8

	if not arg_3_0._tempData.arg_list._exposeGroup then
		var_3_8 = arg_3_2:GetID()
	end

	arg_3_0._exposeGroup = var_3_8

	local var_3_9

	if not arg_3_0._level then
		var_3_9 = 0
	end

	arg_3_0._level = var_3_9
	arg_3_0._metaDot = arg_3_0._tempData.arg_list.metaDot

	local var_3_10 = 0

	if not arg_3_0._metaDot then
		var_3_10 = var_0_2.CaclulateDOTDuration(arg_3_0._tempData, arg_3_0._orb, arg_3_1)
	end

	arg_3_2:SetOrbDuration(var_3_10)

	if arg_3_0._tempData.arg_list.WorldBossDotDamage then
		local var_3_11 = arg_3_0._tempData.arg_list.WorldBossDotDamage
		local var_3_12 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_3_13

		if not var_6.GetInitData(var_3_12)[var_3_11.useGlobalAttr] then
			pg = var_3_13
			var_3_13 = var_3_13.bfConsts.NUM0
		end

		local var_3_14

		if not var_3_11.paramA then
			pg = var_3_14
			var_3_14 = var_3_14.bfConsts.NUM1
		end

		arg_3_0._igniteDMG = var_3_13 * var_3_14
	elseif arg_3_0._orb then
		arg_3_0._igniteAttr = arg_3_0._tempData.arg_list.attr
		arg_3_0._igniteCoefficient = arg_3_0._tempData.arg_list.k
		arg_3_0._igniteDMG = var_0_2.CalculateIgniteDamage(arg_3_0._orb, arg_3_0._igniteAttr, arg_3_0._igniteCoefficient)
	elseif arg_3_0._infection then
		arg_3_0._igniteDMG = arg_3_0._infection
	else
		arg_3_0._igniteDMG = 0
	end

	if arg_3_0._cloakExpose and arg_3_0._cloakExpose > 0 then
		arg_3_1:CloakExpose(arg_3_0._cloakExpose)
	end

	arg_3_0._infective = arg_3_0._tempData.arg_list.infective
	arg_3_0._proxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0_5.onStack(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_5.onUpdate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.timeStamp >= arg_5_0._nextEffectTime then
		arg_5_0:doDamage(arg_5_1, arg_5_2)

		if arg_5_1:IsAlive() then
			arg_5_0._nextEffectTime = arg_5_0._nextEffectTime + arg_5_0._time
		end
	end

	return
end

function var_0_5.onSink(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:handleInfect(arg_6_1, arg_6_2)

	return
end

function var_0_5.onRemove(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:doDamage(arg_7_1, arg_7_2)

	return
end

function var_0_5.doDamage(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:IsAlive()
	local var_8_1 = arg_8_0:CalcNumber(arg_8_1, arg_8_2)
	local var_8_2 = arg_8_0._proxy

	var_5.HandleDirectDamage(var_8_2, arg_8_1, var_8_1)

	if not arg_8_1:IsAlive() and var_8_0 then
		arg_8_0:handleInfect(arg_8_1, arg_8_2)
	end

	return
end

function var_0_5.handleInfect(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._infective then
		return
	end

	local var_9_0 = arg_9_0._infective.target_choise
	local var_9_1 = arg_9_0._infective.arg_list
	local var_9_2 = arg_9_0:getTargetList(arg_9_1, var_9_0, var_9_1, {})

	ipairs = var_1_10006

	for iter_9_0, iter_9_1 in var_1_10006(var_9_2) do
		local var_9_3 = var_0.Battle.BattleBuffUnit.New(arg_9_2:GetID(), arg_9_2:GetLv())

		var_11.SetInfection(var_9_3, arg_9_0._igniteDMG)
		iter_9_1:AddBuff(var_11)
	end

	return
end

function var_0_5.CalcNumber(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._metaDot then
		local var_10_0 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_10_1 = var_3.GetInitData(var_10_0)

		return (var_0_2.CaclulateMetaDotaDamage(var_10_1.bossConfigId, var_10_1.bossLevel))
	else
		local var_10_2 = var_0_2.CaclulateDOTDamageEnhanceRate(arg_10_0._tempData, arg_10_0._orb, arg_10_1)
		local var_10_3, var_10_4 = arg_10_1:GetHP()
		local var_10_5 = var_10_3 * arg_10_0._currentHPRatio + var_10_4 * arg_10_0._maxHPRatio + arg_10_0._number + arg_10_0._igniteDMG
		local var_10_6 = arg_10_0._randExtraRange

		if 0 < var_10_6 then
			math = var_10_6
			var_10_5 = var_10_5 + var_10_6.random(0, arg_10_0._randExtraRange)
		end

		local var_10_7 = var_10_5 * (1 + var_10_2)

		math = var_8

		local var_10_8 = var_8.max
		local var_10_9 = 0

		math = var_1_10011

		local var_10_10 = var_1_10011.floor

		math = var_1_10013

		return var_10_8(var_10_9, var_10_10(var_1_10013.min(var_10_3 - var_10_4 * arg_10_0._minRestHPRatio, var_10_7 * arg_10_2._stack * var_0_1.GetCurrent(arg_10_1, "repressReduce"))))
	end

	return
end

function var_0_5.SetOrb(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._orb = arg_11_2
	arg_11_0._level = arg_11_3

	arg_11_1:SetOrbLevel(arg_11_0._level)

	return
end

function var_0_5.SetInfection(arg_12_0, arg_12_1)
	arg_12_0._infection = arg_12_1

	return
end

function var_0_5.UpdateCloakLock(arg_13_0)
	local var_13_0 = arg_13_0:GetBuffList()
	local var_13_1 = 0
	local var_13_2 = {}

	pairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(var_13_0) do
		ipairs = var_1_10009

		for iter_13_2, iter_13_3 in var_1_10009(iter_13_1._effectList) do
			if iter_13_3:GetEffectType() == var_0_5.FX_TYPE then
				local var_13_3 = iter_13_3._cloakExpose
				local var_13_4

				if not var_13_2[iter_13_3._exposeGroup] then
					var_13_4 = 0
				end

				if var_13_4 < var_13_3 then
					var_13_1 = var_13_1 + var_13_3 - var_13_4
					var_13_4 = var_13_3
				end

				var_13_2[var_15] = var_13_4
			end
		end
	end

	arg_13_0:CloakOnFire(var_13_1)

	return
end

return
