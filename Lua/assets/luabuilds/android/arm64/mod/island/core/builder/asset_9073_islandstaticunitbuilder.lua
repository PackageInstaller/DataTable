local IslandStaticUnitBuilder = class("IslandStaticUnitBuilder", import(".IslandGenericBuilder"))

function IslandStaticUnitBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandStaticUnit.New(arg_1_1, arg_1_2)
end

function IslandStaticUnitBuilder:SetTag(arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC

	return
end

function IslandStaticUnitBuilder:AddComponents(arg_3_1, arg_3_2)
	return
end

return IslandStaticUnitBuilder
