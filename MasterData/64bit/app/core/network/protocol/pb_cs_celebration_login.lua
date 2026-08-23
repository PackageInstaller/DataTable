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
	C2S_CELEBRATIONLOGIN_GETINFO_ME = protobuf.Descriptor(),
	C2S_CELEBRATIONLOGIN_GETINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_GETINFO_ME = protobuf.Descriptor(),
	S2C_CELEBRATIONLOGIN_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_GETINFO_LOGIN_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_ME = protobuf.Descriptor(),
	S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_ACTIVITY_LIST_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_LOGINS_F = protobuf.FieldDescriptor(),
	C2S_CELEBRATIONLOGIN_SIGNREWARD_ME = protobuf.Descriptor(),
	C2S_CELEBRATIONLOGIN_SIGNREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_SIGNREWARD_ME = protobuf.Descriptor(),
	S2C_CELEBRATIONLOGIN_SIGNREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_SIGNREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_SIGNREWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_CELEBRATIONLOGIN_DRAWGIFT_ME = protobuf.Descriptor(),
	C2S_CELEBRATIONLOGIN_DRAWGIFT_ID_F = protobuf.FieldDescriptor(),
	C2S_CELEBRATIONLOGIN_DRAWGIFT_DAY_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_DRAWGIFT_ME = protobuf.Descriptor(),
	S2C_CELEBRATIONLOGIN_DRAWGIFT_RET_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_DRAWGIFT_ID_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_DRAWGIFT_GIFT_F = protobuf.FieldDescriptor(),
	S2C_CELEBRATIONLOGIN_DRAWGIFT_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_GETINFO_ID_F, {
	"id",
	".cs.C2S_CelebrationLogin_GetInfo.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_GETINFO_ME, {
	"C2S_CelebrationLogin_GetInfo",
	".cs.C2S_CelebrationLogin_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_CELEBRATIONLOGIN_GETINFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_GETINFO_RET_F, {
	"ret",
	".cs.S2C_CelebrationLogin_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_GETINFO_LOGIN_F, {
	"login",
	".cs.S2C_CelebrationLogin_GetInfo.login",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.CELEBRATIONLOGIN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_GETINFO_ME, {
	"S2C_CelebrationLogin_GetInfo",
	".cs.S2C_CelebrationLogin_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_CELEBRATIONLOGIN_GETINFO_RET_F,
		var_0_10.S2C_CELEBRATIONLOGIN_GETINFO_LOGIN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_ACTIVITY_LIST_F, {
	"activity_list",
	".cs.S2C_CelebrationLogin_NoticeActivity.activity_list",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CELEBRATIONLOGINACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_LOGINS_F, {
	"logins",
	".cs.S2C_CelebrationLogin_NoticeActivity.logins",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CELEBRATIONLOGIN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_ME, {
	"S2C_CelebrationLogin_NoticeActivity",
	".cs.S2C_CelebrationLogin_NoticeActivity",
	{},
	{},
	{
		var_0_10.S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_ACTIVITY_LIST_F,
		var_0_10.S2C_CELEBRATIONLOGIN_NOTICEACTIVITY_LOGINS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_SIGNREWARD_ID_F, {
	"id",
	".cs.C2S_CelebrationLogin_SignReward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_SIGNREWARD_ME, {
	"C2S_CelebrationLogin_SignReward",
	".cs.C2S_CelebrationLogin_SignReward",
	{},
	{},
	{
		var_0_10.C2S_CELEBRATIONLOGIN_SIGNREWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_RET_F, {
	"ret",
	".cs.S2C_CelebrationLogin_SignReward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_ID_F, {
	"id",
	".cs.S2C_CelebrationLogin_SignReward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_AWARDS_F, {
	"awards",
	".cs.S2C_CelebrationLogin_SignReward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_ME, {
	"S2C_CelebrationLogin_SignReward",
	".cs.S2C_CelebrationLogin_SignReward",
	{},
	{},
	{
		var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_RET_F,
		var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_ID_F,
		var_0_10.S2C_CELEBRATIONLOGIN_SIGNREWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_DRAWGIFT_ID_F, {
	"id",
	".cs.C2S_CelebrationLogin_DrawGift.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_DRAWGIFT_DAY_F, {
	"day",
	".cs.C2S_CelebrationLogin_DrawGift.day",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CELEBRATIONLOGIN_DRAWGIFT_ME, {
	"C2S_CelebrationLogin_DrawGift",
	".cs.C2S_CelebrationLogin_DrawGift",
	{},
	{},
	{
		var_0_10.C2S_CELEBRATIONLOGIN_DRAWGIFT_ID_F,
		var_0_10.C2S_CELEBRATIONLOGIN_DRAWGIFT_DAY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_RET_F, {
	"ret",
	".cs.S2C_CelebrationLogin_DrawGift.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_ID_F, {
	"id",
	".cs.S2C_CelebrationLogin_DrawGift.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_GIFT_F, {
	"gift",
	".cs.S2C_CelebrationLogin_DrawGift.gift",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.CELEBRATIONLOGINGIFT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_AWARDS_F, {
	"awards",
	".cs.S2C_CelebrationLogin_DrawGift.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_ME, {
	"S2C_CelebrationLogin_DrawGift",
	".cs.S2C_CelebrationLogin_DrawGift",
	{},
	{},
	{
		var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_RET_F,
		var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_ID_F,
		var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_GIFT_F,
		var_0_10.S2C_CELEBRATIONLOGIN_DRAWGIFT_AWARDS_F
	},
	false,
	{}
})

return var_0_10
