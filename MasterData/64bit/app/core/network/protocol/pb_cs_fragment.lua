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
	C2S_FRAGMENT_COMPOSE_ME = protobuf.Descriptor(),
	C2S_FRAGMENT_COMPOSE_ID_F = protobuf.FieldDescriptor(),
	C2S_FRAGMENT_COMPOSE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FRAGMENT_COMPOSE_ME = protobuf.Descriptor(),
	S2C_FRAGMENT_COMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_FRAGMENT_COMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_FRAGMENT_COMPOSE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FRAGMENT_COMPOSE_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_FRAGMENT_COMPOSE_ID_F, {
	"id",
	".cs.C2S_Fragment_Compose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_FRAGMENT_COMPOSE_NUM_F, {
	"num",
	".cs.C2S_Fragment_Compose.num",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_FRAGMENT_COMPOSE_ME, {
	"C2S_Fragment_Compose",
	".cs.C2S_Fragment_Compose",
	{},
	{},
	{
		var_0_9.C2S_FRAGMENT_COMPOSE_ID_F,
		var_0_9.C2S_FRAGMENT_COMPOSE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_FRAGMENT_COMPOSE_RET_F, {
	"ret",
	".cs.S2C_Fragment_Compose.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_FRAGMENT_COMPOSE_ID_F, {
	"id",
	".cs.S2C_Fragment_Compose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_FRAGMENT_COMPOSE_NUM_F, {
	"num",
	".cs.S2C_Fragment_Compose.num",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_FRAGMENT_COMPOSE_AWARDS_F, {
	"awards",
	".cs.S2C_Fragment_Compose.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_1("pb_out_base").AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_FRAGMENT_COMPOSE_ME, {
	"S2C_Fragment_Compose",
	".cs.S2C_Fragment_Compose",
	{},
	{},
	{
		var_0_9.S2C_FRAGMENT_COMPOSE_RET_F,
		var_0_9.S2C_FRAGMENT_COMPOSE_ID_F,
		var_0_9.S2C_FRAGMENT_COMPOSE_NUM_F,
		var_0_9.S2C_FRAGMENT_COMPOSE_AWARDS_F
	},
	false,
	{}
})

return var_0_9
