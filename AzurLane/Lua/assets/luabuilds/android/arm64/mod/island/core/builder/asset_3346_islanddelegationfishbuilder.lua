class = var_0_10000

local var_0_0 = "IslandDelegationFishBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandGenericBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandDelegationFishUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.LoadAsset(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.modelId
	local var_2_1 = arg_2_1:GetAssetPath()
	local var_2_2 = arg_2_1:GetAnimator()
	local var_2_3 = arg_2_1:GetBehaviourTree()
	local var_2_4 = arg_2_0:GetPoolMgr()

	var_7.GetSceneDelegateItem(var_2_4, var_2_1, var_2_2, var_2_3, arg_2_2)

	return
end

function var_0_1.Recycle(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetAssetPath()
	local var_3_1 = arg_3_1:GetAnimator()
	local var_3_2 = arg_3_1:GetBehaviourTree()
	local var_3_3 = arg_3_0:GetPoolMgr()

	var_6.ReturnSceneDelegateItem(var_3_3, var_3_0, var_3_1, var_3_2, arg_3_2)

	return
end

function var_0_1.SetTag(arg_4_0, arg_4_1)
	IslandConst = var_1_10002
	arg_4_1.tag = var_1_10002.TAG_NPC

	return
end

return var_0_1
