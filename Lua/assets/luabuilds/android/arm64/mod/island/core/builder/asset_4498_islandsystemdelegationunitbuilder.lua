local IslandSystemDelegationUnitBuilder = class("IslandSystemDelegationUnitBuilder", import(".IslandSystemNpcBuilder"))

function IslandSystemDelegationUnitBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandSystemDelegationUnit.New(arg_1_1, arg_1_2)
end

function IslandSystemDelegationUnitBuilder:SetTag(arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

function IslandSystemDelegationUnitBuilder:AddComponents(arg_3_1, arg_3_2)
	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CharacterController))

	var_3_0.slopeLimit = 50
	var_3_0.stepOffset = 0.3
	var_3_0.stepOffset = 0.08
	var_3_0.minMoveDistance = 0
	var_3_0.height = 1.76
	var_3_0.stepOffset = 0.4
	var_3_0.center = Vector3(0, 0.96, 0)

	GetOrAddComponent(arg_3_1, typeof(CharacterHandleController))

	return
end

function IslandSystemDelegationUnitBuilder:LoadOtherPart(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_3.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION then
		arg_4_4()

		return
	end

	local var_4_0 = arg_4_3.id

	if arg_4_3.id == 1 or arg_4_3.isChicken then
		arg_4_4()

		return
	end

	seriesAsync({
		function(arg_5_0)
			local var_5_0 = IslandShipDressHelperNew.New((self.view:GetIsland()))

			arg_4_2:SetShipDressHelper(var_5_0)
			var_5_0:PreLoadShipDressupItem(arg_4_1, var_4_0, arg_5_0)

			return
		end
	}, function()
		existCall(arg_4_4)

		return
	end)

	return
end

return IslandSystemDelegationUnitBuilder
