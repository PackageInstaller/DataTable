local CourtYardRandomControllerFurniture = class("CourtYardRandomControllerFurniture", import(".CourtYardFurniture"))

function CourtYardRandomControllerFurniture:InitSlots()
	table.insert(self.slots, CourtYardRandomControllerSlot.New(1, self.config.spine))

	if type(self.config.animator) == "table" then
		self.slots[1]:SetAnimators(self.config.animator)
	end

	return
end

return CourtYardRandomControllerFurniture
