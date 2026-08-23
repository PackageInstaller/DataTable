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
	C2S_WEDDINGVOW_GETINFO_ME = protobuf.Descriptor(),
	S2C_WEDDINGVOW_GETINFO_ME = protobuf.Descriptor(),
	S2C_WEDDINGVOW_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGVOW_GETINFO_LIST_F = protobuf.FieldDescriptor(),
	C2S_WEDDINGVOW_ACTIVE_ME = protobuf.Descriptor(),
	C2S_WEDDINGVOW_ACTIVE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGVOW_ACTIVE_ME = protobuf.Descriptor(),
	S2C_WEDDINGVOW_ACTIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGVOW_ACTIVE_WEDDING_VOW_F = protobuf.FieldDescriptor(),
	C2S_WEDDINGVOW_UPGRADE_ME = protobuf.Descriptor(),
	C2S_WEDDINGVOW_UPGRADE_KNIGHT_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_WEDDINGVOW_UPGRADE_VOW_ID_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGVOW_UPGRADE_ME = protobuf.Descriptor(),
	S2C_WEDDINGVOW_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGVOW_UPGRADE_WEDDING_VOW_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_WEDDINGVOW_GETINFO_ME, {
	"C2S_WeddingVow_GetInfo",
	".cs.C2S_WeddingVow_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGVOW_GETINFO_RET_F, {
	"ret",
	".cs.S2C_WeddingVow_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGVOW_GETINFO_LIST_F, {
	"list",
	".cs.S2C_WeddingVow_GetInfo.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.WEDDINGVOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEDDINGVOW_GETINFO_ME, {
	"S2C_WeddingVow_GetInfo",
	".cs.S2C_WeddingVow_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_WEDDINGVOW_GETINFO_RET_F,
		var_0_10.S2C_WEDDINGVOW_GETINFO_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEDDINGVOW_ACTIVE_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_WeddingVow_Active.knight_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_WEDDINGVOW_ACTIVE_ME, {
	"C2S_WeddingVow_Active",
	".cs.C2S_WeddingVow_Active",
	{},
	{},
	{
		var_0_10.C2S_WEDDINGVOW_ACTIVE_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGVOW_ACTIVE_RET_F, {
	"ret",
	".cs.S2C_WeddingVow_Active.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGVOW_ACTIVE_WEDDING_VOW_F, {
	"wedding_vow",
	".cs.S2C_WeddingVow_Active.wedding_vow",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.WEDDINGVOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEDDINGVOW_ACTIVE_ME, {
	"S2C_WeddingVow_Active",
	".cs.S2C_WeddingVow_Active",
	{},
	{},
	{
		var_0_10.S2C_WEDDINGVOW_ACTIVE_RET_F,
		var_0_10.S2C_WEDDINGVOW_ACTIVE_WEDDING_VOW_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEDDINGVOW_UPGRADE_KNIGHT_ADVANCE_ID_F, {
	"knight_advance_id",
	".cs.C2S_WeddingVow_Upgrade.knight_advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEDDINGVOW_UPGRADE_VOW_ID_F, {
	"vow_id",
	".cs.C2S_WeddingVow_Upgrade.vow_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_WEDDINGVOW_UPGRADE_ME, {
	"C2S_WeddingVow_Upgrade",
	".cs.C2S_WeddingVow_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_WEDDINGVOW_UPGRADE_KNIGHT_ADVANCE_ID_F,
		var_0_10.C2S_WEDDINGVOW_UPGRADE_VOW_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGVOW_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_WeddingVow_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGVOW_UPGRADE_WEDDING_VOW_F, {
	"wedding_vow",
	".cs.S2C_WeddingVow_Upgrade.wedding_vow",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.WEDDINGVOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEDDINGVOW_UPGRADE_ME, {
	"S2C_WeddingVow_Upgrade",
	".cs.S2C_WeddingVow_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_WEDDINGVOW_UPGRADE_RET_F,
		var_0_10.S2C_WEDDINGVOW_UPGRADE_WEDDING_VOW_F
	},
	false,
	{}
})

return var_0_10
