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
	C2S_BOUNTY_GETINFO_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETINFO_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_ACT_INFO_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_MONSTERS_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_SCORE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_TIMES_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_DAILY_HELP_SCORE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETINFO_SHARE_TYPE_STAR_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_FINDMONSTER_ME = protobuf.Descriptor(),
	C2S_BOUNTY_FINDMONSTER_FIND_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_FINDMONSTER_ME = protobuf.Descriptor(),
	S2C_BOUNTY_FINDMONSTER_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_FINDMONSTER_FIND_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_FINDMONSTER_MONSTER_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_SHAREMONSTER_ME = protobuf.Descriptor(),
	C2S_BOUNTY_SHAREMONSTER_ID_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_SHAREMONSTER_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_SHAREMONSTER_ME = protobuf.Descriptor(),
	S2C_BOUNTY_SHAREMONSTER_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_SHAREMONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_SHAREMONSTER_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_SHAREMONSTER_ERROR_RET_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETSHAREMONSTERLIST_ME = protobuf.Descriptor(),
	C2S_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETSHAREMONSTERLIST_STAR_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETSHAREMONSTERLIST_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETSHAREMONSTERLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETSHAREMONSTERLIST_MONSTERS_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETSHAREMONSTERLIST_STAR_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_STAR_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_MONSTERSHAREAWARD_ME = protobuf.Descriptor(),
	C2S_BOUNTY_MONSTERSHAREAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_MONSTERSHAREAWARD_ME = protobuf.Descriptor(),
	S2C_BOUNTY_MONSTERSHAREAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_MONSTERSHAREAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_MONSTERSHAREAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETUSERDAILYSCORE_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETUSERDAILYSCORE_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETUSERDAILYSCORE_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETUSERDAILYSCORE_USER_DAILY_SCORE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETUSERDAILYSCORE_AWARD_DAILY_SCORE_USER_IDS_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETUSERDAILYSCORE_TODAY_JOIN_GUILD_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_DAILYSCOREAWARD_ME = protobuf.Descriptor(),
	C2S_BOUNTY_DAILYSCOREAWARD_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_DAILYSCOREAWARD_ME = protobuf.Descriptor(),
	S2C_BOUNTY_DAILYSCOREAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_DAILYSCOREAWARD_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_DAILYSCOREAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_BOUNTY_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_CHALLENGEBEGIN_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_BOUNTY_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEBEGIN_ERROR_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEBEGIN_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_DAILY_HELP_SCORE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_CHALLENGEFINISH_ERROR_RET_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETGUILDRANK_ME = protobuf.Descriptor(),
	C2S_BOUNTY_GETGUILDRANK_SIZE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETGUILDRANK_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETGUILDRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETGUILDRANK_SIZE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETGUILDRANK_UNITS_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETGUILDRANK_SELF_GUILD_RANK_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_BOUNTY_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_BOUNTY_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETMONSTERINFO_ME = protobuf.Descriptor(),
	C2S_BOUNTY_GETMONSTERINFO_ID_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETMONSTERINFO_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERINFO_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETMONSTERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERINFO_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERINFO_MONSTER_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETMONSTERDETAILINFO_ME = protobuf.Descriptor(),
	C2S_BOUNTY_GETMONSTERDETAILINFO_ID_F = protobuf.FieldDescriptor(),
	C2S_BOUNTY_GETMONSTERDETAILINFO_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_ME = protobuf.Descriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_UNIT_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_ERROR_RET_F = protobuf.FieldDescriptor(),
	S2C_BOUNTY_GETMONSTERDETAILINFO_SHARE_TYPE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_GETINFO_ME, {
	"C2S_Bounty_GetInfo",
	".cs.C2S_Bounty_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Bounty_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_ACT_INFO_F, {
	"act_info",
	".cs.S2C_Bounty_GetInfo.act_info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.BOUNTYACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_MONSTERS_F, {
	"monsters",
	".cs.S2C_Bounty_GetInfo.monsters",
	3,
	2,
	3,
	false,
	{},
	var_0_3.BOUNTYMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_SCORE_F, {
	"score",
	".cs.S2C_Bounty_GetInfo.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_TIMES_F, {
	"times",
	".cs.S2C_Bounty_GetInfo.times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_Bounty_GetInfo.tasks",
	6,
	5,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_DAILY_HELP_SCORE_F, {
	"daily_help_score",
	".cs.S2C_Bounty_GetInfo.daily_help_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_SHARE_TYPE_STAR_F, {
	"share_type_star",
	".cs.S2C_Bounty_GetInfo.share_type_star",
	8,
	7,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_GETINFO_ME, {
	"S2C_Bounty_GetInfo",
	".cs.S2C_Bounty_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_GETINFO_RET_F,
		var_0_10.S2C_BOUNTY_GETINFO_ACT_INFO_F,
		var_0_10.S2C_BOUNTY_GETINFO_MONSTERS_F,
		var_0_10.S2C_BOUNTY_GETINFO_SCORE_F,
		var_0_10.S2C_BOUNTY_GETINFO_TIMES_F,
		var_0_10.S2C_BOUNTY_GETINFO_TASKS_F,
		var_0_10.S2C_BOUNTY_GETINFO_DAILY_HELP_SCORE_F,
		var_0_10.S2C_BOUNTY_GETINFO_SHARE_TYPE_STAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_FINDMONSTER_FIND_TYPE_F, {
	"find_type",
	".cs.C2S_Bounty_FindMonster.find_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_FINDMONSTER_ME, {
	"C2S_Bounty_FindMonster",
	".cs.C2S_Bounty_FindMonster",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_FINDMONSTER_FIND_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_FINDMONSTER_RET_F, {
	"ret",
	".cs.S2C_Bounty_FindMonster.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_FINDMONSTER_FIND_TYPE_F, {
	"find_type",
	".cs.S2C_Bounty_FindMonster.find_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_FINDMONSTER_MONSTER_F, {
	"monster",
	".cs.S2C_Bounty_FindMonster.monster",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.BOUNTYMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_FINDMONSTER_ME, {
	"S2C_Bounty_FindMonster",
	".cs.S2C_Bounty_FindMonster",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_FINDMONSTER_RET_F,
		var_0_10.S2C_BOUNTY_FINDMONSTER_FIND_TYPE_F,
		var_0_10.S2C_BOUNTY_FINDMONSTER_MONSTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_SHAREMONSTER_ID_F, {
	"id",
	".cs.C2S_Bounty_ShareMonster.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_SHAREMONSTER_SHARE_TYPE_F, {
	"share_type",
	".cs.C2S_Bounty_ShareMonster.share_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_SHAREMONSTER_ME, {
	"C2S_Bounty_ShareMonster",
	".cs.C2S_Bounty_ShareMonster",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_SHAREMONSTER_ID_F,
		var_0_10.C2S_BOUNTY_SHAREMONSTER_SHARE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_SHAREMONSTER_RET_F, {
	"ret",
	".cs.S2C_Bounty_ShareMonster.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_SHAREMONSTER_ID_F, {
	"id",
	".cs.S2C_Bounty_ShareMonster.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_SHAREMONSTER_SHARE_TYPE_F, {
	"share_type",
	".cs.S2C_Bounty_ShareMonster.share_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_SHAREMONSTER_ERROR_RET_F, {
	"error_ret",
	".cs.S2C_Bounty_ShareMonster.error_ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_SHAREMONSTER_ME, {
	"S2C_Bounty_ShareMonster",
	".cs.S2C_Bounty_ShareMonster",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_SHAREMONSTER_RET_F,
		var_0_10.S2C_BOUNTY_SHAREMONSTER_ID_F,
		var_0_10.S2C_BOUNTY_SHAREMONSTER_SHARE_TYPE_F,
		var_0_10.S2C_BOUNTY_SHAREMONSTER_ERROR_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_F, {
	"share_type",
	".cs.C2S_Bounty_GetShareMonsterList.share_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETSHAREMONSTERLIST_STAR_F, {
	"star",
	".cs.C2S_Bounty_GetShareMonsterList.star",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_GETSHAREMONSTERLIST_ME, {
	"C2S_Bounty_GetShareMonsterList",
	".cs.C2S_Bounty_GetShareMonsterList",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_F,
		var_0_10.C2S_BOUNTY_GETSHAREMONSTERLIST_STAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_RET_F, {
	"ret",
	".cs.S2C_Bounty_GetShareMonsterList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_F, {
	"share_type",
	".cs.S2C_Bounty_GetShareMonsterList.share_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_MONSTERS_F, {
	"monsters",
	".cs.S2C_Bounty_GetShareMonsterList.monsters",
	3,
	2,
	3,
	false,
	{},
	var_0_3.BOUNTYMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_STAR_F, {
	"star",
	".cs.S2C_Bounty_GetShareMonsterList.star",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_STAR_F, {
	"share_type_star",
	".cs.S2C_Bounty_GetShareMonsterList.share_type_star",
	5,
	4,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_ME, {
	"S2C_Bounty_GetShareMonsterList",
	".cs.S2C_Bounty_GetShareMonsterList",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_RET_F,
		var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_F,
		var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_MONSTERS_F,
		var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_STAR_F,
		var_0_10.S2C_BOUNTY_GETSHAREMONSTERLIST_SHARE_TYPE_STAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_MONSTERSHAREAWARD_ID_F, {
	"id",
	".cs.C2S_Bounty_MonsterShareAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_MONSTERSHAREAWARD_ME, {
	"C2S_Bounty_MonsterShareAward",
	".cs.C2S_Bounty_MonsterShareAward",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_MONSTERSHAREAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_RET_F, {
	"ret",
	".cs.S2C_Bounty_MonsterShareAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_ID_F, {
	"id",
	".cs.S2C_Bounty_MonsterShareAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Bounty_MonsterShareAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_ME, {
	"S2C_Bounty_MonsterShareAward",
	".cs.S2C_Bounty_MonsterShareAward",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_RET_F,
		var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_ID_F,
		var_0_10.S2C_BOUNTY_MONSTERSHAREAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_GETUSERDAILYSCORE_ME, {
	"C2S_Bounty_GetUserDailyScore",
	".cs.C2S_Bounty_GetUserDailyScore",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_RET_F, {
	"ret",
	".cs.S2C_Bounty_GetUserDailyScore.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_USER_DAILY_SCORE_F, {
	"user_daily_score",
	".cs.S2C_Bounty_GetUserDailyScore.user_daily_score",
	2,
	1,
	3,
	false,
	{},
	var_0_3.BOUNTYUSERDAILYSCORE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_AWARD_DAILY_SCORE_USER_IDS_F, {
	"award_daily_score_user_ids",
	".cs.S2C_Bounty_GetUserDailyScore.award_daily_score_user_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_TODAY_JOIN_GUILD_F, {
	"today_join_guild",
	".cs.S2C_Bounty_GetUserDailyScore.today_join_guild",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_ME, {
	"S2C_Bounty_GetUserDailyScore",
	".cs.S2C_Bounty_GetUserDailyScore",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_RET_F,
		var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_USER_DAILY_SCORE_F,
		var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_AWARD_DAILY_SCORE_USER_IDS_F,
		var_0_10.S2C_BOUNTY_GETUSERDAILYSCORE_TODAY_JOIN_GUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_DAILYSCOREAWARD_USER_ID_F, {
	"user_id",
	".cs.C2S_Bounty_DailyScoreAward.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_DAILYSCOREAWARD_ME, {
	"C2S_Bounty_DailyScoreAward",
	".cs.C2S_Bounty_DailyScoreAward",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_DAILYSCOREAWARD_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_RET_F, {
	"ret",
	".cs.S2C_Bounty_DailyScoreAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_USER_ID_F, {
	"user_id",
	".cs.S2C_Bounty_DailyScoreAward.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Bounty_DailyScoreAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_ME, {
	"S2C_Bounty_DailyScoreAward",
	".cs.S2C_Bounty_DailyScoreAward",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_RET_F,
		var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_USER_ID_F,
		var_0_10.S2C_BOUNTY_DAILYSCOREAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.C2S_Bounty_ChallengeBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_CHALLENGEBEGIN_SHARE_TYPE_F, {
	"share_type",
	".cs.C2S_Bounty_ChallengeBegin.share_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_CHALLENGEBEGIN_ME, {
	"C2S_Bounty_ChallengeBegin",
	".cs.C2S_Bounty_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_CHALLENGEBEGIN_ID_F,
		var_0_10.C2S_BOUNTY_CHALLENGEBEGIN_SHARE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Bounty_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.S2C_Bounty_ChallengeBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Bounty_ChallengeBegin.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_ERROR_RET_F, {
	"error_ret",
	".cs.S2C_Bounty_ChallengeBegin.error_ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_SHARE_TYPE_F, {
	"share_type",
	".cs.S2C_Bounty_ChallengeBegin.share_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_ME, {
	"S2C_Bounty_ChallengeBegin",
	".cs.S2C_Bounty_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_ID_F,
		var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_BATTLE_ID_F,
		var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_ERROR_RET_F,
		var_0_10.S2C_BOUNTY_CHALLENGEBEGIN_SHARE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Bounty_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_ID_F, {
	"id",
	".cs.S2C_Bounty_ChallengeFinish.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Bounty_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Bounty_ChallengeFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_DAILY_HELP_SCORE_F, {
	"daily_help_score",
	".cs.S2C_Bounty_ChallengeFinish.daily_help_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_ERROR_RET_F, {
	"error_ret",
	".cs.S2C_Bounty_ChallengeFinish.error_ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_CHALLENGEFINISH_ME, {
	"S2C_Bounty_ChallengeFinish",
	".cs.S2C_Bounty_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_BOUNTY_CHALLENGEFINISH_ID_F,
		var_0_10.S2C_BOUNTY_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_BOUNTY_CHALLENGEFINISH_AWARDS_F,
		var_0_10.S2C_BOUNTY_CHALLENGEFINISH_DAILY_HELP_SCORE_F,
		var_0_10.S2C_BOUNTY_CHALLENGEFINISH_ERROR_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETGUILDRANK_SIZE_F, {
	"size",
	".cs.C2S_Bounty_GetGuildRank.size",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_GETGUILDRANK_ME, {
	"C2S_Bounty_GetGuildRank",
	".cs.C2S_Bounty_GetGuildRank",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_GETGUILDRANK_SIZE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETGUILDRANK_RET_F, {
	"ret",
	".cs.S2C_Bounty_GetGuildRank.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETGUILDRANK_SIZE_F, {
	"size",
	".cs.S2C_Bounty_GetGuildRank.size",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETGUILDRANK_UNITS_F, {
	"units",
	".cs.S2C_Bounty_GetGuildRank.units",
	3,
	2,
	3,
	false,
	{},
	var_0_3.BOUNTYGUILDSCORERANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETGUILDRANK_SELF_GUILD_RANK_F, {
	"self_guild_rank",
	".cs.S2C_Bounty_GetGuildRank.self_guild_rank",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_GETGUILDRANK_ME, {
	"S2C_Bounty_GetGuildRank",
	".cs.S2C_Bounty_GetGuildRank",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_GETGUILDRANK_RET_F,
		var_0_10.S2C_BOUNTY_GETGUILDRANK_SIZE_F,
		var_0_10.S2C_BOUNTY_GETGUILDRANK_UNITS_F,
		var_0_10.S2C_BOUNTY_GETGUILDRANK_SELF_GUILD_RANK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Bounty_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_TASKAWARD_ME, {
	"C2S_Bounty_TaskAward",
	".cs.C2S_Bounty_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Bounty_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Bounty_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Bounty_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_TASKAWARD_ME, {
	"S2C_Bounty_TaskAward",
	".cs.S2C_Bounty_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_TASKAWARD_RET_F,
		var_0_10.S2C_BOUNTY_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_BOUNTY_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETMONSTERINFO_ID_F, {
	"id",
	".cs.C2S_Bounty_GetMonsterInfo.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETMONSTERINFO_SHARE_TYPE_F, {
	"share_type",
	".cs.C2S_Bounty_GetMonsterInfo.share_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_GETMONSTERINFO_ME, {
	"C2S_Bounty_GetMonsterInfo",
	".cs.C2S_Bounty_GetMonsterInfo",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_GETMONSTERINFO_ID_F,
		var_0_10.C2S_BOUNTY_GETMONSTERINFO_SHARE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERINFO_RET_F, {
	"ret",
	".cs.S2C_Bounty_GetMonsterInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERINFO_ID_F, {
	"id",
	".cs.S2C_Bounty_GetMonsterInfo.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERINFO_SHARE_TYPE_F, {
	"share_type",
	".cs.S2C_Bounty_GetMonsterInfo.share_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERINFO_MONSTER_F, {
	"monster",
	".cs.S2C_Bounty_GetMonsterInfo.monster",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.BOUNTYMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERINFO_ME, {
	"S2C_Bounty_GetMonsterInfo",
	".cs.S2C_Bounty_GetMonsterInfo",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_GETMONSTERINFO_RET_F,
		var_0_10.S2C_BOUNTY_GETMONSTERINFO_ID_F,
		var_0_10.S2C_BOUNTY_GETMONSTERINFO_SHARE_TYPE_F,
		var_0_10.S2C_BOUNTY_GETMONSTERINFO_MONSTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETMONSTERDETAILINFO_ID_F, {
	"id",
	".cs.C2S_Bounty_GetMonsterDetailInfo.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_BOUNTY_GETMONSTERDETAILINFO_SHARE_TYPE_F, {
	"share_type",
	".cs.C2S_Bounty_GetMonsterDetailInfo.share_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_BOUNTY_GETMONSTERDETAILINFO_ME, {
	"C2S_Bounty_GetMonsterDetailInfo",
	".cs.C2S_Bounty_GetMonsterDetailInfo",
	{},
	{},
	{
		var_0_10.C2S_BOUNTY_GETMONSTERDETAILINFO_ID_F,
		var_0_10.C2S_BOUNTY_GETMONSTERDETAILINFO_SHARE_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_RET_F, {
	"ret",
	".cs.S2C_Bounty_GetMonsterDetailInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_ID_F, {
	"id",
	".cs.S2C_Bounty_GetMonsterDetailInfo.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_FIGHT_VALUE_F, {
	"fight_value",
	".cs.S2C_Bounty_GetMonsterDetailInfo.fight_value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_UNIT_F, {
	"unit",
	".cs.S2C_Bounty_GetMonsterDetailInfo.unit",
	4,
	3,
	3,
	false,
	{},
	var_0_3.BOUNTYMONSTERUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_ERROR_RET_F, {
	"error_ret",
	".cs.S2C_Bounty_GetMonsterDetailInfo.error_ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_SHARE_TYPE_F, {
	"share_type",
	".cs.S2C_Bounty_GetMonsterDetailInfo.share_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_ME, {
	"S2C_Bounty_GetMonsterDetailInfo",
	".cs.S2C_Bounty_GetMonsterDetailInfo",
	{},
	{},
	{
		var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_RET_F,
		var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_ID_F,
		var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_FIGHT_VALUE_F,
		var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_UNIT_F,
		var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_ERROR_RET_F,
		var_0_10.S2C_BOUNTY_GETMONSTERDETAILINFO_SHARE_TYPE_F
	},
	false,
	{}
})

return var_0_10
