ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillGridmanFloat = class("BattleSkillGridmanFloat", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillGridmanFloat.__name = "BattleSkillGridmanFloat"

local var_0_1 = ys.Battle.BattleSkillGridmanFloat

function ys.Battle.BattleSkillGridmanFloat:Ctor(arg_1_1, arg_1_2)
	var_0_1.super.Ctor(self, arg_1_1, arg_1_2)

	self._iconType = self._tempData.arg_list.icon_type

	return
end

function ys.Battle.BattleSkillGridmanFloat:DoDataEffect(arg_2_1)
	self:doGridmanSkillFloat(arg_2_1)

	return
end

function ys.Battle.BattleSkillGridmanFloat:DoDataEffectWithoutTarget(arg_3_1)
	self:doGridmanSkillFloat(arg_3_1)

	return
end

function ys.Battle.BattleSkillGridmanFloat:doGridmanSkillFloat(arg_4_1)
	var_0_0.Battle.BattleDataProxy.GetInstance():DispatchGridmanSkill(self._iconType, arg_4_1:GetIFF())

	return
end

return
