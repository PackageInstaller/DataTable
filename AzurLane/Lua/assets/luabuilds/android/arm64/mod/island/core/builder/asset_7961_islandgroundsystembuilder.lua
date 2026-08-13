class = var_0_10000

local var_0_0 = "IslandGroundSystemBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSystemBuilder"))

function var_0_1.Load(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:CreateNode(arg_1_1, function(arg_2_0)
		arg_1_2(arg_2_0)

		return
	end)

	return
end

function var_0_1.CreateNode(arg_3_0, arg_3_1, arg_3_2)
	IslandAssetLoadDispatcher = var_1_10003

	local var_3_0 = var_1_10003.Instance
	local var_3_1 = var_3.Enqueue
	local var_3_2 = arg_3_1
	local var_3_3 = arg_3_1.GetAssetPath(var_3_2)
	local var_3_4 = ""

	typeof = var_3_2
	GameObject = var_1_10010

	local var_3_5 = var_3_2(var_1_10010)

	UnityEngine = var_1_10009

	local var_3_6 = var_3_1(var_3_0, var_3_3, var_3_4, var_3_5, var_1_10009.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		FrameAsyncInstantiateManager = var_2_10001

		local var_4_0 = var_2_10001.Instance
		local var_4_1 = var_1.EnqueueInstantiate(var_4_0, arg_4_0, function(arg_5_0)
			arg_3_2(arg_5_0)

			return
		end)

		table = var_2_10002

		var_2_10002.insert(arg_3_0.insIdList, var_4_1)

		return
	end), true, true)

	arg_3_0:AddLoadingID(var_3_6)

	return
end

return var_0_1
