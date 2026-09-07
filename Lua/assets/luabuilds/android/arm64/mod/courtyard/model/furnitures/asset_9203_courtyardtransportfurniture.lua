local CourtYardTransportFurniture = class("CourtYardTransportFurniture", import(".CourtYardFurniture"))

function CourtYardTransportFurniture:InitSlots()
	table.insert(self.slots, CourtYardTransportSlot.New(1, self.config.spine))

	if type(self.config.animator) == "table" then
		self.slots[1]:SetAnimators(self.config.animator)
	end

	return
end

function CourtYardTransportFurniture:IsUsing()
	return #self:GetUsingSlots() > 0
end

function CourtYardTransportFurniture:Stop()
	self.slots[1]:Stop()

	return
end

return CourtYardTransportFurniture
