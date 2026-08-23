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
	C2S_ARENA_GETMAININFO_ME = protobuf.Descriptor(),
	S2C_ARENA_GETMAININFO_ME = protobuf.Descriptor(),
	S2C_ARENA_GETMAININFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETMAININFO_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETMAININFO_MAX_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETMAININFO_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETMAININFO_ARENA_UNITS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETMAININFO_GUIDE_ROBOT_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETMAININFO_ALREADY_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	C2S_ARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_ARENA_CHALLENGEBEGIN_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_ARENA_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEBEGIN_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_ARENA_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_CUR_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_MAX_RANK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGEFINISH_GUARD_SNAPSHOT_F = protobuf.FieldDescriptor(),
	C2S_ARENA_FASTCHALLENGE_ME = protobuf.Descriptor(),
	C2S_ARENA_FASTCHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	C2S_ARENA_FASTCHALLENGE_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_FASTCHALLENGE_ME = protobuf.Descriptor(),
	S2C_ARENA_FASTCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_FASTCHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ARENA_FASTCHALLENGE_RANK_F = protobuf.FieldDescriptor(),
	S2C_ARENA_FASTCHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_FASTCHALLENGE_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_ARENA_FASTCHALLENGE_ALREADY_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	C2S_ARENA_GETTASKINFO_ME = protobuf.Descriptor(),
	S2C_ARENA_GETTASKINFO_ME = protobuf.Descriptor(),
	S2C_ARENA_GETTASKINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKINFO_DAILY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKINFO_WEEKLY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKINFO_DAILY_TASKS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKINFO_WEEKLY_TASKS_F = protobuf.FieldDescriptor(),
	C2S_ARENA_GETTASKAWARD_ME = protobuf.Descriptor(),
	C2S_ARENA_GETTASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKAWARD_ME = protobuf.Descriptor(),
	S2C_ARENA_GETTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ARENA_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_ARENA_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_ARENA_GETRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_GETRANKLIST_USERS_F = protobuf.FieldDescriptor(),
	C2S_ARENA_CHALLENGERECORD_ME = protobuf.Descriptor(),
	C2S_ARENA_CHALLENGERECORD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGERECORD_ME = protobuf.Descriptor(),
	S2C_ARENA_CHALLENGERECORD_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGERECORD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_ARENA_CHALLENGERECORD_RECORDS_F = protobuf.FieldDescriptor(),
	C2S_ARENA_ONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	C2S_ARENA_ONEKEYCHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	C2S_ARENA_ONEKEYCHALLENGE_IS_HELP_F = protobuf.FieldDescriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_ITEM_NUM_F = protobuf.FieldDescriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_TURN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARENA_ONEKEYCHALLENGE_IS_HELP_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_GETMAININFO_ME, {
	"C2S_Arena_GetMainInfo",
	".cs.C2S_Arena_GetMainInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_RET_F, {
	"ret",
	".cs.S2C_Arena_GetMainInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_RANK_F, {
	"rank",
	".cs.S2C_Arena_GetMainInfo.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_MAX_RANK_F, {
	"max_rank",
	".cs.S2C_Arena_GetMainInfo.max_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_CHALLENGE_COUNT_F, {
	"challenge_count",
	".cs.S2C_Arena_GetMainInfo.challenge_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_ARENA_UNITS_F, {
	"arena_units",
	".cs.S2C_Arena_GetMainInfo.arena_units",
	5,
	4,
	3,
	false,
	{},
	var_0_3.ARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_GUIDE_ROBOT_F, {
	"guide_robot",
	".cs.S2C_Arena_GetMainInfo.guide_robot",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.ARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_ALREADY_CHALLENGE_COUNT_F, {
	"already_challenge_count",
	".cs.S2C_Arena_GetMainInfo.already_challenge_count",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_GETMAININFO_ME, {
	"S2C_Arena_GetMainInfo",
	".cs.S2C_Arena_GetMainInfo",
	{},
	{},
	{
		var_0_10.S2C_ARENA_GETMAININFO_RET_F,
		var_0_10.S2C_ARENA_GETMAININFO_RANK_F,
		var_0_10.S2C_ARENA_GETMAININFO_MAX_RANK_F,
		var_0_10.S2C_ARENA_GETMAININFO_CHALLENGE_COUNT_F,
		var_0_10.S2C_ARENA_GETMAININFO_ARENA_UNITS_F,
		var_0_10.S2C_ARENA_GETMAININFO_GUIDE_ROBOT_F,
		var_0_10.S2C_ARENA_GETMAININFO_ALREADY_CHALLENGE_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_CHALLENGEBEGIN_RANK_F, {
	"rank",
	".cs.C2S_Arena_ChallengeBegin.rank",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_CHALLENGEBEGIN_ME, {
	"C2S_Arena_ChallengeBegin",
	".cs.C2S_Arena_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_ARENA_CHALLENGEBEGIN_RANK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Arena_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEBEGIN_RANK_F, {
	"rank",
	".cs.S2C_Arena_ChallengeBegin.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Arena_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_CHALLENGEBEGIN_ME, {
	"S2C_Arena_ChallengeBegin",
	".cs.S2C_Arena_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_ARENA_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_ARENA_CHALLENGEBEGIN_RANK_F,
		var_0_10.S2C_ARENA_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Arena_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_RANK_F, {
	"rank",
	".cs.S2C_Arena_ChallengeFinish.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Arena_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_CUR_RANK_F, {
	"cur_rank",
	".cs.S2C_Arena_ChallengeFinish.cur_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Arena_ChallengeFinish.awards",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.ARENAAWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_MAX_RANK_AWARDS_F, {
	"max_rank_awards",
	".cs.S2C_Arena_ChallengeFinish.max_rank_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_GUARD_SNAPSHOT_F, {
	"guard_snapshot",
	".cs.S2C_Arena_ChallengeFinish.guard_snapshot",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_CHALLENGEFINISH_ME, {
	"S2C_Arena_ChallengeFinish",
	".cs.S2C_Arena_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_ARENA_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_ARENA_CHALLENGEFINISH_RANK_F,
		var_0_10.S2C_ARENA_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_ARENA_CHALLENGEFINISH_CUR_RANK_F,
		var_0_10.S2C_ARENA_CHALLENGEFINISH_AWARDS_F,
		var_0_10.S2C_ARENA_CHALLENGEFINISH_MAX_RANK_AWARDS_F,
		var_0_10.S2C_ARENA_CHALLENGEFINISH_GUARD_SNAPSHOT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_FASTCHALLENGE_NUM_F, {
	"num",
	".cs.C2S_Arena_FastChallenge.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_FASTCHALLENGE_RANK_F, {
	"rank",
	".cs.C2S_Arena_FastChallenge.rank",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_FASTCHALLENGE_ME, {
	"C2S_Arena_FastChallenge",
	".cs.C2S_Arena_FastChallenge",
	{},
	{},
	{
		var_0_10.C2S_ARENA_FASTCHALLENGE_NUM_F,
		var_0_10.C2S_ARENA_FASTCHALLENGE_RANK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_Arena_FastChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_NUM_F, {
	"num",
	".cs.S2C_Arena_FastChallenge.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_RANK_F, {
	"rank",
	".cs.S2C_Arena_FastChallenge.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_AWARDS_F, {
	"awards",
	".cs.S2C_Arena_FastChallenge.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.ARENAAWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_CHALLENGE_COUNT_F, {
	"challenge_count",
	".cs.S2C_Arena_FastChallenge.challenge_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_ALREADY_CHALLENGE_COUNT_F, {
	"already_challenge_count",
	".cs.S2C_Arena_FastChallenge.already_challenge_count",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_FASTCHALLENGE_ME, {
	"S2C_Arena_FastChallenge",
	".cs.S2C_Arena_FastChallenge",
	{},
	{},
	{
		var_0_10.S2C_ARENA_FASTCHALLENGE_RET_F,
		var_0_10.S2C_ARENA_FASTCHALLENGE_NUM_F,
		var_0_10.S2C_ARENA_FASTCHALLENGE_RANK_F,
		var_0_10.S2C_ARENA_FASTCHALLENGE_AWARDS_F,
		var_0_10.S2C_ARENA_FASTCHALLENGE_CHALLENGE_COUNT_F,
		var_0_10.S2C_ARENA_FASTCHALLENGE_ALREADY_CHALLENGE_COUNT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_GETTASKINFO_ME, {
	"C2S_Arena_GetTaskInfo",
	".cs.C2S_Arena_GetTaskInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKINFO_RET_F, {
	"ret",
	".cs.S2C_Arena_GetTaskInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKINFO_DAILY_AWARDS_F, {
	"daily_awards",
	".cs.S2C_Arena_GetTaskInfo.daily_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKINFO_WEEKLY_AWARDS_F, {
	"weekly_awards",
	".cs.S2C_Arena_GetTaskInfo.weekly_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKINFO_DAILY_TASKS_F, {
	"daily_tasks",
	".cs.S2C_Arena_GetTaskInfo.daily_tasks",
	4,
	3,
	3,
	false,
	{},
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKINFO_WEEKLY_TASKS_F, {
	"weekly_tasks",
	".cs.S2C_Arena_GetTaskInfo.weekly_tasks",
	5,
	4,
	3,
	false,
	{},
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_GETTASKINFO_ME, {
	"S2C_Arena_GetTaskInfo",
	".cs.S2C_Arena_GetTaskInfo",
	{},
	{},
	{
		var_0_10.S2C_ARENA_GETTASKINFO_RET_F,
		var_0_10.S2C_ARENA_GETTASKINFO_DAILY_AWARDS_F,
		var_0_10.S2C_ARENA_GETTASKINFO_WEEKLY_AWARDS_F,
		var_0_10.S2C_ARENA_GETTASKINFO_DAILY_TASKS_F,
		var_0_10.S2C_ARENA_GETTASKINFO_WEEKLY_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_GETTASKAWARD_ID_F, {
	"id",
	".cs.C2S_Arena_GetTaskAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_GETTASKAWARD_ME, {
	"C2S_Arena_GetTaskAward",
	".cs.C2S_Arena_GetTaskAward",
	{},
	{},
	{
		var_0_10.C2S_ARENA_GETTASKAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Arena_GetTaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKAWARD_ID_F, {
	"id",
	".cs.S2C_Arena_GetTaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Arena_GetTaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_GETTASKAWARD_ME, {
	"S2C_Arena_GetTaskAward",
	".cs.S2C_Arena_GetTaskAward",
	{},
	{},
	{
		var_0_10.S2C_ARENA_GETTASKAWARD_RET_F,
		var_0_10.S2C_ARENA_GETTASKAWARD_ID_F,
		var_0_10.S2C_ARENA_GETTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_GETRANKLIST_ME, {
	"C2S_Arena_GetRanklist",
	".cs.C2S_Arena_GetRanklist",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETRANKLIST_RET_F, {
	"ret",
	".cs.S2C_Arena_GetRanklist.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_GETRANKLIST_USERS_F, {
	"users",
	".cs.S2C_Arena_GetRanklist.users",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_GETRANKLIST_ME, {
	"S2C_Arena_GetRanklist",
	".cs.S2C_Arena_GetRanklist",
	{},
	{},
	{
		var_0_10.S2C_ARENA_GETRANKLIST_RET_F,
		var_0_10.S2C_ARENA_GETRANKLIST_USERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_CHALLENGERECORD_TYPE_F, {
	"type",
	".cs.C2S_Arena_ChallengeRecord.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_CHALLENGERECORD_ME, {
	"C2S_Arena_ChallengeRecord",
	".cs.C2S_Arena_ChallengeRecord",
	{},
	{},
	{
		var_0_10.C2S_ARENA_CHALLENGERECORD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGERECORD_RET_F, {
	"ret",
	".cs.S2C_Arena_ChallengeRecord.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGERECORD_TYPE_F, {
	"type",
	".cs.S2C_Arena_ChallengeRecord.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_CHALLENGERECORD_RECORDS_F, {
	"records",
	".cs.S2C_Arena_ChallengeRecord.records",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ARENARECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_CHALLENGERECORD_ME, {
	"S2C_Arena_ChallengeRecord",
	".cs.S2C_Arena_ChallengeRecord",
	{},
	{},
	{
		var_0_10.S2C_ARENA_CHALLENGERECORD_RET_F,
		var_0_10.S2C_ARENA_CHALLENGERECORD_TYPE_F,
		var_0_10.S2C_ARENA_CHALLENGERECORD_RECORDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_ONEKEYCHALLENGE_NUM_F, {
	"num",
	".cs.C2S_Arena_OneKeyChallenge.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARENA_ONEKEYCHALLENGE_IS_HELP_F, {
	"is_help",
	".cs.C2S_Arena_OneKeyChallenge.is_help",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARENA_ONEKEYCHALLENGE_ME, {
	"C2S_Arena_OneKeyChallenge",
	".cs.C2S_Arena_OneKeyChallenge",
	{},
	{},
	{
		var_0_10.C2S_ARENA_ONEKEYCHALLENGE_NUM_F,
		var_0_10.C2S_ARENA_ONEKEYCHALLENGE_IS_HELP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_Arena_OneKeyChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_NUM_F, {
	"num",
	".cs.S2C_Arena_OneKeyChallenge.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_AWARDS_F, {
	"awards",
	".cs.S2C_Arena_OneKeyChallenge.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARDS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_ITEM_NUM_F, {
	"item_num",
	".cs.S2C_Arena_OneKeyChallenge.item_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_TURN_AWARDS_F, {
	"turn_awards",
	".cs.S2C_Arena_OneKeyChallenge.turn_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_IS_HELP_F, {
	"is_help",
	".cs.S2C_Arena_OneKeyChallenge.is_help",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARENA_ONEKEYCHALLENGE_ME, {
	"S2C_Arena_OneKeyChallenge",
	".cs.S2C_Arena_OneKeyChallenge",
	{},
	{},
	{
		var_0_10.S2C_ARENA_ONEKEYCHALLENGE_RET_F,
		var_0_10.S2C_ARENA_ONEKEYCHALLENGE_NUM_F,
		var_0_10.S2C_ARENA_ONEKEYCHALLENGE_AWARDS_F,
		var_0_10.S2C_ARENA_ONEKEYCHALLENGE_ITEM_NUM_F,
		var_0_10.S2C_ARENA_ONEKEYCHALLENGE_TURN_AWARDS_F,
		var_0_10.S2C_ARENA_ONEKEYCHALLENGE_IS_HELP_F
	},
	false,
	{}
})

return var_0_10
