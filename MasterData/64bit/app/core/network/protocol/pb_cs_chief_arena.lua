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
	C2S_CHIEFARENA_GETINFO_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GETINFO_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_HISTORY_MAX_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_GUIDE_FINISH_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_MATCH_UNITS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_BUFF_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_GUILD_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_GUILD_RANK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETINFO_LAST_SEASON_RANK_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GETRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETRANKLIST_UNITS_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_CHIEFARENA_CHALLENGEBEGIN_RANK_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEBEGIN_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_MULTI_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_CHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_TURN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_BREAK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_WAVE_UNITS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_CHALLENGEFINISH_GUILD_RATE_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_ONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	C2S_CHIEFARENA_ONEKEYCHALLENGE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_ONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_ONEKEYCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_ONEKEYCHALLENGE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_ONEKEYCHALLENGE_CHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_ONEKEYCHALLENGE_TURN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_ONEKEYCHALLENGE_GUILD_RATE_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GETSERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETSERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GETSERVERINFOS_SID_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_NOTICEACTIVITY_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_NOTICEACTIVITY_ACTIVITY_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_GUILDRANK_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDRANK_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDRANK_LIST_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDRANK_RANK_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_GUILDHONORRANK_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDHONORRANK_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDHONORRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDHONORRANK_GUILD_HONOR_RANKS_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_GUILDRANKAWARD_ME = protobuf.Descriptor(),
	C2S_CHIEFARENA_GUILDRANKAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDRANKAWARD_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDRANKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDRANKAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDRANKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_GUILDSKILL_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDSKILL_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_GUILDSKILL_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_GUILDSKILL_GUILD_SKILLS_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_OTHERGUILDSKILL_ME = protobuf.Descriptor(),
	C2S_CHIEFARENA_OTHERGUILDSKILL_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_OTHERGUILDSKILL_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_OTHERGUILDSKILL_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_OTHERGUILDSKILL_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_OTHERGUILDSKILL_SKILLS_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_SKILLLEVELUP_ME = protobuf.Descriptor(),
	C2S_CHIEFARENA_SKILLLEVELUP_GROUP_F = protobuf.FieldDescriptor(),
	C2S_CHIEFARENA_SKILLLEVELUP_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_SKILLLEVELUP_ME = protobuf.Descriptor(),
	S2C_CHIEFARENA_SKILLLEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIEFARENA_SKILLLEVELUP_SKILL_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GETINFO_ME, {
	"C2S_ChiefArena_GetInfo",
	".cs.C2S_ChiefArena_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_RANK_F, {
	"rank",
	".cs.S2C_ChiefArena_GetInfo.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_HISTORY_MAX_RANK_F, {
	"history_max_rank",
	".cs.S2C_ChiefArena_GetInfo.history_max_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_GUIDE_FINISH_F, {
	"guide_finish",
	".cs.S2C_ChiefArena_GetInfo.guide_finish",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_MATCH_UNITS_F, {
	"match_units",
	".cs.S2C_ChiefArena_GetInfo.match_units",
	5,
	4,
	3,
	false,
	{},
	var_0_3.CHIEFARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_BUFF_F, {
	"buff",
	".cs.S2C_ChiefArena_GetInfo.buff",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_GUILD_RANK_F, {
	"guild_rank",
	".cs.S2C_ChiefArena_GetInfo.guild_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_GUILD_RANK_AWARDS_F, {
	"guild_rank_awards",
	".cs.S2C_ChiefArena_GetInfo.guild_rank_awards",
	8,
	7,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_LAST_SEASON_RANK_F, {
	"last_season_rank",
	".cs.S2C_ChiefArena_GetInfo.last_season_rank",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GETINFO_ME, {
	"S2C_ChiefArena_GetInfo",
	".cs.S2C_ChiefArena_GetInfo",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GETINFO_RET_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_RANK_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_HISTORY_MAX_RANK_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_GUIDE_FINISH_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_MATCH_UNITS_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_BUFF_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_GUILD_RANK_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_GUILD_RANK_AWARDS_F,
		var_0_9.S2C_CHIEFARENA_GETINFO_LAST_SEASON_RANK_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GETRANKLIST_ME, {
	"C2S_ChiefArena_GetRankList",
	".cs.C2S_ChiefArena_GetRankList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETRANKLIST_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GetRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETRANKLIST_UNITS_F, {
	"units",
	".cs.S2C_ChiefArena_GetRankList.units",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CHIEFARENAUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GETRANKLIST_ME, {
	"S2C_ChiefArena_GetRankList",
	".cs.S2C_ChiefArena_GetRankList",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GETRANKLIST_RET_F,
		var_0_9.S2C_CHIEFARENA_GETRANKLIST_UNITS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_CHALLENGEBEGIN_RANK_F, {
	"rank",
	".cs.C2S_ChiefArena_ChallengeBegin.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.C2S_ChiefArena_ChallengeBegin.id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_CHALLENGEBEGIN_ME, {
	"C2S_ChiefArena_ChallengeBegin",
	".cs.C2S_ChiefArena_ChallengeBegin",
	{},
	{},
	{
		var_0_9.C2S_CHIEFARENA_CHALLENGEBEGIN_RANK_F,
		var_0_9.C2S_CHIEFARENA_CHALLENGEBEGIN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_RANK_F, {
	"rank",
	".cs.S2C_ChiefArena_ChallengeBegin.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.S2C_ChiefArena_ChallengeBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_ChiefArena_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_ME, {
	"S2C_ChiefArena_ChallengeBegin",
	".cs.S2C_ChiefArena_ChallengeBegin",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_RET_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_RANK_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_ID_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_RANK_F, {
	"rank",
	".cs.S2C_ChiefArena_ChallengeFinish.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_ChiefArena_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_MULTI_RESULT_F, {
	"multi_result",
	".cs.S2C_ChiefArena_ChallengeFinish.multi_result",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_CHALLENGE_AWARDS_F, {
	"challenge_awards",
	".cs.S2C_ChiefArena_ChallengeFinish.challenge_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_TURN_AWARDS_F, {
	"turn_awards",
	".cs.S2C_ChiefArena_ChallengeFinish.turn_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_BREAK_AWARDS_F, {
	"break_awards",
	".cs.S2C_ChiefArena_ChallengeFinish.break_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_WAVE_UNITS_F, {
	"wave_units",
	".cs.S2C_ChiefArena_ChallengeFinish.wave_units",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_GUILD_RATE_F, {
	"guild_rate",
	".cs.S2C_ChiefArena_ChallengeFinish.guild_rate",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_ME, {
	"S2C_ChiefArena_ChallengeFinish",
	".cs.S2C_ChiefArena_ChallengeFinish",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_RET_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_RANK_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_IS_WIN_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_MULTI_RESULT_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_CHALLENGE_AWARDS_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_TURN_AWARDS_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_BREAK_AWARDS_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_WAVE_UNITS_F,
		var_0_9.S2C_CHIEFARENA_CHALLENGEFINISH_GUILD_RATE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_ONEKEYCHALLENGE_TIMES_F, {
	"times",
	".cs.C2S_ChiefArena_OneKeyChallenge.times",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_ONEKEYCHALLENGE_ME, {
	"C2S_ChiefArena_OneKeyChallenge",
	".cs.C2S_ChiefArena_OneKeyChallenge",
	{},
	{},
	{
		var_0_9.C2S_CHIEFARENA_ONEKEYCHALLENGE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_OneKeyChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_TIMES_F, {
	"times",
	".cs.S2C_ChiefArena_OneKeyChallenge.times",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_CHALLENGE_AWARDS_F, {
	"challenge_awards",
	".cs.S2C_ChiefArena_OneKeyChallenge.challenge_awards",
	4,
	2,
	3,
	false,
	{},
	var_0_3.AWARDS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_TURN_AWARDS_F, {
	"turn_awards",
	".cs.S2C_ChiefArena_OneKeyChallenge.turn_awards",
	5,
	3,
	3,
	false,
	{},
	var_0_3.AWARDS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_GUILD_RATE_F, {
	"guild_rate",
	".cs.S2C_ChiefArena_OneKeyChallenge.guild_rate",
	6,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_ME, {
	"S2C_ChiefArena_OneKeyChallenge",
	".cs.S2C_ChiefArena_OneKeyChallenge",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_RET_F,
		var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_TIMES_F,
		var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_CHALLENGE_AWARDS_F,
		var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_TURN_AWARDS_F,
		var_0_9.S2C_CHIEFARENA_ONEKEYCHALLENGE_GUILD_RATE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GETSERVERINFOS_ME, {
	"C2S_ChiefArena_GetServerInfos",
	".cs.C2S_ChiefArena_GetServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GetServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_ChiefArena_GetServerInfos.server_infos",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_ChiefArena_GetServerInfos.sid",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_ME, {
	"S2C_ChiefArena_GetServerInfos",
	".cs.S2C_ChiefArena_GetServerInfos",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_RET_F,
		var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_SERVER_INFOS_F,
		var_0_9.S2C_CHIEFARENA_GETSERVERINFOS_SID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_NOTICEACTIVITY_ACTIVITY_F, {
	"activity",
	".cs.S2C_ChiefArena_NoticeActivity.activity",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.CHIEFARENAACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_NOTICEACTIVITY_ME, {
	"S2C_ChiefArena_NoticeActivity",
	".cs.S2C_ChiefArena_NoticeActivity",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_NOTICEACTIVITY_ACTIVITY_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GUILDRANK_ME, {
	"C2S_ChiefArena_GuildRank",
	".cs.C2S_ChiefArena_GuildRank",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANK_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GuildRank.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANK_LIST_F, {
	"list",
	".cs.S2C_ChiefArena_GuildRank.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CHIEFARENAGUILDRANK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANK_RANK_F, {
	"rank",
	".cs.S2C_ChiefArena_GuildRank.rank",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANK_ME, {
	"S2C_ChiefArena_GuildRank",
	".cs.S2C_ChiefArena_GuildRank",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GUILDRANK_RET_F,
		var_0_9.S2C_CHIEFARENA_GUILDRANK_LIST_F,
		var_0_9.S2C_CHIEFARENA_GUILDRANK_RANK_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GUILDHONORRANK_ME, {
	"C2S_ChiefArena_GuildHonorRank",
	".cs.C2S_ChiefArena_GuildHonorRank",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDHONORRANK_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GuildHonorRank.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDHONORRANK_GUILD_HONOR_RANKS_F, {
	"guild_honor_ranks",
	".cs.S2C_ChiefArena_GuildHonorRank.guild_honor_ranks",
	9,
	1,
	3,
	false,
	{},
	var_0_3.CHIEFARENAGUILDHONORRANK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDHONORRANK_ME, {
	"S2C_ChiefArena_GuildHonorRank",
	".cs.S2C_ChiefArena_GuildHonorRank",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GUILDHONORRANK_RET_F,
		var_0_9.S2C_CHIEFARENA_GUILDHONORRANK_GUILD_HONOR_RANKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_GUILDRANKAWARD_INDEX_F, {
	"index",
	".cs.C2S_ChiefArena_GuildRankAward.index",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GUILDRANKAWARD_ME, {
	"C2S_ChiefArena_GuildRankAward",
	".cs.C2S_ChiefArena_GuildRankAward",
	{},
	{},
	{
		var_0_9.C2S_CHIEFARENA_GUILDRANKAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GuildRankAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_INDEX_F, {
	"index",
	".cs.S2C_ChiefArena_GuildRankAward.index",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_ChiefArena_GuildRankAward.awards",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_ME, {
	"S2C_ChiefArena_GuildRankAward",
	".cs.S2C_ChiefArena_GuildRankAward",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_RET_F,
		var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_INDEX_F,
		var_0_9.S2C_CHIEFARENA_GUILDRANKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_GUILDSKILL_ME, {
	"C2S_ChiefArena_GuildSkill",
	".cs.C2S_ChiefArena_GuildSkill",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDSKILL_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_GuildSkill.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDSKILL_GUILD_SKILLS_F, {
	"guild_skills",
	".cs.S2C_ChiefArena_GuildSkill.guild_skills",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CHIEFARENAGUILDSKILL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_GUILDSKILL_ME, {
	"S2C_ChiefArena_GuildSkill",
	".cs.S2C_ChiefArena_GuildSkill",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_GUILDSKILL_RET_F,
		var_0_9.S2C_CHIEFARENA_GUILDSKILL_GUILD_SKILLS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_OTHERGUILDSKILL_TARGET_ID_F, {
	"target_id",
	".cs.C2S_ChiefArena_OtherGuildSkill.target_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_OTHERGUILDSKILL_ME, {
	"C2S_ChiefArena_OtherGuildSkill",
	".cs.C2S_ChiefArena_OtherGuildSkill",
	{},
	{},
	{
		var_0_9.C2S_CHIEFARENA_OTHERGUILDSKILL_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_OtherGuildSkill.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_TARGET_ID_F, {
	"target_id",
	".cs.S2C_ChiefArena_OtherGuildSkill.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_SKILLS_F, {
	"skills",
	".cs.S2C_ChiefArena_OtherGuildSkill.skills",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_ME, {
	"S2C_ChiefArena_OtherGuildSkill",
	".cs.S2C_ChiefArena_OtherGuildSkill",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_RET_F,
		var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_TARGET_ID_F,
		var_0_9.S2C_CHIEFARENA_OTHERGUILDSKILL_SKILLS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_SKILLLEVELUP_GROUP_F, {
	"group",
	".cs.C2S_ChiefArena_SkillLevelUp.group",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_CHIEFARENA_SKILLLEVELUP_NUM_F, {
	"num",
	".cs.C2S_ChiefArena_SkillLevelUp.num",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_CHIEFARENA_SKILLLEVELUP_ME, {
	"C2S_ChiefArena_SkillLevelUp",
	".cs.C2S_ChiefArena_SkillLevelUp",
	{},
	{},
	{
		var_0_9.C2S_CHIEFARENA_SKILLLEVELUP_GROUP_F,
		var_0_9.C2S_CHIEFARENA_SKILLLEVELUP_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_SKILLLEVELUP_RET_F, {
	"ret",
	".cs.S2C_ChiefArena_SkillLevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_CHIEFARENA_SKILLLEVELUP_SKILL_F, {
	"skill",
	".cs.S2C_ChiefArena_SkillLevelUp.skill",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.CHIEFARENAGUILDSKILL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_CHIEFARENA_SKILLLEVELUP_ME, {
	"S2C_ChiefArena_SkillLevelUp",
	".cs.S2C_ChiefArena_SkillLevelUp",
	{},
	{},
	{
		var_0_9.S2C_CHIEFARENA_SKILLLEVELUP_RET_F,
		var_0_9.S2C_CHIEFARENA_SKILLLEVELUP_SKILL_F
	},
	false,
	{}
})

return var_0_9
