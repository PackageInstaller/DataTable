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
	C2S_GUILDALLIANCE_GETINFO_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_GETINFO_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_ALLIANCE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_GUILDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_SUGGESTIONS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_APPLY_ALLIANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_INVITE_ALLIANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_AREA_OPEN_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_LAST_GUILD_QUIT_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_LAST_USER_QUIT_TIME_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_SELF_BOX_DATA_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETINFO_TRIAL_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPLYLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_APPLYLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_APPLYLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPLYLIST_APPLY_GUILDS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_INVITELIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_INVITELIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_INVITELIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_INVITELIST_INVITE_GUILDS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_SEARCHLIST_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_SEARCHLIST_NAME_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SEARCHLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_SEARCHLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SEARCHLIST_ALLIANCES_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_CREATE_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_CREATE_NAME_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_CREATE_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_CREATE_APPLY_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_CREATE_FLAG_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_CREATE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_CREATE_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPLY_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_APPLY_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPLY_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_APPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPLY_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_CANCELAPPLY_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_CANCELAPPLY_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_CANCELAPPLY_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_CANCELAPPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_CANCELAPPLY_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPROVEAPPLY_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_APPROVEAPPLY_GUILD_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPROVEAPPLY_AGREE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEAPPLY_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_APPROVEAPPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEAPPLY_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEAPPLY_AGREE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEAPPLY_GUILDS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_INVITE_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_INVITE_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_INVITE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_INVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_INVITE_INVITE_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_CANCELINVITE_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_CANCELINVITE_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_CANCELINVITE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_CANCELINVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_CANCELINVITE_GUILD_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPROVEINVITE_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_APPROVEINVITE_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPROVEINVITE_AGREE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEINVITE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_APPROVEINVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEINVITE_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPROVEINVITE_AGREE_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_SUGGEST_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_SUGGEST_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SUGGEST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_SUGGEST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SUGGEST_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_QUIT_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_QUIT_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_QUIT_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_KICK_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_KICK_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_KICK_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_KICK_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_KICK_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_KICKNOTICE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_KICKNOTICE_GUILD_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_DISMISS_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_DISMISS_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_DISMISS_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPOINT_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_APPOINT_GUILD_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_APPOINT_GRADE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPOINT_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_APPOINT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPOINT_GUILD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_APPOINT_GRADE_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_IMPEACH_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_IMPEACH_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_IMPEACH_RET_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_MODIFYCONTENT_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_MODIFYCONTENT_TP_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_MODIFYCONTENT_CONTENT_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_MODIFYCONTENT_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_MODIFYCONTENT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_MODIFYCONTENT_TP_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_MODIFYCONTENT_CONTENT_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_MODIFYSETTING_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_MODIFYSETTING_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_MODIFYSETTING_APPLY_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_MODIFYSETTING_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_MODIFYSETTING_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_MODIFYSETTING_CONFIRM_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_MODIFYSETTING_APPLY_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_TASKLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_TASKLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_TASKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_TASKLIST_TASKS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_DISMISSNOTICE_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_GETSNAPSHOT_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_GETSNAPSHOT_ALLIANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETSNAPSHOT_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_GETSNAPSHOT_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETSNAPSHOT_ALLIANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETSNAPSHOT_SNAPSHOTS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_NOTICESTATE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_NOTICESTATE_STATE_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_GUILDLIST_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_GUILDLIST_NAME_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GUILDLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_GUILDLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GUILDLIST_GUILD_IDS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_DISPLAYLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_DISPLAYLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_DISPLAYLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_DISPLAYLIST_USER_IDS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_GETLOG_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_GETLOG_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_GETLOG_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_GETLOG_LOGS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_SERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SERVERINFOS_SID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SERVERINFOS_AREA_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_USERLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_USERLIST_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_USERLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_USERLIST_LIST_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_BOXINFO_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_BOXINFO_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_BOXINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXINFO_BOX_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_BOXGET_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_BOXGET_BOXES_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXGET_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_BOXGET_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXGET_BOXES_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_BOXOPEN_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_BOXOPEN_BOX_INFO_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_BOXOPEN_NUM_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXOPEN_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_BOXOPEN_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXOPEN_BOX_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXOPEN_NUM_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXOPEN_CUR_SCORE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXOPEN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXNOTIFY_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_BOXNOTIFY_BOX_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXNOTIFY_NUM_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_BOXGRANDNOTIFY_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_BOXGRANDNOTIFY_BOX_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_SENDBOX_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_SENDBOX_BOX_INFO_ID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_SENDBOX_NUM_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SENDBOX_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_SENDBOX_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_SENDBOX_BOX_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_EXCHANGEBOXAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_BOX_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_NEW_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_LEFT_SCORE_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_HONOURGETINFO_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_HONOURGETINFO_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_HONOURGETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_HONOURGETINFO_GUILD_HONOURS_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_HONOURSENDLIKE_ME = protobuf.Descriptor(),
	C2S_GUILDALLIANCE_HONOURSENDLIKE_TARGET_UID_F = protobuf.FieldDescriptor(),
	C2S_GUILDALLIANCE_HONOURSENDLIKE_TP_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_HONOURSENDLIKE_ME = protobuf.Descriptor(),
	S2C_GUILDALLIANCE_HONOURSENDLIKE_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_HONOURSENDLIKE_TP_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_HONOURSENDLIKE_HONOUR_LIKE_F = protobuf.FieldDescriptor(),
	S2C_GUILDALLIANCE_HONOURSENDLIKE_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_GETINFO_ME, {
	"C2S_GuildAlliance_GetInfo",
	".cs.C2S_GuildAlliance_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_ALLIANCE_F, {
	"alliance",
	".cs.S2C_GuildAlliance_GetInfo.alliance",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDALLIANCE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_GUILDS_F, {
	"guilds",
	".cs.S2C_GuildAlliance_GetInfo.guilds",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ALLIANCEGUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_SUGGESTIONS_F, {
	"suggestions",
	".cs.S2C_GuildAlliance_GetInfo.suggestions",
	4,
	3,
	3,
	false,
	{},
	var_0_3.ALLIANCESUGGESTION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_APPLY_ALLIANCE_IDS_F, {
	"apply_alliance_ids",
	".cs.S2C_GuildAlliance_GetInfo.apply_alliance_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_INVITE_ALLIANCE_IDS_F, {
	"invite_alliance_ids",
	".cs.S2C_GuildAlliance_GetInfo.invite_alliance_ids",
	6,
	5,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_AREA_OPEN_TIME_F, {
	"area_open_time",
	".cs.S2C_GuildAlliance_GetInfo.area_open_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_LAST_GUILD_QUIT_TIME_F, {
	"last_guild_quit_time",
	".cs.S2C_GuildAlliance_GetInfo.last_guild_quit_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_LAST_USER_QUIT_TIME_F, {
	"last_user_quit_time",
	".cs.S2C_GuildAlliance_GetInfo.last_user_quit_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_SELF_BOX_DATA_F, {
	"self_box_data",
	".cs.S2C_GuildAlliance_GetInfo.self_box_data",
	10,
	9,
	1,
	false,
	nil,
	var_0_3.SELFGUILDALLIANCEBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_TRIAL_F, {
	"trial",
	".cs.S2C_GuildAlliance_GetInfo.trial",
	11,
	10,
	1,
	false,
	nil,
	var_0_3.TRIALALLIANCE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETINFO_ME, {
	"S2C_GuildAlliance_GetInfo",
	".cs.S2C_GuildAlliance_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_GETINFO_RET_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_ALLIANCE_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_GUILDS_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_SUGGESTIONS_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_APPLY_ALLIANCE_IDS_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_INVITE_ALLIANCE_IDS_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_AREA_OPEN_TIME_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_LAST_GUILD_QUIT_TIME_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_LAST_USER_QUIT_TIME_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_SELF_BOX_DATA_F,
		var_0_10.S2C_GUILDALLIANCE_GETINFO_TRIAL_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPLYLIST_ME, {
	"C2S_GuildAlliance_ApplyList",
	".cs.C2S_GuildAlliance_ApplyList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPLYLIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ApplyList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPLYLIST_APPLY_GUILDS_F, {
	"apply_guilds",
	".cs.S2C_GuildAlliance_ApplyList.apply_guilds",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ALLIANCEAPPLY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPLYLIST_ME, {
	"S2C_GuildAlliance_ApplyList",
	".cs.S2C_GuildAlliance_ApplyList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_APPLYLIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_APPLYLIST_APPLY_GUILDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_INVITELIST_ME, {
	"C2S_GuildAlliance_InviteList",
	".cs.C2S_GuildAlliance_InviteList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_INVITELIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_InviteList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_INVITELIST_INVITE_GUILDS_F, {
	"invite_guilds",
	".cs.S2C_GuildAlliance_InviteList.invite_guilds",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ALLIANCEINVITE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_INVITELIST_ME, {
	"S2C_GuildAlliance_InviteList",
	".cs.S2C_GuildAlliance_InviteList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_INVITELIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_INVITELIST_INVITE_GUILDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_SEARCHLIST_NAME_F, {
	"name",
	".cs.C2S_GuildAlliance_SearchList.name",
	1,
	0,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_SEARCHLIST_ME, {
	"C2S_GuildAlliance_SearchList",
	".cs.C2S_GuildAlliance_SearchList",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_SEARCHLIST_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SEARCHLIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_SearchList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SEARCHLIST_ALLIANCES_F, {
	"alliances",
	".cs.S2C_GuildAlliance_SearchList.alliances",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ALLIANCESNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_SEARCHLIST_ME, {
	"S2C_GuildAlliance_SearchList",
	".cs.S2C_GuildAlliance_SearchList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_SEARCHLIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_SEARCHLIST_ALLIANCES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_CREATE_NAME_F, {
	"name",
	".cs.C2S_GuildAlliance_Create.name",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_CREATE_CONFIRM_F, {
	"confirm",
	".cs.C2S_GuildAlliance_Create.confirm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_CREATE_APPLY_LEVEL_F, {
	"apply_level",
	".cs.C2S_GuildAlliance_Create.apply_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_CREATE_FLAG_F, {
	"flag",
	".cs.C2S_GuildAlliance_Create.flag",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_CREATE_ME, {
	"C2S_GuildAlliance_Create",
	".cs.C2S_GuildAlliance_Create",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_CREATE_NAME_F,
		var_0_10.C2S_GUILDALLIANCE_CREATE_CONFIRM_F,
		var_0_10.C2S_GUILDALLIANCE_CREATE_APPLY_LEVEL_F,
		var_0_10.C2S_GUILDALLIANCE_CREATE_FLAG_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_CREATE_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Create.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_CREATE_ME, {
	"S2C_GuildAlliance_Create",
	".cs.S2C_GuildAlliance_Create",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_CREATE_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPLY_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.C2S_GuildAlliance_Apply.alliance_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPLY_ME, {
	"C2S_GuildAlliance_Apply",
	".cs.C2S_GuildAlliance_Apply",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_APPLY_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPLY_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Apply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPLY_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.S2C_GuildAlliance_Apply.alliance_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPLY_ME, {
	"S2C_GuildAlliance_Apply",
	".cs.S2C_GuildAlliance_Apply",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_APPLY_RET_F,
		var_0_10.S2C_GUILDALLIANCE_APPLY_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_CANCELAPPLY_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.C2S_GuildAlliance_CancelApply.alliance_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_CANCELAPPLY_ME, {
	"C2S_GuildAlliance_CancelApply",
	".cs.C2S_GuildAlliance_CancelApply",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_CANCELAPPLY_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_CANCELAPPLY_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_CancelApply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_CANCELAPPLY_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.S2C_GuildAlliance_CancelApply.alliance_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_CANCELAPPLY_ME, {
	"S2C_GuildAlliance_CancelApply",
	".cs.S2C_GuildAlliance_CancelApply",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_CANCELAPPLY_RET_F,
		var_0_10.S2C_GUILDALLIANCE_CANCELAPPLY_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPROVEAPPLY_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_GuildAlliance_ApproveApply.guild_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPROVEAPPLY_AGREE_F, {
	"agree",
	".cs.C2S_GuildAlliance_ApproveApply.agree",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPROVEAPPLY_ME, {
	"C2S_GuildAlliance_ApproveApply",
	".cs.C2S_GuildAlliance_ApproveApply",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_APPROVEAPPLY_GUILD_ID_F,
		var_0_10.C2S_GUILDALLIANCE_APPROVEAPPLY_AGREE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ApproveApply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_GuildAlliance_ApproveApply.guild_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_AGREE_F, {
	"agree",
	".cs.S2C_GuildAlliance_ApproveApply.agree",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_GUILDS_F, {
	"guilds",
	".cs.S2C_GuildAlliance_ApproveApply.guilds",
	4,
	3,
	3,
	false,
	{},
	var_0_3.ALLIANCEGUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_ME, {
	"S2C_GuildAlliance_ApproveApply",
	".cs.S2C_GuildAlliance_ApproveApply",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_RET_F,
		var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_GUILD_ID_F,
		var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_AGREE_F,
		var_0_10.S2C_GUILDALLIANCE_APPROVEAPPLY_GUILDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_INVITE_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_GuildAlliance_Invite.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_INVITE_ME, {
	"C2S_GuildAlliance_Invite",
	".cs.C2S_GuildAlliance_Invite",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_INVITE_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_INVITE_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Invite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_INVITE_INVITE_F, {
	"invite",
	".cs.S2C_GuildAlliance_Invite.invite",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ALLIANCEINVITE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_INVITE_ME, {
	"S2C_GuildAlliance_Invite",
	".cs.S2C_GuildAlliance_Invite",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_INVITE_RET_F,
		var_0_10.S2C_GUILDALLIANCE_INVITE_INVITE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_CANCELINVITE_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_GuildAlliance_CancelInvite.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_CANCELINVITE_ME, {
	"C2S_GuildAlliance_CancelInvite",
	".cs.C2S_GuildAlliance_CancelInvite",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_CANCELINVITE_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_CANCELINVITE_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_CancelInvite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_CANCELINVITE_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_GuildAlliance_CancelInvite.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_CANCELINVITE_ME, {
	"S2C_GuildAlliance_CancelInvite",
	".cs.S2C_GuildAlliance_CancelInvite",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_CANCELINVITE_RET_F,
		var_0_10.S2C_GUILDALLIANCE_CANCELINVITE_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPROVEINVITE_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.C2S_GuildAlliance_ApproveInvite.alliance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPROVEINVITE_AGREE_F, {
	"agree",
	".cs.C2S_GuildAlliance_ApproveInvite.agree",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPROVEINVITE_ME, {
	"C2S_GuildAlliance_ApproveInvite",
	".cs.C2S_GuildAlliance_ApproveInvite",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_APPROVEINVITE_ALLIANCE_ID_F,
		var_0_10.C2S_GUILDALLIANCE_APPROVEINVITE_AGREE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ApproveInvite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.S2C_GuildAlliance_ApproveInvite.alliance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_AGREE_F, {
	"agree",
	".cs.S2C_GuildAlliance_ApproveInvite.agree",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_ME, {
	"S2C_GuildAlliance_ApproveInvite",
	".cs.S2C_GuildAlliance_ApproveInvite",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_RET_F,
		var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_ALLIANCE_ID_F,
		var_0_10.S2C_GUILDALLIANCE_APPROVEINVITE_AGREE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_SUGGEST_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.C2S_GuildAlliance_Suggest.alliance_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_SUGGEST_ME, {
	"C2S_GuildAlliance_Suggest",
	".cs.C2S_GuildAlliance_Suggest",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_SUGGEST_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SUGGEST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Suggest.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SUGGEST_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.S2C_GuildAlliance_Suggest.alliance_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_SUGGEST_ME, {
	"S2C_GuildAlliance_Suggest",
	".cs.S2C_GuildAlliance_Suggest",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_SUGGEST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_SUGGEST_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_QUIT_ME, {
	"C2S_GuildAlliance_Quit",
	".cs.C2S_GuildAlliance_Quit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_QUIT_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Quit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_QUIT_ME, {
	"S2C_GuildAlliance_Quit",
	".cs.S2C_GuildAlliance_Quit",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_QUIT_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_KICK_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_GuildAlliance_Kick.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_KICK_ME, {
	"C2S_GuildAlliance_Kick",
	".cs.C2S_GuildAlliance_Kick",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_KICK_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_KICK_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Kick.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_KICK_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_GuildAlliance_Kick.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_KICK_ME, {
	"S2C_GuildAlliance_Kick",
	".cs.S2C_GuildAlliance_Kick",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_KICK_RET_F,
		var_0_10.S2C_GUILDALLIANCE_KICK_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_KICKNOTICE_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_GuildAlliance_KickNotice.guild_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_KICKNOTICE_ME, {
	"S2C_GuildAlliance_KickNotice",
	".cs.S2C_GuildAlliance_KickNotice",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_KICKNOTICE_GUILD_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_DISMISS_ME, {
	"C2S_GuildAlliance_Dismiss",
	".cs.C2S_GuildAlliance_Dismiss",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_DISMISS_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Dismiss.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_DISMISS_ME, {
	"S2C_GuildAlliance_Dismiss",
	".cs.S2C_GuildAlliance_Dismiss",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_DISMISS_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPOINT_GUILD_ID_F, {
	"guild_id",
	".cs.C2S_GuildAlliance_Appoint.guild_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPOINT_GRADE_F, {
	"grade",
	".cs.C2S_GuildAlliance_Appoint.grade",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_APPOINT_ME, {
	"C2S_GuildAlliance_Appoint",
	".cs.C2S_GuildAlliance_Appoint",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_APPOINT_GUILD_ID_F,
		var_0_10.C2S_GUILDALLIANCE_APPOINT_GRADE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPOINT_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Appoint.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPOINT_GUILD_ID_F, {
	"guild_id",
	".cs.S2C_GuildAlliance_Appoint.guild_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPOINT_GRADE_F, {
	"grade",
	".cs.S2C_GuildAlliance_Appoint.grade",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_APPOINT_ME, {
	"S2C_GuildAlliance_Appoint",
	".cs.S2C_GuildAlliance_Appoint",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_APPOINT_RET_F,
		var_0_10.S2C_GUILDALLIANCE_APPOINT_GUILD_ID_F,
		var_0_10.S2C_GUILDALLIANCE_APPOINT_GRADE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_IMPEACH_ME, {
	"C2S_GuildAlliance_Impeach",
	".cs.C2S_GuildAlliance_Impeach",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_IMPEACH_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_Impeach.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_IMPEACH_ME, {
	"S2C_GuildAlliance_Impeach",
	".cs.S2C_GuildAlliance_Impeach",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_IMPEACH_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_MODIFYCONTENT_TP_F, {
	"tp",
	".cs.C2S_GuildAlliance_ModifyContent.tp",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_MODIFYCONTENT_CONTENT_F, {
	"content",
	".cs.C2S_GuildAlliance_ModifyContent.content",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_MODIFYCONTENT_ME, {
	"C2S_GuildAlliance_ModifyContent",
	".cs.C2S_GuildAlliance_ModifyContent",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_MODIFYCONTENT_TP_F,
		var_0_10.C2S_GUILDALLIANCE_MODIFYCONTENT_CONTENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ModifyContent.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_TP_F, {
	"tp",
	".cs.S2C_GuildAlliance_ModifyContent.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_CONTENT_F, {
	"content",
	".cs.S2C_GuildAlliance_ModifyContent.content",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_ME, {
	"S2C_GuildAlliance_ModifyContent",
	".cs.S2C_GuildAlliance_ModifyContent",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_RET_F,
		var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_TP_F,
		var_0_10.S2C_GUILDALLIANCE_MODIFYCONTENT_CONTENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_MODIFYSETTING_CONFIRM_F, {
	"confirm",
	".cs.C2S_GuildAlliance_ModifySetting.confirm",
	1,
	0,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_MODIFYSETTING_APPLY_LEVEL_F, {
	"apply_level",
	".cs.C2S_GuildAlliance_ModifySetting.apply_level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_MODIFYSETTING_ME, {
	"C2S_GuildAlliance_ModifySetting",
	".cs.C2S_GuildAlliance_ModifySetting",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_MODIFYSETTING_CONFIRM_F,
		var_0_10.C2S_GUILDALLIANCE_MODIFYSETTING_APPLY_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ModifySetting.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_CONFIRM_F, {
	"confirm",
	".cs.S2C_GuildAlliance_ModifySetting.confirm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_APPLY_LEVEL_F, {
	"apply_level",
	".cs.S2C_GuildAlliance_ModifySetting.apply_level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_ME, {
	"S2C_GuildAlliance_ModifySetting",
	".cs.S2C_GuildAlliance_ModifySetting",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_RET_F,
		var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_CONFIRM_F,
		var_0_10.S2C_GUILDALLIANCE_MODIFYSETTING_APPLY_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_TASKLIST_ME, {
	"C2S_GuildAlliance_TaskList",
	".cs.C2S_GuildAlliance_TaskList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKLIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_TaskList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKLIST_TASKS_F, {
	"tasks",
	".cs.S2C_GuildAlliance_TaskList.tasks",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKLIST_ME, {
	"S2C_GuildAlliance_TaskList",
	".cs.S2C_GuildAlliance_TaskList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_TASKLIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_TASKLIST_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_TASKAWARD_ID_F, {
	"id",
	".cs.C2S_GuildAlliance_TaskAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_TASKAWARD_ME, {
	"C2S_GuildAlliance_TaskAward",
	".cs.C2S_GuildAlliance_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_TASKAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKAWARD_ID_F, {
	"id",
	".cs.S2C_GuildAlliance_TaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GuildAlliance_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_TASKAWARD_ME, {
	"S2C_GuildAlliance_TaskAward",
	".cs.S2C_GuildAlliance_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_TASKAWARD_RET_F,
		var_0_10.S2C_GUILDALLIANCE_TASKAWARD_ID_F,
		var_0_10.S2C_GUILDALLIANCE_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_DISMISSNOTICE_ME, {
	"S2C_GuildAlliance_DismissNotice",
	".cs.S2C_GuildAlliance_DismissNotice",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_GETSNAPSHOT_ALLIANCE_IDS_F, {
	"alliance_ids",
	".cs.C2S_GuildAlliance_GetSnapshot.alliance_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_GETSNAPSHOT_ME, {
	"C2S_GuildAlliance_GetSnapshot",
	".cs.C2S_GuildAlliance_GetSnapshot",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_GETSNAPSHOT_ALLIANCE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_GetSnapshot.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_ALLIANCE_IDS_F, {
	"alliance_ids",
	".cs.S2C_GuildAlliance_GetSnapshot.alliance_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_SNAPSHOTS_F, {
	"snapshots",
	".cs.S2C_GuildAlliance_GetSnapshot.snapshots",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ALLIANCESNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_ME, {
	"S2C_GuildAlliance_GetSnapshot",
	".cs.S2C_GuildAlliance_GetSnapshot",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_RET_F,
		var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_ALLIANCE_IDS_F,
		var_0_10.S2C_GUILDALLIANCE_GETSNAPSHOT_SNAPSHOTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_NOTICESTATE_STATE_F, {
	"state",
	".cs.S2C_GuildAlliance_NoticeState.state",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_NOTICESTATE_ME, {
	"S2C_GuildAlliance_NoticeState",
	".cs.S2C_GuildAlliance_NoticeState",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_NOTICESTATE_STATE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_GUILDLIST_NAME_F, {
	"name",
	".cs.C2S_GuildAlliance_GuildList.name",
	1,
	0,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_GUILDLIST_ME, {
	"C2S_GuildAlliance_GuildList",
	".cs.C2S_GuildAlliance_GuildList",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_GUILDLIST_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GUILDLIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_GuildList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GUILDLIST_GUILD_IDS_F, {
	"guild_ids",
	".cs.S2C_GuildAlliance_GuildList.guild_ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_GUILDLIST_ME, {
	"S2C_GuildAlliance_GuildList",
	".cs.S2C_GuildAlliance_GuildList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_GUILDLIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_GUILDLIST_GUILD_IDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_DISPLAYLIST_ME, {
	"C2S_GuildAlliance_DisplayList",
	".cs.C2S_GuildAlliance_DisplayList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_DISPLAYLIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_DisplayList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_DISPLAYLIST_USER_IDS_F, {
	"user_ids",
	".cs.S2C_GuildAlliance_DisplayList.user_ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_DISPLAYLIST_ME, {
	"S2C_GuildAlliance_DisplayList",
	".cs.S2C_GuildAlliance_DisplayList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_DISPLAYLIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_DISPLAYLIST_USER_IDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_GETLOG_ME, {
	"C2S_GuildAlliance_GetLog",
	".cs.C2S_GuildAlliance_GetLog",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETLOG_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_GetLog.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETLOG_LOGS_F, {
	"logs",
	".cs.S2C_GuildAlliance_GetLog.logs",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ALLIANCELOG_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_GETLOG_ME, {
	"S2C_GuildAlliance_GetLog",
	".cs.S2C_GuildAlliance_GetLog",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_GETLOG_RET_F,
		var_0_10.S2C_GUILDALLIANCE_GETLOG_LOGS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_SERVERINFOS_ME, {
	"C2S_GuildAlliance_ServerInfos",
	".cs.C2S_GuildAlliance_ServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_GuildAlliance_ServerInfos.server_infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SERVERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_GuildAlliance_ServerInfos.sid",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_AREA_F, {
	"area",
	".cs.S2C_GuildAlliance_ServerInfos.area",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_ME, {
	"S2C_GuildAlliance_ServerInfos",
	".cs.S2C_GuildAlliance_ServerInfos",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_RET_F,
		var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_SERVER_INFOS_F,
		var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_SID_F,
		var_0_10.S2C_GUILDALLIANCE_SERVERINFOS_AREA_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_USERLIST_ME, {
	"C2S_GuildAlliance_UserList",
	".cs.C2S_GuildAlliance_UserList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_USERLIST_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_UserList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_USERLIST_LIST_F, {
	"list",
	".cs.S2C_GuildAlliance_UserList.list",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_USERLIST_ME, {
	"S2C_GuildAlliance_UserList",
	".cs.S2C_GuildAlliance_UserList",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_USERLIST_RET_F,
		var_0_10.S2C_GUILDALLIANCE_USERLIST_LIST_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_BOXINFO_ME, {
	"C2S_GuildAlliance_BoxInfo",
	".cs.C2S_GuildAlliance_BoxInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXINFO_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_BoxInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXINFO_BOX_F, {
	"box",
	".cs.S2C_GuildAlliance_BoxInfo.box",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GUILDALLIANCEBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXINFO_ME, {
	"S2C_GuildAlliance_BoxInfo",
	".cs.S2C_GuildAlliance_BoxInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_BOXINFO_RET_F,
		var_0_10.S2C_GUILDALLIANCE_BOXINFO_BOX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_BOXGET_BOXES_F, {
	"boxes",
	".cs.C2S_GuildAlliance_BoxGet.boxes",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_BOXGET_ME, {
	"C2S_GuildAlliance_BoxGet",
	".cs.C2S_GuildAlliance_BoxGet",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_BOXGET_BOXES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXGET_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_BoxGet.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXGET_BOXES_F, {
	"boxes",
	".cs.S2C_GuildAlliance_BoxGet.boxes",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXGET_ME, {
	"S2C_GuildAlliance_BoxGet",
	".cs.S2C_GuildAlliance_BoxGet",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_BOXGET_RET_F,
		var_0_10.S2C_GUILDALLIANCE_BOXGET_BOXES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_BOXOPEN_BOX_INFO_ID_F, {
	"box_info_id",
	".cs.C2S_GuildAlliance_BoxOpen.box_info_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_BOXOPEN_NUM_F, {
	"num",
	".cs.C2S_GuildAlliance_BoxOpen.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_BOXOPEN_ME, {
	"C2S_GuildAlliance_BoxOpen",
	".cs.C2S_GuildAlliance_BoxOpen",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_BOXOPEN_BOX_INFO_ID_F,
		var_0_10.C2S_GUILDALLIANCE_BOXOPEN_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXOPEN_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_BoxOpen.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXOPEN_BOX_INFO_ID_F, {
	"box_info_id",
	".cs.S2C_GuildAlliance_BoxOpen.box_info_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXOPEN_NUM_F, {
	"num",
	".cs.S2C_GuildAlliance_BoxOpen.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXOPEN_CUR_SCORE_F, {
	"cur_score",
	".cs.S2C_GuildAlliance_BoxOpen.cur_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXOPEN_AWARDS_F, {
	"awards",
	".cs.S2C_GuildAlliance_BoxOpen.awards",
	5,
	4,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXOPEN_ME, {
	"S2C_GuildAlliance_BoxOpen",
	".cs.S2C_GuildAlliance_BoxOpen",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_BOXOPEN_RET_F,
		var_0_10.S2C_GUILDALLIANCE_BOXOPEN_BOX_INFO_ID_F,
		var_0_10.S2C_GUILDALLIANCE_BOXOPEN_NUM_F,
		var_0_10.S2C_GUILDALLIANCE_BOXOPEN_CUR_SCORE_F,
		var_0_10.S2C_GUILDALLIANCE_BOXOPEN_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXNOTIFY_BOX_INFO_ID_F, {
	"box_info_id",
	".cs.S2C_GuildAlliance_BoxNotify.box_info_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXNOTIFY_NUM_F, {
	"num",
	".cs.S2C_GuildAlliance_BoxNotify.num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXNOTIFY_ME, {
	"S2C_GuildAlliance_BoxNotify",
	".cs.S2C_GuildAlliance_BoxNotify",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_BOXNOTIFY_BOX_INFO_ID_F,
		var_0_10.S2C_GUILDALLIANCE_BOXNOTIFY_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXGRANDNOTIFY_BOX_F, {
	"box",
	".cs.S2C_GuildAlliance_BoxGrandNotify.box",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.GUILDALLIANCEBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_BOXGRANDNOTIFY_ME, {
	"S2C_GuildAlliance_BoxGrandNotify",
	".cs.S2C_GuildAlliance_BoxGrandNotify",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_BOXGRANDNOTIFY_BOX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_SENDBOX_BOX_INFO_ID_F, {
	"box_info_id",
	".cs.C2S_GuildAlliance_SendBox.box_info_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_SENDBOX_NUM_F, {
	"num",
	".cs.C2S_GuildAlliance_SendBox.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_SENDBOX_ME, {
	"C2S_GuildAlliance_SendBox",
	".cs.C2S_GuildAlliance_SendBox",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_SENDBOX_BOX_INFO_ID_F,
		var_0_10.C2S_GUILDALLIANCE_SENDBOX_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SENDBOX_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_SendBox.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_SENDBOX_BOX_F, {
	"box",
	".cs.S2C_GuildAlliance_SendBox.box",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDALLIANCEBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_SENDBOX_ME, {
	"S2C_GuildAlliance_SendBox",
	".cs.S2C_GuildAlliance_SendBox",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_SENDBOX_RET_F,
		var_0_10.S2C_GUILDALLIANCE_SENDBOX_BOX_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_EXCHANGEBOXAWARD_ME, {
	"C2S_GuildAlliance_ExchangeBoxAward",
	".cs.C2S_GuildAlliance_ExchangeBoxAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_ExchangeBoxAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_BOX_INFO_ID_F, {
	"box_info_id",
	".cs.S2C_GuildAlliance_ExchangeBoxAward.box_info_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_NEW_ID_F, {
	"new_id",
	".cs.S2C_GuildAlliance_ExchangeBoxAward.new_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_LEFT_SCORE_F, {
	"left_score",
	".cs.S2C_GuildAlliance_ExchangeBoxAward.left_score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_ME, {
	"S2C_GuildAlliance_ExchangeBoxAward",
	".cs.S2C_GuildAlliance_ExchangeBoxAward",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_RET_F,
		var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_BOX_INFO_ID_F,
		var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_NEW_ID_F,
		var_0_10.S2C_GUILDALLIANCE_EXCHANGEBOXAWARD_LEFT_SCORE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_HONOURGETINFO_ME, {
	"C2S_GuildAlliance_HonourGetInfo",
	".cs.C2S_GuildAlliance_HonourGetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURGETINFO_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_HonourGetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURGETINFO_GUILD_HONOURS_F, {
	"guild_honours",
	".cs.S2C_GuildAlliance_HonourGetInfo.guild_honours",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GUILDHONOUR_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURGETINFO_ME, {
	"S2C_GuildAlliance_HonourGetInfo",
	".cs.S2C_GuildAlliance_HonourGetInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_HONOURGETINFO_RET_F,
		var_0_10.S2C_GUILDALLIANCE_HONOURGETINFO_GUILD_HONOURS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_HONOURSENDLIKE_TARGET_UID_F, {
	"target_uid",
	".cs.C2S_GuildAlliance_HonourSendLike.target_uid",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDALLIANCE_HONOURSENDLIKE_TP_F, {
	"tp",
	".cs.C2S_GuildAlliance_HonourSendLike.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDALLIANCE_HONOURSENDLIKE_ME, {
	"C2S_GuildAlliance_HonourSendLike",
	".cs.C2S_GuildAlliance_HonourSendLike",
	{},
	{},
	{
		var_0_10.C2S_GUILDALLIANCE_HONOURSENDLIKE_TARGET_UID_F,
		var_0_10.C2S_GUILDALLIANCE_HONOURSENDLIKE_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_RET_F, {
	"ret",
	".cs.S2C_GuildAlliance_HonourSendLike.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_TP_F, {
	"tp",
	".cs.S2C_GuildAlliance_HonourSendLike.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_HONOUR_LIKE_F, {
	"honour_like",
	".cs.S2C_GuildAlliance_HonourSendLike.honour_like",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.HONOURINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_AWARDS_F, {
	"awards",
	".cs.S2C_GuildAlliance_HonourSendLike.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_ME, {
	"S2C_GuildAlliance_HonourSendLike",
	".cs.S2C_GuildAlliance_HonourSendLike",
	{},
	{},
	{
		var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_RET_F,
		var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_TP_F,
		var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_HONOUR_LIKE_F,
		var_0_10.S2C_GUILDALLIANCE_HONOURSENDLIKE_AWARDS_F
	},
	false,
	{}
})

return var_0_10
