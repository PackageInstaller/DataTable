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
	C2S_FRIENDHELPER_GETKNIGHTS_ME = protobuf.Descriptor(),
	C2S_FRIENDHELPER_GETKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_GETKNIGHTS_PAGE_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_GETKNIGHTS_PAGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_ME = protobuf.Descriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_PAGE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_PAGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_HELPER_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_GETKNIGHTS_TOTAL_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_SETKNIGHTS_ME = protobuf.Descriptor(),
	C2S_FRIENDHELPER_SETKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_SETKNIGHTS_SETTING_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_SETKNIGHTS_ME = protobuf.Descriptor(),
	S2C_FRIENDHELPER_SETKNIGHTS_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_SETKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_SETKNIGHTS_SETTING_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_SHOWSETKNIGHTS_ME = protobuf.Descriptor(),
	C2S_FRIENDHELPER_SHOWSETKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_SHOWSETKNIGHTS_ME = protobuf.Descriptor(),
	S2C_FRIENDHELPER_SHOWSETKNIGHTS_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_SHOWSETKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_SHOWSETKNIGHTS_SETTING_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_USEKNIGHTS_ME = protobuf.Descriptor(),
	C2S_FRIENDHELPER_USEKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_FRIENDHELPER_USEKNIGHTS_USE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_USEKNIGHTS_ME = protobuf.Descriptor(),
	S2C_FRIENDHELPER_USEKNIGHTS_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_USEKNIGHTS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDHELPER_USEKNIGHTS_USE_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_FriendHelper_GetKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_PAGE_F, {
	"page",
	".cs.C2S_FriendHelper_GetKnights.page",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_PAGE_NUM_F, {
	"page_num",
	".cs.C2S_FriendHelper_GetKnights.page_num",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_ME, {
	"C2S_FriendHelper_GetKnights",
	".cs.C2S_FriendHelper_GetKnights",
	{},
	{},
	{
		var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_PLAY_TYPE_F,
		var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_PAGE_F,
		var_0_10.C2S_FRIENDHELPER_GETKNIGHTS_PAGE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_RET_F, {
	"ret",
	".cs.S2C_FriendHelper_GetKnights.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_FriendHelper_GetKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_PAGE_F, {
	"page",
	".cs.S2C_FriendHelper_GetKnights.page",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_PAGE_NUM_F, {
	"page_num",
	".cs.S2C_FriendHelper_GetKnights.page_num",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_HELPER_F, {
	"helper",
	".cs.S2C_FriendHelper_GetKnights.helper",
	5,
	4,
	3,
	false,
	{},
	var_0_3.USERFRIENDHELPER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_TOTAL_KNIGHTS_F, {
	"total_knights",
	".cs.S2C_FriendHelper_GetKnights.total_knights",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_ME, {
	"S2C_FriendHelper_GetKnights",
	".cs.S2C_FriendHelper_GetKnights",
	{},
	{},
	{
		var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_RET_F,
		var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_PLAY_TYPE_F,
		var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_PAGE_F,
		var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_PAGE_NUM_F,
		var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_HELPER_F,
		var_0_10.S2C_FRIENDHELPER_GETKNIGHTS_TOTAL_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_SETKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_FriendHelper_SetKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_SETKNIGHTS_SETTING_F, {
	"setting",
	".cs.C2S_FriendHelper_SetKnights.setting",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FRIENDHELPERKNIGHTSETTING_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDHELPER_SETKNIGHTS_ME, {
	"C2S_FriendHelper_SetKnights",
	".cs.C2S_FriendHelper_SetKnights",
	{},
	{},
	{
		var_0_10.C2S_FRIENDHELPER_SETKNIGHTS_PLAY_TYPE_F,
		var_0_10.C2S_FRIENDHELPER_SETKNIGHTS_SETTING_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_RET_F, {
	"ret",
	".cs.S2C_FriendHelper_SetKnights.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_FriendHelper_SetKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_SETTING_F, {
	"setting",
	".cs.S2C_FriendHelper_SetKnights.setting",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FRIENDHELPERKNIGHTSETTING_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_ME, {
	"S2C_FriendHelper_SetKnights",
	".cs.S2C_FriendHelper_SetKnights",
	{},
	{},
	{
		var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_RET_F,
		var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_PLAY_TYPE_F,
		var_0_10.S2C_FRIENDHELPER_SETKNIGHTS_SETTING_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_SHOWSETKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_FriendHelper_ShowSetKnights.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDHELPER_SHOWSETKNIGHTS_ME, {
	"C2S_FriendHelper_ShowSetKnights",
	".cs.C2S_FriendHelper_ShowSetKnights",
	{},
	{},
	{
		var_0_10.C2S_FRIENDHELPER_SHOWSETKNIGHTS_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_RET_F, {
	"ret",
	".cs.S2C_FriendHelper_ShowSetKnights.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_FriendHelper_ShowSetKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_SETTING_F, {
	"setting",
	".cs.S2C_FriendHelper_ShowSetKnights.setting",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FRIENDHELPERKNIGHTSETTING_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_ME, {
	"S2C_FriendHelper_ShowSetKnights",
	".cs.S2C_FriendHelper_ShowSetKnights",
	{},
	{},
	{
		var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_RET_F,
		var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_PLAY_TYPE_F,
		var_0_10.S2C_FRIENDHELPER_SHOWSETKNIGHTS_SETTING_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_USEKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_FriendHelper_UseKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDHELPER_USEKNIGHTS_USE_F, {
	"use",
	".cs.C2S_FriendHelper_UseKnights.use",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FRIENDHELPERKNIGHTUSE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDHELPER_USEKNIGHTS_ME, {
	"C2S_FriendHelper_UseKnights",
	".cs.C2S_FriendHelper_UseKnights",
	{},
	{},
	{
		var_0_10.C2S_FRIENDHELPER_USEKNIGHTS_PLAY_TYPE_F,
		var_0_10.C2S_FRIENDHELPER_USEKNIGHTS_USE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_RET_F, {
	"ret",
	".cs.S2C_FriendHelper_UseKnights.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_FriendHelper_UseKnights.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_USE_F, {
	"use",
	".cs.S2C_FriendHelper_UseKnights.use",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FRIENDHELPERKNIGHTUSE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_ME, {
	"S2C_FriendHelper_UseKnights",
	".cs.S2C_FriendHelper_UseKnights",
	{},
	{},
	{
		var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_RET_F,
		var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_PLAY_TYPE_F,
		var_0_10.S2C_FRIENDHELPER_USEKNIGHTS_USE_F
	},
	false,
	{}
})

return var_0_10
