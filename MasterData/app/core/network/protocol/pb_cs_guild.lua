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
	C2S_GUILD_GETINFO_ME = protobuf.Descriptor(),
	C2S_GUILD_GETINFO_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_ME = protobuf.Descriptor(),
	S2C_GUILD_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_GUILD_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_MEMBERS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_JOIN_GUILD_COOL_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_ZERO_HOUR_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_SEND_MERGE_DATA_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_RECEIVE_MERGE_DATA_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETINFO_ACTIVE_NUM_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CREATE_ME = protobuf.Descriptor(),
	C2S_GUILD_CREATE_NAME_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CREATE_ICON_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CREATE_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CREATE_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CREATE_IS_HIGH_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_ME = protobuf.Descriptor(),
	S2C_GUILD_CREATE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_NAME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_ICON_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_CONFIRM_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_GUILD_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CREATE_IS_HIGH_F = protobuf.FieldDescriptor(),
	C2S_GUILD_REQJOIN_ME = protobuf.Descriptor(),
	C2S_GUILD_REQJOIN_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REQJOIN_ME = protobuf.Descriptor(),
	S2C_GUILD_REQJOIN_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REQJOIN_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REQJOIN_JOIN_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REQJOIN_GUILD_NAME_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CONFIRM_ME = protobuf.Descriptor(),
	C2S_GUILD_CONFIRM_APPLY_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILD_CONFIRM_ACCEPT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CONFIRM_ME = protobuf.Descriptor(),
	S2C_GUILD_CONFIRM_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CONFIRM_ACCEPT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CONFIRM_APPLY_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CONFIRM_MEMBER_F = protobuf.FieldDescriptor(),
	S2C_GUILD_CONFIRM_REMAIN_MEMBER_F = protobuf.FieldDescriptor(),
	C2S_GUILD_KICKOUT_ME = protobuf.Descriptor(),
	C2S_GUILD_KICKOUT_KICK_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_KICKOUT_ME = protobuf.Descriptor(),
	S2C_GUILD_KICKOUT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_KICKOUT_KICK_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILD_QUIT_ME = protobuf.Descriptor(),
	S2C_GUILD_QUIT_ME = protobuf.Descriptor(),
	S2C_GUILD_QUIT_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILD_DISMISS_ME = protobuf.Descriptor(),
	S2C_GUILD_DISMISS_ME = protobuf.Descriptor(),
	S2C_GUILD_DISMISS_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILD_APPOINT_ME = protobuf.Descriptor(),
	C2S_GUILD_APPOINT_MEMBER_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILD_APPOINT_POSITION_F = protobuf.FieldDescriptor(),
	S2C_GUILD_APPOINT_ME = protobuf.Descriptor(),
	S2C_GUILD_APPOINT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_APPOINT_MEMBER_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_APPOINT_POSITION_F = protobuf.FieldDescriptor(),
	C2S_GUILD_IMPEACH_ME = protobuf.Descriptor(),
	S2C_GUILD_IMPEACH_ME = protobuf.Descriptor(),
	S2C_GUILD_IMPEACH_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILD_GETHISTORY_ME = protobuf.Descriptor(),
	C2S_GUILD_GETHISTORY_START_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETHISTORY_ME = protobuf.Descriptor(),
	S2C_GUILD_GETHISTORY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETHISTORY_START_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETHISTORY_HISTORYS_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_ME = protobuf.Descriptor(),
	C2S_GUILD_MODIFYINFO_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_NAME_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_ICON_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_FRAME_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_APPLY_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_DECLARATION_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_ANNOUNCEMENT_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MODIFYINFO_CONFIRM_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_ME = protobuf.Descriptor(),
	S2C_GUILD_MODIFYINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_NAME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_ICON_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_FRAME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_APPLY_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_DECLARATION_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_ANNOUNCEMENT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MODIFYINFO_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_GUILD_GETMESSAGEBOARD_ME = protobuf.Descriptor(),
	S2C_GUILD_GETMESSAGEBOARD_ME = protobuf.Descriptor(),
	S2C_GUILD_GETMESSAGEBOARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETMESSAGEBOARD_MESSAGES_F = protobuf.FieldDescriptor(),
	C2S_GUILD_LEAVEAMESSAGE_ME = protobuf.Descriptor(),
	C2S_GUILD_LEAVEAMESSAGE_MESSAGE_F = protobuf.FieldDescriptor(),
	S2C_GUILD_LEAVEAMESSAGE_ME = protobuf.Descriptor(),
	S2C_GUILD_LEAVEAMESSAGE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_LEAVEAMESSAGE_MESSAGE_F = protobuf.FieldDescriptor(),
	S2C_GUILD_LEAVEAMESSAGE_GUILD_MESSAGE_F = protobuf.FieldDescriptor(),
	C2S_GUILD_OPERATEMESSAGE_ME = protobuf.Descriptor(),
	C2S_GUILD_OPERATEMESSAGE_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILD_OPERATEMESSAGE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILD_OPERATEMESSAGE_ME = protobuf.Descriptor(),
	S2C_GUILD_OPERATEMESSAGE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_OPERATEMESSAGE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_OPERATEMESSAGE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GUILD_RECOMMEND_ME = protobuf.Descriptor(),
	C2S_GUILD_RECOMMEND_INDEX_F = protobuf.FieldDescriptor(),
	S2C_GUILD_RECOMMEND_ME = protobuf.Descriptor(),
	S2C_GUILD_RECOMMEND_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_RECOMMEND_INDEX_F = protobuf.FieldDescriptor(),
	S2C_GUILD_RECOMMEND_GUILDS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_RECOMMEND_START_JOIN_TIME_F = protobuf.FieldDescriptor(),
	C2S_GUILD_SEARCH_ME = protobuf.Descriptor(),
	C2S_GUILD_SEARCH_KEY_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SEARCH_ME = protobuf.Descriptor(),
	S2C_GUILD_SEARCH_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SEARCH_KEY_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SEARCH_GUILDS_F = protobuf.FieldDescriptor(),
	C2S_GUILD_GETAPPLYLIST_ME = protobuf.Descriptor(),
	S2C_GUILD_GETAPPLYLIST_ME = protobuf.Descriptor(),
	S2C_GUILD_GETAPPLYLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETAPPLYLIST_USERS_F = protobuf.FieldDescriptor(),
	C2S_GUILD_GETAPPLYHISTORY_ME = protobuf.Descriptor(),
	S2C_GUILD_GETAPPLYHISTORY_ME = protobuf.Descriptor(),
	S2C_GUILD_GETAPPLYHISTORY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETAPPLYHISTORY_GUILDS_F = protobuf.FieldDescriptor(),
	C2S_GUILD_DELETEAPPLY_ME = protobuf.Descriptor(),
	C2S_GUILD_DELETEAPPLY_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_DELETEAPPLY_ME = protobuf.Descriptor(),
	S2C_GUILD_DELETEAPPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_DELETEAPPLY_GUILD_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILD_GETWORSHIPINFO_ME = protobuf.Descriptor(),
	S2C_GUILD_GETWORSHIPINFO_ME = protobuf.Descriptor(),
	S2C_GUILD_GETWORSHIPINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPINFO_PROGRESS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPINFO_WORSHIP_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPINFO_AWARDED_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPINFO_ZERO_HOUR_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPINFO_WORSHIP_NUM_F = protobuf.FieldDescriptor(),
	C2S_GUILD_DOWORSHIP_ME = protobuf.Descriptor(),
	C2S_GUILD_DOWORSHIP_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_DOWORSHIP_ME = protobuf.Descriptor(),
	S2C_GUILD_DOWORSHIP_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_DOWORSHIP_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_DOWORSHIP_CRIT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_DOWORSHIP_WORSHIP_NUM_F = protobuf.FieldDescriptor(),
	C2S_GUILD_GETWORSHIPAWARD_ME = protobuf.Descriptor(),
	C2S_GUILD_GETWORSHIPAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPAWARD_ME = protobuf.Descriptor(),
	S2C_GUILD_GETWORSHIPAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_GUILD_GETWORSHIPAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_NOTIFYJOIN_ME = protobuf.Descriptor(),
	S2C_GUILD_NOTIFYJOIN_GUILD_F = protobuf.FieldDescriptor(),
	S2C_GUILD_NOTIFYLEAVE_ME = protobuf.Descriptor(),
	S2C_GUILD_NOTIFYLEAVE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GUILD_FASTJOIN_ME = protobuf.Descriptor(),
	S2C_GUILD_FASTJOIN_ME = protobuf.Descriptor(),
	S2C_GUILD_FASTJOIN_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_FASTJOIN_GUILD_F = protobuf.FieldDescriptor(),
	C2S_GUILD_SENDGIFT_ME = protobuf.Descriptor(),
	C2S_GUILD_SENDGIFT_MEMBER_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SENDGIFT_ME = protobuf.Descriptor(),
	S2C_GUILD_SENDGIFT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SENDGIFT_MEMBER_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SENDGIFT_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SENDGIFT_GUILD_RECEIVE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_SENDGIFT_GUILD_SEND_COUNT_F = protobuf.FieldDescriptor(),
	C2S_GUILD_ONEKEYSENDGIFT_ME = protobuf.Descriptor(),
	S2C_GUILD_ONEKEYSENDGIFT_ME = protobuf.Descriptor(),
	S2C_GUILD_ONEKEYSENDGIFT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_ONEKEYSENDGIFT_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_ONEKEYSENDGIFT_GUILD_SEND_COUNT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_ONEKEYSENDGIFT_CAN_AWARD_WORSHIP_HELP_F = protobuf.FieldDescriptor(),
	S2C_GUILD_ONEKEYSENDGIFT_MEMBER_IDS_F = protobuf.FieldDescriptor(),
	C2S_GUILD_REDPACKET_INFO_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_INFO_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_INFO_RP_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_INFO_USE_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_INFO_PICK_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_INFO_GUILD_PICK_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_INFO_POINT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_INFO_LUCK_F = protobuf.FieldDescriptor(),
	C2S_GUILD_REDPACKET_DETAIL_ME = protobuf.Descriptor(),
	C2S_GUILD_REDPACKET_DETAIL_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_DETAIL_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_DETAIL_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_DETAIL_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_DETAIL_RP_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_DETAIL_PICK_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_DETAIL_DISTRIBUTE_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_DETAIL_LUCKY_F = protobuf.FieldDescriptor(),
	C2S_GUILD_REDPACKET_PICK_ME = protobuf.Descriptor(),
	C2S_GUILD_REDPACKET_PICK_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_PICK_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_RP_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_PICK_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_GUILD_PICK_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_LUCK_F = protobuf.FieldDescriptor(),
	C2S_GUILD_REDPACKET_PICK_ONEKEY_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_PICK_ONEKEY_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_PICK_ONEKEY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_PICK_ONEKEY_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_GUILD_REDPACKET_USE_ME = protobuf.Descriptor(),
	C2S_GUILD_REDPACKET_USE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_USE_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_USE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_USE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_USE_RP_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_USE_USE_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_USE_POINT_F = protobuf.FieldDescriptor(),
	S2C_GUILD_REDPACKET_FLUSH_ME = protobuf.Descriptor(),
	S2C_GUILD_REDPACKET_FLUSH_RP_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MERGE_REQUEST_ME = protobuf.Descriptor(),
	C2S_GUILD_MERGE_REQUEST_TARGET_GUILD_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MERGE_REQUEST_TARGET_USER_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_REQUEST_ME = protobuf.Descriptor(),
	S2C_GUILD_MERGE_REQUEST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_REQUEST_MERGE_DATA_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MERGE_AGREE_ME = protobuf.Descriptor(),
	C2S_GUILD_MERGE_AGREE_TARGET_GUILD_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MERGE_AGREE_CHANGE_USER_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_AGREE_ME = protobuf.Descriptor(),
	S2C_GUILD_MERGE_AGREE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_AGREE_MERGE_DATA_F = protobuf.FieldDescriptor(),
	C2S_GUILD_MERGE_REFUSE_ME = protobuf.Descriptor(),
	C2S_GUILD_MERGE_REFUSE_TARGET_GUILD_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_REFUSE_ME = protobuf.Descriptor(),
	S2C_GUILD_MERGE_REFUSE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_REFUSE_TARGET_GUILD_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_NOTIFY_ME = protobuf.Descriptor(),
	C2S_GUILD_MERGE_CANCEL_ME = protobuf.Descriptor(),
	C2S_GUILD_MERGE_CANCEL_TARGET_GUILD_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_CANCEL_ME = protobuf.Descriptor(),
	S2C_GUILD_MERGE_CANCEL_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILD_MERGE_CANCEL_TARGET_GUILD_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_GETINFO_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_Guild_GetInfo.guild_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETINFO_ME, {
	"C2S_Guild_GetInfo",
	".cs.C2S_Guild_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_GUILD_GETINFO_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Guild_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_GUILD_F, {
	"guild",
	".cs.S2C_Guild_GetInfo.guild",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_MEMBERS_F, {
	"members",
	".cs.S2C_Guild_GetInfo.members",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GUILDMEMBER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_JOIN_GUILD_COOL_TIME_F, {
	"join_guild_cool_time",
	".cs.S2C_Guild_GetInfo.join_guild_cool_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_ZERO_HOUR_LEVEL_F, {
	"zero_hour_level",
	".cs.S2C_Guild_GetInfo.zero_hour_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_Guild_GetInfo.guild_id",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_SEND_MERGE_DATA_F, {
	"send_merge_data",
	".cs.S2C_Guild_GetInfo.send_merge_data",
	7,
	6,
	3,
	false,
	{},
	var_0_3.GUILDMERGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_RECEIVE_MERGE_DATA_F, {
	"receive_merge_data",
	".cs.S2C_Guild_GetInfo.receive_merge_data",
	8,
	7,
	3,
	false,
	{},
	var_0_3.GUILDMERGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETINFO_ACTIVE_NUM_F, {
	"active_num",
	".cs.S2C_Guild_GetInfo.active_num",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETINFO_ME, {
	"S2C_Guild_GetInfo",
	".cs.S2C_Guild_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETINFO_RET_F,
		var_0_10.S2C_GUILD_GETINFO_GUILD_F,
		var_0_10.S2C_GUILD_GETINFO_MEMBERS_F,
		var_0_10.S2C_GUILD_GETINFO_JOIN_GUILD_COOL_TIME_F,
		var_0_10.S2C_GUILD_GETINFO_ZERO_HOUR_LEVEL_F,
		var_0_10.S2C_GUILD_GETINFO_GUILD_ID_F,
		var_0_10.S2C_GUILD_GETINFO_SEND_MERGE_DATA_F,
		var_0_10.S2C_GUILD_GETINFO_RECEIVE_MERGE_DATA_F,
		var_0_10.S2C_GUILD_GETINFO_ACTIVE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CREATE_NAME_F, {
	"name",
	".cs.C2S_Guild_Create.name",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CREATE_ICON_F, {
	"icon",
	".cs.C2S_Guild_Create.icon",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CREATE_CONFIRM_F, {
	"confirm",
	".cs.C2S_Guild_Create.confirm",
	3,
	2,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CREATE_LEVEL_F, {
	"level",
	".cs.C2S_Guild_Create.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CREATE_IS_HIGH_F, {
	"is_high",
	".cs.C2S_Guild_Create.is_high",
	5,
	4,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_CREATE_ME, {
	"C2S_Guild_Create",
	".cs.C2S_Guild_Create",
	{},
	{},
	{
		var_0_10.C2S_GUILD_CREATE_NAME_F,
		var_0_10.C2S_GUILD_CREATE_ICON_F,
		var_0_10.C2S_GUILD_CREATE_CONFIRM_F,
		var_0_10.C2S_GUILD_CREATE_LEVEL_F,
		var_0_10.C2S_GUILD_CREATE_IS_HIGH_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_RET_F, {
	"ret",
	".cs.S2C_Guild_Create.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_NAME_F, {
	"name",
	".cs.S2C_Guild_Create.name",
	2,
	1,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_ICON_F, {
	"icon",
	".cs.S2C_Guild_Create.icon",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_CONFIRM_F, {
	"confirm",
	".cs.S2C_Guild_Create.confirm",
	4,
	3,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_LEVEL_F, {
	"level",
	".cs.S2C_Guild_Create.level",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_GUILD_F, {
	"guild",
	".cs.S2C_Guild_Create.guild",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CREATE_IS_HIGH_F, {
	"is_high",
	".cs.S2C_Guild_Create.is_high",
	7,
	6,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_CREATE_ME, {
	"S2C_Guild_Create",
	".cs.S2C_Guild_Create",
	{},
	{},
	{
		var_0_10.S2C_GUILD_CREATE_RET_F,
		var_0_10.S2C_GUILD_CREATE_NAME_F,
		var_0_10.S2C_GUILD_CREATE_ICON_F,
		var_0_10.S2C_GUILD_CREATE_CONFIRM_F,
		var_0_10.S2C_GUILD_CREATE_LEVEL_F,
		var_0_10.S2C_GUILD_CREATE_GUILD_F,
		var_0_10.S2C_GUILD_CREATE_IS_HIGH_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_REQJOIN_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_Guild_ReqJoin.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_REQJOIN_ME, {
	"C2S_Guild_ReqJoin",
	".cs.C2S_Guild_ReqJoin",
	{},
	{},
	{
		var_0_10.C2S_GUILD_REQJOIN_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REQJOIN_RET_F, {
	"ret",
	".cs.S2C_Guild_ReqJoin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REQJOIN_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_Guild_ReqJoin.guild_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REQJOIN_JOIN_F, {
	"join",
	".cs.S2C_Guild_ReqJoin.join",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REQJOIN_GUILD_NAME_F, {
	"guild_name",
	".cs.S2C_Guild_ReqJoin.guild_name",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REQJOIN_ME, {
	"S2C_Guild_ReqJoin",
	".cs.S2C_Guild_ReqJoin",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REQJOIN_RET_F,
		var_0_10.S2C_GUILD_REQJOIN_GUILD_ID_F,
		var_0_10.S2C_GUILD_REQJOIN_JOIN_F,
		var_0_10.S2C_GUILD_REQJOIN_GUILD_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CONFIRM_APPLY_ID_F, {
	"apply_id",
	".cs.C2S_Guild_Confirm.apply_id",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_CONFIRM_ACCEPT_F, {
	"accept",
	".cs.C2S_Guild_Confirm.accept",
	2,
	1,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_CONFIRM_ME, {
	"C2S_Guild_Confirm",
	".cs.C2S_Guild_Confirm",
	{},
	{},
	{
		var_0_10.C2S_GUILD_CONFIRM_APPLY_ID_F,
		var_0_10.C2S_GUILD_CONFIRM_ACCEPT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CONFIRM_RET_F, {
	"ret",
	".cs.S2C_Guild_Confirm.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CONFIRM_ACCEPT_F, {
	"accept",
	".cs.S2C_Guild_Confirm.accept",
	2,
	1,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CONFIRM_APPLY_ID_F, {
	"apply_id",
	".cs.S2C_Guild_Confirm.apply_id",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CONFIRM_MEMBER_F, {
	"member",
	".cs.S2C_Guild_Confirm.member",
	4,
	3,
	3,
	false,
	{},
	var_0_3.GUILDMEMBER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_CONFIRM_REMAIN_MEMBER_F, {
	"remain_member",
	".cs.S2C_Guild_Confirm.remain_member",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_CONFIRM_ME, {
	"S2C_Guild_Confirm",
	".cs.S2C_Guild_Confirm",
	{},
	{},
	{
		var_0_10.S2C_GUILD_CONFIRM_RET_F,
		var_0_10.S2C_GUILD_CONFIRM_ACCEPT_F,
		var_0_10.S2C_GUILD_CONFIRM_APPLY_ID_F,
		var_0_10.S2C_GUILD_CONFIRM_MEMBER_F,
		var_0_10.S2C_GUILD_CONFIRM_REMAIN_MEMBER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_KICKOUT_KICK_ID_F, {
	"kick_id",
	".cs.C2S_Guild_KickOut.kick_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_KICKOUT_ME, {
	"C2S_Guild_KickOut",
	".cs.C2S_Guild_KickOut",
	{},
	{},
	{
		var_0_10.C2S_GUILD_KICKOUT_KICK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_KICKOUT_RET_F, {
	"ret",
	".cs.S2C_Guild_KickOut.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_KICKOUT_KICK_ID_F, {
	"kick_id",
	".cs.S2C_Guild_KickOut.kick_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_KICKOUT_ME, {
	"S2C_Guild_KickOut",
	".cs.S2C_Guild_KickOut",
	{},
	{},
	{
		var_0_10.S2C_GUILD_KICKOUT_RET_F,
		var_0_10.S2C_GUILD_KICKOUT_KICK_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_QUIT_ME, {
	"C2S_Guild_Quit",
	".cs.C2S_Guild_Quit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_QUIT_RET_F, {
	"ret",
	".cs.S2C_Guild_Quit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_QUIT_ME, {
	"S2C_Guild_Quit",
	".cs.S2C_Guild_Quit",
	{},
	{},
	{
		var_0_10.S2C_GUILD_QUIT_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_DISMISS_ME, {
	"C2S_Guild_Dismiss",
	".cs.C2S_Guild_Dismiss",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DISMISS_RET_F, {
	"ret",
	".cs.S2C_Guild_Dismiss.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_DISMISS_ME, {
	"S2C_Guild_Dismiss",
	".cs.S2C_Guild_Dismiss",
	{},
	{},
	{
		var_0_10.S2C_GUILD_DISMISS_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_APPOINT_MEMBER_ID_F, {
	"member_id",
	".cs.C2S_Guild_Appoint.member_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_APPOINT_POSITION_F, {
	"position",
	".cs.C2S_Guild_Appoint.position",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_APPOINT_ME, {
	"C2S_Guild_Appoint",
	".cs.C2S_Guild_Appoint",
	{},
	{},
	{
		var_0_10.C2S_GUILD_APPOINT_MEMBER_ID_F,
		var_0_10.C2S_GUILD_APPOINT_POSITION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_APPOINT_RET_F, {
	"ret",
	".cs.S2C_Guild_Appoint.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_APPOINT_MEMBER_ID_F, {
	"member_id",
	".cs.S2C_Guild_Appoint.member_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_APPOINT_POSITION_F, {
	"position",
	".cs.S2C_Guild_Appoint.position",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_APPOINT_ME, {
	"S2C_Guild_Appoint",
	".cs.S2C_Guild_Appoint",
	{},
	{},
	{
		var_0_10.S2C_GUILD_APPOINT_RET_F,
		var_0_10.S2C_GUILD_APPOINT_MEMBER_ID_F,
		var_0_10.S2C_GUILD_APPOINT_POSITION_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_IMPEACH_ME, {
	"C2S_Guild_Impeach",
	".cs.C2S_Guild_Impeach",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_IMPEACH_RET_F, {
	"ret",
	".cs.S2C_Guild_Impeach.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_IMPEACH_ME, {
	"S2C_Guild_Impeach",
	".cs.S2C_Guild_Impeach",
	{},
	{},
	{
		var_0_10.S2C_GUILD_IMPEACH_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_GETHISTORY_START_F, {
	"start",
	".cs.C2S_Guild_GetHistory.start",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETHISTORY_ME, {
	"C2S_Guild_GetHistory",
	".cs.C2S_Guild_GetHistory",
	{},
	{},
	{
		var_0_10.C2S_GUILD_GETHISTORY_START_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETHISTORY_RET_F, {
	"ret",
	".cs.S2C_Guild_GetHistory.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETHISTORY_START_F, {
	"start",
	".cs.S2C_Guild_GetHistory.start",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETHISTORY_HISTORYS_F, {
	"historys",
	".cs.S2C_Guild_GetHistory.historys",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GUILDHISTORY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETHISTORY_ME, {
	"S2C_Guild_GetHistory",
	".cs.S2C_Guild_GetHistory",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETHISTORY_RET_F,
		var_0_10.S2C_GUILD_GETHISTORY_START_F,
		var_0_10.S2C_GUILD_GETHISTORY_HISTORYS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_TYPE_F, {
	"type",
	".cs.C2S_Guild_ModifyInfo.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_NAME_F, {
	"name",
	".cs.C2S_Guild_ModifyInfo.name",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_ICON_F, {
	"icon",
	".cs.C2S_Guild_ModifyInfo.icon",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_FRAME_F, {
	"frame",
	".cs.C2S_Guild_ModifyInfo.frame",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_APPLY_LEVEL_F, {
	"apply_level",
	".cs.C2S_Guild_ModifyInfo.apply_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_DECLARATION_F, {
	"declaration",
	".cs.C2S_Guild_ModifyInfo.declaration",
	6,
	5,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_ANNOUNCEMENT_F, {
	"announcement",
	".cs.C2S_Guild_ModifyInfo.announcement",
	7,
	6,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_CONFIRM_F, {
	"confirm",
	".cs.C2S_Guild_ModifyInfo.confirm",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_MODIFYINFO_ME, {
	"C2S_Guild_ModifyInfo",
	".cs.C2S_Guild_ModifyInfo",
	{},
	{},
	{
		var_0_10.C2S_GUILD_MODIFYINFO_TYPE_F,
		var_0_10.C2S_GUILD_MODIFYINFO_NAME_F,
		var_0_10.C2S_GUILD_MODIFYINFO_ICON_F,
		var_0_10.C2S_GUILD_MODIFYINFO_FRAME_F,
		var_0_10.C2S_GUILD_MODIFYINFO_APPLY_LEVEL_F,
		var_0_10.C2S_GUILD_MODIFYINFO_DECLARATION_F,
		var_0_10.C2S_GUILD_MODIFYINFO_ANNOUNCEMENT_F,
		var_0_10.C2S_GUILD_MODIFYINFO_CONFIRM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_RET_F, {
	"ret",
	".cs.S2C_Guild_ModifyInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_TYPE_F, {
	"type",
	".cs.S2C_Guild_ModifyInfo.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_NAME_F, {
	"name",
	".cs.S2C_Guild_ModifyInfo.name",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_ICON_F, {
	"icon",
	".cs.S2C_Guild_ModifyInfo.icon",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_FRAME_F, {
	"frame",
	".cs.S2C_Guild_ModifyInfo.frame",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_APPLY_LEVEL_F, {
	"apply_level",
	".cs.S2C_Guild_ModifyInfo.apply_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_DECLARATION_F, {
	"declaration",
	".cs.S2C_Guild_ModifyInfo.declaration",
	7,
	6,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_ANNOUNCEMENT_F, {
	"announcement",
	".cs.S2C_Guild_ModifyInfo.announcement",
	8,
	7,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_CONFIRM_F, {
	"confirm",
	".cs.S2C_Guild_ModifyInfo.confirm",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_MODIFYINFO_ME, {
	"S2C_Guild_ModifyInfo",
	".cs.S2C_Guild_ModifyInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILD_MODIFYINFO_RET_F,
		var_0_10.S2C_GUILD_MODIFYINFO_TYPE_F,
		var_0_10.S2C_GUILD_MODIFYINFO_NAME_F,
		var_0_10.S2C_GUILD_MODIFYINFO_ICON_F,
		var_0_10.S2C_GUILD_MODIFYINFO_FRAME_F,
		var_0_10.S2C_GUILD_MODIFYINFO_APPLY_LEVEL_F,
		var_0_10.S2C_GUILD_MODIFYINFO_DECLARATION_F,
		var_0_10.S2C_GUILD_MODIFYINFO_ANNOUNCEMENT_F,
		var_0_10.S2C_GUILD_MODIFYINFO_CONFIRM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETMESSAGEBOARD_ME, {
	"C2S_Guild_GetMessageBoard",
	".cs.C2S_Guild_GetMessageBoard",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETMESSAGEBOARD_RET_F, {
	"ret",
	".cs.S2C_Guild_GetMessageBoard.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETMESSAGEBOARD_MESSAGES_F, {
	"messages",
	".cs.S2C_Guild_GetMessageBoard.messages",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GUILDMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETMESSAGEBOARD_ME, {
	"S2C_Guild_GetMessageBoard",
	".cs.S2C_Guild_GetMessageBoard",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETMESSAGEBOARD_RET_F,
		var_0_10.S2C_GUILD_GETMESSAGEBOARD_MESSAGES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_LEAVEAMESSAGE_MESSAGE_F, {
	"message",
	".cs.C2S_Guild_LeaveAMessage.message",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_LEAVEAMESSAGE_ME, {
	"C2S_Guild_LeaveAMessage",
	".cs.C2S_Guild_LeaveAMessage",
	{},
	{},
	{
		var_0_10.C2S_GUILD_LEAVEAMESSAGE_MESSAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_LEAVEAMESSAGE_RET_F, {
	"ret",
	".cs.S2C_Guild_LeaveAMessage.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_LEAVEAMESSAGE_MESSAGE_F, {
	"message",
	".cs.S2C_Guild_LeaveAMessage.message",
	2,
	1,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_LEAVEAMESSAGE_GUILD_MESSAGE_F, {
	"guild_message",
	".cs.S2C_Guild_LeaveAMessage.guild_message",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.GUILDMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_LEAVEAMESSAGE_ME, {
	"S2C_Guild_LeaveAMessage",
	".cs.S2C_Guild_LeaveAMessage",
	{},
	{},
	{
		var_0_10.S2C_GUILD_LEAVEAMESSAGE_RET_F,
		var_0_10.S2C_GUILD_LEAVEAMESSAGE_MESSAGE_F,
		var_0_10.S2C_GUILD_LEAVEAMESSAGE_GUILD_MESSAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_OPERATEMESSAGE_ID_F, {
	"id",
	".cs.C2S_Guild_OperateMessage.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_OPERATEMESSAGE_TYPE_F, {
	"type",
	".cs.C2S_Guild_OperateMessage.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_OPERATEMESSAGE_ME, {
	"C2S_Guild_OperateMessage",
	".cs.C2S_Guild_OperateMessage",
	{},
	{},
	{
		var_0_10.C2S_GUILD_OPERATEMESSAGE_ID_F,
		var_0_10.C2S_GUILD_OPERATEMESSAGE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_OPERATEMESSAGE_RET_F, {
	"ret",
	".cs.S2C_Guild_OperateMessage.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_OPERATEMESSAGE_ID_F, {
	"id",
	".cs.S2C_Guild_OperateMessage.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_OPERATEMESSAGE_TYPE_F, {
	"type",
	".cs.S2C_Guild_OperateMessage.type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_OPERATEMESSAGE_ME, {
	"S2C_Guild_OperateMessage",
	".cs.S2C_Guild_OperateMessage",
	{},
	{},
	{
		var_0_10.S2C_GUILD_OPERATEMESSAGE_RET_F,
		var_0_10.S2C_GUILD_OPERATEMESSAGE_ID_F,
		var_0_10.S2C_GUILD_OPERATEMESSAGE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_RECOMMEND_INDEX_F, {
	"index",
	".cs.C2S_Guild_Recommend.index",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_RECOMMEND_ME, {
	"C2S_Guild_Recommend",
	".cs.C2S_Guild_Recommend",
	{},
	{},
	{
		var_0_10.C2S_GUILD_RECOMMEND_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_RECOMMEND_RET_F, {
	"ret",
	".cs.S2C_Guild_Recommend.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_RECOMMEND_INDEX_F, {
	"index",
	".cs.S2C_Guild_Recommend.index",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_RECOMMEND_GUILDS_F, {
	"guilds",
	".cs.S2C_Guild_Recommend.guilds",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_RECOMMEND_START_JOIN_TIME_F, {
	"start_join_time",
	".cs.S2C_Guild_Recommend.start_join_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_RECOMMEND_ME, {
	"S2C_Guild_Recommend",
	".cs.S2C_Guild_Recommend",
	{},
	{},
	{
		var_0_10.S2C_GUILD_RECOMMEND_RET_F,
		var_0_10.S2C_GUILD_RECOMMEND_INDEX_F,
		var_0_10.S2C_GUILD_RECOMMEND_GUILDS_F,
		var_0_10.S2C_GUILD_RECOMMEND_START_JOIN_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_SEARCH_KEY_F, {
	"key",
	".cs.C2S_Guild_Search.key",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_SEARCH_ME, {
	"C2S_Guild_Search",
	".cs.C2S_Guild_Search",
	{},
	{},
	{
		var_0_10.C2S_GUILD_SEARCH_KEY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SEARCH_RET_F, {
	"ret",
	".cs.S2C_Guild_Search.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SEARCH_KEY_F, {
	"key",
	".cs.S2C_Guild_Search.key",
	2,
	1,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SEARCH_GUILDS_F, {
	"guilds",
	".cs.S2C_Guild_Search.guilds",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_SEARCH_ME, {
	"S2C_Guild_Search",
	".cs.S2C_Guild_Search",
	{},
	{},
	{
		var_0_10.S2C_GUILD_SEARCH_RET_F,
		var_0_10.S2C_GUILD_SEARCH_KEY_F,
		var_0_10.S2C_GUILD_SEARCH_GUILDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETAPPLYLIST_ME, {
	"C2S_Guild_GetApplyList",
	".cs.C2S_Guild_GetApplyList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETAPPLYLIST_RET_F, {
	"ret",
	".cs.S2C_Guild_GetApplyList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETAPPLYLIST_USERS_F, {
	"users",
	".cs.S2C_Guild_GetApplyList.users",
	2,
	1,
	3,
	false,
	{},
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETAPPLYLIST_ME, {
	"S2C_Guild_GetApplyList",
	".cs.S2C_Guild_GetApplyList",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETAPPLYLIST_RET_F,
		var_0_10.S2C_GUILD_GETAPPLYLIST_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETAPPLYHISTORY_ME, {
	"C2S_Guild_GetApplyHistory",
	".cs.C2S_Guild_GetApplyHistory",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETAPPLYHISTORY_RET_F, {
	"ret",
	".cs.S2C_Guild_GetApplyHistory.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETAPPLYHISTORY_GUILDS_F, {
	"guilds",
	".cs.S2C_Guild_GetApplyHistory.guilds",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETAPPLYHISTORY_ME, {
	"S2C_Guild_GetApplyHistory",
	".cs.S2C_Guild_GetApplyHistory",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETAPPLYHISTORY_RET_F,
		var_0_10.S2C_GUILD_GETAPPLYHISTORY_GUILDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_DELETEAPPLY_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_Guild_DeleteApply.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_DELETEAPPLY_ME, {
	"C2S_Guild_DeleteApply",
	".cs.C2S_Guild_DeleteApply",
	{},
	{},
	{
		var_0_10.C2S_GUILD_DELETEAPPLY_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DELETEAPPLY_RET_F, {
	"ret",
	".cs.S2C_Guild_DeleteApply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DELETEAPPLY_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_Guild_DeleteApply.guild_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_DELETEAPPLY_ME, {
	"S2C_Guild_DeleteApply",
	".cs.S2C_Guild_DeleteApply",
	{},
	{},
	{
		var_0_10.S2C_GUILD_DELETEAPPLY_RET_F,
		var_0_10.S2C_GUILD_DELETEAPPLY_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETWORSHIPINFO_ME, {
	"C2S_Guild_GetWorshipInfo",
	".cs.C2S_Guild_GetWorshipInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_RET_F, {
	"ret",
	".cs.S2C_Guild_GetWorshipInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_PROGRESS_F, {
	"progress",
	".cs.S2C_Guild_GetWorshipInfo.progress",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_WORSHIP_ID_F, {
	"worship_id",
	".cs.S2C_Guild_GetWorshipInfo.worship_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_AWARDED_ID_F, {
	"awarded_id",
	".cs.S2C_Guild_GetWorshipInfo.awarded_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_ZERO_HOUR_LEVEL_F, {
	"zero_hour_level",
	".cs.S2C_Guild_GetWorshipInfo.zero_hour_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_WORSHIP_NUM_F, {
	"worship_num",
	".cs.S2C_Guild_GetWorshipInfo.worship_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPINFO_ME, {
	"S2C_Guild_GetWorshipInfo",
	".cs.S2C_Guild_GetWorshipInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETWORSHIPINFO_RET_F,
		var_0_10.S2C_GUILD_GETWORSHIPINFO_PROGRESS_F,
		var_0_10.S2C_GUILD_GETWORSHIPINFO_WORSHIP_ID_F,
		var_0_10.S2C_GUILD_GETWORSHIPINFO_AWARDED_ID_F,
		var_0_10.S2C_GUILD_GETWORSHIPINFO_ZERO_HOUR_LEVEL_F,
		var_0_10.S2C_GUILD_GETWORSHIPINFO_WORSHIP_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_DOWORSHIP_ID_F, {
	"id",
	".cs.C2S_Guild_DoWorship.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_DOWORSHIP_ME, {
	"C2S_Guild_DoWorship",
	".cs.C2S_Guild_DoWorship",
	{},
	{},
	{
		var_0_10.C2S_GUILD_DOWORSHIP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DOWORSHIP_RET_F, {
	"ret",
	".cs.S2C_Guild_DoWorship.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DOWORSHIP_ID_F, {
	"id",
	".cs.S2C_Guild_DoWorship.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DOWORSHIP_CRIT_F, {
	"crit",
	".cs.S2C_Guild_DoWorship.crit",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_DOWORSHIP_WORSHIP_NUM_F, {
	"worship_num",
	".cs.S2C_Guild_DoWorship.worship_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_DOWORSHIP_ME, {
	"S2C_Guild_DoWorship",
	".cs.S2C_Guild_DoWorship",
	{},
	{},
	{
		var_0_10.S2C_GUILD_DOWORSHIP_RET_F,
		var_0_10.S2C_GUILD_DOWORSHIP_ID_F,
		var_0_10.S2C_GUILD_DOWORSHIP_CRIT_F,
		var_0_10.S2C_GUILD_DOWORSHIP_WORSHIP_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_GETWORSHIPAWARD_INDEX_F, {
	"index",
	".cs.C2S_Guild_GetWorshipAward.index",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_GETWORSHIPAWARD_ME, {
	"C2S_Guild_GetWorshipAward",
	".cs.C2S_Guild_GetWorshipAward",
	{},
	{},
	{
		var_0_10.C2S_GUILD_GETWORSHIPAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPAWARD_RET_F, {
	"ret",
	".cs.S2C_Guild_GetWorshipAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPAWARD_INDEX_F, {
	"index",
	".cs.S2C_Guild_GetWorshipAward.index",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Guild_GetWorshipAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_GETWORSHIPAWARD_ME, {
	"S2C_Guild_GetWorshipAward",
	".cs.S2C_Guild_GetWorshipAward",
	{},
	{},
	{
		var_0_10.S2C_GUILD_GETWORSHIPAWARD_RET_F,
		var_0_10.S2C_GUILD_GETWORSHIPAWARD_INDEX_F,
		var_0_10.S2C_GUILD_GETWORSHIPAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_NOTIFYJOIN_GUILD_F, {
	"guild",
	".cs.S2C_Guild_NotifyJoin.guild",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_NOTIFYJOIN_ME, {
	"S2C_Guild_NotifyJoin",
	".cs.S2C_Guild_NotifyJoin",
	{},
	{},
	{
		var_0_10.S2C_GUILD_NOTIFYJOIN_GUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_NOTIFYLEAVE_TYPE_F, {
	"type",
	".cs.S2C_Guild_NotifyLeave.type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_NOTIFYLEAVE_ME, {
	"S2C_Guild_NotifyLeave",
	".cs.S2C_Guild_NotifyLeave",
	{},
	{},
	{
		var_0_10.S2C_GUILD_NOTIFYLEAVE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_FASTJOIN_ME, {
	"C2S_Guild_FastJoin",
	".cs.C2S_Guild_FastJoin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_FASTJOIN_RET_F, {
	"ret",
	".cs.S2C_Guild_FastJoin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_FASTJOIN_GUILD_F, {
	"guild",
	".cs.S2C_Guild_FastJoin.guild",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_FASTJOIN_ME, {
	"S2C_Guild_FastJoin",
	".cs.S2C_Guild_FastJoin",
	{},
	{},
	{
		var_0_10.S2C_GUILD_FASTJOIN_RET_F,
		var_0_10.S2C_GUILD_FASTJOIN_GUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_SENDGIFT_MEMBER_ID_F, {
	"member_id",
	".cs.C2S_Guild_SendGift.member_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_SENDGIFT_ME, {
	"C2S_Guild_SendGift",
	".cs.C2S_Guild_SendGift",
	{},
	{},
	{
		var_0_10.C2S_GUILD_SENDGIFT_MEMBER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SENDGIFT_RET_F, {
	"ret",
	".cs.S2C_Guild_SendGift.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SENDGIFT_MEMBER_ID_F, {
	"member_id",
	".cs.S2C_Guild_SendGift.member_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SENDGIFT_AWARDS_F, {
	"awards",
	".cs.S2C_Guild_SendGift.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SENDGIFT_GUILD_RECEIVE_COUNT_F, {
	"guild_receive_count",
	".cs.S2C_Guild_SendGift.guild_receive_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_SENDGIFT_GUILD_SEND_COUNT_F, {
	"guild_send_count",
	".cs.S2C_Guild_SendGift.guild_send_count",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_SENDGIFT_ME, {
	"S2C_Guild_SendGift",
	".cs.S2C_Guild_SendGift",
	{},
	{},
	{
		var_0_10.S2C_GUILD_SENDGIFT_RET_F,
		var_0_10.S2C_GUILD_SENDGIFT_MEMBER_ID_F,
		var_0_10.S2C_GUILD_SENDGIFT_AWARDS_F,
		var_0_10.S2C_GUILD_SENDGIFT_GUILD_RECEIVE_COUNT_F,
		var_0_10.S2C_GUILD_SENDGIFT_GUILD_SEND_COUNT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_ONEKEYSENDGIFT_ME, {
	"C2S_Guild_OneKeySendGift",
	".cs.C2S_Guild_OneKeySendGift",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_ONEKEYSENDGIFT_RET_F, {
	"ret",
	".cs.S2C_Guild_OneKeySendGift.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_ONEKEYSENDGIFT_AWARDS_F, {
	"awards",
	".cs.S2C_Guild_OneKeySendGift.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_ONEKEYSENDGIFT_GUILD_SEND_COUNT_F, {
	"guild_send_count",
	".cs.S2C_Guild_OneKeySendGift.guild_send_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_ONEKEYSENDGIFT_CAN_AWARD_WORSHIP_HELP_F, {
	"can_award_worship_help",
	".cs.S2C_Guild_OneKeySendGift.can_award_worship_help",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_ONEKEYSENDGIFT_MEMBER_IDS_F, {
	"member_ids",
	".cs.S2C_Guild_OneKeySendGift.member_ids",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_ONEKEYSENDGIFT_ME, {
	"S2C_Guild_OneKeySendGift",
	".cs.S2C_Guild_OneKeySendGift",
	{},
	{},
	{
		var_0_10.S2C_GUILD_ONEKEYSENDGIFT_RET_F,
		var_0_10.S2C_GUILD_ONEKEYSENDGIFT_AWARDS_F,
		var_0_10.S2C_GUILD_ONEKEYSENDGIFT_GUILD_SEND_COUNT_F,
		var_0_10.S2C_GUILD_ONEKEYSENDGIFT_CAN_AWARD_WORSHIP_HELP_F,
		var_0_10.S2C_GUILD_ONEKEYSENDGIFT_MEMBER_IDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_REDPACKET_INFO_ME, {
	"C2S_Guild_RedPacket_Info",
	".cs.C2S_Guild_RedPacket_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_RET_F, {
	"ret",
	".cs.S2C_Guild_RedPacket_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_RP_F, {
	"rp",
	".cs.S2C_Guild_RedPacket_Info.rp",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GUILDREDPACKET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_USE_TIME_F, {
	"use_time",
	".cs.S2C_Guild_RedPacket_Info.use_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_PICK_TIME_F, {
	"pick_time",
	".cs.S2C_Guild_RedPacket_Info.pick_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_GUILD_PICK_TIME_F, {
	"guild_pick_time",
	".cs.S2C_Guild_RedPacket_Info.guild_pick_time",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_POINT_F, {
	"point",
	".cs.S2C_Guild_RedPacket_Info.point",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_LUCK_F, {
	"luck",
	".cs.S2C_Guild_RedPacket_Info.luck",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REDPACKET_INFO_ME, {
	"S2C_Guild_RedPacket_Info",
	".cs.S2C_Guild_RedPacket_Info",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REDPACKET_INFO_RET_F,
		var_0_10.S2C_GUILD_REDPACKET_INFO_RP_F,
		var_0_10.S2C_GUILD_REDPACKET_INFO_USE_TIME_F,
		var_0_10.S2C_GUILD_REDPACKET_INFO_PICK_TIME_F,
		var_0_10.S2C_GUILD_REDPACKET_INFO_GUILD_PICK_TIME_F,
		var_0_10.S2C_GUILD_REDPACKET_INFO_POINT_F,
		var_0_10.S2C_GUILD_REDPACKET_INFO_LUCK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_REDPACKET_DETAIL_ID_F, {
	"id",
	".cs.C2S_Guild_RedPacket_Detail.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_REDPACKET_DETAIL_ME, {
	"C2S_Guild_RedPacket_Detail",
	".cs.C2S_Guild_RedPacket_Detail",
	{},
	{},
	{
		var_0_10.C2S_GUILD_REDPACKET_DETAIL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_RET_F, {
	"ret",
	".cs.S2C_Guild_RedPacket_Detail.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_ID_F, {
	"id",
	".cs.S2C_Guild_RedPacket_Detail.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_RP_F, {
	"rp",
	".cs.S2C_Guild_RedPacket_Detail.rp",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.GUILDREDPACKET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_PICK_F, {
	"pick",
	".cs.S2C_Guild_RedPacket_Detail.pick",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_DISTRIBUTE_F, {
	"distribute",
	".cs.S2C_Guild_RedPacket_Detail.distribute",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_LUCKY_F, {
	"lucky",
	".cs.S2C_Guild_RedPacket_Detail.lucky",
	6,
	5,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REDPACKET_DETAIL_ME, {
	"S2C_Guild_RedPacket_Detail",
	".cs.S2C_Guild_RedPacket_Detail",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REDPACKET_DETAIL_RET_F,
		var_0_10.S2C_GUILD_REDPACKET_DETAIL_ID_F,
		var_0_10.S2C_GUILD_REDPACKET_DETAIL_RP_F,
		var_0_10.S2C_GUILD_REDPACKET_DETAIL_PICK_F,
		var_0_10.S2C_GUILD_REDPACKET_DETAIL_DISTRIBUTE_F,
		var_0_10.S2C_GUILD_REDPACKET_DETAIL_LUCKY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_REDPACKET_PICK_ID_F, {
	"id",
	".cs.C2S_Guild_RedPacket_Pick.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_REDPACKET_PICK_ME, {
	"C2S_Guild_RedPacket_Pick",
	".cs.C2S_Guild_RedPacket_Pick",
	{},
	{},
	{
		var_0_10.C2S_GUILD_REDPACKET_PICK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_RET_F, {
	"ret",
	".cs.S2C_Guild_RedPacket_Pick.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_ID_F, {
	"id",
	".cs.S2C_Guild_RedPacket_Pick.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_AWARDS_F, {
	"awards",
	".cs.S2C_Guild_RedPacket_Pick.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_RP_F, {
	"rp",
	".cs.S2C_Guild_RedPacket_Pick.rp",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.GUILDREDPACKET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_PICK_TIME_F, {
	"pick_time",
	".cs.S2C_Guild_RedPacket_Pick.pick_time",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_GUILD_PICK_TIME_F, {
	"guild_pick_time",
	".cs.S2C_Guild_RedPacket_Pick.guild_pick_time",
	6,
	5,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_LUCK_F, {
	"luck",
	".cs.S2C_Guild_RedPacket_Pick.luck",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_ME, {
	"S2C_Guild_RedPacket_Pick",
	".cs.S2C_Guild_RedPacket_Pick",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REDPACKET_PICK_RET_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_ID_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_AWARDS_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_RP_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_PICK_TIME_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_GUILD_PICK_TIME_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_LUCK_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_REDPACKET_PICK_ONEKEY_ME, {
	"C2S_Guild_RedPacket_Pick_OneKey",
	".cs.C2S_Guild_RedPacket_Pick_OneKey",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_ONEKEY_RET_F, {
	"ret",
	".cs.S2C_Guild_RedPacket_Pick_OneKey.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_ONEKEY_AWARDS_F, {
	"awards",
	".cs.S2C_Guild_RedPacket_Pick_OneKey.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REDPACKET_PICK_ONEKEY_ME, {
	"S2C_Guild_RedPacket_Pick_OneKey",
	".cs.S2C_Guild_RedPacket_Pick_OneKey",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REDPACKET_PICK_ONEKEY_RET_F,
		var_0_10.S2C_GUILD_REDPACKET_PICK_ONEKEY_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_REDPACKET_USE_ID_F, {
	"id",
	".cs.C2S_Guild_RedPacket_Use.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_REDPACKET_USE_ME, {
	"C2S_Guild_RedPacket_Use",
	".cs.C2S_Guild_RedPacket_Use",
	{},
	{},
	{
		var_0_10.C2S_GUILD_REDPACKET_USE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_USE_RET_F, {
	"ret",
	".cs.S2C_Guild_RedPacket_Use.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_USE_ID_F, {
	"id",
	".cs.S2C_Guild_RedPacket_Use.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_USE_RP_F, {
	"rp",
	".cs.S2C_Guild_RedPacket_Use.rp",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.GUILDREDPACKET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_USE_USE_TIME_F, {
	"use_time",
	".cs.S2C_Guild_RedPacket_Use.use_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_USE_POINT_F, {
	"point",
	".cs.S2C_Guild_RedPacket_Use.point",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REDPACKET_USE_ME, {
	"S2C_Guild_RedPacket_Use",
	".cs.S2C_Guild_RedPacket_Use",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REDPACKET_USE_RET_F,
		var_0_10.S2C_GUILD_REDPACKET_USE_ID_F,
		var_0_10.S2C_GUILD_REDPACKET_USE_RP_F,
		var_0_10.S2C_GUILD_REDPACKET_USE_USE_TIME_F,
		var_0_10.S2C_GUILD_REDPACKET_USE_POINT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_REDPACKET_FLUSH_RP_F, {
	"rp",
	".cs.S2C_Guild_RedPacket_Flush.rp",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.GUILDREDPACKET_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_REDPACKET_FLUSH_ME, {
	"S2C_Guild_RedPacket_Flush",
	".cs.S2C_Guild_RedPacket_Flush",
	{},
	{},
	{
		var_0_10.S2C_GUILD_REDPACKET_FLUSH_RP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MERGE_REQUEST_TARGET_GUILD_F, {
	"target_guild",
	".cs.C2S_Guild_Merge_Request.target_guild",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MERGE_REQUEST_TARGET_USER_F, {
	"target_user",
	".cs.C2S_Guild_Merge_Request.target_user",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_MERGE_REQUEST_ME, {
	"C2S_Guild_Merge_Request",
	".cs.C2S_Guild_Merge_Request",
	{},
	{},
	{
		var_0_10.C2S_GUILD_MERGE_REQUEST_TARGET_GUILD_F,
		var_0_10.C2S_GUILD_MERGE_REQUEST_TARGET_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_REQUEST_RET_F, {
	"ret",
	".cs.S2C_Guild_Merge_Request.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_REQUEST_MERGE_DATA_F, {
	"merge_data",
	".cs.S2C_Guild_Merge_Request.merge_data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDMERGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_MERGE_REQUEST_ME, {
	"S2C_Guild_Merge_Request",
	".cs.S2C_Guild_Merge_Request",
	{},
	{},
	{
		var_0_10.S2C_GUILD_MERGE_REQUEST_RET_F,
		var_0_10.S2C_GUILD_MERGE_REQUEST_MERGE_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MERGE_AGREE_TARGET_GUILD_F, {
	"target_guild",
	".cs.C2S_Guild_Merge_Agree.target_guild",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MERGE_AGREE_CHANGE_USER_F, {
	"change_user",
	".cs.C2S_Guild_Merge_Agree.change_user",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_MERGE_AGREE_ME, {
	"C2S_Guild_Merge_Agree",
	".cs.C2S_Guild_Merge_Agree",
	{},
	{},
	{
		var_0_10.C2S_GUILD_MERGE_AGREE_TARGET_GUILD_F,
		var_0_10.C2S_GUILD_MERGE_AGREE_CHANGE_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_AGREE_RET_F, {
	"ret",
	".cs.S2C_Guild_Merge_Agree.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_AGREE_MERGE_DATA_F, {
	"merge_data",
	".cs.S2C_Guild_Merge_Agree.merge_data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDMERGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_MERGE_AGREE_ME, {
	"S2C_Guild_Merge_Agree",
	".cs.S2C_Guild_Merge_Agree",
	{},
	{},
	{
		var_0_10.S2C_GUILD_MERGE_AGREE_RET_F,
		var_0_10.S2C_GUILD_MERGE_AGREE_MERGE_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MERGE_REFUSE_TARGET_GUILD_F, {
	"target_guild",
	".cs.C2S_Guild_Merge_Refuse.target_guild",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_MERGE_REFUSE_ME, {
	"C2S_Guild_Merge_Refuse",
	".cs.C2S_Guild_Merge_Refuse",
	{},
	{},
	{
		var_0_10.C2S_GUILD_MERGE_REFUSE_TARGET_GUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_REFUSE_RET_F, {
	"ret",
	".cs.S2C_Guild_Merge_Refuse.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_REFUSE_TARGET_GUILD_F, {
	"target_guild",
	".cs.S2C_Guild_Merge_Refuse.target_guild",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_MERGE_REFUSE_ME, {
	"S2C_Guild_Merge_Refuse",
	".cs.S2C_Guild_Merge_Refuse",
	{},
	{},
	{
		var_0_10.S2C_GUILD_MERGE_REFUSE_RET_F,
		var_0_10.S2C_GUILD_MERGE_REFUSE_TARGET_GUILD_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_MERGE_NOTIFY_ME, {
	"S2C_Guild_Merge_Notify",
	".cs.S2C_Guild_Merge_Notify",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILD_MERGE_CANCEL_TARGET_GUILD_F, {
	"target_guild",
	".cs.C2S_Guild_Merge_Cancel.target_guild",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILD_MERGE_CANCEL_ME, {
	"C2S_Guild_Merge_Cancel",
	".cs.C2S_Guild_Merge_Cancel",
	{},
	{},
	{
		var_0_10.C2S_GUILD_MERGE_CANCEL_TARGET_GUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_CANCEL_RET_F, {
	"ret",
	".cs.S2C_Guild_Merge_Cancel.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILD_MERGE_CANCEL_TARGET_GUILD_F, {
	"target_guild",
	".cs.S2C_Guild_Merge_Cancel.target_guild",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILD_MERGE_CANCEL_ME, {
	"S2C_Guild_Merge_Cancel",
	".cs.S2C_Guild_Merge_Cancel",
	{},
	{},
	{
		var_0_10.S2C_GUILD_MERGE_CANCEL_RET_F,
		var_0_10.S2C_GUILD_MERGE_CANCEL_TARGET_GUILD_F
	},
	false,
	{}
})

return var_0_10
