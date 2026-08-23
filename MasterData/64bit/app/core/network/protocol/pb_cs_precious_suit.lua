local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_out_base")
local var_0_4 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_10 = {
	C2S_PRECIOUSSUIT_ACTIVATE_ME = protobuf.Descriptor(),
	C2S_PRECIOUSSUIT_ACTIVATE_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUSSUIT_ACTIVATE_ME = protobuf.Descriptor(),
	S2C_PRECIOUSSUIT_ACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUSSUIT_ACTIVATE_BASE_ID_F = protobuf.FieldDescriptor(),
	C2S_PRECIOUSSUIT_STARUP_ME = protobuf.Descriptor(),
	C2S_PRECIOUSSUIT_STARUP_SUIT_GROUP_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUSSUIT_STARUP_ME = protobuf.Descriptor(),
	S2C_PRECIOUSSUIT_STARUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUSSUIT_STARUP_SUIT_GROUP_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PRECIOUSSUIT_ACTIVATE_BASE_ID_F, {
	"base_id",
	".cs.C2S_PreciousSuit_Activate.base_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUSSUIT_ACTIVATE_ME, {
	"C2S_PreciousSuit_Activate",
	".cs.C2S_PreciousSuit_Activate",
	{},
	{},
	{
		var_0_10.C2S_PRECIOUSSUIT_ACTIVATE_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUSSUIT_ACTIVATE_RET_F, {
	"ret",
	".cs.S2C_PreciousSuit_Activate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUSSUIT_ACTIVATE_BASE_ID_F, {
	"base_id",
	".cs.S2C_PreciousSuit_Activate.base_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUSSUIT_ACTIVATE_ME, {
	"S2C_PreciousSuit_Activate",
	".cs.S2C_PreciousSuit_Activate",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUSSUIT_ACTIVATE_RET_F,
		var_0_10.S2C_PRECIOUSSUIT_ACTIVATE_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PRECIOUSSUIT_STARUP_SUIT_GROUP_F, {
	"suit_group",
	".cs.C2S_PreciousSuit_StarUp.suit_group",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUSSUIT_STARUP_ME, {
	"C2S_PreciousSuit_StarUp",
	".cs.C2S_PreciousSuit_StarUp",
	{},
	{},
	{
		var_0_10.C2S_PRECIOUSSUIT_STARUP_SUIT_GROUP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUSSUIT_STARUP_RET_F, {
	"ret",
	".cs.S2C_PreciousSuit_StarUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUSSUIT_STARUP_SUIT_GROUP_F, {
	"suit_group",
	".cs.S2C_PreciousSuit_StarUp.suit_group",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUSSUIT_STARUP_ME, {
	"S2C_PreciousSuit_StarUp",
	".cs.S2C_PreciousSuit_StarUp",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUSSUIT_STARUP_RET_F,
		var_0_10.S2C_PRECIOUSSUIT_STARUP_SUIT_GROUP_F
	},
	false,
	{}
})

return var_0_10
