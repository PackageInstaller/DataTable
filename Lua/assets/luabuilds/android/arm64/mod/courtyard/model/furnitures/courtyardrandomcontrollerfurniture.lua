local var_0_0 = class("CourtYardRandomControllerFurniture", import(".CourtYardFurniture"))

function var_0_0.InitSlots(arg_1_0)
	table.insert(arg_1_0.slots, CourtYardRandomControllerSlot.New(1, arg_1_0.config.spine))

	if type(arg_1_0.config.animator) == "table" then
		arg_1_0.slots[1]:SetAnimators(arg_1_0.config.animator)
	end

	return
end

return var_0_0
