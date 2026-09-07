local IslandSystemBuilder = class("IslandSystemBuilder", import(".IslandGenericBuilder"))

function IslandSystemBuilder:Ctor(arg_1_1, arg_1_2, arg_1_3)
	IslandSystemBuilder.super.Ctor(self, arg_1_1, arg_1_3 or IslandConst.UNIT_LIST_SYSTEM)

	self.cls = arg_1_2

	return
end

function IslandSystemBuilder:LoadAsset(arg_2_1, arg_2_2)
	arg_2_2((GameObject.New()))

	return
end

function IslandSystemBuilder:GetModule(arg_3_1, arg_3_2)
	return self.cls.New(arg_3_1, arg_3_2)
end

return IslandSystemBuilder
