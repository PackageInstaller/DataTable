ys = ys or {}

local var_0_0 = class("BattleBuffAddTag", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddTag = var_0_0
var_0_0.__name = "BattleBuffAddTag"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._labelTag = arg_2_0._tempData.arg_list.tag

	return
end

function var_0_0.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:AddLabelTag(arg_3_0._labelTag)

	return
end

function var_0_0.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:RemoveLabelTag(arg_4_0._labelTag)

	return
end

return
