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
	C2S_HANDBOOK_INFO_ME = protobuf.Descriptor(),
	C2S_HANDBOOK_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_INFO_ME = protobuf.Descriptor(),
	S2C_HANDBOOK_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_INFO_HB_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_INFO_PASS_IDS_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_SYNC_ME = protobuf.Descriptor(),
	S2C_HANDBOOK_SYNC_ID_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_SYNC_HB_ID_F = protobuf.FieldDescriptor(),
	C2S_HANDBOOK_ONEKEYUPGRADE_ME = protobuf.Descriptor(),
	C2S_HANDBOOK_ONEKEYUPGRADE_TP_F = protobuf.FieldDescriptor(),
	C2S_HANDBOOK_ONEKEYUPGRADE_IDS_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_ONEKEYUPGRADE_ME = protobuf.Descriptor(),
	S2C_HANDBOOK_ONEKEYUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_ONEKEYUPGRADE_TP_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_ONEKEYUPGRADE_IDS_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOK_ONEKEYUPGRADE_HB_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_HANDBOOK_INFO_ID_F, {
	"id",
	".cs.C2S_Handbook_Info.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_HANDBOOK_INFO_ME, {
	"C2S_Handbook_Info",
	".cs.C2S_Handbook_Info",
	{},
	{},
	{
		var_0_10.C2S_HANDBOOK_INFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_INFO_RET_F, {
	"ret",
	".cs.S2C_Handbook_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_INFO_ID_F, {
	"id",
	".cs.S2C_Handbook_Info.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_INFO_HB_F, {
	"hb",
	".cs.S2C_Handbook_Info.hb",
	3,
	2,
	3,
	false,
	{},
	var_0_3.HANDBOOK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_INFO_PASS_IDS_F, {
	"pass_ids",
	".cs.S2C_Handbook_Info.pass_ids",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HANDBOOK_INFO_ME, {
	"S2C_Handbook_Info",
	".cs.S2C_Handbook_Info",
	{},
	{},
	{
		var_0_10.S2C_HANDBOOK_INFO_RET_F,
		var_0_10.S2C_HANDBOOK_INFO_ID_F,
		var_0_10.S2C_HANDBOOK_INFO_HB_F,
		var_0_10.S2C_HANDBOOK_INFO_PASS_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_SYNC_ID_F, {
	"id",
	".cs.S2C_Handbook_Sync.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_SYNC_HB_ID_F, {
	"hb_id",
	".cs.S2C_Handbook_Sync.hb_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_HANDBOOK_SYNC_ME, {
	"S2C_Handbook_Sync",
	".cs.S2C_Handbook_Sync",
	{},
	{},
	{
		var_0_10.S2C_HANDBOOK_SYNC_ID_F,
		var_0_10.S2C_HANDBOOK_SYNC_HB_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_HANDBOOK_ONEKEYUPGRADE_TP_F, {
	"tp",
	".cs.C2S_Handbook_OneKeyUpgrade.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_HANDBOOK_ONEKEYUPGRADE_IDS_F, {
	"ids",
	".cs.C2S_Handbook_OneKeyUpgrade.ids",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_HANDBOOK_ONEKEYUPGRADE_ME, {
	"C2S_Handbook_OneKeyUpgrade",
	".cs.C2S_Handbook_OneKeyUpgrade",
	{},
	{},
	{
		var_0_10.C2S_HANDBOOK_ONEKEYUPGRADE_TP_F,
		var_0_10.C2S_HANDBOOK_ONEKEYUPGRADE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Handbook_OneKeyUpgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_TP_F, {
	"tp",
	".cs.S2C_Handbook_OneKeyUpgrade.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_IDS_F, {
	"ids",
	".cs.S2C_Handbook_OneKeyUpgrade.ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_HB_F, {
	"hb",
	".cs.S2C_Handbook_OneKeyUpgrade.hb",
	4,
	3,
	3,
	false,
	{},
	var_0_3.HANDBOOK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_ME, {
	"S2C_Handbook_OneKeyUpgrade",
	".cs.S2C_Handbook_OneKeyUpgrade",
	{},
	{},
	{
		var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_RET_F,
		var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_TP_F,
		var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_IDS_F,
		var_0_10.S2C_HANDBOOK_ONEKEYUPGRADE_HB_F
	},
	false,
	{}
})

return var_0_10
