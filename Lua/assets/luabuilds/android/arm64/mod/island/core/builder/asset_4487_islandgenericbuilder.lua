local IslandGenericBuilder = class("IslandGenericBuilder", import(".IslandBaseBuilder"))

function IslandGenericBuilder:Load(arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1

	table.insert(var_1_0, function(arg_2_0)
		self:LoadAsset(arg_1_1, function(arg_3_0)
			var_1_1 = arg_3_0

			arg_2_0()

			return
		end)

		return
	end)
	table.insert(var_1_0, function(arg_4_0)
		self:SetupBT(var_1_1, arg_1_1:GetBehaviourTree(), arg_4_0)

		return
	end)
	seriesAsync(var_1_0, function()
		arg_1_2(var_1_1)

		return
	end)

	return
end

function IslandGenericBuilder:LoadAsset(arg_6_1, arg_6_2)
	self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue(arg_6_1:GetAssetPath(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
		table.insert(self.insIdList, (FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_7_0, function(arg_8_0)
			arg_6_2(arg_8_0)

			return
		end)))

		return
	end), true, true)))

	return
end

function IslandGenericBuilder:SetupBT(arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_2 or arg_9_2 == "" then
		arg_9_3()

		return
	end

	self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue(arg_9_2, "", typeof(NodeCanvas.BehaviourTrees.BehaviourTree), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		assert(arg_10_0, arg_9_2)

		GetOrAddComponent(arg_9_1, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)).graph = arg_10_0

		arg_9_3()

		return
	end), true, true)))

	return
end

function IslandGenericBuilder:Recycle(arg_11_1, arg_11_2)
	Object.Destroy(arg_11_2)

	return
end

return IslandGenericBuilder
