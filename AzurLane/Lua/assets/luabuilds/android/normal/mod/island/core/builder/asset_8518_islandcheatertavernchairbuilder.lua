class = var_0_10000

local var_0_0 = "IslandCheaterTavernChairBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandGenericBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandCheaterTavernCharUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.Load(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {}
	local var_2_1

	table = var_1_10005

	var_1_10005.insert(var_2_0, function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.LoadAsset(var_3_0, arg_2_1, function(arg_4_0)
			var_2_1 = arg_4_0

			arg_3_0()

			return
		end)

		return
	end)

	table = var_5

	var_5.insert(var_2_0, function(arg_5_0)
		local var_5_0 = arg_2_0
		local var_5_1 = var_1.SetupBT
		local var_5_2 = var_2_1
		local var_5_3 = arg_2_1

		var_5_1(var_5_0, var_5_2, var_4.GetBehaviourTree(var_5_3), arg_5_0)

		return
	end)

	table = var_5

	var_5.insert(var_2_0, function(arg_6_0)
		local var_6_0 = arg_2_0

		var_2_1 = var_1.NestModel(var_6_0, var_2_1)

		arg_6_0()

		return
	end)

	seriesAsync = var_5

	var_5(var_2_0, function()
		arg_2_2(var_2_1)

		return
	end)

	return
end

function var_0_1.NestModel(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.name

	GameObject = var_1_10003

	local var_8_1 = var_1_10003.New(var_8_0)

	setParent = var_4

	var_4(arg_8_1.transform, var_8_1.transform, false)

	return var_8_1
end

function var_0_1.SetTag(arg_9_0, arg_9_1)
	IslandConst = var_1_10002
	arg_9_1.tag = var_1_10002.TAG_NPC

	return
end

function var_0_1.Recycle(arg_10_0, arg_10_1, arg_10_2)
	Object = var_1_10003

	var_1_10003.Destroy(arg_10_2)

	return
end

function var_0_1.LoadOtherPart(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	IslandAssetLoadDispatcher = var_1_10005

	local var_11_0 = var_1_10005.Instance
	local var_11_1 = var_5.Enqueue
	local var_11_2 = "Island/Effect/Prefab/game/bar/vfx_bar_heidong"
	local var_11_3 = ""

	typeof = var_1_10009
	GameObject = var_1_10010

	local var_11_4 = var_1_10009(var_1_10010)

	UnityEngine = var_1_10010

	local var_11_5 = var_11_1(var_11_0, var_11_2, var_11_3, var_11_4, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		FrameAsyncInstantiateManager = var_2_10001

		local var_12_0 = var_2_10001.Instance
		local var_12_1 = var_1.EnqueueInstantiate(var_12_0, arg_12_0, function(arg_13_0)
			setActive = var_3_10001

			var_3_10001(arg_13_0, false)

			local var_13_0 = arg_13_0.transform

			Vector3 = var_2
			var_13_0.localPosition = var_2(0, 0.05, 0)
			setParent = var_13_0

			var_13_0(arg_13_0, arg_11_1)

			local var_13_1 = arg_11_2

			var_1.SetEffect(var_13_1, arg_13_0)
			arg_11_4(arg_13_0)

			return
		end)

		table = var_12_0

		var_12_0.insert(arg_11_0.insIdList, var_12_1)

		return
	end), true, true)

	arg_11_0:AddLoadingID(var_11_5)

	return
end

return var_0_1
