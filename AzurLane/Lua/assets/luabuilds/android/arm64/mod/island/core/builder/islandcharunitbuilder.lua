local var_0_0 = class("IslandCharUnitBuilder", import(".IslandBaseBuilder"))

function var_0_0.Load(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:GetPoolMgr():GetSceneCharacter(arg_1_1:GetAssetPath(), arg_1_1:GetAnimator(), arg_1_1:GetBehaviourTree(), arg_1_2)

	return
end

function var_0_0.Recycle(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:GetPoolMgr():ReturnSceneCharacter(arg_2_1:GetAssetPath(), arg_2_1:GetAnimator(), arg_2_1:GetBehaviourTree(), arg_2_2)

	return
end

function var_0_0.AddComponents(arg_3_0, arg_3_1, arg_3_2)
	return
end

return var_0_0
