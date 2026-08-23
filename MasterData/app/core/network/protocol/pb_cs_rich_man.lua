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
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_9 = {
	C2S_RICHMAN_GETINFO_ME = protobuf.Descriptor(),
	S2C_RICHMAN_GETINFO_ME = protobuf.Descriptor(),
	S2C_RICHMAN_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_GETINFO_MAP_DATA_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_GETINFO_EVENTS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_GETINFO_CONSTRUCT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROLLDICE_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ROLLDICE_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ROLLDICE_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROLLDICE_DICE_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROLLDICE_EVENTS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROLLDICE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROLLDICE_MAP_DATA_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_EVENTPROCESS_ME = protobuf.Descriptor(),
	C2S_RICHMAN_EVENTPROCESS_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_EVENTPROCESS_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_ME = protobuf.Descriptor(),
	S2C_RICHMAN_EVENTPROCESS_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_EVENT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_EVENTPROCESS_IS_REMOVE_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_ME = protobuf.Descriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_RESULT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_EVENT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_EXP_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CHALLENGEMONSTERFINISH_IS_SKIP_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_MAPUPLEVEL_ME = protobuf.Descriptor(),
	S2C_RICHMAN_MAPUPLEVEL_ME = protobuf.Descriptor(),
	S2C_RICHMAN_MAPUPLEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_MAPUPLEVEL_MAP_DATA_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_MATCHPASSER_ME = protobuf.Descriptor(),
	C2S_RICHMAN_MATCHPASSER_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_MATCHPASSER_ME = protobuf.Descriptor(),
	S2C_RICHMAN_MATCHPASSER_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_MATCHPASSER_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_MATCHPASSER_PASSERS_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ENEMYLIST_ME = protobuf.Descriptor(),
	C2S_RICHMAN_ENEMYLIST_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ENEMYLIST_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ENEMYLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ENEMYLIST_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ENEMYLIST_LIST_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROBDATA_ME = protobuf.Descriptor(),
	C2S_RICHMAN_ROBDATA_EVENT_ID_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROBDATA_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBDATA_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ROBDATA_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBDATA_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBDATA_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBDATA_ONLINE_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBDATA_MAP_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBDATA_CONSTRUCT_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROBBEGIN_ME = protobuf.Descriptor(),
	C2S_RICHMAN_ROBBEGIN_TP_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROBBEGIN_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROBBEGIN_CONSTRUCT_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_ROBBEGIN_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBBEGIN_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ROBBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBBEGIN_TP_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBBEGIN_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBBEGIN_CONSTRUCT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBBEGIN_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBFINISH_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ROBFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBFINISH_TP_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBFINISH_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBFINISH_CONSTRUCT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBFINISH_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_ME = protobuf.Descriptor(),
	S2C_RICHMAN_ROBAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_TP_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_CONSTRUCT_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_ROBAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_CONSTRUCTAWARD_ME = protobuf.Descriptor(),
	S2C_RICHMAN_CONSTRUCTAWARD_ME = protobuf.Descriptor(),
	S2C_RICHMAN_CONSTRUCTAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CONSTRUCTAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_CONSTRUCTAWARD_CONSTRUCT_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_RICHMAN_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_RICHMAN_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_GETLOG_ME = protobuf.Descriptor(),
	S2C_RICHMAN_GETLOG_ME = protobuf.Descriptor(),
	S2C_RICHMAN_GETLOG_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_GETLOG_LOGS_F = protobuf.FieldDescriptor(),
	C2S_RICHMAN_GETCONSTRUCT_ME = protobuf.Descriptor(),
	S2C_RICHMAN_GETCONSTRUCT_ME = protobuf.Descriptor(),
	S2C_RICHMAN_GETCONSTRUCT_RET_F = protobuf.FieldDescriptor(),
	S2C_RICHMAN_GETCONSTRUCT_CONSTRUCT_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_GETINFO_ME, {
	"C2S_RichMan_GetInfo",
	".cs.C2S_RichMan_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETINFO_RET_F, {
	"ret",
	".cs.S2C_RichMan_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETINFO_MAP_DATA_F, {
	"map_data",
	".cs.S2C_RichMan_GetInfo.map_data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RICHMANMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETINFO_EVENTS_F, {
	"events",
	".cs.S2C_RichMan_GetInfo.events",
	3,
	2,
	3,
	false,
	{},
	var_0_3.RICHMANEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETINFO_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_GetInfo.construct",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.RICHMANCONSTRUCT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_RichMan_GetInfo.tasks",
	5,
	4,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_GETINFO_ME, {
	"S2C_RichMan_GetInfo",
	".cs.S2C_RichMan_GetInfo",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_GETINFO_RET_F,
		var_0_9.S2C_RICHMAN_GETINFO_MAP_DATA_F,
		var_0_9.S2C_RICHMAN_GETINFO_EVENTS_F,
		var_0_9.S2C_RICHMAN_GETINFO_CONSTRUCT_F,
		var_0_9.S2C_RICHMAN_GETINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_ROLLDICE_ME, {
	"C2S_RichMan_RollDice",
	".cs.C2S_RichMan_RollDice",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROLLDICE_RET_F, {
	"ret",
	".cs.S2C_RichMan_RollDice.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROLLDICE_DICE_F, {
	"dice",
	".cs.S2C_RichMan_RollDice.dice",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROLLDICE_EVENTS_F, {
	"events",
	".cs.S2C_RichMan_RollDice.events",
	3,
	2,
	3,
	false,
	{},
	var_0_3.RICHMANEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROLLDICE_AWARDS_F, {
	"awards",
	".cs.S2C_RichMan_RollDice.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROLLDICE_MAP_DATA_F, {
	"map_data",
	".cs.S2C_RichMan_RollDice.map_data",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.RICHMANMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_ROLLDICE_ME, {
	"S2C_RichMan_RollDice",
	".cs.S2C_RichMan_RollDice",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_ROLLDICE_RET_F,
		var_0_9.S2C_RICHMAN_ROLLDICE_DICE_F,
		var_0_9.S2C_RICHMAN_ROLLDICE_EVENTS_F,
		var_0_9.S2C_RICHMAN_ROLLDICE_AWARDS_F,
		var_0_9.S2C_RICHMAN_ROLLDICE_MAP_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_EVENTPROCESS_UNIQUE_ID_F, {
	"unique_id",
	".cs.C2S_RichMan_EventProcess.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_EVENTPROCESS_PARAMS_F, {
	"params",
	".cs.C2S_RichMan_EventProcess.params",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_EVENTPROCESS_ME, {
	"C2S_RichMan_EventProcess",
	".cs.C2S_RichMan_EventProcess",
	{},
	{},
	{
		var_0_9.C2S_RICHMAN_EVENTPROCESS_UNIQUE_ID_F,
		var_0_9.C2S_RICHMAN_EVENTPROCESS_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_RET_F, {
	"ret",
	".cs.S2C_RichMan_EventProcess.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_UNIQUE_ID_F, {
	"unique_id",
	".cs.S2C_RichMan_EventProcess.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_PARAMS_F, {
	"params",
	".cs.S2C_RichMan_EventProcess.params",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_EVENT_F, {
	"event",
	".cs.S2C_RichMan_EventProcess.event",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.RICHMANEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_AWARDS_F, {
	"awards",
	".cs.S2C_RichMan_EventProcess.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_RichMan_EventProcess.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_IS_REMOVE_F, {
	"is_remove",
	".cs.S2C_RichMan_EventProcess.is_remove",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_EVENTPROCESS_ME, {
	"S2C_RichMan_EventProcess",
	".cs.S2C_RichMan_EventProcess",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_EVENTPROCESS_RET_F,
		var_0_9.S2C_RICHMAN_EVENTPROCESS_UNIQUE_ID_F,
		var_0_9.S2C_RICHMAN_EVENTPROCESS_PARAMS_F,
		var_0_9.S2C_RICHMAN_EVENTPROCESS_EVENT_F,
		var_0_9.S2C_RICHMAN_EVENTPROCESS_AWARDS_F,
		var_0_9.S2C_RICHMAN_EVENTPROCESS_BATTLE_ID_F,
		var_0_9.S2C_RICHMAN_EVENTPROCESS_IS_REMOVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_RET_F, {
	"ret",
	".cs.S2C_RichMan_ChallengeMonsterFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_RichMan_ChallengeMonsterFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_RESULT_F, {
	"result",
	".cs.S2C_RichMan_ChallengeMonsterFinish.result",
	3,
	2,
	1,
	false,
	nil,
	var_0_1("pb_bs").BATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_EVENT_F, {
	"event",
	".cs.S2C_RichMan_ChallengeMonsterFinish.event",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.RICHMANEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_RichMan_ChallengeMonsterFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_EXP_F, {
	"exp",
	".cs.S2C_RichMan_ChallengeMonsterFinish.exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_IS_SKIP_F, {
	"is_skip",
	".cs.S2C_RichMan_ChallengeMonsterFinish.is_skip",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_ME, {
	"S2C_RichMan_ChallengeMonsterFinish",
	".cs.S2C_RichMan_ChallengeMonsterFinish",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_RET_F,
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_IS_WIN_F,
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_RESULT_F,
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_EVENT_F,
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_AWARDS_F,
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_EXP_F,
		var_0_9.S2C_RICHMAN_CHALLENGEMONSTERFINISH_IS_SKIP_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_MAPUPLEVEL_ME, {
	"C2S_RichMan_MapUpLevel",
	".cs.C2S_RichMan_MapUpLevel",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_MAPUPLEVEL_RET_F, {
	"ret",
	".cs.S2C_RichMan_MapUpLevel.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_MAPUPLEVEL_MAP_DATA_F, {
	"map_data",
	".cs.S2C_RichMan_MapUpLevel.map_data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RICHMANMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_MAPUPLEVEL_ME, {
	"S2C_RichMan_MapUpLevel",
	".cs.S2C_RichMan_MapUpLevel",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_MAPUPLEVEL_RET_F,
		var_0_9.S2C_RICHMAN_MAPUPLEVEL_MAP_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_MATCHPASSER_EVENT_ID_F, {
	"event_id",
	".cs.C2S_RichMan_MatchPasser.event_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_MATCHPASSER_ME, {
	"C2S_RichMan_MatchPasser",
	".cs.C2S_RichMan_MatchPasser",
	{},
	{},
	{
		var_0_9.C2S_RICHMAN_MATCHPASSER_EVENT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_MATCHPASSER_RET_F, {
	"ret",
	".cs.S2C_RichMan_MatchPasser.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_MATCHPASSER_EVENT_ID_F, {
	"event_id",
	".cs.S2C_RichMan_MatchPasser.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_MATCHPASSER_PASSERS_F, {
	"passers",
	".cs.S2C_RichMan_MatchPasser.passers",
	3,
	2,
	3,
	false,
	{},
	var_0_3.RICHMANROBUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_MATCHPASSER_ME, {
	"S2C_RichMan_MatchPasser",
	".cs.S2C_RichMan_MatchPasser",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_MATCHPASSER_RET_F,
		var_0_9.S2C_RICHMAN_MATCHPASSER_EVENT_ID_F,
		var_0_9.S2C_RICHMAN_MATCHPASSER_PASSERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ENEMYLIST_EVENT_ID_F, {
	"event_id",
	".cs.C2S_RichMan_EnemyList.event_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_ENEMYLIST_ME, {
	"C2S_RichMan_EnemyList",
	".cs.C2S_RichMan_EnemyList",
	{},
	{},
	{
		var_0_9.C2S_RICHMAN_ENEMYLIST_EVENT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ENEMYLIST_RET_F, {
	"ret",
	".cs.S2C_RichMan_EnemyList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ENEMYLIST_EVENT_ID_F, {
	"event_id",
	".cs.S2C_RichMan_EnemyList.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ENEMYLIST_LIST_F, {
	"list",
	".cs.S2C_RichMan_EnemyList.list",
	3,
	2,
	3,
	false,
	{},
	var_0_3.RICHMANROBUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_ENEMYLIST_ME, {
	"S2C_RichMan_EnemyList",
	".cs.S2C_RichMan_EnemyList",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_ENEMYLIST_RET_F,
		var_0_9.S2C_RICHMAN_ENEMYLIST_EVENT_ID_F,
		var_0_9.S2C_RICHMAN_ENEMYLIST_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ROBDATA_EVENT_ID_F, {
	"event_id",
	".cs.C2S_RichMan_RobData.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ROBDATA_USER_ID_F, {
	"user_id",
	".cs.C2S_RichMan_RobData.user_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_ROBDATA_ME, {
	"C2S_RichMan_RobData",
	".cs.C2S_RichMan_RobData",
	{},
	{},
	{
		var_0_9.C2S_RICHMAN_ROBDATA_EVENT_ID_F,
		var_0_9.C2S_RICHMAN_ROBDATA_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_RET_F, {
	"ret",
	".cs.S2C_RichMan_RobData.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_EVENT_ID_F, {
	"event_id",
	".cs.S2C_RichMan_RobData.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_USER_ID_F, {
	"user_id",
	".cs.S2C_RichMan_RobData.user_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_ONLINE_F, {
	"online",
	".cs.S2C_RichMan_RobData.online",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_MAP_LEVEL_F, {
	"map_level",
	".cs.S2C_RichMan_RobData.map_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_RobData.construct",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.RICHMANCONSTRUCT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_ROBDATA_ME, {
	"S2C_RichMan_RobData",
	".cs.S2C_RichMan_RobData",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_ROBDATA_RET_F,
		var_0_9.S2C_RICHMAN_ROBDATA_EVENT_ID_F,
		var_0_9.S2C_RICHMAN_ROBDATA_USER_ID_F,
		var_0_9.S2C_RICHMAN_ROBDATA_ONLINE_F,
		var_0_9.S2C_RICHMAN_ROBDATA_MAP_LEVEL_F,
		var_0_9.S2C_RICHMAN_ROBDATA_CONSTRUCT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ROBBEGIN_TP_F, {
	"tp",
	".cs.C2S_RichMan_RobBegin.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ROBBEGIN_USER_ID_F, {
	"user_id",
	".cs.C2S_RichMan_RobBegin.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ROBBEGIN_CONSTRUCT_F, {
	"construct",
	".cs.C2S_RichMan_RobBegin.construct",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_ROBBEGIN_EVENT_ID_F, {
	"event_id",
	".cs.C2S_RichMan_RobBegin.event_id",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_ROBBEGIN_ME, {
	"C2S_RichMan_RobBegin",
	".cs.C2S_RichMan_RobBegin",
	{},
	{},
	{
		var_0_9.C2S_RICHMAN_ROBBEGIN_TP_F,
		var_0_9.C2S_RICHMAN_ROBBEGIN_USER_ID_F,
		var_0_9.C2S_RICHMAN_ROBBEGIN_CONSTRUCT_F,
		var_0_9.C2S_RICHMAN_ROBBEGIN_EVENT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_RET_F, {
	"ret",
	".cs.S2C_RichMan_RobBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_TP_F, {
	"tp",
	".cs.S2C_RichMan_RobBegin.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_USER_ID_F, {
	"user_id",
	".cs.S2C_RichMan_RobBegin.user_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_RobBegin.construct",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_EVENT_ID_F, {
	"event_id",
	".cs.S2C_RichMan_RobBegin.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_RichMan_RobBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_ROBBEGIN_ME, {
	"S2C_RichMan_RobBegin",
	".cs.S2C_RichMan_RobBegin",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_ROBBEGIN_RET_F,
		var_0_9.S2C_RICHMAN_ROBBEGIN_TP_F,
		var_0_9.S2C_RICHMAN_ROBBEGIN_USER_ID_F,
		var_0_9.S2C_RICHMAN_ROBBEGIN_CONSTRUCT_F,
		var_0_9.S2C_RICHMAN_ROBBEGIN_EVENT_ID_F,
		var_0_9.S2C_RICHMAN_ROBBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_RET_F, {
	"ret",
	".cs.S2C_RichMan_RobFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_TP_F, {
	"tp",
	".cs.S2C_RichMan_RobFinish.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_USER_ID_F, {
	"user_id",
	".cs.S2C_RichMan_RobFinish.user_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_RobFinish.construct",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_EVENT_ID_F, {
	"event_id",
	".cs.S2C_RichMan_RobFinish.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_RichMan_RobFinish.is_win",
	6,
	5,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_ROBFINISH_ME, {
	"S2C_RichMan_RobFinish",
	".cs.S2C_RichMan_RobFinish",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_ROBFINISH_RET_F,
		var_0_9.S2C_RICHMAN_ROBFINISH_TP_F,
		var_0_9.S2C_RICHMAN_ROBFINISH_USER_ID_F,
		var_0_9.S2C_RICHMAN_ROBFINISH_CONSTRUCT_F,
		var_0_9.S2C_RICHMAN_ROBFINISH_EVENT_ID_F,
		var_0_9.S2C_RICHMAN_ROBFINISH_IS_WIN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_RET_F, {
	"ret",
	".cs.S2C_RichMan_RobAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_TP_F, {
	"tp",
	".cs.S2C_RichMan_RobAward.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_USER_ID_F, {
	"user_id",
	".cs.S2C_RichMan_RobAward.user_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_RobAward.construct",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_EVENT_ID_F, {
	"event_id",
	".cs.S2C_RichMan_RobAward.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_IS_WIN_F, {
	"is_win",
	".cs.S2C_RichMan_RobAward.is_win",
	6,
	5,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_RichMan_RobAward.awards",
	7,
	6,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_ROBAWARD_ME, {
	"S2C_RichMan_RobAward",
	".cs.S2C_RichMan_RobAward",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_ROBAWARD_RET_F,
		var_0_9.S2C_RICHMAN_ROBAWARD_TP_F,
		var_0_9.S2C_RICHMAN_ROBAWARD_USER_ID_F,
		var_0_9.S2C_RICHMAN_ROBAWARD_CONSTRUCT_F,
		var_0_9.S2C_RICHMAN_ROBAWARD_EVENT_ID_F,
		var_0_9.S2C_RICHMAN_ROBAWARD_IS_WIN_F,
		var_0_9.S2C_RICHMAN_ROBAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_CONSTRUCTAWARD_ME, {
	"C2S_RichMan_ConstructAward",
	".cs.C2S_RichMan_ConstructAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_RET_F, {
	"ret",
	".cs.S2C_RichMan_ConstructAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_RichMan_ConstructAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_ConstructAward.construct",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.RICHMANCONSTRUCT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_ME, {
	"S2C_RichMan_ConstructAward",
	".cs.S2C_RichMan_ConstructAward",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_RET_F,
		var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_AWARDS_F,
		var_0_9.S2C_RICHMAN_CONSTRUCTAWARD_CONSTRUCT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RICHMAN_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_RichMan_TaskAward.ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_TASKAWARD_ME, {
	"C2S_RichMan_TaskAward",
	".cs.C2S_RichMan_TaskAward",
	{},
	{},
	{
		var_0_9.C2S_RICHMAN_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_RichMan_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_RichMan_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_RichMan_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_TASKAWARD_ME, {
	"S2C_RichMan_TaskAward",
	".cs.S2C_RichMan_TaskAward",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_TASKAWARD_RET_F,
		var_0_9.S2C_RICHMAN_TASKAWARD_IDS_F,
		var_0_9.S2C_RICHMAN_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_GETLOG_ME, {
	"C2S_RichMan_GetLog",
	".cs.C2S_RichMan_GetLog",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETLOG_RET_F, {
	"ret",
	".cs.S2C_RichMan_GetLog.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETLOG_LOGS_F, {
	"logs",
	".cs.S2C_RichMan_GetLog.logs",
	2,
	1,
	3,
	false,
	{},
	var_0_3.RICHMANLOG_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_GETLOG_ME, {
	"S2C_RichMan_GetLog",
	".cs.S2C_RichMan_GetLog",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_GETLOG_RET_F,
		var_0_9.S2C_RICHMAN_GETLOG_LOGS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_RICHMAN_GETCONSTRUCT_ME, {
	"C2S_RichMan_GetConstruct",
	".cs.C2S_RichMan_GetConstruct",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETCONSTRUCT_RET_F, {
	"ret",
	".cs.S2C_RichMan_GetConstruct.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RICHMAN_GETCONSTRUCT_CONSTRUCT_F, {
	"construct",
	".cs.S2C_RichMan_GetConstruct.construct",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RICHMANCONSTRUCT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_RICHMAN_GETCONSTRUCT_ME, {
	"S2C_RichMan_GetConstruct",
	".cs.S2C_RichMan_GetConstruct",
	{},
	{},
	{
		var_0_9.S2C_RICHMAN_GETCONSTRUCT_RET_F,
		var_0_9.S2C_RICHMAN_GETCONSTRUCT_CONSTRUCT_F
	},
	false,
	{}
})

return var_0_9
