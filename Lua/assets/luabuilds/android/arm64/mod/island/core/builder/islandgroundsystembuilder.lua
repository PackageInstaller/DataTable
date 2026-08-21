local var_0_0 = class("IslandGroundSystemBuilder", import(".IslandSystemBuilder"))

function var_0_0.Load(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:CreateNode(arg_1_1, function(arg_2_0)
		arg_1_2(arg_2_0)

		return
	end)

	return
end

function var_0_0.CreateNode(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue(arg_3_1:GetAssetPath(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		table.insert(arg_3_0.insIdList, (FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_4_0, function(arg_5_0)
			arg_3_2(arg_5_0)

			return
		end)))

		return
	end), true, true)))

	return
end

return var_0_0
