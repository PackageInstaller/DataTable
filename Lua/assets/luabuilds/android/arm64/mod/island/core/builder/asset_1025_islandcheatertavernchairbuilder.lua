local IslandCheaterTavernChairBuilder = class("IslandCheaterTavernChairBuilder", import(".IslandGenericBuilder"))

function IslandCheaterTavernChairBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandCheaterTavernCharUnit.New(arg_1_1, arg_1_2)
end

function IslandCheaterTavernChairBuilder:Load(arg_2_1, arg_2_2)
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
	table.insert(var_2_0, function(arg_6_0)
		var_2_1 = self:NestModel(var_2_1)

		arg_6_0()

		return
	end)
	seriesAsync(var_2_0, function()
		arg_2_2(var_2_1)

		return
	end)

	return
end

function IslandCheaterTavernChairBuilder:NestModel(arg_8_1)
	local var_8_0 = GameObject.New(arg_8_1.name)

	setParent(arg_8_1.transform, var_8_0.transform, false)

	arg_8_1 = var_8_0

	return var_8_0
end

function IslandCheaterTavernChairBuilder:SetTag(arg_9_1)
	arg_9_1.tag = IslandConst.TAG_NPC

	return
end

function IslandCheaterTavernChairBuilder:Recycle(arg_10_1, arg_10_2)
	Object.Destroy(arg_10_2)

	return
end

function IslandCheaterTavernChairBuilder:LoadOtherPart(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("Island/Effect/Prefab/game/bar/vfx_bar_heidong", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		table.insert(self.insIdList, (FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_12_0, function(arg_13_0)
			setActive(arg_13_0, false)

			arg_13_0.transform.localPosition = Vector3(0, 0.05, 0)

			setParent(arg_13_0, arg_11_1)
			arg_11_2:SetEffect(arg_13_0)
			arg_11_4(arg_13_0)

			return
		end)))

		return
	end), true, true)))

	return
end

return IslandCheaterTavernChairBuilder
