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
	C2S_ELDERBOSS_ENTER_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_ENTER_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_ENTER_BOSS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_ENTER_USER_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_ENTER_SHOW_USERS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_ENTER_RANK_USERS_F = protobuf.FieldDescriptor(),
	C2S_ELDERBOSS_GETREPORT_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_GETREPORT_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_GETREPORT_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_GETREPORT_REPORTS_F = protobuf.FieldDescriptor(),
	C2S_ELDERBOSS_CHOOSEBUFF_ME = protobuf.Descriptor(),
	C2S_ELDERBOSS_CHOOSEBUFF_BUFF_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHOOSEBUFF_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_CHOOSEBUFF_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHOOSEBUFF_BUFF_F = protobuf.FieldDescriptor(),
	C2S_ELDERBOSS_EXIT_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_EXIT_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_EXIT_RET_F = protobuf.FieldDescriptor(),
	C2S_ELDERBOSS_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_HONOR_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_OLD_MAX_RANK_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_NEW_MAX_RANK_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_OLD_TOTAL_RANK_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_NEW_TOTAL_RANK_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_CHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_LUCKY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_GUILD_HONOR_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGEFINISH_GUILD_RANK_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_BUFF_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_BOSS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_HONOR_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_CHALLENGENOTIFY_LUCKY_F = protobuf.FieldDescriptor(),
	C2S_ELDERBOSS_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_ELDERBOSS_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ELDERBOSS_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_ELDERBOSS_SERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_ELDERBOSS_SERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_ENTER_ME, {
	"C2S_ElderBoss_Enter",
	".cs.C2S_ElderBoss_Enter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_ENTER_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_ENTER_BOSS_F, {
	"boss",
	".cs.S2C_ElderBoss_Enter.boss",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ELDERBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_ENTER_USER_F, {
	"user",
	".cs.S2C_ElderBoss_Enter.user",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.USERELDERBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_ENTER_SHOW_USERS_F, {
	"show_users",
	".cs.S2C_ElderBoss_Enter.show_users",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_ENTER_RANK_USERS_F, {
	"rank_users",
	".cs.S2C_ElderBoss_Enter.rank_users",
	5,
	4,
	3,
	false,
	{},
	var_0_3.ELDERBOSSRANKUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_ENTER_ME, {
	"S2C_ElderBoss_Enter",
	".cs.S2C_ElderBoss_Enter",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_ENTER_RET_F,
		var_0_10.S2C_ELDERBOSS_ENTER_BOSS_F,
		var_0_10.S2C_ELDERBOSS_ENTER_USER_F,
		var_0_10.S2C_ELDERBOSS_ENTER_SHOW_USERS_F,
		var_0_10.S2C_ELDERBOSS_ENTER_RANK_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_GETREPORT_ME, {
	"C2S_ElderBoss_GetReport",
	".cs.C2S_ElderBoss_GetReport",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_GETREPORT_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_GetReport.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_GETREPORT_REPORTS_F, {
	"reports",
	".cs.S2C_ElderBoss_GetReport.reports",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ELDERBOSSREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_GETREPORT_ME, {
	"S2C_ElderBoss_GetReport",
	".cs.S2C_ElderBoss_GetReport",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_GETREPORT_RET_F,
		var_0_10.S2C_ELDERBOSS_GETREPORT_REPORTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ELDERBOSS_CHOOSEBUFF_BUFF_F, {
	"buff",
	".cs.C2S_ElderBoss_ChooseBuff.buff",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_CHOOSEBUFF_ME, {
	"C2S_ElderBoss_ChooseBuff",
	".cs.C2S_ElderBoss_ChooseBuff",
	{},
	{},
	{
		var_0_10.C2S_ELDERBOSS_CHOOSEBUFF_BUFF_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHOOSEBUFF_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_ChooseBuff.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHOOSEBUFF_BUFF_F, {
	"buff",
	".cs.S2C_ElderBoss_ChooseBuff.buff",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_CHOOSEBUFF_ME, {
	"S2C_ElderBoss_ChooseBuff",
	".cs.S2C_ElderBoss_ChooseBuff",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_CHOOSEBUFF_RET_F,
		var_0_10.S2C_ELDERBOSS_CHOOSEBUFF_BUFF_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_EXIT_ME, {
	"C2S_ElderBoss_Exit",
	".cs.C2S_ElderBoss_Exit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_EXIT_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_Exit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_EXIT_ME, {
	"S2C_ElderBoss_Exit",
	".cs.S2C_ElderBoss_Exit",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_EXIT_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_CHALLENGEBEGIN_ME, {
	"C2S_ElderBoss_ChallengeBegin",
	".cs.C2S_ElderBoss_ChallengeBegin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_ElderBoss_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEBEGIN_ME, {
	"S2C_ElderBoss_ChallengeBegin",
	".cs.S2C_ElderBoss_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_DAMAGE_F, {
	"damage",
	".cs.S2C_ElderBoss_ChallengeFinish.damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_HONOR_F, {
	"honor",
	".cs.S2C_ElderBoss_ChallengeFinish.honor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_OLD_MAX_RANK_F, {
	"old_max_rank",
	".cs.S2C_ElderBoss_ChallengeFinish.old_max_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_NEW_MAX_RANK_F, {
	"new_max_rank",
	".cs.S2C_ElderBoss_ChallengeFinish.new_max_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_OLD_TOTAL_RANK_F, {
	"old_total_rank",
	".cs.S2C_ElderBoss_ChallengeFinish.old_total_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_NEW_TOTAL_RANK_F, {
	"new_total_rank",
	".cs.S2C_ElderBoss_ChallengeFinish.new_total_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_CHALLENGE_AWARDS_F, {
	"challenge_awards",
	".cs.S2C_ElderBoss_ChallengeFinish.challenge_awards",
	8,
	7,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_LUCKY_AWARDS_F, {
	"lucky_awards",
	".cs.S2C_ElderBoss_ChallengeFinish.lucky_awards",
	9,
	8,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_GUILD_HONOR_F, {
	"guild_honor",
	".cs.S2C_ElderBoss_ChallengeFinish.guild_honor",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_GUILD_RANK_F, {
	"guild_rank",
	".cs.S2C_ElderBoss_ChallengeFinish.guild_rank",
	11,
	10,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_ME, {
	"S2C_ElderBoss_ChallengeFinish",
	".cs.S2C_ElderBoss_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_DAMAGE_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_HONOR_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_OLD_MAX_RANK_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_NEW_MAX_RANK_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_OLD_TOTAL_RANK_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_NEW_TOTAL_RANK_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_CHALLENGE_AWARDS_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_LUCKY_AWARDS_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_GUILD_HONOR_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGEFINISH_GUILD_RANK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_USER_ID_F, {
	"user_id",
	".cs.S2C_ElderBoss_ChallengeNotify.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_BUFF_F, {
	"buff",
	".cs.S2C_ElderBoss_ChallengeNotify.buff",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_BOSS_F, {
	"boss",
	".cs.S2C_ElderBoss_ChallengeNotify.boss",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.ELDERBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_DAMAGE_F, {
	"damage",
	".cs.S2C_ElderBoss_ChallengeNotify.damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_HONOR_F, {
	"honor",
	".cs.S2C_ElderBoss_ChallengeNotify.honor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_LUCKY_F, {
	"lucky",
	".cs.S2C_ElderBoss_ChallengeNotify.lucky",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_ME, {
	"S2C_ElderBoss_ChallengeNotify",
	".cs.S2C_ElderBoss_ChallengeNotify",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_USER_ID_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_BUFF_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_BOSS_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_DAMAGE_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_HONOR_F,
		var_0_10.S2C_ELDERBOSS_CHALLENGENOTIFY_LUCKY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ELDERBOSS_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_ElderBoss_TaskAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_TASKAWARD_ME, {
	"C2S_ElderBoss_TaskAward",
	".cs.C2S_ElderBoss_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_ELDERBOSS_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_ElderBoss_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_ElderBoss_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_TASKAWARD_ME, {
	"S2C_ElderBoss_TaskAward",
	".cs.S2C_ElderBoss_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_TASKAWARD_RET_F,
		var_0_10.S2C_ELDERBOSS_TASKAWARD_IDS_F,
		var_0_10.S2C_ELDERBOSS_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ELDERBOSS_SERVERINFOS_ME, {
	"C2S_ElderBoss_ServerInfos",
	".cs.C2S_ElderBoss_ServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_SERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_ElderBoss_ServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ELDERBOSS_SERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_ElderBoss_ServerInfos.server_infos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ELDERBOSS_SERVERINFOS_ME, {
	"S2C_ElderBoss_ServerInfos",
	".cs.S2C_ElderBoss_ServerInfos",
	{},
	{},
	{
		var_0_10.S2C_ELDERBOSS_SERVERINFOS_RET_F,
		var_0_10.S2C_ELDERBOSS_SERVERINFOS_SERVER_INFOS_F
	},
	false,
	{}
})

return var_0_10
