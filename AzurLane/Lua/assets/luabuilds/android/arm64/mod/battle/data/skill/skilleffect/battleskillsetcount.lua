ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillSetCount = var_0_10002("BattleSkillSetCount", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillSetCount.__name = "BattleSkillSetCount"

local var_0_2 = var_0.Battle.BattleSkillSetCount

function var_0_2.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	arg_1_0._countType = arg_1_0._tempData.arg_list.countType

	local var_1_3

	if not arg_1_0._tempData.arg_list.countTarget then
		var_1_3 = 0
	end

	arg_1_0._countTarget = var_1_3

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:doSetCounter(arg_2_2)

	return
end

function var_0_2.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doSetCounter(arg_3_1)

	return
end

function var_0_2.doSetCounter(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetBuffList()

	pairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(var_4_0) do
		local var_4_1 = iter_4_1:GetEffectList()

		ipairs = var_1_10009

		for iter_4_2, iter_4_3 in var_1_10009(var_4_1) do
			if iter_4_3:GetEffectType() == var_0.Battle.BattleBuffEffect.FX_TYPE_COUNTER and iter_4_3:GetCountType() == arg_4_0._countType then
				iter_4_3:SetCount(arg_4_0._countTarget)
			end
		end
	end

	return
end

return
