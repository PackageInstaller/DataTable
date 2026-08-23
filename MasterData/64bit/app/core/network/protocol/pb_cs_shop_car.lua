local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_9 = {
	C2S_SHOPCAR_GETINFO_ME = protobuf.Descriptor(),
	S2C_SHOPCAR_GETINFO_ME = protobuf.Descriptor(),
	S2C_SHOPCAR_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SHOPCAR_GETINFO_SHOP_CAR_F = protobuf.FieldDescriptor(),
	C2S_SHOPCAR_FOLLOW_ME = protobuf.Descriptor(),
	C2S_SHOPCAR_FOLLOW_ID_F = protobuf.FieldDescriptor(),
	S2C_SHOPCAR_FOLLOW_ME = protobuf.Descriptor(),
	S2C_SHOPCAR_FOLLOW_RET_F = protobuf.FieldDescriptor(),
	S2C_SHOPCAR_FOLLOW_ID_F = protobuf.FieldDescriptor(),
	C2S_SHOPCAR_UNFOLLOW_ME = protobuf.Descriptor(),
	C2S_SHOPCAR_UNFOLLOW_ID_F = protobuf.FieldDescriptor(),
	S2C_SHOPCAR_UNFOLLOW_ME = protobuf.Descriptor(),
	S2C_SHOPCAR_UNFOLLOW_RET_F = protobuf.FieldDescriptor(),
	S2C_SHOPCAR_UNFOLLOW_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_SHOPCAR_GETINFO_ME, {
	"C2S_ShopCar_GetInfo",
	".cs.C2S_ShopCar_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SHOPCAR_GETINFO_RET_F, {
	"ret",
	".cs.S2C_ShopCar_GetInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SHOPCAR_GETINFO_SHOP_CAR_F, {
	"shop_car",
	".cs.S2C_ShopCar_GetInfo.shop_car",
	2,
	1,
	1,
	false,
	nil,
	var_0_1("pb_out_base").SHOPCAR_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_SHOPCAR_GETINFO_ME, {
	"S2C_ShopCar_GetInfo",
	".cs.S2C_ShopCar_GetInfo",
	{},
	{},
	{
		var_0_9.S2C_SHOPCAR_GETINFO_RET_F,
		var_0_9.S2C_SHOPCAR_GETINFO_SHOP_CAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SHOPCAR_FOLLOW_ID_F, {
	"id",
	".cs.C2S_ShopCar_Follow.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.C2S_SHOPCAR_FOLLOW_ME, {
	"C2S_ShopCar_Follow",
	".cs.C2S_ShopCar_Follow",
	{},
	{},
	{
		var_0_9.C2S_SHOPCAR_FOLLOW_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SHOPCAR_FOLLOW_RET_F, {
	"ret",
	".cs.S2C_ShopCar_Follow.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SHOPCAR_FOLLOW_ID_F, {
	"id",
	".cs.S2C_ShopCar_Follow.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.S2C_SHOPCAR_FOLLOW_ME, {
	"S2C_ShopCar_Follow",
	".cs.S2C_ShopCar_Follow",
	{},
	{},
	{
		var_0_9.S2C_SHOPCAR_FOLLOW_RET_F,
		var_0_9.S2C_SHOPCAR_FOLLOW_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SHOPCAR_UNFOLLOW_ID_F, {
	"id",
	".cs.C2S_ShopCar_Unfollow.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.C2S_SHOPCAR_UNFOLLOW_ME, {
	"C2S_ShopCar_Unfollow",
	".cs.C2S_ShopCar_Unfollow",
	{},
	{},
	{
		var_0_9.C2S_SHOPCAR_UNFOLLOW_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SHOPCAR_UNFOLLOW_RET_F, {
	"ret",
	".cs.S2C_ShopCar_Unfollow.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SHOPCAR_UNFOLLOW_ID_F, {
	"id",
	".cs.S2C_ShopCar_Unfollow.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.S2C_SHOPCAR_UNFOLLOW_ME, {
	"S2C_ShopCar_Unfollow",
	".cs.S2C_ShopCar_Unfollow",
	{},
	{},
	{
		var_0_9.S2C_SHOPCAR_UNFOLLOW_RET_F,
		var_0_9.S2C_SHOPCAR_UNFOLLOW_ID_F
	},
	false,
	{}
})

return var_0_9
