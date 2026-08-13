ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddTag", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAddTag = var_0_1
var_0_1.__name = "BattleBuffAddTag"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._labelTag = arg_2_0._tempData.arg_list.tag

	return
end

function var_0_1.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:AddLabelTag(arg_3_0._labelTag)

	return
end

function var_0_1.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:RemoveLabelTag(arg_4_0._labelTag)

	return
end

return
