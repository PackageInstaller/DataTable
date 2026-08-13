class = var_0_10000

local var_0_0 = "IslandCharUnitBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseBuilder"))

function var_0_1.Load(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetAssetPath()
	local var_1_1 = arg_1_1:GetAnimator()
	local var_1_2 = arg_1_1:GetBehaviourTree()
	local var_1_3 = arg_1_0:GetPoolMgr()

	var_6.GetSceneCharacter(var_1_3, var_1_0, var_1_1, var_1_2, arg_1_2)

	return
end

function var_0_1.Recycle(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetAssetPath()
	local var_2_1 = arg_2_1:GetAnimator()
	local var_2_2 = arg_2_1:GetBehaviourTree()
	local var_2_3 = arg_2_0:GetPoolMgr()

	var_6.ReturnSceneCharacter(var_2_3, var_2_0, var_2_1, var_2_2, arg_2_2)

	return
end

function var_0_1.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	return
end

return var_0_1
