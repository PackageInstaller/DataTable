local var_0_0 = class("IslandDelegationFishBuilder", import(".IslandGenericBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandDelegationFishUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.LoadAsset(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:GetPoolMgr():GetSceneDelegateItem(arg_2_1:GetAssetPath(), arg_2_1:GetAnimator(), arg_2_1:GetBehaviourTree(), arg_2_2)

	return
end

function var_0_0.Recycle(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:GetPoolMgr():ReturnSceneDelegateItem(arg_3_1:GetAssetPath(), arg_3_1:GetAnimator(), arg_3_1:GetBehaviourTree(), arg_3_2)

	return
end

function var_0_0.SetTag(arg_4_0, arg_4_1)
	arg_4_1.tag = IslandConst.TAG_NPC

	return
end

return var_0_0
