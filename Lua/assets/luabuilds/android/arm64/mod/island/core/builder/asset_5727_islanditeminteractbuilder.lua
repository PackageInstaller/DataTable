local IslandItemInteractBuilder = class("IslandItemInteractBuilder", import(".IslandGenericBuilder"))

function IslandItemInteractBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandInteractUnit.New(arg_1_1, arg_1_2)
end

function IslandItemInteractBuilder:Load(arg_2_1, arg_2_2)
	local var_2_0 = {}
	local var_2_1

	table.insert(var_2_0, function(arg_3_0)
		self:LoadAsset(arg_2_1, function(arg_4_0)
			var_2_1 = arg_4_0

			arg_3_0()

			return
		end)

		return
	end)
	table.insert(var_2_0, function(arg_5_0)
		self:SetupBT(var_2_1, arg_2_1:GetBehaviourTree(), arg_5_0)

		return
	end)
	seriesAsync(var_2_0, function()
		arg_2_2(var_2_1)

		return
	end)

	return
end

function IslandItemInteractBuilder:AddComponents(arg_7_1, arg_7_2)
	GetOrAddComponent(arg_7_1, "DftCommonSignalReceiver")

	return
end

function IslandItemInteractBuilder:LoadTimeline(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0

	if not arg_8_3:HasTimeline() then
		arg_8_4()

		do return end

		var_8_0 = {}

		local var_8_1 = {}
	end

	for iter_8_0, iter_8_1 in ipairs((arg_8_3:GetTimeline())) do
		table.insert(var_8_0, function(arg_9_0)
			self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue(iter_8_1.name, "", typeof(UnityEngine.Playables.PlayableAsset), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
				var_8_1[iter_8_0] = Object.Instantiate(arg_10_0)

				arg_9_0()

				return
			end), true, true)))

			return
		end)
	end

	parallelAsync(var_8_0, function()
		local var_11_0 = GetOrAddComponent(arg_8_1, typeof(UnityEngine.Playables.PlayableDirector))

		var_11_0.playableAsset = var_8_1[1]

		var_11_0:Stop()

		var_11_0.playOnAwake = false

		arg_8_2:SetTimelineDic(var_8_1)
		arg_8_4()

		return
	end)

	return
end

return IslandItemInteractBuilder
