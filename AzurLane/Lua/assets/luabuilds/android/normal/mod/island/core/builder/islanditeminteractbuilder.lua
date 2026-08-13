class = var_0_10000

local var_0_0 = "IslandItemInteractBuilder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandGenericBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandInteractUnit = var_1_10003

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

	seriesAsync = var_5

	var_5(var_2_0, function()
		arg_2_2(var_2_1)

		return
	end)

	return
end

function var_0_1.AddComponents(arg_7_0, arg_7_1, arg_7_2)
	GetOrAddComponent = var_1_10003

	var_1_10003(arg_7_1, "DftCommonSignalReceiver")

	return
end

function var_0_1.LoadTimeline(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_3:HasTimeline() then
		arg_8_4()

		return
	end

	local var_8_0 = arg_8_3:GetTimeline()
	local var_8_1 = {}
	local var_8_2 = {}

	ipairs = var_1_10008

	for iter_8_0, iter_8_1 in var_1_10008(var_8_0) do
		table = var_1_10013

		var_1_10013.insert(var_8_1, function(arg_9_0)
			IslandAssetLoadDispatcher = var_2_10001

			local var_9_0 = var_2_10001.Instance
			local var_9_1 = var_1.Enqueue
			local var_9_2 = iter_8_1.name
			local var_9_3 = ""

			typeof = var_2_10005
			UnityEngine = var_2_10006

			local var_9_4 = var_2_10005(var_2_10006.Playables.PlayableAsset)

			UnityEngine = var_6

			local var_9_5 = var_9_1(var_9_0, var_9_2, var_9_3, var_9_4, var_6.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
				Object = var_3_10001

				local var_10_0 = var_3_10001.Instantiate(arg_10_0)

				var_8_2[iter_8_0] = var_10_0

				arg_9_0()

				return
			end), true, true)
			local var_9_6 = arg_8_0

			var_2.AddLoadingID(var_9_6, var_9_5)

			return
		end)
	end

	parallelAsync = var_8

	var_8(var_8_1, function()
		GetOrAddComponent = var_2_10000

		local var_11_0 = arg_8_1

		typeof = var_2_10002
		UnityEngine = var_2_10003

		local var_11_1 = var_2_10000(var_11_0, var_2_10002(var_2_10003.Playables.PlayableDirector))

		var_11_1.playableAsset = var_8_2[1]

		var_11_1:Stop()

		var_11_1.playOnAwake = false

		local var_11_2 = arg_8_2

		var_1.SetTimelineDic(var_11_2, var_8_2)
		arg_8_4()

		return
	end)

	return
end

return var_0_1
