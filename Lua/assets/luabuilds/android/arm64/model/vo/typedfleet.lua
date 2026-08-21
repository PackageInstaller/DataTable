local var_0_0 = class("TypedFleet", import(".Fleet"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	assert(arg_1_1.fleetType)

	arg_1_0.fleetType = arg_1_1.fleetType or FleetType.Unknowns

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.saveLastShipFlag = arg_1_1.saveLastShipFlag

	return
end

function var_0_0.SeparateOut(arg_2_0)
	local var_2_0 = var_0_0.super.SeparateOut(arg_2_0)

	var_2_0.fleetType = arg_2_0.fleetType
	var_2_0.saveLastShipFlag = arg_2_0.saveLastShipFlag

	return var_2_0
end

function var_0_0.SetFleetType(arg_3_0, arg_3_1)
	arg_3_0.fleetType = arg_3_1 or FleetType.Normal

	return
end

function var_0_0.isSubmarineFleet(arg_4_0)
	return tobool(arg_4_0:getFleetType() == FleetType.Submarine)
end

function var_0_0.SetSaveLastShip(arg_5_0, arg_5_1)
	arg_5_0.saveLastShipFlag = arg_5_1

	return
end

function var_0_0.canRemove(arg_6_0, arg_6_1)
	if not arg_6_0.saveLastShipFlag then
		return true
	end

	local var_6_0, var_6_1 = arg_6_0:getShipPos(arg_6_1)

	if var_6_0 > 0 then
		local var_6_2 = arg_6_0:getTeamByName(var_6_1) or {}

		if #var_6_2 == 1 then
			return false
		end
	end

	return true
end

function var_0_0.getFleetType(arg_7_0)
	local var_7_0 = arg_7_0.fleetType and arg_7_0.fleetType ~= FleetType.Unknown

	assert(var_7_0, "not set fleet type on init")

	if arg_7_0.fleetType == FleetType.Unknown then
		return FleetType.Normal
	end

	return arg_7_0.fleetType
end

function var_0_0.IsTeamMatch(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getFleetType()

	if var_8_0 == FleetType.Submarine then
		return arg_8_1 == TeamType.Submarine
	elseif var_8_0 == FleetType.Normal then
		return arg_8_1 == TeamType.Vanguard or arg_8_1 == TeamType.Main
	end

	assert(false)

	return true
end

function var_0_0.CanInsertShip(arg_9_0, arg_9_1, arg_9_2)
	if not var_0_0.super.CanInsertShip(arg_9_0, arg_9_1, arg_9_2) then
		return false
	end

	return arg_9_0:IsTeamMatch(arg_9_2)
end

return var_0_0
