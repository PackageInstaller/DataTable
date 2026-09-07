local IslandManageSystemBuilder = class("IslandManageSystemBuilder", import(".IslandGenericBuilder"))

function IslandManageSystemBuilder:Ctor(arg_1_1, arg_1_2)
	IslandManageSystemBuilder.super.Ctor(self, arg_1_1, IslandConst.UNIT_LIST_MANAGE_SYSTEM)

	self.cls = arg_1_2

	return
end

function IslandManageSystemBuilder:LoadAsset(arg_2_1, arg_2_2)
	arg_2_2((GameObject.New()))

	return
end

function IslandManageSystemBuilder:GetModule(arg_3_1, arg_3_2)
	return self.cls.New(arg_3_1, arg_3_2)
end

return IslandManageSystemBuilder
