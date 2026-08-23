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
	C2S_ALLIANCETRIAL_ENTER_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_ENTER_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_GIVE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_RECEIVE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_BOX_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_ALLIANCE_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_USERS_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_MONSTERS_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_ENTER_PASS_MONSTERS_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_MOVE_ME = protobuf.Descriptor(),
	C2S_ALLIANCETRIAL_MOVE_POS_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_MOVE_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_MOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_MOVE_POS_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_NOTIFYMOVE_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_NOTIFYMOVE_USER_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_EXIT_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_EXIT_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_EXIT_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_NOTIFYEXIT_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_NOTIFYEXIT_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_ALLIANCETRIAL_CHALLENGEBEGIN_MONSTER_ID_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_CHALLENGEBEGIN_DIFFICULTY_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_CHALLENGEBEGIN_IS_SWEEP_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEBEGIN_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEBEGIN_DIFFICULTY_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_DIFFICULTY_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_SWEEP_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_VALID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_CHALLENGEFINISH_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_MONSTER_ID_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_GIVEINFO_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_GIVEINFO_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_GIVEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_GIVEINFO_GIVES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_GIVEINFO_GIVE_USERS_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_GIVE_ME = protobuf.Descriptor(),
	C2S_ALLIANCETRIAL_GIVE_TARGET_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_GIVE_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_GIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_GIVE_TARGET_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_GIVE_TARGET_RECEIVE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_GIVE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_BOXINFO_ME = protobuf.Descriptor(),
	C2S_ALLIANCETRIAL_BOXINFO_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_BOXINFO_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_BOXINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_BOXINFO_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_BOXINFO_BOXES_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_BOXAWARD_ME = protobuf.Descriptor(),
	C2S_ALLIANCETRIAL_BOXAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_BOXAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_BOXAWARD_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_BOXAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_BOXAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_BOXAWARD_BOX_F = protobuf.FieldDescriptor(),
	C2S_ALLIANCETRIAL_RANKLIST_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_RANKLIST_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_RANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_RANKLIST_UNITS_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_RANKLIST_RANK_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_RANKLIST_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_NOTIFYLEVEL_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_NOTIFYLEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_UPDATEUSER_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_UPDATEUSER_RECEIVE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ALLIANCETRIAL_UPDATEMONSTER_ME = protobuf.Descriptor(),
	S2C_ALLIANCETRIAL_UPDATEMONSTER_MONSTER_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_ENTER_ME, {
	"C2S_AllianceTrial_Enter",
	".cs.C2S_AllianceTrial_Enter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_TIMES_F, {
	"times",
	".cs.S2C_AllianceTrial_Enter.times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_GIVE_TIMES_F, {
	"give_times",
	".cs.S2C_AllianceTrial_Enter.give_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_RECEIVE_TIMES_F, {
	"receive_times",
	".cs.S2C_AllianceTrial_Enter.receive_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_BOX_TIMES_F, {
	"box_times",
	".cs.S2C_AllianceTrial_Enter.box_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_ALLIANCE_F, {
	"alliance",
	".cs.S2C_AllianceTrial_Enter.alliance",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.TRIALALLIANCE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_USERS_F, {
	"users",
	".cs.S2C_AllianceTrial_Enter.users",
	7,
	6,
	3,
	false,
	{},
	var_0_3.ALLIANCETRIALMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_MONSTERS_F, {
	"monsters",
	".cs.S2C_AllianceTrial_Enter.monsters",
	8,
	7,
	3,
	false,
	{},
	var_0_3.ALLIANCETRIALMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_PASS_MONSTERS_F, {
	"pass_monsters",
	".cs.S2C_AllianceTrial_Enter.pass_monsters",
	9,
	8,
	3,
	false,
	{},
	var_0_3.ALLIANCETRIALPASSMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_ENTER_ME, {
	"S2C_AllianceTrial_Enter",
	".cs.S2C_AllianceTrial_Enter",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_ENTER_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_TIMES_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_GIVE_TIMES_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_RECEIVE_TIMES_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_BOX_TIMES_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_ALLIANCE_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_USERS_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_MONSTERS_F,
		var_0_10.S2C_ALLIANCETRIAL_ENTER_PASS_MONSTERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_MOVE_POS_F, {
	"pos",
	".cs.C2S_AllianceTrial_Move.pos",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_MOVE_ME, {
	"C2S_AllianceTrial_Move",
	".cs.C2S_AllianceTrial_Move",
	{},
	{},
	{
		var_0_10.C2S_ALLIANCETRIAL_MOVE_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_MOVE_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_Move.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_MOVE_POS_F, {
	"pos",
	".cs.S2C_AllianceTrial_Move.pos",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_MOVE_ME, {
	"S2C_AllianceTrial_Move",
	".cs.S2C_AllianceTrial_Move",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_MOVE_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_MOVE_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYMOVE_USER_F, {
	"user",
	".cs.S2C_AllianceTrial_NotifyMove.user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.ALLIANCETRIALMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYMOVE_ME, {
	"S2C_AllianceTrial_NotifyMove",
	".cs.S2C_AllianceTrial_NotifyMove",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_NOTIFYMOVE_USER_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_EXIT_ME, {
	"C2S_AllianceTrial_Exit",
	".cs.C2S_AllianceTrial_Exit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_EXIT_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_Exit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_EXIT_ME, {
	"S2C_AllianceTrial_Exit",
	".cs.S2C_AllianceTrial_Exit",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_EXIT_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYEXIT_USER_ID_F, {
	"user_id",
	".cs.S2C_AllianceTrial_NotifyExit.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYEXIT_ME, {
	"S2C_AllianceTrial_NotifyExit",
	".cs.S2C_AllianceTrial_NotifyExit",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_NOTIFYEXIT_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_AllianceTrial_ChallengeBegin.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_DIFFICULTY_F, {
	"difficulty",
	".cs.C2S_AllianceTrial_ChallengeBegin.difficulty",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_IS_SWEEP_F, {
	"is_sweep",
	".cs.C2S_AllianceTrial_ChallengeBegin.is_sweep",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_ME, {
	"C2S_AllianceTrial_ChallengeBegin",
	".cs.C2S_AllianceTrial_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_MONSTER_ID_F,
		var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_DIFFICULTY_F,
		var_0_10.C2S_ALLIANCETRIAL_CHALLENGEBEGIN_IS_SWEEP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_AllianceTrial_ChallengeBegin.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_DIFFICULTY_F, {
	"difficulty",
	".cs.S2C_AllianceTrial_ChallengeBegin.difficulty",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_AllianceTrial_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_ME, {
	"S2C_AllianceTrial_ChallengeBegin",
	".cs.S2C_AllianceTrial_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_MONSTER_ID_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_DIFFICULTY_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_AllianceTrial_ChallengeFinish.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_DIFFICULTY_F, {
	"difficulty",
	".cs.S2C_AllianceTrial_ChallengeFinish.difficulty",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_SWEEP_F, {
	"is_sweep",
	".cs.S2C_AllianceTrial_ChallengeFinish.is_sweep",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_AllianceTrial_ChallengeFinish.is_win",
	5,
	4,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_VALID_F, {
	"is_valid",
	".cs.S2C_AllianceTrial_ChallengeFinish.is_valid",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_AllianceTrial_ChallengeFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_TIMES_F, {
	"times",
	".cs.S2C_AllianceTrial_ChallengeFinish.times",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_ME, {
	"S2C_AllianceTrial_ChallengeFinish",
	".cs.S2C_AllianceTrial_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_MONSTER_ID_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_DIFFICULTY_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_SWEEP_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_IS_VALID_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_AWARDS_F,
		var_0_10.S2C_ALLIANCETRIAL_CHALLENGEFINISH_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_USER_ID_F, {
	"user_id",
	".cs.S2C_AllianceTrial_NotifyChallenge.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_AllianceTrial_NotifyChallenge.monster_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_ME, {
	"S2C_AllianceTrial_NotifyChallenge",
	".cs.S2C_AllianceTrial_NotifyChallenge",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_USER_ID_F,
		var_0_10.S2C_ALLIANCETRIAL_NOTIFYCHALLENGE_MONSTER_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_GIVEINFO_ME, {
	"C2S_AllianceTrial_GiveInfo",
	".cs.C2S_AllianceTrial_GiveInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_GiveInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_GIVES_F, {
	"gives",
	".cs.S2C_AllianceTrial_GiveInfo.gives",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ALLIANCETRIALGIVE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_GIVE_USERS_F, {
	"give_users",
	".cs.S2C_AllianceTrial_GiveInfo.give_users",
	3,
	2,
	3,
	false,
	{},
	var_0_3.K64V32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_ME, {
	"S2C_AllianceTrial_GiveInfo",
	".cs.S2C_AllianceTrial_GiveInfo",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_GIVES_F,
		var_0_10.S2C_ALLIANCETRIAL_GIVEINFO_GIVE_USERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_GIVE_TARGET_USER_ID_F, {
	"target_user_id",
	".cs.C2S_AllianceTrial_Give.target_user_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_GIVE_ME, {
	"C2S_AllianceTrial_Give",
	".cs.C2S_AllianceTrial_Give",
	{},
	{},
	{
		var_0_10.C2S_ALLIANCETRIAL_GIVE_TARGET_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVE_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_Give.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVE_TARGET_USER_ID_F, {
	"target_user_id",
	".cs.S2C_AllianceTrial_Give.target_user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVE_TARGET_RECEIVE_TIMES_F, {
	"target_receive_times",
	".cs.S2C_AllianceTrial_Give.target_receive_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVE_AWARDS_F, {
	"awards",
	".cs.S2C_AllianceTrial_Give.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_GIVE_ME, {
	"S2C_AllianceTrial_Give",
	".cs.S2C_AllianceTrial_Give",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_GIVE_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_GIVE_TARGET_USER_ID_F,
		var_0_10.S2C_ALLIANCETRIAL_GIVE_TARGET_RECEIVE_TIMES_F,
		var_0_10.S2C_ALLIANCETRIAL_GIVE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_BOXINFO_LEVEL_F, {
	"level",
	".cs.C2S_AllianceTrial_BoxInfo.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_BOXINFO_ME, {
	"C2S_AllianceTrial_BoxInfo",
	".cs.C2S_AllianceTrial_BoxInfo",
	{},
	{},
	{
		var_0_10.C2S_ALLIANCETRIAL_BOXINFO_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXINFO_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_BoxInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXINFO_LEVEL_F, {
	"level",
	".cs.S2C_AllianceTrial_BoxInfo.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXINFO_BOXES_F, {
	"boxes",
	".cs.S2C_AllianceTrial_BoxInfo.boxes",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ALLIANCETRIALLEVELBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXINFO_ME, {
	"S2C_AllianceTrial_BoxInfo",
	".cs.S2C_AllianceTrial_BoxInfo",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_BOXINFO_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_BOXINFO_LEVEL_F,
		var_0_10.S2C_ALLIANCETRIAL_BOXINFO_BOXES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_BOXAWARD_LEVEL_F, {
	"level",
	".cs.C2S_AllianceTrial_BoxAward.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ALLIANCETRIAL_BOXAWARD_INDEX_F, {
	"index",
	".cs.C2S_AllianceTrial_BoxAward.index",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_BOXAWARD_ME, {
	"C2S_AllianceTrial_BoxAward",
	".cs.C2S_AllianceTrial_BoxAward",
	{},
	{},
	{
		var_0_10.C2S_ALLIANCETRIAL_BOXAWARD_LEVEL_F,
		var_0_10.C2S_ALLIANCETRIAL_BOXAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_BoxAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_LEVEL_F, {
	"level",
	".cs.S2C_AllianceTrial_BoxAward.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_BOX_F, {
	"box",
	".cs.S2C_AllianceTrial_BoxAward.box",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.ALLIANCETRIALBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_ME, {
	"S2C_AllianceTrial_BoxAward",
	".cs.S2C_AllianceTrial_BoxAward",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_LEVEL_F,
		var_0_10.S2C_ALLIANCETRIAL_BOXAWARD_BOX_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ALLIANCETRIAL_RANKLIST_ME, {
	"C2S_AllianceTrial_RankList",
	".cs.C2S_AllianceTrial_RankList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_RANKLIST_RET_F, {
	"ret",
	".cs.S2C_AllianceTrial_RankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_RANKLIST_UNITS_F, {
	"units",
	".cs.S2C_AllianceTrial_RankList.units",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SORTUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_RANKLIST_RANK_F, {
	"rank",
	".cs.S2C_AllianceTrial_RankList.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_RANKLIST_DAMAGE_F, {
	"damage",
	".cs.S2C_AllianceTrial_RankList.damage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_RANKLIST_ME, {
	"S2C_AllianceTrial_RankList",
	".cs.S2C_AllianceTrial_RankList",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_RANKLIST_RET_F,
		var_0_10.S2C_ALLIANCETRIAL_RANKLIST_UNITS_F,
		var_0_10.S2C_ALLIANCETRIAL_RANKLIST_RANK_F,
		var_0_10.S2C_ALLIANCETRIAL_RANKLIST_DAMAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYLEVEL_LEVEL_F, {
	"level",
	".cs.S2C_AllianceTrial_NotifyLevel.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_NOTIFYLEVEL_ME, {
	"S2C_AllianceTrial_NotifyLevel",
	".cs.S2C_AllianceTrial_NotifyLevel",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_NOTIFYLEVEL_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_UPDATEUSER_RECEIVE_TIMES_F, {
	"receive_times",
	".cs.S2C_AllianceTrial_UpdateUser.receive_times",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_UPDATEUSER_ME, {
	"S2C_AllianceTrial_UpdateUser",
	".cs.S2C_AllianceTrial_UpdateUser",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_UPDATEUSER_RECEIVE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ALLIANCETRIAL_UPDATEMONSTER_MONSTER_F, {
	"monster",
	".cs.S2C_AllianceTrial_UpdateMonster.monster",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.ALLIANCETRIALMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ALLIANCETRIAL_UPDATEMONSTER_ME, {
	"S2C_AllianceTrial_UpdateMonster",
	".cs.S2C_AllianceTrial_UpdateMonster",
	{},
	{},
	{
		var_0_10.S2C_ALLIANCETRIAL_UPDATEMONSTER_MONSTER_F
	},
	false,
	{}
})

return var_0_10
