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
	S2C_GROUPBATTLE_NOTICEACTIVITY_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTICEACTIVITY_ACTIVITY_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_ENTER_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_ENTER_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_RANK_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_HONOR_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_TITLE_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_MAP_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_USER_SHOW_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_ROOM_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_ENTER_TASKS_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_CREATEROOM_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_CREATEROOM_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_CREATEROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_CREATEROOM_ROOM_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_QUICKJOIN_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_QUICKJOIN_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_QUICKJOIN_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_QUICKJOIN_ROOM_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_INVITE_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_INVITE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_INVITE_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_INVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_INVITE_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_CONFIRMINVITE_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_CONFIRMINVITE_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_CONFIRMINVITE_IS_JOIN_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_CONFIRMINVITE_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_CONFIRMINVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_CONFIRMINVITE_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_CONFIRMINVITE_IS_JOIN_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_QUITROOM_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_QUITROOM_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_QUITROOM_RET_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_KICK_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_KICK_GUID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_KICK_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_KICK_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_KICK_GUID_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_READY_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_READY_IS_READY_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_READY_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_READY_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_READY_IS_READY_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_SETTING_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_SETTING_CATALOG_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_SETTING_IS_OPEN_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_SETTING_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_SETTING_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_SETTING_CATALOG_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_SETTING_IS_OPEN_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_LINEUP_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_LINEUP_LINEUP_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_LINEUP_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_LINEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_LINEUP_LINEUP_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_MATCH_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_MATCH_TP_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_MATCH_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_MATCH_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_MATCH_TP_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ROOM_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ADDITION_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYMATCH_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYMATCH_TP_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYMATCHFINISH_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYMATCHFINISH_IS_SUCCESS_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYMATCHFINISH_ROOM_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYBEKICK_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYINVITE_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYINVITE_INVITAION_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_INVITEROBOT_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_INVITEROBOT_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_INVITEROBOT_RET_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_INVITEELIST_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_INVITEELIST_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_INVITEELIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_INVITEELIST_FRIENDS_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_INVITEELIST_GUILD_MEMBERS_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_GETINVITATION_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_GETINVITATION_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_GETINVITATION_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_GETINVITATION_INVITATION_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_JOINROOM_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_JOINROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_JOINROOM_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_JOINROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_JOINROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_IS_SUCCESS_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_REPORT_F = protobuf.FieldDescriptor(),
	C2S_GROUPBATTLE_QUERYROOM_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_QUERYROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_QUERYROOM_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_QUERYROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_QUERYROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_QUERYROOM_ROOM_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_QUERYROOM_ADDITION_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYDISBANDROOM_ME = protobuf.Descriptor(),
	C2S_GROUPBATTLE_REFRESHBATTLEUSER_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_REFRESHBATTLEUSER_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_REFRESHBATTLEUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_GROUPBATTLE_NOTIFYMAPCHANGE_ME = protobuf.Descriptor(),
	S2C_GROUPBATTLE_NOTIFYMAPCHANGE_MAP_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTICEACTIVITY_ACTIVITY_F, {
	"activity",
	".cs.S2C_GroupBattle_NoticeActivity.activity",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTICEACTIVITY_ME, {
	"S2C_GroupBattle_NoticeActivity",
	".cs.S2C_GroupBattle_NoticeActivity",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTICEACTIVITY_ACTIVITY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_GroupBattle_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_TASKAWARD_ME, {
	"C2S_GroupBattle_TaskAward",
	".cs.C2S_GroupBattle_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_GroupBattle_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GroupBattle_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_TASKAWARD_ME, {
	"S2C_GroupBattle_TaskAward",
	".cs.S2C_GroupBattle_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_TASKAWARD_RET_F,
		var_0_10.S2C_GROUPBATTLE_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_GROUPBATTLE_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_ENTER_ME, {
	"C2S_GroupBattle_Enter",
	".cs.C2S_GroupBattle_Enter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_RANK_F, {
	"rank",
	".cs.S2C_GroupBattle_Enter.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_CHALLENGE_NUM_F, {
	"challenge_num",
	".cs.S2C_GroupBattle_Enter.challenge_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_HONOR_F, {
	"honor",
	".cs.S2C_GroupBattle_Enter.honor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_TITLE_F, {
	"title",
	".cs.S2C_GroupBattle_Enter.title",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_MAP_ID_F, {
	"map_id",
	".cs.S2C_GroupBattle_Enter.map_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_USER_SHOW_F, {
	"user_show",
	".cs.S2C_GroupBattle_Enter.user_show",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_ROOM_F, {
	"room",
	".cs.S2C_GroupBattle_Enter.room",
	8,
	7,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_TASKS_F, {
	"tasks",
	".cs.S2C_GroupBattle_Enter.tasks",
	9,
	8,
	3,
	false,
	{},
	var_0_3.GROUPBATTLETASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_ENTER_ME, {
	"S2C_GroupBattle_Enter",
	".cs.S2C_GroupBattle_Enter",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_ENTER_RET_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_RANK_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_CHALLENGE_NUM_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_HONOR_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_TITLE_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_MAP_ID_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_USER_SHOW_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_ROOM_F,
		var_0_10.S2C_GROUPBATTLE_ENTER_TASKS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_CREATEROOM_ME, {
	"C2S_GroupBattle_CreateRoom",
	".cs.C2S_GroupBattle_CreateRoom",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_CREATEROOM_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_CreateRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_CREATEROOM_ROOM_F, {
	"room",
	".cs.S2C_GroupBattle_CreateRoom.room",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_CREATEROOM_ME, {
	"S2C_GroupBattle_CreateRoom",
	".cs.S2C_GroupBattle_CreateRoom",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_CREATEROOM_RET_F,
		var_0_10.S2C_GROUPBATTLE_CREATEROOM_ROOM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_QUICKJOIN_ME, {
	"C2S_GroupBattle_QuickJoin",
	".cs.C2S_GroupBattle_QuickJoin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUICKJOIN_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_QuickJoin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUICKJOIN_ROOM_F, {
	"room",
	".cs.S2C_GroupBattle_QuickJoin.room",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_QUICKJOIN_ME, {
	"S2C_GroupBattle_QuickJoin",
	".cs.S2C_GroupBattle_QuickJoin",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_QUICKJOIN_RET_F,
		var_0_10.S2C_GROUPBATTLE_QUICKJOIN_ROOM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_INVITE_USER_ID_F, {
	"user_id",
	".cs.C2S_GroupBattle_Invite.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_INVITE_ME, {
	"C2S_GroupBattle_Invite",
	".cs.C2S_GroupBattle_Invite",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_INVITE_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITE_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_Invite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITE_USER_ID_F, {
	"user_id",
	".cs.S2C_GroupBattle_Invite.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITE_ME, {
	"S2C_GroupBattle_Invite",
	".cs.S2C_GroupBattle_Invite",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_INVITE_RET_F,
		var_0_10.S2C_GROUPBATTLE_INVITE_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_CONFIRMINVITE_ROOM_ID_F, {
	"room_id",
	".cs.C2S_GroupBattle_ConfirmInvite.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_CONFIRMINVITE_IS_JOIN_F, {
	"is_join",
	".cs.C2S_GroupBattle_ConfirmInvite.is_join",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_CONFIRMINVITE_ME, {
	"C2S_GroupBattle_ConfirmInvite",
	".cs.C2S_GroupBattle_ConfirmInvite",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_CONFIRMINVITE_ROOM_ID_F,
		var_0_10.C2S_GROUPBATTLE_CONFIRMINVITE_IS_JOIN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_ConfirmInvite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_ROOM_ID_F, {
	"room_id",
	".cs.S2C_GroupBattle_ConfirmInvite.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_IS_JOIN_F, {
	"is_join",
	".cs.S2C_GroupBattle_ConfirmInvite.is_join",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_ME, {
	"S2C_GroupBattle_ConfirmInvite",
	".cs.S2C_GroupBattle_ConfirmInvite",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_RET_F,
		var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_ROOM_ID_F,
		var_0_10.S2C_GROUPBATTLE_CONFIRMINVITE_IS_JOIN_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_QUITROOM_ME, {
	"C2S_GroupBattle_QuitRoom",
	".cs.C2S_GroupBattle_QuitRoom",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUITROOM_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_QuitRoom.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_QUITROOM_ME, {
	"S2C_GroupBattle_QuitRoom",
	".cs.S2C_GroupBattle_QuitRoom",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_QUITROOM_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_KICK_GUID_F, {
	"guid",
	".cs.C2S_GroupBattle_Kick.guid",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_KICK_ME, {
	"C2S_GroupBattle_Kick",
	".cs.C2S_GroupBattle_Kick",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_KICK_GUID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_KICK_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_Kick.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_KICK_GUID_F, {
	"guid",
	".cs.S2C_GroupBattle_Kick.guid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_KICK_ME, {
	"S2C_GroupBattle_Kick",
	".cs.S2C_GroupBattle_Kick",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_KICK_RET_F,
		var_0_10.S2C_GROUPBATTLE_KICK_GUID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_READY_IS_READY_F, {
	"is_ready",
	".cs.C2S_GroupBattle_Ready.is_ready",
	1,
	0,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_READY_ME, {
	"C2S_GroupBattle_Ready",
	".cs.C2S_GroupBattle_Ready",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_READY_IS_READY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_READY_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_Ready.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_READY_IS_READY_F, {
	"is_ready",
	".cs.S2C_GroupBattle_Ready.is_ready",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_READY_ME, {
	"S2C_GroupBattle_Ready",
	".cs.S2C_GroupBattle_Ready",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_READY_RET_F,
		var_0_10.S2C_GROUPBATTLE_READY_IS_READY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_SETTING_CATALOG_F, {
	"catalog",
	".cs.C2S_GroupBattle_Setting.catalog",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_SETTING_IS_OPEN_F, {
	"is_open",
	".cs.C2S_GroupBattle_Setting.is_open",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_SETTING_ME, {
	"C2S_GroupBattle_Setting",
	".cs.C2S_GroupBattle_Setting",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_SETTING_CATALOG_F,
		var_0_10.C2S_GROUPBATTLE_SETTING_IS_OPEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_SETTING_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_Setting.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_SETTING_CATALOG_F, {
	"catalog",
	".cs.S2C_GroupBattle_Setting.catalog",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_SETTING_IS_OPEN_F, {
	"is_open",
	".cs.S2C_GroupBattle_Setting.is_open",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_SETTING_ME, {
	"S2C_GroupBattle_Setting",
	".cs.S2C_GroupBattle_Setting",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_SETTING_RET_F,
		var_0_10.S2C_GROUPBATTLE_SETTING_CATALOG_F,
		var_0_10.S2C_GROUPBATTLE_SETTING_IS_OPEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_LINEUP_LINEUP_F, {
	"lineup",
	".cs.C2S_GroupBattle_LineUp.lineup",
	1,
	0,
	3,
	false,
	{},
	var_0_3.GROUPBATTLEROOMLINEUP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_LINEUP_ME, {
	"C2S_GroupBattle_LineUp",
	".cs.C2S_GroupBattle_LineUp",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_LINEUP_LINEUP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_LINEUP_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_LineUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_LINEUP_LINEUP_F, {
	"lineup",
	".cs.S2C_GroupBattle_LineUp.lineup",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GROUPBATTLEROOMLINEUP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_LINEUP_ME, {
	"S2C_GroupBattle_LineUp",
	".cs.S2C_GroupBattle_LineUp",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_LINEUP_RET_F,
		var_0_10.S2C_GROUPBATTLE_LINEUP_LINEUP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_MATCH_TP_F, {
	"tp",
	".cs.C2S_GroupBattle_Match.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_MATCH_ME, {
	"C2S_GroupBattle_Match",
	".cs.C2S_GroupBattle_Match",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_MATCH_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_MATCH_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_Match.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_MATCH_TP_F, {
	"tp",
	".cs.S2C_GroupBattle_Match.tp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_MATCH_ME, {
	"S2C_GroupBattle_Match",
	".cs.S2C_GroupBattle_Match",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_MATCH_RET_F,
		var_0_10.S2C_GROUPBATTLE_MATCH_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ROOM_F, {
	"room",
	".cs.S2C_GroupBattle_NotifyRoomChange.room",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.GROUPBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ADDITION_F, {
	"addition",
	".cs.S2C_GroupBattle_NotifyRoomChange.addition",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ME, {
	"S2C_GroupBattle_NotifyRoomChange",
	".cs.S2C_GroupBattle_NotifyRoomChange",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ROOM_F,
		var_0_10.S2C_GROUPBATTLE_NOTIFYROOMCHANGE_ADDITION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMATCH_TP_F, {
	"tp",
	".cs.S2C_GroupBattle_NotifyMatch.tp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMATCH_ME, {
	"S2C_GroupBattle_NotifyMatch",
	".cs.S2C_GroupBattle_NotifyMatch",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTIFYMATCH_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMATCHFINISH_IS_SUCCESS_F, {
	"is_success",
	".cs.S2C_GroupBattle_NotifyMatchFinish.is_success",
	1,
	0,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMATCHFINISH_ROOM_F, {
	"room",
	".cs.S2C_GroupBattle_NotifyMatchFinish.room",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMATCHFINISH_ME, {
	"S2C_GroupBattle_NotifyMatchFinish",
	".cs.S2C_GroupBattle_NotifyMatchFinish",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTIFYMATCHFINISH_IS_SUCCESS_F,
		var_0_10.S2C_GROUPBATTLE_NOTIFYMATCHFINISH_ROOM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYBEKICK_ME, {
	"S2C_GroupBattle_NotifyBeKick",
	".cs.S2C_GroupBattle_NotifyBeKick",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYINVITE_INVITAION_F, {
	"invitaion",
	".cs.S2C_GroupBattle_NotifyInvite.invitaion",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.GROUPBATTLEINVITATION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYINVITE_ME, {
	"S2C_GroupBattle_NotifyInvite",
	".cs.S2C_GroupBattle_NotifyInvite",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTIFYINVITE_INVITAION_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_INVITEROBOT_ME, {
	"C2S_GroupBattle_InviteRobot",
	".cs.C2S_GroupBattle_InviteRobot",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITEROBOT_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_InviteRobot.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITEROBOT_ME, {
	"S2C_GroupBattle_InviteRobot",
	".cs.S2C_GroupBattle_InviteRobot",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_INVITEROBOT_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_INVITEELIST_ME, {
	"C2S_GroupBattle_InviteeList",
	".cs.C2S_GroupBattle_InviteeList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITEELIST_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_InviteeList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITEELIST_FRIENDS_F, {
	"friends",
	".cs.S2C_GroupBattle_InviteeList.friends",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITEELIST_GUILD_MEMBERS_F, {
	"guild_members",
	".cs.S2C_GroupBattle_InviteeList.guild_members",
	3,
	2,
	3,
	false,
	{},
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_INVITEELIST_ME, {
	"S2C_GroupBattle_InviteeList",
	".cs.S2C_GroupBattle_InviteeList",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_INVITEELIST_RET_F,
		var_0_10.S2C_GROUPBATTLE_INVITEELIST_FRIENDS_F,
		var_0_10.S2C_GROUPBATTLE_INVITEELIST_GUILD_MEMBERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_GETINVITATION_ME, {
	"C2S_GroupBattle_GetInvitation",
	".cs.C2S_GroupBattle_GetInvitation",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_GETINVITATION_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_GetInvitation.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_GETINVITATION_INVITATION_F, {
	"invitation",
	".cs.S2C_GroupBattle_GetInvitation.invitation",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GROUPBATTLEINVITATION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_GETINVITATION_ME, {
	"S2C_GroupBattle_GetInvitation",
	".cs.S2C_GroupBattle_GetInvitation",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_GETINVITATION_RET_F,
		var_0_10.S2C_GROUPBATTLE_GETINVITATION_INVITATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_JOINROOM_ROOM_ID_F, {
	"room_id",
	".cs.C2S_GroupBattle_JoinRoom.room_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_JOINROOM_ME, {
	"C2S_GroupBattle_JoinRoom",
	".cs.C2S_GroupBattle_JoinRoom",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_JOINROOM_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_JOINROOM_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_JoinRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_JOINROOM_ROOM_ID_F, {
	"room_id",
	".cs.S2C_GroupBattle_JoinRoom.room_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_JOINROOM_ME, {
	"S2C_GroupBattle_JoinRoom",
	".cs.S2C_GroupBattle_JoinRoom",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_JOINROOM_RET_F,
		var_0_10.S2C_GROUPBATTLE_JOINROOM_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_IS_SUCCESS_F, {
	"is_success",
	".cs.S2C_GroupBattle_NotifyFightReport.is_success",
	1,
	0,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_REPORT_F, {
	"report",
	".cs.S2C_GroupBattle_NotifyFightReport.report",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEFIGHTREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_ME, {
	"S2C_GroupBattle_NotifyFightReport",
	".cs.S2C_GroupBattle_NotifyFightReport",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_IS_SUCCESS_F,
		var_0_10.S2C_GROUPBATTLE_NOTIFYFIGHTREPORT_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GROUPBATTLE_QUERYROOM_ROOM_ID_F, {
	"room_id",
	".cs.C2S_GroupBattle_QueryRoom.room_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_QUERYROOM_ME, {
	"C2S_GroupBattle_QueryRoom",
	".cs.C2S_GroupBattle_QueryRoom",
	{},
	{},
	{
		var_0_10.C2S_GROUPBATTLE_QUERYROOM_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUERYROOM_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_QueryRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUERYROOM_ROOM_ID_F, {
	"room_id",
	".cs.S2C_GroupBattle_QueryRoom.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUERYROOM_ROOM_F, {
	"room",
	".cs.S2C_GroupBattle_QueryRoom.room",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.GROUPBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_QUERYROOM_ADDITION_F, {
	"addition",
	".cs.S2C_GroupBattle_QueryRoom.addition",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_QUERYROOM_ME, {
	"S2C_GroupBattle_QueryRoom",
	".cs.S2C_GroupBattle_QueryRoom",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_QUERYROOM_RET_F,
		var_0_10.S2C_GROUPBATTLE_QUERYROOM_ROOM_ID_F,
		var_0_10.S2C_GROUPBATTLE_QUERYROOM_ROOM_F,
		var_0_10.S2C_GROUPBATTLE_QUERYROOM_ADDITION_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYDISBANDROOM_ME, {
	"S2C_GroupBattle_NotifyDisbandRoom",
	".cs.S2C_GroupBattle_NotifyDisbandRoom",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GROUPBATTLE_REFRESHBATTLEUSER_ME, {
	"C2S_GroupBattle_RefreshBattleUser",
	".cs.C2S_GroupBattle_RefreshBattleUser",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_REFRESHBATTLEUSER_RET_F, {
	"ret",
	".cs.S2C_GroupBattle_RefreshBattleUser.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_REFRESHBATTLEUSER_ME, {
	"S2C_GroupBattle_RefreshBattleUser",
	".cs.S2C_GroupBattle_RefreshBattleUser",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_REFRESHBATTLEUSER_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMAPCHANGE_MAP_ID_F, {
	"map_id",
	".cs.S2C_GroupBattle_NotifyMapChange.map_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GROUPBATTLE_NOTIFYMAPCHANGE_ME, {
	"S2C_GroupBattle_NotifyMapChange",
	".cs.S2C_GroupBattle_NotifyMapChange",
	{},
	{},
	{
		var_0_10.S2C_GROUPBATTLE_NOTIFYMAPCHANGE_MAP_ID_F
	},
	false,
	{}
})

return var_0_10
