ys = ys or {}

local BattleBuffAddTag = class("BattleBuffAddTag", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddTag = BattleBuffAddTag
BattleBuffAddTag.__name = "BattleBuffAddTag"

function BattleBuffAddTag:Ctor(arg_1_1)
	BattleBuffAddTag.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddTag:SetArgs(arg_2_1, arg_2_2)
	self._labelTag = self._tempData.arg_list.tag

	return
end

function BattleBuffAddTag:onAttach(arg_3_1, arg_3_2)
	arg_3_1:AddLabelTag(self._labelTag)

	return
end

function BattleBuffAddTag:onRemove(arg_4_1, arg_4_2)
	arg_4_1:RemoveLabelTag(self._labelTag)

	return
end

return
