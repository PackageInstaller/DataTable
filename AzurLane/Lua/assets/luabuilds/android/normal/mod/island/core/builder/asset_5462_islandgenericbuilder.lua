class = var_0_10000

local var_0_0 = "IslandGenericBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseBuilder"))

function var_0_1.Load(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1

	table = var_1_10005

	var_1_10005.insert(var_1_0, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.LoadAsset(var_2_0, arg_1_1, function(arg_3_0)
			var_1_1 = arg_3_0

			arg_2_0()

			return
		end)

		return
	end)

	table = var_5

	var_5.insert(var_1_0, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.SetupBT
		local var_4_2 = var_1_1
		local var_4_3 = arg_1_1

		var_4_1(var_4_0, var_4_2, var_4.GetBehaviourTree(var_4_3), arg_4_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_1_0, function()
		arg_1_2(var_1_1)

		return
	end)

	return
end

function var_0_1.LoadAsset(arg_6_0, arg_6_1, arg_6_2)
	IslandAssetLoadDispatcher = var_1_10003

	local var_6_0 = var_1_10003.Instance
	local var_6_1 = var_3.Enqueue
	local var_6_2 = arg_6_1:GetAssetPath()
	local var_6_3 = ""

	typeof = var_1_10007
	GameObject = var_1_10008

	local var_6_4 = var_1_10007(var_1_10008)

	UnityEngine = var_1_10008

	local var_6_5 = var_6_1(var_6_0, var_6_2, var_6_3, var_6_4, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
		FrameAsyncInstantiateManager = var_2_10001

		local var_7_0 = var_2_10001.Instance
		local var_7_1 = var_1.EnqueueInstantiate(var_7_0, arg_7_0, function(arg_8_0)
			arg_6_2(arg_8_0)

			return
		end)

		table = var_7_0

		var_7_0.insert(arg_6_0.insIdList, var_7_1)

		return
	end), true, true)

	arg_6_0:AddLoadingID(var_6_5)

	return
end

function var_0_1.SetupBT(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_2 or arg_9_2 == "" then
		arg_9_3()

		return
	end

	IslandAssetLoadDispatcher = var_1_10004

	local var_9_0 = var_1_10004.Instance
	local var_9_1 = var_4.Enqueue
	local var_9_2 = arg_9_2
	local var_9_3 = ""

	typeof = var_1_10008
	NodeCanvas = var_1_10009

	local var_9_4 = var_1_10008(var_1_10009.BehaviourTrees.BehaviourTree)

	UnityEngine = var_9

	local var_9_5 = var_9_1(var_9_0, var_9_2, var_9_3, var_9_4, var_9.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		assert = var_2_10001

		var_2_10001(arg_10_0, arg_9_2)

		GetOrAddComponent = var_2_10001

		local var_10_0 = arg_9_1

		typeof = var_3
		NodeCanvas = var_2_10004
		var_2_10001(var_10_0, var_3(var_2_10004.BehaviourTrees.BehaviourTreeOwner)).graph = arg_10_0

		arg_9_3()

		return
	end), true, true)

	arg_9_0:AddLoadingID(var_9_5)

	return
end

function var_0_1.Recycle(arg_11_0, arg_11_1, arg_11_2)
	Object = var_1_10003

	var_1_10003.Destroy(arg_11_2)

	return
end

return var_0_1
