local IslandCheaterTavernTableBuilder = class("IslandCheaterTavernTableBuilder", import(".IslandGenericBuilder"))

function IslandCheaterTavernTableBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandCheaterTavernTableUnit.New(arg_1_1, arg_1_2)
end

function IslandCheaterTavernTableBuilder:SetTag(arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

return IslandCheaterTavernTableBuilder
