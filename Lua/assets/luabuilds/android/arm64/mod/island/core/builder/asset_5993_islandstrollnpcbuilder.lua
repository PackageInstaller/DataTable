local IslandStrollNpcBuilder = class("IslandStrollNpcBuilder", import(".IslandDressupNpcBuilder"))

function IslandStrollNpcBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandStrollNpcUnit.New(arg_1_1, arg_1_2)
end

return IslandStrollNpcBuilder
