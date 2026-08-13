class = var_0_10000

local var_0_0 = "TypedFleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Fleet"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	assert = var_1_10002

	var_1_10002(arg_1_1.fleetType)

	local var_1_0

	if not arg_1_1.fleetType then
		FleetType = var_1_0
		var_1_0 = var_1_0.Unknowns
	end

	arg_1_0.fleetType = var_1_0

	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.saveLastShipFlag = arg_1_1.saveLastShipFlag

	return
end

function var_0_1.SeparateOut(arg_2_0)
	local var_2_0 = var_0_1.super.SeparateOut(arg_2_0)

	var_2_0.fleetType = arg_2_0.fleetType
	var_2_0.saveLastShipFlag = arg_2_0.saveLastShipFlag

	return var_2_0
end

function var_0_1.SetFleetType(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_1 then
		::label_3_0::

		FleetType = var_3_0
		var_3_0 = var_3_0.Normal
	end

	arg_3_0.fleetType = var_3_0

	return
end

function var_0_1.isSubmarineFleet(arg_4_0)
	tobool = var_1_10001

	local var_4_0 = arg_4_0:getFleetType()

	FleetType = var_1_10004

	return var_1_10001(var_4_0 == var_1_10004.Submarine)
end

function var_0_1.SetSaveLastShip(arg_5_0, arg_5_1)
	arg_5_0.saveLastShipFlag = arg_5_1

	return
end

function var_0_1.canRemove(arg_6_0, arg_6_1)
	if not arg_6_0.saveLastShipFlag then
		return true
	end

	local var_6_0, var_6_1 = arg_6_0:getShipPos(arg_6_1)

	if var_6_0 > 0 then
		local var_6_2

		if not arg_6_0:getTeamByName(var_6_1) then
			var_6_2 = {}
		end

		if #var_6_2 == 1 then
			return false
		end
	end

	return true
end

function var_0_1.getFleetType(arg_7_0)
	assert = var_1_10001

	local var_7_0

	if arg_7_0.fleetType then
		var_7_0 = arg_7_0.fleetType
		FleetType = var_1_10004
		var_7_0 = var_7_0 ~= var_1_10004.Unknown
	end

	var_1_10001(var_7_0, "not set fleet type on init")

	local var_7_1 = arg_7_0.fleetType

	FleetType = var_1_10002

	if var_7_1 == var_1_10002.Unknown then
		FleetType = var_7_1

		return var_7_1.Normal
	end

	return arg_7_0.fleetType
end

function var_0_1.IsTeamMatch(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getFleetType()

	FleetType = var_1_10003

	local var_8_1

	if var_8_0 == var_1_10003.Submarine then
		TeamType = var_8_1
		var_8_1 = arg_8_1 == var_8_1.Submarine

		return var_8_1
	else
		FleetType = var_8_1

		if var_8_0 == var_8_1.Normal then
			TeamType = var_8_1

			if arg_8_1 ~= var_8_1.Vanguard then
				TeamType = var_8_1

				if arg_8_1 ~= var_8_1.Main then
					var_8_1 = false

					goto label_8_0
				end
			end

			var_8_1 = true

			::label_8_0::

			return var_8_1
		end
	end

	assert = var_8_1

	var_8_1(false)

	return true
end

function var_0_1.CanInsertShip(arg_9_0, arg_9_1, arg_9_2)
	if not var_0_1.super.CanInsertShip(arg_9_0, arg_9_1, arg_9_2) then
		return false
	end

	return arg_9_0:IsTeamMatch(arg_9_2)
end

return var_0_1
