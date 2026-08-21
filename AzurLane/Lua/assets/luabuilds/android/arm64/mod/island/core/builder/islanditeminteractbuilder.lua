local var_0_0 = class("IslandItemInteractBuilder", import(".IslandGenericBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandInteractUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	table.insert({}, function(arg_3_0)
		arg_2_0:LoadAsset(arg_2_1, function(arg_4_0)
			var_2_0 = arg_4_0

			arg_3_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_5_0)
		arg_2_0:SetupBT(var_2_0, arg_2_1:GetBehaviourTree(), arg_5_0)

		return
	end)
	seriesAsync({}, function()
		arg_2_2(var_2_0)

		return
	end)

	return
end

function var_0_0.AddComponents(arg_7_0, arg_7_1, arg_7_2)
	GetOrAddComponent(arg_7_1, "DftCommonSignalReceiver")

	return
end

function var_0_0.LoadTimeline(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0

	if not arg_8_3:HasTimeline() then
		arg_8_4()

		do return end

		var_8_0 = {}
	end

	for iter_8_0, iter_8_1 in ipairs((arg_8_3:GetTimeline())) do
		table.insert({}, function(arg_9_0)
			arg_8_0:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue(iter_8_1.name, "", typeof(UnityEngine.Playables.PlayableAsset), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
				var_8_0[iter_8_0] = Object.Instantiate(arg_10_0)

				arg_9_0()

				return
			end), true, true)))

			return
		end)
	end

	parallelAsync({}, function()
		local var_11_0 = GetOrAddComponent(arg_8_1, typeof(UnityEngine.Playables.PlayableDirector))

		var_11_0.playableAsset = var_8_0[1]

		var_11_0:Stop()

		var_11_0.playOnAwake = false

		arg_8_2:SetTimelineDic(var_8_0)
		arg_8_4()

		return
	end)

	return
end

return var_0_0
