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
	C2S_TOWER_GETINFO_ME = protobuf.Descriptor(),
	C2S_TOWER_GETINFO_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_ME = protobuf.Descriptor(),
	S2C_TOWER_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_OPEN_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_BUFF_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_STAGES_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_HANGUP_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_HANGUP_END_TIME_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_HANGUP_STUB_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_CAN_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETINFO_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_CHALLENGESTAGEBEGIN_ME = protobuf.Descriptor(),
	C2S_TOWER_CHALLENGESTAGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	C2S_TOWER_CHALLENGESTAGEBEGIN_FORMATION_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	C2S_TOWER_CHALLENGESTAGEBEGIN_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEBEGIN_ME = protobuf.Descriptor(),
	S2C_TOWER_CHALLENGESTAGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEBEGIN_FORMATION_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEBEGIN_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_ME = protobuf.Descriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_ID_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_STAGE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_CHALLENGESTAGEFINISH_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_GETFIRSTPASSINFO_ME = protobuf.Descriptor(),
	C2S_TOWER_GETFIRSTPASSINFO_IDS_F = protobuf.FieldDescriptor(),
	C2S_TOWER_GETFIRSTPASSINFO_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETFIRSTPASSINFO_ME = protobuf.Descriptor(),
	S2C_TOWER_GETFIRSTPASSINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETFIRSTPASSINFO_IDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETFIRSTPASSINFO_STAGE_RECORDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETFIRSTPASSINFO_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_FIRSTPASSAWARD_ME = protobuf.Descriptor(),
	C2S_TOWER_FIRSTPASSAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_TOWER_FIRSTPASSAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FIRSTPASSAWARD_ME = protobuf.Descriptor(),
	S2C_TOWER_FIRSTPASSAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FIRSTPASSAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FIRSTPASSAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FIRSTPASSAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_ONEKEYFIRSTPASSAWARD_ME = protobuf.Descriptor(),
	C2S_TOWER_ONEKEYFIRSTPASSAWARD_IDS_F = protobuf.FieldDescriptor(),
	C2S_TOWER_ONEKEYFIRSTPASSAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYFIRSTPASSAWARD_ME = protobuf.Descriptor(),
	S2C_TOWER_ONEKEYFIRSTPASSAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYFIRSTPASSAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYFIRSTPASSAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYFIRSTPASSAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_HANGUPAWARD_ME = protobuf.Descriptor(),
	C2S_TOWER_HANGUPAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPAWARD_ME = protobuf.Descriptor(),
	S2C_TOWER_HANGUPAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_HANGUPQUICKAWARD_ME = protobuf.Descriptor(),
	C2S_TOWER_HANGUPQUICKAWARD_COUNT_F = protobuf.FieldDescriptor(),
	C2S_TOWER_HANGUPQUICKAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPQUICKAWARD_ME = protobuf.Descriptor(),
	S2C_TOWER_HANGUPQUICKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPQUICKAWARD_COUNT_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPQUICKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HANGUPQUICKAWARD_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_ONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	C2S_TOWER_ONEKEYCHALLENGE_STAGE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_ONEKEYCHALLENGE_TARGET_STAGE_ORDER_F = protobuf.FieldDescriptor(),
	C2S_TOWER_ONEKEYCHALLENGE_ONEKEY_FIGHT_F = protobuf.FieldDescriptor(),
	C2S_TOWER_ONEKEYCHALLENGE_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_STAGE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_TARGET_STAGE_ORDER_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_STAGE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_ONEKEY_FIGHT_F = protobuf.FieldDescriptor(),
	S2C_TOWER_ONEKEYCHALLENGE_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_FASTROLLING_ME = protobuf.Descriptor(),
	C2S_TOWER_FASTROLLING_STAGE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_FASTROLLING_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FASTROLLING_ME = protobuf.Descriptor(),
	S2C_TOWER_FASTROLLING_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FASTROLLING_STAGE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FASTROLLING_STAGE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FASTROLLING_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FASTROLLING_TARGET_STAGE_ORDER_F = protobuf.FieldDescriptor(),
	S2C_TOWER_FASTROLLING_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_GETCANAWARDIDS_ME = protobuf.Descriptor(),
	C2S_TOWER_GETCANAWARDIDS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETCANAWARDIDS_ME = protobuf.Descriptor(),
	S2C_TOWER_GETCANAWARDIDS_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETCANAWARDIDS_CAN_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_TOWER_GETCANAWARDIDS_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_HELPONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	C2S_TOWER_HELPONEKEYCHALLENGE_STAGE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TOWER_HELPONEKEYCHALLENGE_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HELPONEKEYCHALLENGE_ME = protobuf.Descriptor(),
	S2C_TOWER_HELPONEKEYCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HELPONEKEYCHALLENGE_STAGE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HELPONEKEYCHALLENGE_PLAY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HELPONEKEYCHALLENGE_STAGE_F = protobuf.FieldDescriptor(),
	S2C_TOWER_HELPONEKEYCHALLENGE_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_GETINFO_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_GetInfo.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_GETINFO_ME, {
	"C2S_Tower_GetInfo",
	".cs.C2S_Tower_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_TOWER_GETINFO_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Tower_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_OPEN_ACTIVITY_F, {
	"open_activity",
	".cs.S2C_Tower_GetInfo.open_activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TOWEROPENACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_BUFF_ACTIVITY_F, {
	"buff_activity",
	".cs.S2C_Tower_GetInfo.buff_activity",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TOWERBUFFACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_STAGES_F, {
	"stages",
	".cs.S2C_Tower_GetInfo.stages",
	4,
	3,
	3,
	false,
	{},
	var_0_3.TOWERSTAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_HANGUP_START_TIME_F, {
	"hangup_start_time",
	".cs.S2C_Tower_GetInfo.hangup_start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_HANGUP_END_TIME_F, {
	"hangup_end_time",
	".cs.S2C_Tower_GetInfo.hangup_end_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_HANGUP_STUB_AWARDS_F, {
	"hangup_stub_awards",
	".cs.S2C_Tower_GetInfo.hangup_stub_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_CAN_AWARD_IDS_F, {
	"can_award_ids",
	".cs.S2C_Tower_GetInfo.can_award_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETINFO_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_GetInfo.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_GETINFO_ME, {
	"S2C_Tower_GetInfo",
	".cs.S2C_Tower_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_TOWER_GETINFO_RET_F,
		var_0_10.S2C_TOWER_GETINFO_OPEN_ACTIVITY_F,
		var_0_10.S2C_TOWER_GETINFO_BUFF_ACTIVITY_F,
		var_0_10.S2C_TOWER_GETINFO_STAGES_F,
		var_0_10.S2C_TOWER_GETINFO_HANGUP_START_TIME_F,
		var_0_10.S2C_TOWER_GETINFO_HANGUP_END_TIME_F,
		var_0_10.S2C_TOWER_GETINFO_HANGUP_STUB_AWARDS_F,
		var_0_10.S2C_TOWER_GETINFO_CAN_AWARD_IDS_F,
		var_0_10.S2C_TOWER_GETINFO_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_ID_F, {
	"id",
	".cs.C2S_Tower_ChallengeStageBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_FORMATION_KNIGHT_IDS_F, {
	"formation_knight_ids",
	".cs.C2S_Tower_ChallengeStageBegin.formation_knight_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_ChallengeStageBegin.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_ME, {
	"C2S_Tower_ChallengeStageBegin",
	".cs.C2S_Tower_ChallengeStageBegin",
	{},
	{},
	{
		var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_ID_F,
		var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_FORMATION_KNIGHT_IDS_F,
		var_0_10.C2S_TOWER_CHALLENGESTAGEBEGIN_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Tower_ChallengeStageBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_ID_F, {
	"id",
	".cs.S2C_Tower_ChallengeStageBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Tower_ChallengeStageBegin.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_FORMATION_KNIGHT_IDS_F, {
	"formation_knight_ids",
	".cs.S2C_Tower_ChallengeStageBegin.formation_knight_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_ChallengeStageBegin.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_ME, {
	"S2C_Tower_ChallengeStageBegin",
	".cs.S2C_Tower_ChallengeStageBegin",
	{},
	{},
	{
		var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_RET_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_ID_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_BATTLE_ID_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_FORMATION_KNIGHT_IDS_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEBEGIN_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Tower_ChallengeStageFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_ID_F, {
	"id",
	".cs.S2C_Tower_ChallengeStageFinish.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Tower_ChallengeStageFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_STAGE_F, {
	"stage",
	".cs.S2C_Tower_ChallengeStageFinish.stage",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TOWERSTAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_ChallengeStageFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_ChallengeStageFinish.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_ME, {
	"S2C_Tower_ChallengeStageFinish",
	".cs.S2C_Tower_ChallengeStageFinish",
	{},
	{},
	{
		var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_RET_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_ID_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_IS_WIN_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_STAGE_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_AWARDS_F,
		var_0_10.S2C_TOWER_CHALLENGESTAGEFINISH_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_GETFIRSTPASSINFO_IDS_F, {
	"ids",
	".cs.C2S_Tower_GetFirstPassInfo.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_GETFIRSTPASSINFO_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_GetFirstPassInfo.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_GETFIRSTPASSINFO_ME, {
	"C2S_Tower_GetFirstPassInfo",
	".cs.C2S_Tower_GetFirstPassInfo",
	{},
	{},
	{
		var_0_10.C2S_TOWER_GETFIRSTPASSINFO_IDS_F,
		var_0_10.C2S_TOWER_GETFIRSTPASSINFO_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETFIRSTPASSINFO_RET_F, {
	"ret",
	".cs.S2C_Tower_GetFirstPassInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETFIRSTPASSINFO_IDS_F, {
	"ids",
	".cs.S2C_Tower_GetFirstPassInfo.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETFIRSTPASSINFO_STAGE_RECORDS_F, {
	"stage_records",
	".cs.S2C_Tower_GetFirstPassInfo.stage_records",
	3,
	2,
	3,
	false,
	{},
	var_0_3.TOWERSTAGEFIRSTRECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETFIRSTPASSINFO_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_GetFirstPassInfo.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_GETFIRSTPASSINFO_ME, {
	"S2C_Tower_GetFirstPassInfo",
	".cs.S2C_Tower_GetFirstPassInfo",
	{},
	{},
	{
		var_0_10.S2C_TOWER_GETFIRSTPASSINFO_RET_F,
		var_0_10.S2C_TOWER_GETFIRSTPASSINFO_IDS_F,
		var_0_10.S2C_TOWER_GETFIRSTPASSINFO_STAGE_RECORDS_F,
		var_0_10.S2C_TOWER_GETFIRSTPASSINFO_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_FIRSTPASSAWARD_ID_F, {
	"id",
	".cs.C2S_Tower_FirstPassAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_FIRSTPASSAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_FirstPassAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_FIRSTPASSAWARD_ME, {
	"C2S_Tower_FirstPassAward",
	".cs.C2S_Tower_FirstPassAward",
	{},
	{},
	{
		var_0_10.C2S_TOWER_FIRSTPASSAWARD_ID_F,
		var_0_10.C2S_TOWER_FIRSTPASSAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FIRSTPASSAWARD_RET_F, {
	"ret",
	".cs.S2C_Tower_FirstPassAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FIRSTPASSAWARD_ID_F, {
	"id",
	".cs.S2C_Tower_FirstPassAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FIRSTPASSAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_FirstPassAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FIRSTPASSAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_FirstPassAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_FIRSTPASSAWARD_ME, {
	"S2C_Tower_FirstPassAward",
	".cs.S2C_Tower_FirstPassAward",
	{},
	{},
	{
		var_0_10.S2C_TOWER_FIRSTPASSAWARD_RET_F,
		var_0_10.S2C_TOWER_FIRSTPASSAWARD_ID_F,
		var_0_10.S2C_TOWER_FIRSTPASSAWARD_AWARDS_F,
		var_0_10.S2C_TOWER_FIRSTPASSAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_ONEKEYFIRSTPASSAWARD_IDS_F, {
	"ids",
	".cs.C2S_Tower_OnekeyFirstPassAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_ONEKEYFIRSTPASSAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_OnekeyFirstPassAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_ONEKEYFIRSTPASSAWARD_ME, {
	"C2S_Tower_OnekeyFirstPassAward",
	".cs.C2S_Tower_OnekeyFirstPassAward",
	{},
	{},
	{
		var_0_10.C2S_TOWER_ONEKEYFIRSTPASSAWARD_IDS_F,
		var_0_10.C2S_TOWER_ONEKEYFIRSTPASSAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_RET_F, {
	"ret",
	".cs.S2C_Tower_OnekeyFirstPassAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_IDS_F, {
	"ids",
	".cs.S2C_Tower_OnekeyFirstPassAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_OnekeyFirstPassAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_OnekeyFirstPassAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_ME, {
	"S2C_Tower_OnekeyFirstPassAward",
	".cs.S2C_Tower_OnekeyFirstPassAward",
	{},
	{},
	{
		var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_RET_F,
		var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_IDS_F,
		var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_AWARDS_F,
		var_0_10.S2C_TOWER_ONEKEYFIRSTPASSAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_HANGUPAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_HangupAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_HANGUPAWARD_ME, {
	"C2S_Tower_HangupAward",
	".cs.C2S_Tower_HangupAward",
	{},
	{},
	{
		var_0_10.C2S_TOWER_HANGUPAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPAWARD_RET_F, {
	"ret",
	".cs.S2C_Tower_HangupAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_HangupAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_HangupAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_HANGUPAWARD_ME, {
	"S2C_Tower_HangupAward",
	".cs.S2C_Tower_HangupAward",
	{},
	{},
	{
		var_0_10.S2C_TOWER_HANGUPAWARD_RET_F,
		var_0_10.S2C_TOWER_HANGUPAWARD_AWARDS_F,
		var_0_10.S2C_TOWER_HANGUPAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_HANGUPQUICKAWARD_COUNT_F, {
	"count",
	".cs.C2S_Tower_HangupQuickAward.count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_HANGUPQUICKAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_HangupQuickAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_HANGUPQUICKAWARD_ME, {
	"C2S_Tower_HangupQuickAward",
	".cs.C2S_Tower_HangupQuickAward",
	{},
	{},
	{
		var_0_10.C2S_TOWER_HANGUPQUICKAWARD_COUNT_F,
		var_0_10.C2S_TOWER_HANGUPQUICKAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPQUICKAWARD_RET_F, {
	"ret",
	".cs.S2C_Tower_HangupQuickAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPQUICKAWARD_COUNT_F, {
	"count",
	".cs.S2C_Tower_HangupQuickAward.count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPQUICKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_HangupQuickAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HANGUPQUICKAWARD_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_HangupQuickAward.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_HANGUPQUICKAWARD_ME, {
	"S2C_Tower_HangupQuickAward",
	".cs.S2C_Tower_HangupQuickAward",
	{},
	{},
	{
		var_0_10.S2C_TOWER_HANGUPQUICKAWARD_RET_F,
		var_0_10.S2C_TOWER_HANGUPQUICKAWARD_COUNT_F,
		var_0_10.S2C_TOWER_HANGUPQUICKAWARD_AWARDS_F,
		var_0_10.S2C_TOWER_HANGUPQUICKAWARD_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_ONEKEYCHALLENGE_STAGE_TYPE_F, {
	"stage_type",
	".cs.C2S_Tower_OnekeyChallenge.stage_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_ONEKEYCHALLENGE_TARGET_STAGE_ORDER_F, {
	"target_stage_order",
	".cs.C2S_Tower_OnekeyChallenge.target_stage_order",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_ONEKEYCHALLENGE_ONEKEY_FIGHT_F, {
	"onekey_fight",
	".cs.C2S_Tower_OnekeyChallenge.onekey_fight",
	3,
	2,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_ONEKEYCHALLENGE_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_OnekeyChallenge.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_ONEKEYCHALLENGE_ME, {
	"C2S_Tower_OnekeyChallenge",
	".cs.C2S_Tower_OnekeyChallenge",
	{},
	{},
	{
		var_0_10.C2S_TOWER_ONEKEYCHALLENGE_STAGE_TYPE_F,
		var_0_10.C2S_TOWER_ONEKEYCHALLENGE_TARGET_STAGE_ORDER_F,
		var_0_10.C2S_TOWER_ONEKEYCHALLENGE_ONEKEY_FIGHT_F,
		var_0_10.C2S_TOWER_ONEKEYCHALLENGE_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_Tower_OnekeyChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_STAGE_TYPE_F, {
	"stage_type",
	".cs.S2C_Tower_OnekeyChallenge.stage_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_TARGET_STAGE_ORDER_F, {
	"target_stage_order",
	".cs.S2C_Tower_OnekeyChallenge.target_stage_order",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_STAGE_F, {
	"stage",
	".cs.S2C_Tower_OnekeyChallenge.stage",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TOWERSTAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_OnekeyChallenge.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_ONEKEY_FIGHT_F, {
	"onekey_fight",
	".cs.S2C_Tower_OnekeyChallenge.onekey_fight",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_OnekeyChallenge.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_ONEKEYCHALLENGE_ME, {
	"S2C_Tower_OnekeyChallenge",
	".cs.S2C_Tower_OnekeyChallenge",
	{},
	{},
	{
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_RET_F,
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_STAGE_TYPE_F,
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_TARGET_STAGE_ORDER_F,
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_STAGE_F,
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_AWARDS_F,
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_ONEKEY_FIGHT_F,
		var_0_10.S2C_TOWER_ONEKEYCHALLENGE_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_FASTROLLING_STAGE_TYPE_F, {
	"stage_type",
	".cs.C2S_Tower_FastRolling.stage_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_FASTROLLING_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_FastRolling.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_FASTROLLING_ME, {
	"C2S_Tower_FastRolling",
	".cs.C2S_Tower_FastRolling",
	{},
	{},
	{
		var_0_10.C2S_TOWER_FASTROLLING_STAGE_TYPE_F,
		var_0_10.C2S_TOWER_FASTROLLING_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_RET_F, {
	"ret",
	".cs.S2C_Tower_FastRolling.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_STAGE_TYPE_F, {
	"stage_type",
	".cs.S2C_Tower_FastRolling.stage_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_STAGE_F, {
	"stage",
	".cs.S2C_Tower_FastRolling.stage",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TOWERSTAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_FastRolling.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.TOWERSTAGEIDAWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_TARGET_STAGE_ORDER_F, {
	"target_stage_order",
	".cs.S2C_Tower_FastRolling.target_stage_order",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_FastRolling.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_FASTROLLING_ME, {
	"S2C_Tower_FastRolling",
	".cs.S2C_Tower_FastRolling",
	{},
	{},
	{
		var_0_10.S2C_TOWER_FASTROLLING_RET_F,
		var_0_10.S2C_TOWER_FASTROLLING_STAGE_TYPE_F,
		var_0_10.S2C_TOWER_FASTROLLING_STAGE_F,
		var_0_10.S2C_TOWER_FASTROLLING_AWARDS_F,
		var_0_10.S2C_TOWER_FASTROLLING_TARGET_STAGE_ORDER_F,
		var_0_10.S2C_TOWER_FASTROLLING_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_GETCANAWARDIDS_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_GetCanAwardIds.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_GETCANAWARDIDS_ME, {
	"C2S_Tower_GetCanAwardIds",
	".cs.C2S_Tower_GetCanAwardIds",
	{},
	{},
	{
		var_0_10.C2S_TOWER_GETCANAWARDIDS_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETCANAWARDIDS_RET_F, {
	"ret",
	".cs.S2C_Tower_GetCanAwardIds.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETCANAWARDIDS_CAN_AWARD_IDS_F, {
	"can_award_ids",
	".cs.S2C_Tower_GetCanAwardIds.can_award_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_GETCANAWARDIDS_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_GetCanAwardIds.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_GETCANAWARDIDS_ME, {
	"S2C_Tower_GetCanAwardIds",
	".cs.S2C_Tower_GetCanAwardIds",
	{},
	{},
	{
		var_0_10.S2C_TOWER_GETCANAWARDIDS_RET_F,
		var_0_10.S2C_TOWER_GETCANAWARDIDS_CAN_AWARD_IDS_F,
		var_0_10.S2C_TOWER_GETCANAWARDIDS_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_HELPONEKEYCHALLENGE_STAGE_TYPE_F, {
	"stage_type",
	".cs.C2S_Tower_HelpOneKeyChallenge.stage_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TOWER_HELPONEKEYCHALLENGE_PLAY_TYPE_F, {
	"play_type",
	".cs.C2S_Tower_HelpOneKeyChallenge.play_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TOWER_HELPONEKEYCHALLENGE_ME, {
	"C2S_Tower_HelpOneKeyChallenge",
	".cs.C2S_Tower_HelpOneKeyChallenge",
	{},
	{},
	{
		var_0_10.C2S_TOWER_HELPONEKEYCHALLENGE_STAGE_TYPE_F,
		var_0_10.C2S_TOWER_HELPONEKEYCHALLENGE_PLAY_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_Tower_HelpOneKeyChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_STAGE_TYPE_F, {
	"stage_type",
	".cs.S2C_Tower_HelpOneKeyChallenge.stage_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_PLAY_TYPE_F, {
	"play_type",
	".cs.S2C_Tower_HelpOneKeyChallenge.play_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_STAGE_F, {
	"stage",
	".cs.S2C_Tower_HelpOneKeyChallenge.stage",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TOWERSTAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_AWARDS_F, {
	"awards",
	".cs.S2C_Tower_HelpOneKeyChallenge.awards",
	5,
	4,
	3,
	false,
	{},
	var_0_3.TOWERSTAGEIDAWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_ME, {
	"S2C_Tower_HelpOneKeyChallenge",
	".cs.S2C_Tower_HelpOneKeyChallenge",
	{},
	{},
	{
		var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_RET_F,
		var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_STAGE_TYPE_F,
		var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_PLAY_TYPE_F,
		var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_STAGE_F,
		var_0_10.S2C_TOWER_HELPONEKEYCHALLENGE_AWARDS_F
	},
	false,
	{}
})

return var_0_10
