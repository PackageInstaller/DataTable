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
	C2S_PRECIOUS_GETINFO_ME = protobuf.Descriptor(),
	S2C_PRECIOUS_GETINFO_ME = protobuf.Descriptor(),
	S2C_PRECIOUS_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_GETINFO_OWNS_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_GETINFO_SUITS_F = protobuf.FieldDescriptor(),
	C2S_PRECIOUS_STARUP_ME = protobuf.Descriptor(),
	C2S_PRECIOUS_STARUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_STARUP_ME = protobuf.Descriptor(),
	S2C_PRECIOUS_STARUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_STARUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_PRECIOUS_UPGRADE_ME = protobuf.Descriptor(),
	C2S_PRECIOUS_UPGRADE_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_UPGRADE_ME = protobuf.Descriptor(),
	S2C_PRECIOUS_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_UPGRADE_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_PRECIOUS_SUITACTIVATE_ME = protobuf.Descriptor(),
	C2S_PRECIOUS_SUITACTIVATE_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_SUITACTIVATE_ME = protobuf.Descriptor(),
	S2C_PRECIOUS_SUITACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_SUITACTIVATE_SUIT_F = protobuf.FieldDescriptor(),
	C2S_PRECIOUS_SUITSTARUP_ME = protobuf.Descriptor(),
	C2S_PRECIOUS_SUITSTARUP_SUIT_GROUP_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_SUITSTARUP_ME = protobuf.Descriptor(),
	S2C_PRECIOUS_SUITSTARUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PRECIOUS_SUITSTARUP_SUIT_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUS_GETINFO_ME, {
	"C2S_Precious_GetInfo",
	".cs.C2S_Precious_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Precious_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_GETINFO_OWNS_F, {
	"owns",
	".cs.S2C_Precious_GetInfo.owns",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PRECIOUS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_GETINFO_SUITS_F, {
	"suits",
	".cs.S2C_Precious_GetInfo.suits",
	3,
	2,
	3,
	false,
	{},
	var_0_3.PRECIOUSSUIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUS_GETINFO_ME, {
	"S2C_Precious_GetInfo",
	".cs.S2C_Precious_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUS_GETINFO_RET_F,
		var_0_10.S2C_PRECIOUS_GETINFO_OWNS_F,
		var_0_10.S2C_PRECIOUS_GETINFO_SUITS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PRECIOUS_STARUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_Precious_StarUp.advance_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUS_STARUP_ME, {
	"C2S_Precious_StarUp",
	".cs.C2S_Precious_StarUp",
	{},
	{},
	{
		var_0_10.C2S_PRECIOUS_STARUP_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_STARUP_RET_F, {
	"ret",
	".cs.S2C_Precious_StarUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_STARUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_Precious_StarUp.advance_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUS_STARUP_ME, {
	"S2C_Precious_StarUp",
	".cs.S2C_Precious_StarUp",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUS_STARUP_RET_F,
		var_0_10.S2C_PRECIOUS_STARUP_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PRECIOUS_UPGRADE_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_Precious_Upgrade.advance_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUS_UPGRADE_ME, {
	"C2S_Precious_Upgrade",
	".cs.C2S_Precious_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_PRECIOUS_UPGRADE_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Precious_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_UPGRADE_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_Precious_Upgrade.advance_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUS_UPGRADE_ME, {
	"S2C_Precious_Upgrade",
	".cs.S2C_Precious_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUS_UPGRADE_RET_F,
		var_0_10.S2C_PRECIOUS_UPGRADE_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PRECIOUS_SUITACTIVATE_BASE_ID_F, {
	"base_id",
	".cs.C2S_Precious_SuitActivate.base_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUS_SUITACTIVATE_ME, {
	"C2S_Precious_SuitActivate",
	".cs.C2S_Precious_SuitActivate",
	{},
	{},
	{
		var_0_10.C2S_PRECIOUS_SUITACTIVATE_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_SUITACTIVATE_RET_F, {
	"ret",
	".cs.S2C_Precious_SuitActivate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_SUITACTIVATE_SUIT_F, {
	"suit",
	".cs.S2C_Precious_SuitActivate.suit",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.PRECIOUSSUIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUS_SUITACTIVATE_ME, {
	"S2C_Precious_SuitActivate",
	".cs.S2C_Precious_SuitActivate",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUS_SUITACTIVATE_RET_F,
		var_0_10.S2C_PRECIOUS_SUITACTIVATE_SUIT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PRECIOUS_SUITSTARUP_SUIT_GROUP_F, {
	"suit_group",
	".cs.C2S_Precious_SuitStarUp.suit_group",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PRECIOUS_SUITSTARUP_ME, {
	"C2S_Precious_SuitStarUp",
	".cs.C2S_Precious_SuitStarUp",
	{},
	{},
	{
		var_0_10.C2S_PRECIOUS_SUITSTARUP_SUIT_GROUP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_SUITSTARUP_RET_F, {
	"ret",
	".cs.S2C_Precious_SuitStarUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PRECIOUS_SUITSTARUP_SUIT_F, {
	"suit",
	".cs.S2C_Precious_SuitStarUp.suit",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.PRECIOUSSUIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PRECIOUS_SUITSTARUP_ME, {
	"S2C_Precious_SuitStarUp",
	".cs.S2C_Precious_SuitStarUp",
	{},
	{},
	{
		var_0_10.S2C_PRECIOUS_SUITSTARUP_RET_F,
		var_0_10.S2C_PRECIOUS_SUITSTARUP_SUIT_F
	},
	false,
	{}
})

return var_0_10
