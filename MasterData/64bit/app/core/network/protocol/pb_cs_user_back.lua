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
	C2S_USERBACK_GETINFO_ME = protobuf.Descriptor(),
	S2C_USERBACK_GETINFO_ME = protobuf.Descriptor(),
	S2C_USERBACK_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETINFO_INFO_F = protobuf.FieldDescriptor(),
	C2S_USERBACK_GETSIGNREWARD_ME = protobuf.Descriptor(),
	C2S_USERBACK_GETSIGNREWARD_DAY_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETSIGNREWARD_ME = protobuf.Descriptor(),
	S2C_USERBACK_GETSIGNREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETSIGNREWARD_DAY_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETSIGNREWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_USERBACK_BUYGIFT_ME = protobuf.Descriptor(),
	C2S_USERBACK_BUYGIFT_ID_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_BUYGIFT_ME = protobuf.Descriptor(),
	S2C_USERBACK_BUYGIFT_RET_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_BUYGIFT_ID_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_BUYGIFT_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_USERBACK_GETBACKRES_ME = protobuf.Descriptor(),
	C2S_USERBACK_GETBACKRES_DAY_F = protobuf.FieldDescriptor(),
	C2S_USERBACK_GETBACKRES_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETBACKRES_ME = protobuf.Descriptor(),
	S2C_USERBACK_GETBACKRES_RET_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETBACKRES_DAY_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETBACKRES_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_GETBACKRES_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_USERBACK_RESACTIONNOTIFY_ME = protobuf.Descriptor(),
	S2C_USERBACK_RESACTIONNOTIFY_DATAS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_USERBACK_GETINFO_ME, {
	"C2S_UserBack_GetInfo",
	".cs.C2S_UserBack_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETINFO_RET_F, {
	"ret",
	".cs.S2C_UserBack_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETINFO_INFO_F, {
	"info",
	".cs.S2C_UserBack_GetInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.USERBACK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_USERBACK_GETINFO_ME, {
	"S2C_UserBack_GetInfo",
	".cs.S2C_UserBack_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_USERBACK_GETINFO_RET_F,
		var_0_10.S2C_USERBACK_GETINFO_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_USERBACK_GETSIGNREWARD_DAY_F, {
	"day",
	".cs.C2S_UserBack_GetSignReward.day",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_USERBACK_GETSIGNREWARD_ME, {
	"C2S_UserBack_GetSignReward",
	".cs.C2S_UserBack_GetSignReward",
	{},
	{},
	{
		var_0_10.C2S_USERBACK_GETSIGNREWARD_DAY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETSIGNREWARD_RET_F, {
	"ret",
	".cs.S2C_UserBack_GetSignReward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETSIGNREWARD_DAY_F, {
	"day",
	".cs.S2C_UserBack_GetSignReward.day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETSIGNREWARD_AWARDS_F, {
	"awards",
	".cs.S2C_UserBack_GetSignReward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_USERBACK_GETSIGNREWARD_ME, {
	"S2C_UserBack_GetSignReward",
	".cs.S2C_UserBack_GetSignReward",
	{},
	{},
	{
		var_0_10.S2C_USERBACK_GETSIGNREWARD_RET_F,
		var_0_10.S2C_USERBACK_GETSIGNREWARD_DAY_F,
		var_0_10.S2C_USERBACK_GETSIGNREWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_USERBACK_BUYGIFT_ID_F, {
	"id",
	".cs.C2S_UserBack_BuyGift.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_USERBACK_BUYGIFT_ME, {
	"C2S_UserBack_BuyGift",
	".cs.C2S_UserBack_BuyGift",
	{},
	{},
	{
		var_0_10.C2S_USERBACK_BUYGIFT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_BUYGIFT_RET_F, {
	"ret",
	".cs.S2C_UserBack_BuyGift.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_BUYGIFT_ID_F, {
	"id",
	".cs.S2C_UserBack_BuyGift.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_BUYGIFT_AWARDS_F, {
	"awards",
	".cs.S2C_UserBack_BuyGift.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_USERBACK_BUYGIFT_ME, {
	"S2C_UserBack_BuyGift",
	".cs.S2C_UserBack_BuyGift",
	{},
	{},
	{
		var_0_10.S2C_USERBACK_BUYGIFT_RET_F,
		var_0_10.S2C_USERBACK_BUYGIFT_ID_F,
		var_0_10.S2C_USERBACK_BUYGIFT_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_USERBACK_GETBACKRES_DAY_F, {
	"day",
	".cs.C2S_UserBack_GetBackRes.day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_USERBACK_GETBACKRES_TARGET_ID_F, {
	"target_id",
	".cs.C2S_UserBack_GetBackRes.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_USERBACK_GETBACKRES_ME, {
	"C2S_UserBack_GetBackRes",
	".cs.C2S_UserBack_GetBackRes",
	{},
	{},
	{
		var_0_10.C2S_USERBACK_GETBACKRES_DAY_F,
		var_0_10.C2S_USERBACK_GETBACKRES_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETBACKRES_RET_F, {
	"ret",
	".cs.S2C_UserBack_GetBackRes.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETBACKRES_DAY_F, {
	"day",
	".cs.S2C_UserBack_GetBackRes.day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETBACKRES_TARGET_ID_F, {
	"target_id",
	".cs.S2C_UserBack_GetBackRes.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_GETBACKRES_AWARDS_F, {
	"awards",
	".cs.S2C_UserBack_GetBackRes.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_USERBACK_GETBACKRES_ME, {
	"S2C_UserBack_GetBackRes",
	".cs.S2C_UserBack_GetBackRes",
	{},
	{},
	{
		var_0_10.S2C_USERBACK_GETBACKRES_RET_F,
		var_0_10.S2C_USERBACK_GETBACKRES_DAY_F,
		var_0_10.S2C_USERBACK_GETBACKRES_TARGET_ID_F,
		var_0_10.S2C_USERBACK_GETBACKRES_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_USERBACK_RESACTIONNOTIFY_DATAS_F, {
	"datas",
	".cs.S2C_UserBack_ResActionNotify.datas",
	1,
	0,
	3,
	false,
	{},
	var_0_3.USERBACKOKRES_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_USERBACK_RESACTIONNOTIFY_ME, {
	"S2C_UserBack_ResActionNotify",
	".cs.S2C_UserBack_ResActionNotify",
	{},
	{},
	{
		var_0_10.S2C_USERBACK_RESACTIONNOTIFY_DATAS_F
	},
	false,
	{}
})

return var_0_10
