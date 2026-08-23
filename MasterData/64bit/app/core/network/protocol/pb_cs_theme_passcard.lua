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
	C2S_THEMEPASSCARD_GETINFO_ME = protobuf.Descriptor(),
	C2S_THEMEPASSCARD_GETINFO_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_GETINFO_ME = protobuf.Descriptor(),
	S2C_THEMEPASSCARD_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_GETINFO_PASSCARD_F = protobuf.FieldDescriptor(),
	C2S_THEMEPASSCARD_GETAWARD_ME = protobuf.Descriptor(),
	C2S_THEMEPASSCARD_GETAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_THEMEPASSCARD_GETAWARD_PASSCARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_GETAWARD_ME = protobuf.Descriptor(),
	S2C_THEMEPASSCARD_GETAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_GETAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_GETAWARD_PASSCARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_GETAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_THEMEPASSCARD_UPDATEACTION_ME = protobuf.Descriptor(),
	S2C_THEMEPASSCARD_UPDATEACTION_ACTIONS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_THEMEPASSCARD_GETINFO_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_ThemePasscard_GetInfo.activity_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_THEMEPASSCARD_GETINFO_ME, {
	"C2S_ThemePasscard_GetInfo",
	".cs.C2S_ThemePasscard_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_THEMEPASSCARD_GETINFO_ACTIVITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETINFO_RET_F, {
	"ret",
	".cs.S2C_ThemePasscard_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETINFO_PASSCARD_F, {
	"passcard",
	".cs.S2C_ThemePasscard_GetInfo.passcard",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.THEMEPASSCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETINFO_ME, {
	"S2C_ThemePasscard_GetInfo",
	".cs.S2C_ThemePasscard_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_THEMEPASSCARD_GETINFO_RET_F,
		var_0_10.S2C_THEMEPASSCARD_GETINFO_PASSCARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_THEMEPASSCARD_GETAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_ThemePasscard_GetAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_THEMEPASSCARD_GETAWARD_PASSCARD_IDS_F, {
	"passcard_ids",
	".cs.C2S_ThemePasscard_GetAward.passcard_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_THEMEPASSCARD_GETAWARD_ME, {
	"C2S_ThemePasscard_GetAward",
	".cs.C2S_ThemePasscard_GetAward",
	{},
	{},
	{
		var_0_10.C2S_THEMEPASSCARD_GETAWARD_ACTIVITY_ID_F,
		var_0_10.C2S_THEMEPASSCARD_GETAWARD_PASSCARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETAWARD_RET_F, {
	"ret",
	".cs.S2C_ThemePasscard_GetAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_ThemePasscard_GetAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETAWARD_PASSCARD_IDS_F, {
	"passcard_ids",
	".cs.S2C_ThemePasscard_GetAward.passcard_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_ThemePasscard_GetAward.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_THEMEPASSCARD_GETAWARD_ME, {
	"S2C_ThemePasscard_GetAward",
	".cs.S2C_ThemePasscard_GetAward",
	{},
	{},
	{
		var_0_10.S2C_THEMEPASSCARD_GETAWARD_RET_F,
		var_0_10.S2C_THEMEPASSCARD_GETAWARD_ACTIVITY_ID_F,
		var_0_10.S2C_THEMEPASSCARD_GETAWARD_PASSCARD_IDS_F,
		var_0_10.S2C_THEMEPASSCARD_GETAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_THEMEPASSCARD_UPDATEACTION_ACTIONS_F, {
	"actions",
	".cs.S2C_ThemePasscard_UpdateAction.actions",
	1,
	0,
	3,
	false,
	{},
	var_0_3.ACTIVITYACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_THEMEPASSCARD_UPDATEACTION_ME, {
	"S2C_ThemePasscard_UpdateAction",
	".cs.S2C_ThemePasscard_UpdateAction",
	{},
	{},
	{
		var_0_10.S2C_THEMEPASSCARD_UPDATEACTION_ACTIONS_F
	},
	false,
	{}
})

return var_0_10
