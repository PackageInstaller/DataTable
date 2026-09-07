local IslandGroundSystemBuilder = class("IslandGroundSystemBuilder", import(".IslandSystemBuilder"))

function IslandGroundSystemBuilder:Load(arg_1_1, arg_1_2)
	self:CreateNode(arg_1_1, function(arg_2_0)
		arg_1_2(arg_2_0)

		return
	end)

	return
end

function IslandGroundSystemBuilder:CreateNode(arg_3_1, arg_3_2)
	self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue(arg_3_1:GetAssetPath(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		table.insert(self.insIdList, (FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_4_0, function(arg_5_0)
			arg_3_2(arg_5_0)

			return
		end)))

		return
	end), true, true)))

	return
end

return IslandGroundSystemBuilder
