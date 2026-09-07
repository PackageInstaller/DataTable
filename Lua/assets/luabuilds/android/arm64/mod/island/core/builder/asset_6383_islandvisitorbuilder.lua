local IslandVisitorBuilder = class("IslandVisitorBuilder", import(".IslandCharUnitBuilder"))

function IslandVisitorBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandVisitorUnit.New(arg_1_1, arg_1_2)
end

function IslandVisitorBuilder:SetTag(arg_2_1)
	return
end

function IslandVisitorBuilder:SetupBT(arg_3_1, arg_3_2, arg_3_3)
	arg_3_3()

	return
end

function IslandVisitorBuilder:AddComponents(arg_4_1, arg_4_2)
	IslandVisitorBuilder.super.AddComponents(self, arg_4_1, arg_4_2)

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

function IslandVisitorBuilder:LoadOtherPart(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	seriesAsync({
		function(arg_6_0)
			local var_6_0 = IslandShipDressHelperNew.New()

			arg_5_2:SetShipDressHelper(var_6_0)
			var_6_0:PreLoadVisterDressupItem(arg_5_1, arg_5_3.id, getProxy(PlayerProxy):getRawData().id == arg_5_3.islandId, arg_6_0)

			return
		end
	}, function()
		existCall(arg_5_4)

		return
	end)

	return
end

function IslandVisitorBuilder:Load(arg_8_1, arg_8_2)
	self:GetPoolMgr():GetCommanderModel({
		model = arg_8_1:GetAssetPath(),
		animator = arg_8_1:GetAnimator()
	}, arg_8_2, arg_8_1.id, getProxy(PlayerProxy):getRawData().id == arg_8_1.islandId, (arg_8_1:GetBehaviourTree()))

	return
end

function IslandVisitorBuilder:Recycle(arg_9_1, arg_9_2)
	self:GetPoolMgr():ReturnCommanderModel(arg_9_2, (arg_9_1:GetBehaviourTree()))

	return
end

return IslandVisitorBuilder
