ys = ys or {}

local BattleSkillEditTag = class("BattleSkillEditTag", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillEditTag = BattleSkillEditTag
BattleSkillEditTag.__name = "BattleSkillEditTag"
BattleSkillEditTag.TAG_OPERATION_APPEND = 1
BattleSkillEditTag.TAG_OPERATION_REMOVE = -1

function BattleSkillEditTag:Ctor(arg_1_1, arg_1_2)
	BattleSkillEditTag.super.Ctor(self, arg_1_1, arg_1_2)

	self._tag = self._tempData.arg_list.tag
	self._op = self._tempData.arg_list.operation

	return
end

function BattleSkillEditTag:DoDataEffect(arg_2_1, arg_2_2)
	if self._op == BattleSkillEditTag.TAG_OPERATION_APPEND then
		arg_2_2:AddLabelTag(self._tag)
	elseif self._op == BattleSkillEditTag.TAG_OPERATION_REMOVE then
		arg_2_2:RemoveLabelTag(self._tag)
	end

	return
end

return
