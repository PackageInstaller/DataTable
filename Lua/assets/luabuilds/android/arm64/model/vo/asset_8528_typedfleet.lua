local TypedFleet = class("TypedFleet", import(".Fleet"))

function TypedFleet:Ctor(arg_1_1)
	assert(arg_1_1.fleetType)

	self.fleetType = arg_1_1.fleetType or FleetType.Unknowns

	TypedFleet.super.Ctor(self, arg_1_1)

	self.saveLastShipFlag = arg_1_1.saveLastShipFlag

	return
end

function TypedFleet:SeparateOut()
	local var_2_0 = TypedFleet.super.SeparateOut(self)

	var_2_0.fleetType = self.fleetType
	var_2_0.saveLastShipFlag = self.saveLastShipFlag

	return var_2_0
end

function TypedFleet:SetFleetType(arg_3_1)
	self.fleetType = arg_3_1 or FleetType.Normal

	return
end

function TypedFleet:isSubmarineFleet()
	return tobool(self:getFleetType() == FleetType.Submarine)
end

function TypedFleet:SetSaveLastShip(arg_5_1)
	self.saveLastShipFlag = arg_5_1

	return
end

function TypedFleet:canRemove(arg_6_1)
	if not self.saveLastShipFlag then
		return true
	end

	local var_6_0, var_6_1 = self:getShipPos(arg_6_1)

	if var_6_0 > 0 then
		if #(self:getTeamByName(var_6_1) or {}) == 1 then
			return false
		end
	end

	return true
end

function TypedFleet:getFleetType()
	assert(self.fleetType and self.fleetType ~= FleetType.Unknown, "not set fleet type on init")

	if self.fleetType == FleetType.Unknown then
		return FleetType.Normal
	end

	return self.fleetType
end

function TypedFleet:IsTeamMatch(arg_8_1)
	local var_8_0 = self:getFleetType()

	if var_8_0 == FleetType.Submarine then
		return arg_8_1 == TeamType.Submarine
	elseif var_8_0 == FleetType.Normal then
		return arg_8_1 == TeamType.Vanguard or arg_8_1 == TeamType.Main
	end

	assert(false)

	return true
end

function TypedFleet:CanInsertShip(arg_9_1, arg_9_2)
	if not TypedFleet.super.CanInsertShip(self, arg_9_1, arg_9_2) then
		return false
	end

	return self:IsTeamMatch(arg_9_2)
end

return TypedFleet
