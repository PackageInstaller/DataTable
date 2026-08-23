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
	C2S_BLAZINGARENA_GETINFO_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_GETINFO_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_GETINFO_RANK_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_GETINFO_MAX_RANK_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_GETINFO_GUIDE_FINISH_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_GETINFO_MATCH_UNITS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_GETINFO_DAILY_CHALLENGE_TIMES_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_RANKLIST_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_RANKLIST_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_RANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_RANKLIST_UNITS_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_BLAZINGARENA_CHALLENGEBEGIN_RANK_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEBEGIN_RANK_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_RANK_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_MULTI_RESULT_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_CHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_TURN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_BREAK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_CHALLENGEFINISH_WAVE_UNITS_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_SWEEP_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_SWEEP_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_SWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_SWEEP_CHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_SWEEP_TURN_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_SERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_SERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_BLAZINGARENA_TASKAWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_TASKAWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_EMBRYOBORROW_ME = protobuf.Descriptor(),
	C2S_BLAZINGARENA_EMBRYOBORROW_EMBRYO_TYPE_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_EMBRYOBORROW_EMBRYO_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_EMBRYOBORROW_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_EMBRYOBORROW_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_EMBRYOBORROW_EMBRYO_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_EMBRYOBORROW_EMBRYO_BASE_ID_F = protobuf.FieldDescriptor(),
	C2S_BLAZINGARENA_EMBRYOGIVEBACK_ME = protobuf.Descriptor(),
	C2S_BLAZINGARENA_EMBRYOGIVEBACK_EMBRYO_UNIQUE_IDS_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_EMBRYOGIVEBACK_ME = protobuf.Descriptor(),
	S2C_BLAZINGARENA_EMBRYOGIVEBACK_RET_F = protobuf.FieldDescriptor(),
	S2C_BLAZINGARENA_EMBRYOGIVEBACK_EMBRYO_UNIQUE_IDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_GETINFO_ME, {
	"C2S_BlazingArena_GetInfo",
	".cs.C2S_BlazingArena_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_RANK_F, {
	"rank",
	".cs.S2C_BlazingArena_GetInfo.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_MAX_RANK_F, {
	"max_rank",
	".cs.S2C_BlazingArena_GetInfo.max_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_GUIDE_FINISH_F, {
	"guide_finish",
	".cs.S2C_BlazingArena_GetInfo.guide_finish",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_MATCH_UNITS_F, {
	"match_units",
	".cs.S2C_BlazingArena_GetInfo.match_units",
	5,
	4,
	3,
	false,
	{},
	var_0_3.BLAZINGARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_BlazingArena_GetInfo.tasks",
	6,
	5,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_DAILY_CHALLENGE_TIMES_F, {
	"daily_challenge_times",
	".cs.S2C_BlazingArena_GetInfo.daily_challenge_times",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_GETINFO_ME, {
	"S2C_BlazingArena_GetInfo",
	".cs.S2C_BlazingArena_GetInfo",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_GETINFO_RET_F,
		var_0_9.S2C_BLAZINGARENA_GETINFO_RANK_F,
		var_0_9.S2C_BLAZINGARENA_GETINFO_MAX_RANK_F,
		var_0_9.S2C_BLAZINGARENA_GETINFO_GUIDE_FINISH_F,
		var_0_9.S2C_BLAZINGARENA_GETINFO_MATCH_UNITS_F,
		var_0_9.S2C_BLAZINGARENA_GETINFO_TASKS_F,
		var_0_9.S2C_BLAZINGARENA_GETINFO_DAILY_CHALLENGE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_RANKLIST_ME, {
	"C2S_BlazingArena_RankList",
	".cs.C2S_BlazingArena_RankList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_RANKLIST_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_RankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_RANKLIST_UNITS_F, {
	"units",
	".cs.S2C_BlazingArena_RankList.units",
	2,
	1,
	3,
	false,
	{},
	var_0_3.BLAZINGARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_RANKLIST_ME, {
	"S2C_BlazingArena_RankList",
	".cs.S2C_BlazingArena_RankList",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_RANKLIST_RET_F,
		var_0_9.S2C_BLAZINGARENA_RANKLIST_UNITS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_BLAZINGARENA_CHALLENGEBEGIN_RANK_F, {
	"rank",
	".cs.C2S_BlazingArena_ChallengeBegin.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_BLAZINGARENA_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.C2S_BlazingArena_ChallengeBegin.id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_CHALLENGEBEGIN_ME, {
	"C2S_BlazingArena_ChallengeBegin",
	".cs.C2S_BlazingArena_ChallengeBegin",
	{},
	{},
	{
		var_0_9.C2S_BLAZINGARENA_CHALLENGEBEGIN_RANK_F,
		var_0_9.C2S_BLAZINGARENA_CHALLENGEBEGIN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_RANK_F, {
	"rank",
	".cs.S2C_BlazingArena_ChallengeBegin.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.S2C_BlazingArena_ChallengeBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_BlazingArena_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_ME, {
	"S2C_BlazingArena_ChallengeBegin",
	".cs.S2C_BlazingArena_ChallengeBegin",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_RET_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_RANK_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_ID_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_RANK_F, {
	"rank",
	".cs.S2C_BlazingArena_ChallengeFinish.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_BlazingArena_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_MULTI_RESULT_F, {
	"multi_result",
	".cs.S2C_BlazingArena_ChallengeFinish.multi_result",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_CHALLENGE_AWARDS_F, {
	"challenge_awards",
	".cs.S2C_BlazingArena_ChallengeFinish.challenge_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_TURN_AWARDS_F, {
	"turn_awards",
	".cs.S2C_BlazingArena_ChallengeFinish.turn_awards",
	6,
	5,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_BREAK_AWARDS_F, {
	"break_awards",
	".cs.S2C_BlazingArena_ChallengeFinish.break_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_WAVE_UNITS_F, {
	"wave_units",
	".cs.S2C_BlazingArena_ChallengeFinish.wave_units",
	8,
	7,
	3,
	false,
	{},
	var_0_1("pb_bs").BATTLEWAVEUNITRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_ME, {
	"S2C_BlazingArena_ChallengeFinish",
	".cs.S2C_BlazingArena_ChallengeFinish",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_RET_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_RANK_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_IS_WIN_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_MULTI_RESULT_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_CHALLENGE_AWARDS_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_TURN_AWARDS_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_BREAK_AWARDS_F,
		var_0_9.S2C_BLAZINGARENA_CHALLENGEFINISH_WAVE_UNITS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_SWEEP_ME, {
	"C2S_BlazingArena_Sweep",
	".cs.C2S_BlazingArena_Sweep",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_SWEEP_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_Sweep.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_SWEEP_CHALLENGE_AWARDS_F, {
	"challenge_awards",
	".cs.S2C_BlazingArena_Sweep.challenge_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_SWEEP_TURN_AWARDS_F, {
	"turn_awards",
	".cs.S2C_BlazingArena_Sweep.turn_awards",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_SWEEP_ME, {
	"S2C_BlazingArena_Sweep",
	".cs.S2C_BlazingArena_Sweep",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_SWEEP_RET_F,
		var_0_9.S2C_BLAZINGARENA_SWEEP_CHALLENGE_AWARDS_F,
		var_0_9.S2C_BLAZINGARENA_SWEEP_TURN_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_SERVERINFOS_ME, {
	"C2S_BlazingArena_ServerInfos",
	".cs.C2S_BlazingArena_ServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_SERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_ServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_SERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_BlazingArena_ServerInfos.server_infos",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_SERVERINFOS_ME, {
	"S2C_BlazingArena_ServerInfos",
	".cs.S2C_BlazingArena_ServerInfos",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_SERVERINFOS_RET_F,
		var_0_9.S2C_BLAZINGARENA_SERVERINFOS_SERVER_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_BLAZINGARENA_TASKAWARD_TASK_IDS_F, {
	"task_ids",
	".cs.C2S_BlazingArena_TaskAward.task_ids",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_TASKAWARD_ME, {
	"C2S_BlazingArena_TaskAward",
	".cs.C2S_BlazingArena_TaskAward",
	{},
	{},
	{
		var_0_9.C2S_BLAZINGARENA_TASKAWARD_TASK_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_TASKAWARD_TASK_IDS_F, {
	"task_ids",
	".cs.S2C_BlazingArena_TaskAward.task_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_BlazingArena_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_TASKAWARD_ME, {
	"S2C_BlazingArena_TaskAward",
	".cs.S2C_BlazingArena_TaskAward",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_TASKAWARD_RET_F,
		var_0_9.S2C_BLAZINGARENA_TASKAWARD_TASK_IDS_F,
		var_0_9.S2C_BLAZINGARENA_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_BLAZINGARENA_EMBRYOBORROW_EMBRYO_TYPE_F, {
	"embryo_type",
	".cs.C2S_BlazingArena_EmbryoBorrow.embryo_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_BLAZINGARENA_EMBRYOBORROW_EMBRYO_BASE_ID_F, {
	"embryo_base_id",
	".cs.C2S_BlazingArena_EmbryoBorrow.embryo_base_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_EMBRYOBORROW_ME, {
	"C2S_BlazingArena_EmbryoBorrow",
	".cs.C2S_BlazingArena_EmbryoBorrow",
	{},
	{},
	{
		var_0_9.C2S_BLAZINGARENA_EMBRYOBORROW_EMBRYO_TYPE_F,
		var_0_9.C2S_BLAZINGARENA_EMBRYOBORROW_EMBRYO_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_EmbryoBorrow.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_EMBRYO_TYPE_F, {
	"embryo_type",
	".cs.S2C_BlazingArena_EmbryoBorrow.embryo_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_EMBRYO_BASE_ID_F, {
	"embryo_base_id",
	".cs.S2C_BlazingArena_EmbryoBorrow.embryo_base_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_ME, {
	"S2C_BlazingArena_EmbryoBorrow",
	".cs.S2C_BlazingArena_EmbryoBorrow",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_RET_F,
		var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_EMBRYO_TYPE_F,
		var_0_9.S2C_BLAZINGARENA_EMBRYOBORROW_EMBRYO_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_BLAZINGARENA_EMBRYOGIVEBACK_EMBRYO_UNIQUE_IDS_F, {
	"embryo_unique_ids",
	".cs.C2S_BlazingArena_EmbryoGiveBack.embryo_unique_ids",
	1,
	0,
	3,
	false,
	{},
	var_0_3.EMBRYOUNIQUEIDS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.C2S_BLAZINGARENA_EMBRYOGIVEBACK_ME, {
	"C2S_BlazingArena_EmbryoGiveBack",
	".cs.C2S_BlazingArena_EmbryoGiveBack",
	{},
	{},
	{
		var_0_9.C2S_BLAZINGARENA_EMBRYOGIVEBACK_EMBRYO_UNIQUE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOGIVEBACK_RET_F, {
	"ret",
	".cs.S2C_BlazingArena_EmbryoGiveBack.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOGIVEBACK_EMBRYO_UNIQUE_IDS_F, {
	"embryo_unique_ids",
	".cs.S2C_BlazingArena_EmbryoGiveBack.embryo_unique_ids",
	2,
	1,
	3,
	false,
	{},
	var_0_3.EMBRYOUNIQUEIDS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_BLAZINGARENA_EMBRYOGIVEBACK_ME, {
	"S2C_BlazingArena_EmbryoGiveBack",
	".cs.S2C_BlazingArena_EmbryoGiveBack",
	{},
	{},
	{
		var_0_9.S2C_BLAZINGARENA_EMBRYOGIVEBACK_RET_F,
		var_0_9.S2C_BLAZINGARENA_EMBRYOGIVEBACK_EMBRYO_UNIQUE_IDS_F
	},
	false,
	{}
})

return var_0_9
