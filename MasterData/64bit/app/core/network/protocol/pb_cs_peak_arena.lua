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
	C2S_PEAKARENA_GETACTIVITYINFO_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETACTIVITYINFO_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETACTIVITYINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETACTIVITYINFO_IS_FINAL_PLAYER_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETACTIVITYINFO_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETACTIVITYINFO_MATCH_MODE_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_GETFINALINFO_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETFINALINFO_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETFINALINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETFINALINFO_USER_DATA_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETFINALINFO_ROUNDS_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETFINALINFO_BATTLE_IDS_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETFINALINFO_BET_DATA_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_GETUSERINFO_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETUSERINFO_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETUSERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETUSERINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETUSERINFO_USER_DATA_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETUSERINFO_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETUSERINFO_RANK_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETUSERINFO_FINAL_LV_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_GETRECORDS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETRECORDS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETRECORDS_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETRECORDS_RECORDS_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_GETHISTORYS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETHISTORYS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETHISTORYS_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETHISTORYS_HISTORYS_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_MATCH_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_MATCH_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_MATCH_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_MATCH_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_MATCH_ROBOT_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_MATCH_TARGET_SCORE_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_MATCH_SELF_SCORE_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_PEAKARENA_CHALLENGEBEGIN_IS_BATTLE_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEFINISH_SCORE_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEFINISH_RANK_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHALLENGEFINISH_OLD_SCORE_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_PLAYBETS_ME = protobuf.Descriptor(),
	C2S_PEAKARENA_PLAYBETS_TARGET_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_PLAYBETS_BETS_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_PLAYBETS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_PLAYBETS_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_PLAYBETS_TARGET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_PLAYBETS_BETS_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_SETBATTLETEAM_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_SETBATTLETEAM_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_SETBATTLETEAM_RET_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_CHEER_ME = protobuf.Descriptor(),
	C2S_PEAKARENA_CHEER_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHEER_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_CHEER_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHEER_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHEER_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_CHEER_CHEER_COUNT_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_ALLIANCERANKAWARD_ME = protobuf.Descriptor(),
	C2S_PEAKARENA_ALLIANCERANKAWARD_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_ALLIANCERANKAWARD_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_ALLIANCERANKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_ALLIANCERANKAWARD_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_ALLIANCERANKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_PEAKARENA_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_PEAKARENA_GETSERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETSERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_PEAKARENA_GETSERVERINFOS_SID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_GETACTIVITYINFO_ME, {
	"C2S_PeakArena_GetActivityInfo",
	".cs.C2S_PeakArena_GetActivityInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_INFO_F, {
	"info",
	".cs.S2C_PeakArena_GetActivityInfo.info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.PEAKARENAINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_IS_FINAL_PLAYER_F, {
	"is_final_player",
	".cs.S2C_PeakArena_GetActivityInfo.is_final_player",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_ROOM_ID_F, {
	"room_id",
	".cs.S2C_PeakArena_GetActivityInfo.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_MATCH_MODE_F, {
	"match_mode",
	".cs.S2C_PeakArena_GetActivityInfo.match_mode",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_ME, {
	"S2C_PeakArena_GetActivityInfo",
	".cs.S2C_PeakArena_GetActivityInfo",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_INFO_F,
		var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_IS_FINAL_PLAYER_F,
		var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_ROOM_ID_F,
		var_0_10.S2C_PEAKARENA_GETACTIVITYINFO_MATCH_MODE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_GETFINALINFO_ME, {
	"C2S_PeakArena_GetFinalInfo",
	".cs.C2S_PeakArena_GetFinalInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETFINALINFO_RET_F, {
	"ret",
	".cs.S2C_PeakArena_GetFinalInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETFINALINFO_USER_DATA_F, {
	"user_data",
	".cs.S2C_PeakArena_GetFinalInfo.user_data",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PEAKARENAFINALUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETFINALINFO_ROUNDS_F, {
	"rounds",
	".cs.S2C_PeakArena_GetFinalInfo.rounds",
	3,
	2,
	3,
	false,
	{},
	var_0_3.PEAKARENAFINALROUND_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETFINALINFO_BATTLE_IDS_F, {
	"battle_ids",
	".cs.S2C_PeakArena_GetFinalInfo.battle_ids",
	4,
	3,
	3,
	false,
	{},
	var_0_3.PEAKARENAFINALBATTLEID_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETFINALINFO_BET_DATA_F, {
	"bet_data",
	".cs.S2C_PeakArena_GetFinalInfo.bet_data",
	5,
	4,
	3,
	false,
	{},
	var_0_3.PEAKARENABETDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_GETFINALINFO_ME, {
	"S2C_PeakArena_GetFinalInfo",
	".cs.S2C_PeakArena_GetFinalInfo",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_GETFINALINFO_RET_F,
		var_0_10.S2C_PEAKARENA_GETFINALINFO_USER_DATA_F,
		var_0_10.S2C_PEAKARENA_GETFINALINFO_ROUNDS_F,
		var_0_10.S2C_PEAKARENA_GETFINALINFO_BATTLE_IDS_F,
		var_0_10.S2C_PEAKARENA_GETFINALINFO_BET_DATA_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_GETUSERINFO_ME, {
	"C2S_PeakArena_GetUserInfo",
	".cs.C2S_PeakArena_GetUserInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_RET_F, {
	"ret",
	".cs.S2C_PeakArena_GetUserInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_INFO_F, {
	"info",
	".cs.S2C_PeakArena_GetUserInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.PEAKARENASELF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_USER_DATA_F, {
	"user_data",
	".cs.S2C_PeakArena_GetUserInfo.user_data",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.PEAKARENAUSERDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_AWARDS_F, {
	"awards",
	".cs.S2C_PeakArena_GetUserInfo.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_RANK_F, {
	"rank",
	".cs.S2C_PeakArena_GetUserInfo.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_FINAL_LV_F, {
	"final_lv",
	".cs.S2C_PeakArena_GetUserInfo.final_lv",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_GETUSERINFO_ME, {
	"S2C_PeakArena_GetUserInfo",
	".cs.S2C_PeakArena_GetUserInfo",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_GETUSERINFO_RET_F,
		var_0_10.S2C_PEAKARENA_GETUSERINFO_INFO_F,
		var_0_10.S2C_PEAKARENA_GETUSERINFO_USER_DATA_F,
		var_0_10.S2C_PEAKARENA_GETUSERINFO_AWARDS_F,
		var_0_10.S2C_PEAKARENA_GETUSERINFO_RANK_F,
		var_0_10.S2C_PEAKARENA_GETUSERINFO_FINAL_LV_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_GETRECORDS_ME, {
	"C2S_PeakArena_GetRecords",
	".cs.C2S_PeakArena_GetRecords",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETRECORDS_RET_F, {
	"ret",
	".cs.S2C_PeakArena_GetRecords.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETRECORDS_RECORDS_F, {
	"records",
	".cs.S2C_PeakArena_GetRecords.records",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PEAKARENARECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_GETRECORDS_ME, {
	"S2C_PeakArena_GetRecords",
	".cs.S2C_PeakArena_GetRecords",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_GETRECORDS_RET_F,
		var_0_10.S2C_PEAKARENA_GETRECORDS_RECORDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_GETHISTORYS_ME, {
	"C2S_PeakArena_GetHistorys",
	".cs.C2S_PeakArena_GetHistorys",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETHISTORYS_RET_F, {
	"ret",
	".cs.S2C_PeakArena_GetHistorys.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETHISTORYS_HISTORYS_F, {
	"historys",
	".cs.S2C_PeakArena_GetHistorys.historys",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PEAKARENAHISTORY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_GETHISTORYS_ME, {
	"S2C_PeakArena_GetHistorys",
	".cs.S2C_PeakArena_GetHistorys",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_GETHISTORYS_RET_F,
		var_0_10.S2C_PEAKARENA_GETHISTORYS_HISTORYS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_MATCH_ME, {
	"C2S_PeakArena_Match",
	".cs.C2S_PeakArena_Match",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_MATCH_RET_F, {
	"ret",
	".cs.S2C_PeakArena_Match.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_MATCH_TARGET_ID_F, {
	"target_id",
	".cs.S2C_PeakArena_Match.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_MATCH_ROBOT_ID_F, {
	"robot_id",
	".cs.S2C_PeakArena_Match.robot_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_MATCH_TARGET_SCORE_F, {
	"target_score",
	".cs.S2C_PeakArena_Match.target_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_MATCH_SELF_SCORE_F, {
	"self_score",
	".cs.S2C_PeakArena_Match.self_score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_MATCH_ME, {
	"S2C_PeakArena_Match",
	".cs.S2C_PeakArena_Match",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_MATCH_RET_F,
		var_0_10.S2C_PEAKARENA_MATCH_TARGET_ID_F,
		var_0_10.S2C_PEAKARENA_MATCH_ROBOT_ID_F,
		var_0_10.S2C_PEAKARENA_MATCH_TARGET_SCORE_F,
		var_0_10.S2C_PEAKARENA_MATCH_SELF_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PEAKARENA_CHALLENGEBEGIN_IS_BATTLE_F, {
	"is_battle",
	".cs.C2S_PeakArena_ChallengeBegin.is_battle",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_CHALLENGEBEGIN_ME, {
	"C2S_PeakArena_ChallengeBegin",
	".cs.C2S_PeakArena_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_PEAKARENA_CHALLENGEBEGIN_IS_BATTLE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_PeakArena_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_PeakArena_ChallengeBegin.battle_id",
	3,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEBEGIN_ME, {
	"S2C_PeakArena_ChallengeBegin",
	".cs.S2C_PeakArena_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_PEAKARENA_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_PeakArena_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_PeakArena_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_SCORE_F, {
	"score",
	".cs.S2C_PeakArena_ChallengeFinish.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_RANK_F, {
	"rank",
	".cs.S2C_PeakArena_ChallengeFinish.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_OLD_SCORE_F, {
	"old_score",
	".cs.S2C_PeakArena_ChallengeFinish.old_score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_ME, {
	"S2C_PeakArena_ChallengeFinish",
	".cs.S2C_PeakArena_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_SCORE_F,
		var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_RANK_F,
		var_0_10.S2C_PEAKARENA_CHALLENGEFINISH_OLD_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PEAKARENA_PLAYBETS_TARGET_F, {
	"target",
	".cs.C2S_PeakArena_PlayBets.target",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PEAKARENA_PLAYBETS_BETS_F, {
	"bets",
	".cs.C2S_PeakArena_PlayBets.bets",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_PLAYBETS_ME, {
	"C2S_PeakArena_PlayBets",
	".cs.C2S_PeakArena_PlayBets",
	{},
	{},
	{
		var_0_10.C2S_PEAKARENA_PLAYBETS_TARGET_F,
		var_0_10.C2S_PEAKARENA_PLAYBETS_BETS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_PLAYBETS_RET_F, {
	"ret",
	".cs.S2C_PeakArena_PlayBets.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_PLAYBETS_TARGET_F, {
	"target",
	".cs.S2C_PeakArena_PlayBets.target",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_PLAYBETS_BETS_F, {
	"bets",
	".cs.S2C_PeakArena_PlayBets.bets",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_PLAYBETS_ME, {
	"S2C_PeakArena_PlayBets",
	".cs.S2C_PeakArena_PlayBets",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_PLAYBETS_RET_F,
		var_0_10.S2C_PEAKARENA_PLAYBETS_TARGET_F,
		var_0_10.S2C_PEAKARENA_PLAYBETS_BETS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_SETBATTLETEAM_ME, {
	"C2S_PeakArena_SetBattleTeam",
	".cs.C2S_PeakArena_SetBattleTeam",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_SETBATTLETEAM_RET_F, {
	"ret",
	".cs.S2C_PeakArena_SetBattleTeam.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_SETBATTLETEAM_ME, {
	"S2C_PeakArena_SetBattleTeam",
	".cs.S2C_PeakArena_SetBattleTeam",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_SETBATTLETEAM_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PEAKARENA_CHEER_TARGET_ID_F, {
	"target_id",
	".cs.C2S_PeakArena_Cheer.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_CHEER_ME, {
	"C2S_PeakArena_Cheer",
	".cs.C2S_PeakArena_Cheer",
	{},
	{},
	{
		var_0_10.C2S_PEAKARENA_CHEER_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHEER_RET_F, {
	"ret",
	".cs.S2C_PeakArena_Cheer.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHEER_TARGET_ID_F, {
	"target_id",
	".cs.S2C_PeakArena_Cheer.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHEER_AWARDS_F, {
	"awards",
	".cs.S2C_PeakArena_Cheer.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_CHEER_CHEER_COUNT_F, {
	"cheer_count",
	".cs.S2C_PeakArena_Cheer.cheer_count",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_CHEER_ME, {
	"S2C_PeakArena_Cheer",
	".cs.S2C_PeakArena_Cheer",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_CHEER_RET_F,
		var_0_10.S2C_PEAKARENA_CHEER_TARGET_ID_F,
		var_0_10.S2C_PEAKARENA_CHEER_AWARDS_F,
		var_0_10.S2C_PEAKARENA_CHEER_CHEER_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PEAKARENA_ALLIANCERANKAWARD_TARGET_ID_F, {
	"target_id",
	".cs.C2S_PeakArena_AllianceRankAward.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_ALLIANCERANKAWARD_ME, {
	"C2S_PeakArena_AllianceRankAward",
	".cs.C2S_PeakArena_AllianceRankAward",
	{},
	{},
	{
		var_0_10.C2S_PEAKARENA_ALLIANCERANKAWARD_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_RET_F, {
	"ret",
	".cs.S2C_PeakArena_AllianceRankAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_TARGET_ID_F, {
	"target_id",
	".cs.S2C_PeakArena_AllianceRankAward.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_PeakArena_AllianceRankAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_ME, {
	"S2C_PeakArena_AllianceRankAward",
	".cs.S2C_PeakArena_AllianceRankAward",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_RET_F,
		var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_TARGET_ID_F,
		var_0_10.S2C_PEAKARENA_ALLIANCERANKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PEAKARENA_GETSERVERINFOS_ME, {
	"C2S_PeakArena_GetServerInfos",
	".cs.C2S_PeakArena_GetServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETSERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_PeakArena_GetServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETSERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_PeakArena_GetServerInfos.server_infos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PEAKARENA_GETSERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_PeakArena_GetServerInfos.sid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PEAKARENA_GETSERVERINFOS_ME, {
	"S2C_PeakArena_GetServerInfos",
	".cs.S2C_PeakArena_GetServerInfos",
	{},
	{},
	{
		var_0_10.S2C_PEAKARENA_GETSERVERINFOS_RET_F,
		var_0_10.S2C_PEAKARENA_GETSERVERINFOS_SERVER_INFOS_F,
		var_0_10.S2C_PEAKARENA_GETSERVERINFOS_SID_F
	},
	false,
	{}
})

return var_0_10
