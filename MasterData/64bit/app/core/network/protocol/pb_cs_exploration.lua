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
	C2S_EXPLORATION_INFO_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_INFO_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_EXPLORATION_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_GUILD_BUFFS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_BOSS_BATTLE_TEAM_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_BOSS_DAILY_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_EVENTS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_ROOMS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_GAME_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_TASK_PROGRESS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_INFO_REWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_GETSERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_GETSERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_GETSERVERINFOS_SID_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_CHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_BOSS_DAILY_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEBOSSFINISH_HISTORY_MAX_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTNOTIFY_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_EVENTNOTIFY_EVENTS_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_EVENTPROCESS_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_EVENTPROCESS_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_EVENTPROCESS_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_EVENTPROCESS_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_EVENT_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_EVENTPROCESS_DELETE_EVENT_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_MOVE_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_MOVE_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_MOVE_X_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_MOVE_Y_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_MOVE_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_MOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_MOVE_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_MOVE_X_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_MOVE_Y_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_UNLOCKCELL_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_UNLOCKCELL_X_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_UNLOCKCELL_Y_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_UNLOCKCELL_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_UNLOCKCELL_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_UNLOCKCELL_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_UNLOCKCELL_X_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_UNLOCKCELL_Y_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_UNLOCKCELL_EVENT_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_UNLOCKCELL_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_UNLOCKCELL_USED_ACTION_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_GUILD_BUFF_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_RESULT_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEMONSTERFINISH_IS_SKIP_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_CHALLENGEGUARDBEGIN_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_CHALLENGEGUARDBEGIN_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_CHALLENGEGUARDBEGIN_GUARD_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDBEGIN_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDBEGIN_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDBEGIN_GUARD_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_GUILD_BUFF_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_RESULT_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_CHALLENGEGUARDFINISH_IS_SKIP_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_SHOPREFRESH_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_SHOPREFRESH_SHOP_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SHOPREFRESH_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_SHOPREFRESH_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SHOPREFRESH_SHOP_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SHOPREFRESH_EVENT_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_SELL_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_SELL_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_SELL_TP_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SELL_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_SELL_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SELL_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SELL_TP_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_SELL_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_GETGUILDBUFFDETAIL_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_GETGUILDBUFFDETAIL_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_GETGUILDBUFFDETAIL_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_GETGUILDBUFFDETAIL_GUILD_BUFFS_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_GETGUILDBUFFDETAIL_SNAPSHOTS_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_GETBOSSBATTLETEAM_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_GETBOSSBATTLETEAM_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_GETBOSSBATTLETEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_GETBOSSBATTLETEAM_BOSS_BATTLE_TEAM_F = protobuf.FieldDescriptor(),
	C2S_EXPLORATION_FINISHTASK_ME = protobuf.Descriptor(),
	C2S_EXPLORATION_FINISHTASK_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_FINISHTASK_ME = protobuf.Descriptor(),
	S2C_EXPLORATION_FINISHTASK_RET_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_FINISHTASK_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_EXPLORATION_FINISHTASK_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_INFO_ME, {
	"C2S_Exploration_Info",
	".cs.C2S_Exploration_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_RET_F, {
	"ret",
	".cs.S2C_Exploration_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_Exploration_Info.activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_EXPLORATION_F, {
	"exploration",
	".cs.S2C_Exploration_Info.exploration",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.USEREXPLORATION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_GUILD_BUFFS_F, {
	"guild_buffs",
	".cs.S2C_Exploration_Info.guild_buffs",
	4,
	3,
	3,
	false,
	{},
	var_0_3.EXPLORATIONGUILDBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_BOSS_BATTLE_TEAM_F, {
	"boss_battle_team",
	".cs.S2C_Exploration_Info.boss_battle_team",
	5,
	4,
	1,
	false,
	nil,
	var_0_4.BATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_BOSS_DAILY_CHALLENGE_COUNT_F, {
	"boss_daily_challenge_count",
	".cs.S2C_Exploration_Info.boss_daily_challenge_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_EVENTS_F, {
	"events",
	".cs.S2C_Exploration_Info.events",
	7,
	6,
	3,
	false,
	{},
	var_0_3.EXPLORATIONEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_ROOMS_F, {
	"rooms",
	".cs.S2C_Exploration_Info.rooms",
	8,
	7,
	3,
	false,
	{},
	var_0_3.EXPLORATIONROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_GAME_F, {
	"game",
	".cs.S2C_Exploration_Info.game",
	9,
	8,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONGAME_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_TASK_PROGRESS_F, {
	"task_progress",
	".cs.S2C_Exploration_Info.task_progress",
	10,
	9,
	3,
	false,
	{},
	var_0_3.STATUS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_INFO_REWARD_TASK_IDS_F, {
	"reward_task_ids",
	".cs.S2C_Exploration_Info.reward_task_ids",
	11,
	10,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_INFO_ME, {
	"S2C_Exploration_Info",
	".cs.S2C_Exploration_Info",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_INFO_RET_F,
		var_0_10.S2C_EXPLORATION_INFO_ACTIVITY_F,
		var_0_10.S2C_EXPLORATION_INFO_EXPLORATION_F,
		var_0_10.S2C_EXPLORATION_INFO_GUILD_BUFFS_F,
		var_0_10.S2C_EXPLORATION_INFO_BOSS_BATTLE_TEAM_F,
		var_0_10.S2C_EXPLORATION_INFO_BOSS_DAILY_CHALLENGE_COUNT_F,
		var_0_10.S2C_EXPLORATION_INFO_EVENTS_F,
		var_0_10.S2C_EXPLORATION_INFO_ROOMS_F,
		var_0_10.S2C_EXPLORATION_INFO_GAME_F,
		var_0_10.S2C_EXPLORATION_INFO_TASK_PROGRESS_F,
		var_0_10.S2C_EXPLORATION_INFO_REWARD_TASK_IDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_GETSERVERINFOS_ME, {
	"C2S_Exploration_GetServerInfos",
	".cs.C2S_Exploration_GetServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETSERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_Exploration_GetServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETSERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_Exploration_GetServerInfos.server_infos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETSERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_Exploration_GetServerInfos.sid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_GETSERVERINFOS_ME, {
	"S2C_Exploration_GetServerInfos",
	".cs.S2C_Exploration_GetServerInfos",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_GETSERVERINFOS_RET_F,
		var_0_10.S2C_EXPLORATION_GETSERVERINFOS_SERVER_INFOS_F,
		var_0_10.S2C_EXPLORATION_GETSERVERINFOS_SID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_CHALLENGEBOSSBEGIN_ME, {
	"C2S_Exploration_ChallengeBossBegin",
	".cs.C2S_Exploration_ChallengeBossBegin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSBEGIN_RET_F, {
	"ret",
	".cs.S2C_Exploration_ChallengeBossBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Exploration_ChallengeBossBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSBEGIN_ME, {
	"S2C_Exploration_ChallengeBossBegin",
	".cs.S2C_Exploration_ChallengeBossBegin",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSBEGIN_RET_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_RET_F, {
	"ret",
	".cs.S2C_Exploration_ChallengeBossFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Exploration_ChallengeBossFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Exploration_ChallengeBossFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_BOSS_DAILY_CHALLENGE_COUNT_F, {
	"boss_daily_challenge_count",
	".cs.S2C_Exploration_ChallengeBossFinish.boss_daily_challenge_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_DAMAGE_F, {
	"damage",
	".cs.S2C_Exploration_ChallengeBossFinish.damage",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_HISTORY_MAX_DAMAGE_F, {
	"history_max_damage",
	".cs.S2C_Exploration_ChallengeBossFinish.history_max_damage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_ME, {
	"S2C_Exploration_ChallengeBossFinish",
	".cs.S2C_Exploration_ChallengeBossFinish",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_RET_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_IS_WIN_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_AWARDS_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_BOSS_DAILY_CHALLENGE_COUNT_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_DAMAGE_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEBOSSFINISH_HISTORY_MAX_DAMAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTNOTIFY_EVENTS_F, {
	"events",
	".cs.S2C_Exploration_EventNotify.events",
	1,
	0,
	3,
	false,
	{},
	var_0_3.EXPLORATIONEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_EVENTNOTIFY_ME, {
	"S2C_Exploration_EventNotify",
	".cs.S2C_Exploration_EventNotify",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_EVENTNOTIFY_EVENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_EVENTPROCESS_UNIQUE_ID_F, {
	"unique_id",
	".cs.C2S_Exploration_EventProcess.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_EVENTPROCESS_PARAMS_F, {
	"params",
	".cs.C2S_Exploration_EventProcess.params",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_EVENTPROCESS_ME, {
	"C2S_Exploration_EventProcess",
	".cs.C2S_Exploration_EventProcess",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_EVENTPROCESS_UNIQUE_ID_F,
		var_0_10.C2S_EXPLORATION_EVENTPROCESS_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_RET_F, {
	"ret",
	".cs.S2C_Exploration_EventProcess.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_UNIQUE_ID_F, {
	"unique_id",
	".cs.S2C_Exploration_EventProcess.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_EVENT_F, {
	"event",
	".cs.S2C_Exploration_EventProcess.event",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_AWARDS_F, {
	"awards",
	".cs.S2C_Exploration_EventProcess.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_PARAMS_F, {
	"params",
	".cs.S2C_Exploration_EventProcess.params",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Exploration_EventProcess.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_DELETE_EVENT_F, {
	"delete_event",
	".cs.S2C_Exploration_EventProcess.delete_event",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_EVENTPROCESS_ME, {
	"S2C_Exploration_EventProcess",
	".cs.S2C_Exploration_EventProcess",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_RET_F,
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_UNIQUE_ID_F,
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_EVENT_F,
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_AWARDS_F,
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_PARAMS_F,
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_BATTLE_ID_F,
		var_0_10.S2C_EXPLORATION_EVENTPROCESS_DELETE_EVENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_MOVE_ROOM_ID_F, {
	"room_id",
	".cs.C2S_Exploration_Move.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_MOVE_X_F, {
	"x",
	".cs.C2S_Exploration_Move.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_MOVE_Y_F, {
	"y",
	".cs.C2S_Exploration_Move.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_MOVE_ME, {
	"C2S_Exploration_Move",
	".cs.C2S_Exploration_Move",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_MOVE_ROOM_ID_F,
		var_0_10.C2S_EXPLORATION_MOVE_X_F,
		var_0_10.C2S_EXPLORATION_MOVE_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_MOVE_RET_F, {
	"ret",
	".cs.S2C_Exploration_Move.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_MOVE_ROOM_ID_F, {
	"room_id",
	".cs.S2C_Exploration_Move.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_MOVE_X_F, {
	"x",
	".cs.S2C_Exploration_Move.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_MOVE_Y_F, {
	"y",
	".cs.S2C_Exploration_Move.y",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_MOVE_ME, {
	"S2C_Exploration_Move",
	".cs.S2C_Exploration_Move",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_MOVE_RET_F,
		var_0_10.S2C_EXPLORATION_MOVE_ROOM_ID_F,
		var_0_10.S2C_EXPLORATION_MOVE_X_F,
		var_0_10.S2C_EXPLORATION_MOVE_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_UNLOCKCELL_X_F, {
	"x",
	".cs.C2S_Exploration_UnlockCell.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_UNLOCKCELL_Y_F, {
	"y",
	".cs.C2S_Exploration_UnlockCell.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_UNLOCKCELL_ROOM_ID_F, {
	"room_id",
	".cs.C2S_Exploration_UnlockCell.room_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_UNLOCKCELL_ME, {
	"C2S_Exploration_UnlockCell",
	".cs.C2S_Exploration_UnlockCell",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_UNLOCKCELL_X_F,
		var_0_10.C2S_EXPLORATION_UNLOCKCELL_Y_F,
		var_0_10.C2S_EXPLORATION_UNLOCKCELL_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_RET_F, {
	"ret",
	".cs.S2C_Exploration_UnlockCell.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_X_F, {
	"x",
	".cs.S2C_Exploration_UnlockCell.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_Y_F, {
	"y",
	".cs.S2C_Exploration_UnlockCell.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_EVENT_F, {
	"event",
	".cs.S2C_Exploration_UnlockCell.event",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_ROOM_ID_F, {
	"room_id",
	".cs.S2C_Exploration_UnlockCell.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_USED_ACTION_F, {
	"used_action",
	".cs.S2C_Exploration_UnlockCell.used_action",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_UNLOCKCELL_ME, {
	"S2C_Exploration_UnlockCell",
	".cs.S2C_Exploration_UnlockCell",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_UNLOCKCELL_RET_F,
		var_0_10.S2C_EXPLORATION_UNLOCKCELL_X_F,
		var_0_10.S2C_EXPLORATION_UNLOCKCELL_Y_F,
		var_0_10.S2C_EXPLORATION_UNLOCKCELL_EVENT_F,
		var_0_10.S2C_EXPLORATION_UNLOCKCELL_ROOM_ID_F,
		var_0_10.S2C_EXPLORATION_UNLOCKCELL_USED_ACTION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_RET_F, {
	"ret",
	".cs.S2C_Exploration_ChallengeMonsterFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Exploration_ChallengeMonsterFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Exploration_ChallengeMonsterFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Exploration_ChallengeMonsterFinish.knight_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_GUILD_BUFF_F, {
	"guild_buff",
	".cs.S2C_Exploration_ChallengeMonsterFinish.guild_buff",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONGUILDBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_RESULT_F, {
	"result",
	".cs.S2C_Exploration_ChallengeMonsterFinish.result",
	6,
	5,
	1,
	false,
	nil,
	var_0_4.BATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_IS_SKIP_F, {
	"is_skip",
	".cs.S2C_Exploration_ChallengeMonsterFinish.is_skip",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_ME, {
	"S2C_Exploration_ChallengeMonsterFinish",
	".cs.S2C_Exploration_ChallengeMonsterFinish",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_RET_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_IS_WIN_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_AWARDS_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_KNIGHT_ID_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_GUILD_BUFF_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_RESULT_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEMONSTERFINISH_IS_SKIP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_CHALLENGEGUARDBEGIN_ROOM_ID_F, {
	"room_id",
	".cs.C2S_Exploration_ChallengeGuardBegin.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_CHALLENGEGUARDBEGIN_GUARD_F, {
	"guard",
	".cs.C2S_Exploration_ChallengeGuardBegin.guard",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_CHALLENGEGUARDBEGIN_ME, {
	"C2S_Exploration_ChallengeGuardBegin",
	".cs.C2S_Exploration_ChallengeGuardBegin",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_CHALLENGEGUARDBEGIN_ROOM_ID_F,
		var_0_10.C2S_EXPLORATION_CHALLENGEGUARDBEGIN_GUARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_RET_F, {
	"ret",
	".cs.S2C_Exploration_ChallengeGuardBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_ROOM_ID_F, {
	"room_id",
	".cs.S2C_Exploration_ChallengeGuardBegin.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_GUARD_F, {
	"guard",
	".cs.S2C_Exploration_ChallengeGuardBegin.guard",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Exploration_ChallengeGuardBegin.battle_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_ME, {
	"S2C_Exploration_ChallengeGuardBegin",
	".cs.S2C_Exploration_ChallengeGuardBegin",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_RET_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_ROOM_ID_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_GUARD_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_RET_F, {
	"ret",
	".cs.S2C_Exploration_ChallengeGuardFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Exploration_ChallengeGuardFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Exploration_ChallengeGuardFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Exploration_ChallengeGuardFinish.knight_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_GUILD_BUFF_F, {
	"guild_buff",
	".cs.S2C_Exploration_ChallengeGuardFinish.guild_buff",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONGUILDBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_RESULT_F, {
	"result",
	".cs.S2C_Exploration_ChallengeGuardFinish.result",
	6,
	5,
	1,
	false,
	nil,
	var_0_4.BATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_IS_SKIP_F, {
	"is_skip",
	".cs.S2C_Exploration_ChallengeGuardFinish.is_skip",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_ME, {
	"S2C_Exploration_ChallengeGuardFinish",
	".cs.S2C_Exploration_ChallengeGuardFinish",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_RET_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_IS_WIN_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_AWARDS_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_KNIGHT_ID_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_GUILD_BUFF_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_RESULT_F,
		var_0_10.S2C_EXPLORATION_CHALLENGEGUARDFINISH_IS_SKIP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_SHOPREFRESH_SHOP_ID_F, {
	"shop_id",
	".cs.C2S_Exploration_ShopRefresh.shop_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_SHOPREFRESH_ME, {
	"C2S_Exploration_ShopRefresh",
	".cs.C2S_Exploration_ShopRefresh",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_SHOPREFRESH_SHOP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SHOPREFRESH_RET_F, {
	"ret",
	".cs.S2C_Exploration_ShopRefresh.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SHOPREFRESH_SHOP_ID_F, {
	"shop_id",
	".cs.S2C_Exploration_ShopRefresh.shop_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SHOPREFRESH_EVENT_F, {
	"event",
	".cs.S2C_Exploration_ShopRefresh.event",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.EXPLORATIONEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_SHOPREFRESH_ME, {
	"S2C_Exploration_ShopRefresh",
	".cs.S2C_Exploration_ShopRefresh",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_SHOPREFRESH_RET_F,
		var_0_10.S2C_EXPLORATION_SHOPREFRESH_SHOP_ID_F,
		var_0_10.S2C_EXPLORATION_SHOPREFRESH_EVENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_SELL_UNIQUE_ID_F, {
	"unique_id",
	".cs.C2S_Exploration_Sell.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_SELL_TP_F, {
	"tp",
	".cs.C2S_Exploration_Sell.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_SELL_ME, {
	"C2S_Exploration_Sell",
	".cs.C2S_Exploration_Sell",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_SELL_UNIQUE_ID_F,
		var_0_10.C2S_EXPLORATION_SELL_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SELL_RET_F, {
	"ret",
	".cs.S2C_Exploration_Sell.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SELL_UNIQUE_ID_F, {
	"unique_id",
	".cs.S2C_Exploration_Sell.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SELL_TP_F, {
	"tp",
	".cs.S2C_Exploration_Sell.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_SELL_AWARDS_F, {
	"awards",
	".cs.S2C_Exploration_Sell.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_SELL_ME, {
	"S2C_Exploration_Sell",
	".cs.S2C_Exploration_Sell",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_SELL_RET_F,
		var_0_10.S2C_EXPLORATION_SELL_UNIQUE_ID_F,
		var_0_10.S2C_EXPLORATION_SELL_TP_F,
		var_0_10.S2C_EXPLORATION_SELL_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_GETGUILDBUFFDETAIL_ME, {
	"C2S_Exploration_GetGuildBuffDetail",
	".cs.C2S_Exploration_GetGuildBuffDetail",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_RET_F, {
	"ret",
	".cs.S2C_Exploration_GetGuildBuffDetail.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_GUILD_BUFFS_F, {
	"guild_buffs",
	".cs.S2C_Exploration_GetGuildBuffDetail.guild_buffs",
	2,
	1,
	3,
	false,
	{},
	var_0_3.EXPLORATIONGUILDBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_SNAPSHOTS_F, {
	"snapshots",
	".cs.S2C_Exploration_GetGuildBuffDetail.snapshots",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_ME, {
	"S2C_Exploration_GetGuildBuffDetail",
	".cs.S2C_Exploration_GetGuildBuffDetail",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_RET_F,
		var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_GUILD_BUFFS_F,
		var_0_10.S2C_EXPLORATION_GETGUILDBUFFDETAIL_SNAPSHOTS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_GETBOSSBATTLETEAM_ME, {
	"C2S_Exploration_GetBossBattleTeam",
	".cs.C2S_Exploration_GetBossBattleTeam",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETBOSSBATTLETEAM_RET_F, {
	"ret",
	".cs.S2C_Exploration_GetBossBattleTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_GETBOSSBATTLETEAM_BOSS_BATTLE_TEAM_F, {
	"boss_battle_team",
	".cs.S2C_Exploration_GetBossBattleTeam.boss_battle_team",
	2,
	1,
	1,
	false,
	nil,
	var_0_4.BATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_GETBOSSBATTLETEAM_ME, {
	"S2C_Exploration_GetBossBattleTeam",
	".cs.S2C_Exploration_GetBossBattleTeam",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_GETBOSSBATTLETEAM_RET_F,
		var_0_10.S2C_EXPLORATION_GETBOSSBATTLETEAM_BOSS_BATTLE_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EXPLORATION_FINISHTASK_TASK_ID_F, {
	"task_id",
	".cs.C2S_Exploration_FinishTask.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EXPLORATION_FINISHTASK_ME, {
	"C2S_Exploration_FinishTask",
	".cs.C2S_Exploration_FinishTask",
	{},
	{},
	{
		var_0_10.C2S_EXPLORATION_FINISHTASK_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_FINISHTASK_RET_F, {
	"ret",
	".cs.S2C_Exploration_FinishTask.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_FINISHTASK_TASK_ID_F, {
	"task_id",
	".cs.S2C_Exploration_FinishTask.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EXPLORATION_FINISHTASK_AWARDS_F, {
	"awards",
	".cs.S2C_Exploration_FinishTask.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EXPLORATION_FINISHTASK_ME, {
	"S2C_Exploration_FinishTask",
	".cs.S2C_Exploration_FinishTask",
	{},
	{},
	{
		var_0_10.S2C_EXPLORATION_FINISHTASK_RET_F,
		var_0_10.S2C_EXPLORATION_FINISHTASK_TASK_ID_F,
		var_0_10.S2C_EXPLORATION_FINISHTASK_AWARDS_F
	},
	false,
	{}
})

return var_0_10
