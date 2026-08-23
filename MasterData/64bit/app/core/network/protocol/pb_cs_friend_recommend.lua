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
	C2S_FRIENDRECOMMEND_GETINFO_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_INVITE_CODE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_USER_STATE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_INVITED_STATE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_INVITE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_TASK_INFO_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_INVITE_INFO_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_ACT_INFO_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_INVITE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_TASK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_RECHARGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_GETINFO_RECHARGE_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_SYNCINFO_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_SYNCINFO_ACT_INFO_F = protobuf.FieldDescriptor(),
	C2S_FRIENDRECOMMEND_USEINVITECODE_ME = protobuf.Descriptor(),
	C2S_FRIENDRECOMMEND_USEINVITECODE_INVITE_CODE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_USEINVITECODE_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_USEINVITECODE_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_USEINVITECODE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_FRIENDRECOMMEND_INVITED_AWARD_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_INVITED_AWARD_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_INVITED_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_INVITED_AWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_FRIENDRECOMMEND_INVITE_AWARD_ME = protobuf.Descriptor(),
	C2S_FRIENDRECOMMEND_INVITE_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_INVITE_AWARD_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_INVITE_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_INVITE_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_INVITE_AWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_AWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_IS_TASK_AWARD_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_RECHARGE_NUM_F = protobuf.FieldDescriptor(),
	C2S_FRIENDRECOMMEND_RECHARGE_GETAWARD_ME = protobuf.Descriptor(),
	C2S_FRIENDRECOMMEND_RECHARGE_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_ME = protobuf.Descriptor(),
	S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_GETINFO_ME, {
	"C2S_FriendRecommend_GetInfo",
	".cs.C2S_FriendRecommend_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_RET_F, {
	"ret",
	".cs.S2C_FriendRecommend_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_CODE_F, {
	"invite_code",
	".cs.S2C_FriendRecommend_GetInfo.invite_code",
	2,
	1,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_USER_STATE_F, {
	"user_state",
	".cs.S2C_FriendRecommend_GetInfo.user_state",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITED_STATE_F, {
	"invited_state",
	".cs.S2C_FriendRecommend_GetInfo.invited_state",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_NUM_F, {
	"invite_num",
	".cs.S2C_FriendRecommend_GetInfo.invite_num",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_TASK_INFO_F, {
	"task_info",
	".cs.S2C_FriendRecommend_GetInfo.task_info",
	6,
	5,
	3,
	false,
	{},
	var_0_3.FRIENDRECOMMENDTASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_AWARD_IDS_F, {
	"award_ids",
	".cs.S2C_FriendRecommend_GetInfo.award_ids",
	7,
	6,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_INFO_F, {
	"invite_info",
	".cs.S2C_FriendRecommend_GetInfo.invite_info",
	8,
	7,
	3,
	false,
	{},
	var_0_3.FRIENDRECOMMENDINVITEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_ACT_INFO_F, {
	"act_info",
	".cs.S2C_FriendRecommend_GetInfo.act_info",
	9,
	8,
	1,
	false,
	nil,
	var_0_3.FRIENDRECOMMENDACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_AWARDS_F, {
	"invite_awards",
	".cs.S2C_FriendRecommend_GetInfo.invite_awards",
	10,
	9,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_TASK_AWARDS_F, {
	"task_awards",
	".cs.S2C_FriendRecommend_GetInfo.task_awards",
	11,
	10,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_RECHARGE_NUM_F, {
	"recharge_num",
	".cs.S2C_FriendRecommend_GetInfo.recharge_num",
	12,
	11,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_RECHARGE_AWARD_IDS_F, {
	"recharge_award_ids",
	".cs.S2C_FriendRecommend_GetInfo.recharge_award_ids",
	13,
	12,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_GETINFO_ME, {
	"S2C_FriendRecommend_GetInfo",
	".cs.S2C_FriendRecommend_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_RET_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_CODE_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_USER_STATE_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITED_STATE_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_NUM_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_TASK_INFO_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_AWARD_IDS_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_INFO_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_ACT_INFO_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_INVITE_AWARDS_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_TASK_AWARDS_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_RECHARGE_NUM_F,
		var_0_10.S2C_FRIENDRECOMMEND_GETINFO_RECHARGE_AWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_SYNCINFO_ACT_INFO_F, {
	"act_info",
	".cs.S2C_FriendRecommend_SyncInfo.act_info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.FRIENDRECOMMENDACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_SYNCINFO_ME, {
	"S2C_FriendRecommend_SyncInfo",
	".cs.S2C_FriendRecommend_SyncInfo",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_SYNCINFO_ACT_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_USEINVITECODE_INVITE_CODE_F, {
	"invite_code",
	".cs.C2S_FriendRecommend_UseInviteCode.invite_code",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_USEINVITECODE_ME, {
	"C2S_FriendRecommend_UseInviteCode",
	".cs.C2S_FriendRecommend_UseInviteCode",
	{},
	{},
	{
		var_0_10.C2S_FRIENDRECOMMEND_USEINVITECODE_INVITE_CODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_USEINVITECODE_RET_F, {
	"ret",
	".cs.S2C_FriendRecommend_UseInviteCode.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_USEINVITECODE_AWARDS_F, {
	"awards",
	".cs.S2C_FriendRecommend_UseInviteCode.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_USEINVITECODE_ME, {
	"S2C_FriendRecommend_UseInviteCode",
	".cs.S2C_FriendRecommend_UseInviteCode",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_USEINVITECODE_RET_F,
		var_0_10.S2C_FRIENDRECOMMEND_USEINVITECODE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_INVITED_AWARD_ME, {
	"C2S_FriendRecommend_Invited_Award",
	".cs.C2S_FriendRecommend_Invited_Award",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITED_AWARD_RET_F, {
	"ret",
	".cs.S2C_FriendRecommend_Invited_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITED_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_FriendRecommend_Invited_Award.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITED_AWARD_ME, {
	"S2C_FriendRecommend_Invited_Award",
	".cs.S2C_FriendRecommend_Invited_Award",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_INVITED_AWARD_RET_F,
		var_0_10.S2C_FRIENDRECOMMEND_INVITED_AWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_INVITE_AWARD_ID_F, {
	"id",
	".cs.C2S_FriendRecommend_Invite_Award.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_INVITE_AWARD_ME, {
	"C2S_FriendRecommend_Invite_Award",
	".cs.C2S_FriendRecommend_Invite_Award",
	{},
	{},
	{
		var_0_10.C2S_FRIENDRECOMMEND_INVITE_AWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_RET_F, {
	"ret",
	".cs.S2C_FriendRecommend_Invite_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_ID_F, {
	"id",
	".cs.S2C_FriendRecommend_Invite_Award.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_FriendRecommend_Invite_Award.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_ME, {
	"S2C_FriendRecommend_Invite_Award",
	".cs.S2C_FriendRecommend_Invite_Award",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_RET_F,
		var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_ID_F,
		var_0_10.S2C_FRIENDRECOMMEND_INVITE_AWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_AWARD_TYPE_F, {
	"award_type",
	".cs.S2C_FriendRecommend_AwardStatusFlush.award_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_IS_TASK_AWARD_F, {
	"is_task_award",
	".cs.S2C_FriendRecommend_AwardStatusFlush.is_task_award",
	2,
	1,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_AWARD_IDS_F, {
	"award_ids",
	".cs.S2C_FriendRecommend_AwardStatusFlush.award_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_RECHARGE_NUM_F, {
	"recharge_num",
	".cs.S2C_FriendRecommend_AwardStatusFlush.recharge_num",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_ME, {
	"S2C_FriendRecommend_AwardStatusFlush",
	".cs.S2C_FriendRecommend_AwardStatusFlush",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_AWARD_TYPE_F,
		var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_IS_TASK_AWARD_F,
		var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_AWARD_IDS_F,
		var_0_10.S2C_FRIENDRECOMMEND_AWARDSTATUSFLUSH_RECHARGE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_RECHARGE_GETAWARD_ID_F, {
	"id",
	".cs.C2S_FriendRecommend_Recharge_GetAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FRIENDRECOMMEND_RECHARGE_GETAWARD_ME, {
	"C2S_FriendRecommend_Recharge_GetAward",
	".cs.C2S_FriendRecommend_Recharge_GetAward",
	{},
	{},
	{
		var_0_10.C2S_FRIENDRECOMMEND_RECHARGE_GETAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_RET_F, {
	"ret",
	".cs.S2C_FriendRecommend_Recharge_GetAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_ID_F, {
	"id",
	".cs.S2C_FriendRecommend_Recharge_GetAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_FriendRecommend_Recharge_GetAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_ME, {
	"S2C_FriendRecommend_Recharge_GetAward",
	".cs.S2C_FriendRecommend_Recharge_GetAward",
	{},
	{},
	{
		var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_RET_F,
		var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_ID_F,
		var_0_10.S2C_FRIENDRECOMMEND_RECHARGE_GETAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
