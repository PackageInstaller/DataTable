local var_0_0 = class("IslandVisitorBuilder", import(".IslandCharUnitBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandVisitorUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.SetTag(arg_2_0, arg_2_1)
	return
end

function var_0_0.SetupBT(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_3()

	return
end

function var_0_0.AddComponents(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.AddComponents(arg_4_0, arg_4_1, arg_4_2)

	local var_4_0 = GetOrAddComponent(arg_4_1, typeof(CharacterController))

	var_4_0.slopeLimit = 50
	var_4_0.stepOffset = 0.3
	var_4_0.stepOffset = 0.08
	var_4_0.minMoveDistance = 0
	var_4_0.height = 1.76
	var_4_0.stepOffset = 0.4
	var_4_0.center = Vector3(0, 0.96, 0)

	GetOrAddComponent(arg_4_1, typeof(CharacterHandleController))

	arg_4_1.name = "Visitor_" .. arg_4_2.id

	return
end

function var_0_0.LoadOtherPart(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	seriesAsync({
		function(arg_6_0)
			local var_6_0 = IslandShipDressHelperNew.New()

			arg_5_2:SetShipDressHelper(var_6_0)

			local var_6_1 = getProxy(PlayerProxy)

			var_6_0:PreLoadVisterDressupItem(arg_5_1, arg_5_3.id, var_6_1:getRawData().id == arg_5_3.islandId, arg_6_0)

			return
		end
	}, function()
		existCall(arg_5_4)

		return
	end)

	return
end

function var_0_0.Load(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = getProxy(PlayerProxy)

	arg_8_0:GetPoolMgr():GetCommanderModel({
		model = arg_8_1:GetAssetPath(),
		animator = arg_8_1:GetAnimator()
	}, arg_8_2, arg_8_1.id, var_8_0:getRawData().id == arg_8_1.islandId, (arg_8_1:GetBehaviourTree()))

	return
end

function var_0_0.Recycle(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:GetPoolMgr():ReturnCommanderModel(arg_9_2, (arg_9_1:GetBehaviourTree()))

	return
end

return var_0_0
