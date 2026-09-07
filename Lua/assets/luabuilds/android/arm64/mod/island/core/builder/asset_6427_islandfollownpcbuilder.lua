local IslandFollowNpcBuilder = class("IslandFollowNpcBuilder", import(".IslandDressupNpcBuilder"))

function IslandFollowNpcBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandFollowNpcUnit.New(arg_1_1, arg_1_2)
end

return IslandFollowNpcBuilder
