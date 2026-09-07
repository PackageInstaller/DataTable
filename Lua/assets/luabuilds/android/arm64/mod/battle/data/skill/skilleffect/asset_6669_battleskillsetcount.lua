ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillSetCount = class("BattleSkillSetCount", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillSetCount.__name = "BattleSkillSetCount"

local var_0_1 = ys.Battle.BattleSkillSetCount

function ys.Battle.BattleSkillSetCount:Ctor(arg_1_1)
	var_0_1.super.Ctor(self, arg_1_1, lv)

	self._countType = self._tempData.arg_list.countType
	self._countTarget = self._tempData.arg_list.countTarget or 0

	return
end

function ys.Battle.BattleSkillSetCount:DoDataEffect(arg_2_1, arg_2_2)
	self:doSetCounter(arg_2_2)

	return
end

function ys.Battle.BattleSkillSetCount:DoDataEffectWithoutTarget(arg_3_1)
	self:doSetCounter(arg_3_1)

	return
end

function ys.Battle.BattleSkillSetCount:doSetCounter(arg_4_1)
	for iter_4_0, iter_4_1 in pairs((arg_4_1:GetBuffList())) do
		for iter_4_2, iter_4_3 in ipairs((iter_4_1:GetEffectList())) do
			if iter_4_3:GetEffectType() == var_0_0.Battle.BattleBuffEffect.FX_TYPE_COUNTER and iter_4_3:GetCountType() == self._countType then
				iter_4_3:SetCount(self._countTarget)
			end
		end
	end

	return
end

return
