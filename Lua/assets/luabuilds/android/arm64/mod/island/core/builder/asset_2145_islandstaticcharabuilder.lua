local IslandStaticCharaBuilder = class("IslandStaticCharaBuilder", import(".IslandCharUnitBuilder"))

function IslandStaticCharaBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandStaticCharaUnit.New(arg_1_1, arg_1_2)
end

return IslandStaticCharaBuilder
