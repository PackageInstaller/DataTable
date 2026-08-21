ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillSetCount = class("BattleSkillSetCount", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillSetCount.__name = "BattleSkillSetCount"

local var_0_1 = ys.Battle.BattleSkillSetCount

function ys.Battle.BattleSkillSetCount.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._countType = arg_1_0._tempData.arg_list.countType
	arg_1_0._countTarget = arg_1_0._tempData.arg_list.countTarget or 0

	return
end

function ys.Battle.BattleSkillSetCount.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:doSetCounter(arg_2_2)

	return
end

function ys.Battle.BattleSkillSetCount.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doSetCounter(arg_3_1)

	return
end

function ys.Battle.BattleSkillSetCount.doSetCounter(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs((arg_4_1:GetBuffList())) do
		for iter_4_2, iter_4_3 in ipairs((iter_4_1:GetEffectList())) do
			if iter_4_3:GetEffectType() == var_0_0.Battle.BattleBuffEffect.FX_TYPE_COUNTER and iter_4_3:GetCountType() == arg_4_0._countType then
				iter_4_3:SetCount(arg_4_0._countTarget)
			end
		end
	end

	return
end

return
