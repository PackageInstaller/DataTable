ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffRemoteBone", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffRemoteBone = var_0_1
var_0_1.__name = "BattleBuffRemoteBone"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._group = arg_2_2:GetID()
	arg_2_0._targetChoice = arg_2_0._tempData.arg_list.bone_target
	arg_2_0._bone = arg_2_0._tempData.arg_list.bone_name

	return
end

function var_0_1.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:SetRemoteBoundBone(arg_3_0._group, arg_3_0._bone, arg_3_0._targetChoice)

	return
end

function var_0_1.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:RemoveRemoteBoundBone(arg_4_0._group)

	return
end

return
