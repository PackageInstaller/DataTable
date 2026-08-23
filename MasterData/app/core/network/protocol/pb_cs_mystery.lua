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
	C2S_MYSTERY_INFO_ME = protobuf.Descriptor(),
	S2C_MYSTERY_INFO_ME = protobuf.Descriptor(),
	S2C_MYSTERY_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_INFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_INFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_GETROOMLIST_ME = protobuf.Descriptor(),
	C2S_MYSTERY_GETROOMLIST_MYSTERY_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_GETROOMLIST_ME = protobuf.Descriptor(),
	S2C_MYSTERY_GETROOMLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_GETROOMLIST_MYSTERY_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_GETROOMLIST_ROOM_ID_LIST_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_GETROOMLIST_ROOM_NUM_LIST_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_ENTER_ME = protobuf.Descriptor(),
	C2S_MYSTERY_ENTER_MYSTERY_ID_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_ENTER_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_ENTER_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ENTER_ME = protobuf.Descriptor(),
	S2C_MYSTERY_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ENTER_MYSTERY_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ENTER_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ENTER_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ENTER_ROOM_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_EXIT_ME = protobuf.Descriptor(),
	S2C_MYSTERY_EXIT_ME = protobuf.Descriptor(),
	S2C_MYSTERY_EXIT_RET_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_MOVE_ME = protobuf.Descriptor(),
	C2S_MYSTERY_MOVE_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MOVE_ME = protobuf.Descriptor(),
	S2C_MYSTERY_MOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MOVE_POS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_MONSTER_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_MYSTERY_MONSTER_CHALLENGEBEGIN_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_MONSTER_FASTCHALLENGE_ME = protobuf.Descriptor(),
	C2S_MYSTERY_MONSTER_FASTCHALLENGE_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_FASTCHALLENGE_ME = protobuf.Descriptor(),
	S2C_MYSTERY_MONSTER_FASTCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_FASTCHALLENGE_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_FASTCHALLENGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEFINISH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_MONSTER_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_ELITE_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_MYSTERY_ELITE_CHALLENGEBEGIN_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEBEGIN_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEFINISH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ELITE_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_ACCEPTTASK_ME = protobuf.Descriptor(),
	C2S_MYSTERY_ACCEPTTASK_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ACCEPTTASK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_ACCEPTTASK_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_ACCEPTTASK_TASK_ID_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_GIVEUPTASK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_GIVEUPTASK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_GIVEUPTASK_RET_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_AWARD_ME = protobuf.Descriptor(),
	C2S_MYSTERY_AWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_AWARD_ME = protobuf.Descriptor(),
	S2C_MYSTERY_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_AWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_AWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_STORY_FINISH_ME = protobuf.Descriptor(),
	C2S_MYSTERY_STORY_FINISH_STORY_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_STORY_FINISH_ME = protobuf.Descriptor(),
	S2C_MYSTERY_STORY_FINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_STORY_FINISH_STORY_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_STORY_FINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYMOVE_ME = protobuf.Descriptor(),
	S2C_MYSTERY_NOTIFYMOVE_USER_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYATTACK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_NOTIFYATTACK_USER_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYATTACK_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYATTACK_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYTASK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_NOTIFYTASK_TASK_LIST_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYEXIT_ME = protobuf.Descriptor(),
	S2C_MYSTERY_NOTIFYEXIT_UID_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_SENDLOOK_ME = protobuf.Descriptor(),
	C2S_MYSTERY_SENDLOOK_LOOK_F = protobuf.FieldDescriptor(),
	C2S_MYSTERY_SENDLOOK_LOOK_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_SENDLOOK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_SENDLOOK_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_SENDLOOK_LOOK_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_SENDLOOK_LOOK_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYLOOK_ME = protobuf.Descriptor(),
	S2C_MYSTERY_NOTIFYLOOK_UID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYLOOK_LOOK_F = protobuf.FieldDescriptor(),
	S2C_MYSTERY_NOTIFYLOOK_LOOK_TYPE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_INFO_ME, {
	"C2S_Mystery_Info",
	".cs.C2S_Mystery_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_INFO_RET_F, {
	"ret",
	".cs.S2C_Mystery_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_INFO_INFO_F, {
	"info",
	".cs.S2C_Mystery_Info.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.MYSTERY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_INFO_TASKS_F, {
	"tasks",
	".cs.S2C_Mystery_Info.tasks",
	3,
	2,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_INFO_ME, {
	"S2C_Mystery_Info",
	".cs.S2C_Mystery_Info",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_INFO_RET_F,
		var_0_10.S2C_MYSTERY_INFO_INFO_F,
		var_0_10.S2C_MYSTERY_INFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_GETROOMLIST_MYSTERY_ID_F, {
	"mystery_id",
	".cs.C2S_Mystery_GetRoomList.mystery_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_GETROOMLIST_ME, {
	"C2S_Mystery_GetRoomList",
	".cs.C2S_Mystery_GetRoomList",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_GETROOMLIST_MYSTERY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_GETROOMLIST_RET_F, {
	"ret",
	".cs.S2C_Mystery_GetRoomList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_GETROOMLIST_MYSTERY_ID_F, {
	"mystery_id",
	".cs.S2C_Mystery_GetRoomList.mystery_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_GETROOMLIST_ROOM_ID_LIST_F, {
	"room_id_list",
	".cs.S2C_Mystery_GetRoomList.room_id_list",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_GETROOMLIST_ROOM_NUM_LIST_F, {
	"room_num_list",
	".cs.S2C_Mystery_GetRoomList.room_num_list",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_GETROOMLIST_ME, {
	"S2C_Mystery_GetRoomList",
	".cs.S2C_Mystery_GetRoomList",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_GETROOMLIST_RET_F,
		var_0_10.S2C_MYSTERY_GETROOMLIST_MYSTERY_ID_F,
		var_0_10.S2C_MYSTERY_GETROOMLIST_ROOM_ID_LIST_F,
		var_0_10.S2C_MYSTERY_GETROOMLIST_ROOM_NUM_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_ENTER_MYSTERY_ID_F, {
	"mystery_id",
	".cs.C2S_Mystery_Enter.mystery_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_ENTER_ROOM_ID_F, {
	"room_id",
	".cs.C2S_Mystery_Enter.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_ENTER_POS_F, {
	"pos",
	".cs.C2S_Mystery_Enter.pos",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_ENTER_ME, {
	"C2S_Mystery_Enter",
	".cs.C2S_Mystery_Enter",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_ENTER_MYSTERY_ID_F,
		var_0_10.C2S_MYSTERY_ENTER_ROOM_ID_F,
		var_0_10.C2S_MYSTERY_ENTER_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ENTER_RET_F, {
	"ret",
	".cs.S2C_Mystery_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ENTER_MYSTERY_ID_F, {
	"mystery_id",
	".cs.S2C_Mystery_Enter.mystery_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ENTER_ROOM_ID_F, {
	"room_id",
	".cs.S2C_Mystery_Enter.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ENTER_POS_F, {
	"pos",
	".cs.S2C_Mystery_Enter.pos",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ENTER_ROOM_F, {
	"room",
	".cs.S2C_Mystery_Enter.room",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.MYSTERYROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_ENTER_ME, {
	"S2C_Mystery_Enter",
	".cs.S2C_Mystery_Enter",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_ENTER_RET_F,
		var_0_10.S2C_MYSTERY_ENTER_MYSTERY_ID_F,
		var_0_10.S2C_MYSTERY_ENTER_ROOM_ID_F,
		var_0_10.S2C_MYSTERY_ENTER_POS_F,
		var_0_10.S2C_MYSTERY_ENTER_ROOM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_EXIT_ME, {
	"C2S_Mystery_Exit",
	".cs.C2S_Mystery_Exit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_EXIT_RET_F, {
	"ret",
	".cs.S2C_Mystery_Exit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_EXIT_ME, {
	"S2C_Mystery_Exit",
	".cs.S2C_Mystery_Exit",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_EXIT_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_MOVE_POS_F, {
	"pos",
	".cs.C2S_Mystery_Move.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_MOVE_ME, {
	"C2S_Mystery_Move",
	".cs.C2S_Mystery_Move",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_MOVE_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MOVE_RET_F, {
	"ret",
	".cs.S2C_Mystery_Move.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MOVE_POS_F, {
	"pos",
	".cs.S2C_Mystery_Move.pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_MOVE_ME, {
	"S2C_Mystery_Move",
	".cs.S2C_Mystery_Move",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_MOVE_RET_F,
		var_0_10.S2C_MYSTERY_MOVE_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_MONSTER_CHALLENGEBEGIN_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_Mystery_Monster_ChallengeBegin.monster_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_MONSTER_CHALLENGEBEGIN_ME, {
	"C2S_Mystery_Monster_ChallengeBegin",
	".cs.C2S_Mystery_Monster_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_MONSTER_CHALLENGEBEGIN_MONSTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Mystery_Monster_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_Mystery_Monster_ChallengeBegin.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Mystery_Monster_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_ME, {
	"S2C_Mystery_Monster_ChallengeBegin",
	".cs.S2C_Mystery_Monster_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_MONSTER_ID_F,
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_MONSTER_FASTCHALLENGE_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_Mystery_Monster_FastChallenge.monster_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_MONSTER_FASTCHALLENGE_ME, {
	"C2S_Mystery_Monster_FastChallenge",
	".cs.C2S_Mystery_Monster_FastChallenge",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_MONSTER_FASTCHALLENGE_MONSTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_Mystery_Monster_FastChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_Mystery_Monster_FastChallenge.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_AWARDS_F, {
	"awards",
	".cs.S2C_Mystery_Monster_FastChallenge.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_ME, {
	"S2C_Mystery_Monster_FastChallenge",
	".cs.S2C_Mystery_Monster_FastChallenge",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_RET_F,
		var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_MONSTER_ID_F,
		var_0_10.S2C_MYSTERY_MONSTER_FASTCHALLENGE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Mystery_Monster_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_Mystery_Monster_ChallengeFinish.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Mystery_Monster_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Mystery_Monster_ChallengeFinish.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_ME, {
	"S2C_Mystery_Monster_ChallengeFinish",
	".cs.S2C_Mystery_Monster_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_MONSTER_ID_F,
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_MYSTERY_MONSTER_CHALLENGEFINISH_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_ELITE_CHALLENGEBEGIN_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_Mystery_Elite_ChallengeBegin.monster_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_ELITE_CHALLENGEBEGIN_ME, {
	"C2S_Mystery_Elite_ChallengeBegin",
	".cs.C2S_Mystery_Elite_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_ELITE_CHALLENGEBEGIN_MONSTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Mystery_Elite_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_Mystery_Elite_ChallengeBegin.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Mystery_Elite_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_ME, {
	"S2C_Mystery_Elite_ChallengeBegin",
	".cs.S2C_Mystery_Elite_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_MONSTER_ID_F,
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Mystery_Elite_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_Mystery_Elite_ChallengeFinish.monster_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Mystery_Elite_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Mystery_Elite_ChallengeFinish.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_ME, {
	"S2C_Mystery_Elite_ChallengeFinish",
	".cs.S2C_Mystery_Elite_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_MONSTER_ID_F,
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_MYSTERY_ELITE_CHALLENGEFINISH_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_ACCEPTTASK_TASK_ID_F, {
	"task_id",
	".cs.C2S_Mystery_AcceptTask.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_ACCEPTTASK_ME, {
	"C2S_Mystery_AcceptTask",
	".cs.C2S_Mystery_AcceptTask",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_ACCEPTTASK_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ACCEPTTASK_RET_F, {
	"ret",
	".cs.S2C_Mystery_AcceptTask.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_ACCEPTTASK_TASK_ID_F, {
	"task_id",
	".cs.S2C_Mystery_AcceptTask.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_ACCEPTTASK_ME, {
	"S2C_Mystery_AcceptTask",
	".cs.S2C_Mystery_AcceptTask",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_ACCEPTTASK_RET_F,
		var_0_10.S2C_MYSTERY_ACCEPTTASK_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_GIVEUPTASK_ME, {
	"C2S_Mystery_GiveUpTask",
	".cs.C2S_Mystery_GiveUpTask",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_GIVEUPTASK_RET_F, {
	"ret",
	".cs.S2C_Mystery_GiveUpTask.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_GIVEUPTASK_ME, {
	"S2C_Mystery_GiveUpTask",
	".cs.S2C_Mystery_GiveUpTask",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_GIVEUPTASK_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_AWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Mystery_Award.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_AWARD_ME, {
	"C2S_Mystery_Award",
	".cs.C2S_Mystery_Award",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_AWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_AWARD_RET_F, {
	"ret",
	".cs.S2C_Mystery_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_AWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Mystery_Award.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Mystery_Award.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_AWARD_ME, {
	"S2C_Mystery_Award",
	".cs.S2C_Mystery_Award",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_AWARD_RET_F,
		var_0_10.S2C_MYSTERY_AWARD_TASK_ID_F,
		var_0_10.S2C_MYSTERY_AWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_STORY_FINISH_STORY_ID_F, {
	"story_id",
	".cs.C2S_Mystery_Story_Finish.story_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_STORY_FINISH_ME, {
	"C2S_Mystery_Story_Finish",
	".cs.C2S_Mystery_Story_Finish",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_STORY_FINISH_STORY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_STORY_FINISH_RET_F, {
	"ret",
	".cs.S2C_Mystery_Story_Finish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_STORY_FINISH_STORY_ID_F, {
	"story_id",
	".cs.S2C_Mystery_Story_Finish.story_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_STORY_FINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Mystery_Story_Finish.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_STORY_FINISH_ME, {
	"S2C_Mystery_Story_Finish",
	".cs.S2C_Mystery_Story_Finish",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_STORY_FINISH_RET_F,
		var_0_10.S2C_MYSTERY_STORY_FINISH_STORY_ID_F,
		var_0_10.S2C_MYSTERY_STORY_FINISH_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYMOVE_USER_F, {
	"user",
	".cs.S2C_Mystery_NotifyMove.user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.MYSTERYUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYMOVE_ME, {
	"S2C_Mystery_NotifyMove",
	".cs.S2C_Mystery_NotifyMove",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_NOTIFYMOVE_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYATTACK_USER_F, {
	"user",
	".cs.S2C_Mystery_NotifyAttack.user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.MYSTERYUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYATTACK_DAMAGE_F, {
	"damage",
	".cs.S2C_Mystery_NotifyAttack.damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYATTACK_MONSTER_F, {
	"monster",
	".cs.S2C_Mystery_NotifyAttack.monster",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.MYSTERYMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYATTACK_ME, {
	"S2C_Mystery_NotifyAttack",
	".cs.S2C_Mystery_NotifyAttack",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_NOTIFYATTACK_USER_F,
		var_0_10.S2C_MYSTERY_NOTIFYATTACK_DAMAGE_F,
		var_0_10.S2C_MYSTERY_NOTIFYATTACK_MONSTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYTASK_TASK_LIST_F, {
	"task_list",
	".cs.S2C_Mystery_NotifyTask.task_list",
	1,
	0,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYTASK_ME, {
	"S2C_Mystery_NotifyTask",
	".cs.S2C_Mystery_NotifyTask",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_NOTIFYTASK_TASK_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYEXIT_UID_F, {
	"uid",
	".cs.S2C_Mystery_NotifyExit.uid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYEXIT_ME, {
	"S2C_Mystery_NotifyExit",
	".cs.S2C_Mystery_NotifyExit",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_NOTIFYEXIT_UID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_SENDLOOK_LOOK_F, {
	"look",
	".cs.C2S_Mystery_SendLook.look",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERY_SENDLOOK_LOOK_TYPE_F, {
	"look_type",
	".cs.C2S_Mystery_SendLook.look_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERY_SENDLOOK_ME, {
	"C2S_Mystery_SendLook",
	".cs.C2S_Mystery_SendLook",
	{},
	{},
	{
		var_0_10.C2S_MYSTERY_SENDLOOK_LOOK_F,
		var_0_10.C2S_MYSTERY_SENDLOOK_LOOK_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_SENDLOOK_RET_F, {
	"ret",
	".cs.S2C_Mystery_SendLook.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_SENDLOOK_LOOK_F, {
	"look",
	".cs.S2C_Mystery_SendLook.look",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_SENDLOOK_LOOK_TYPE_F, {
	"look_type",
	".cs.S2C_Mystery_SendLook.look_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_SENDLOOK_ME, {
	"S2C_Mystery_SendLook",
	".cs.S2C_Mystery_SendLook",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_SENDLOOK_RET_F,
		var_0_10.S2C_MYSTERY_SENDLOOK_LOOK_F,
		var_0_10.S2C_MYSTERY_SENDLOOK_LOOK_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYLOOK_UID_F, {
	"uid",
	".cs.S2C_Mystery_NotifyLook.uid",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYLOOK_LOOK_F, {
	"look",
	".cs.S2C_Mystery_NotifyLook.look",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYLOOK_LOOK_TYPE_F, {
	"look_type",
	".cs.S2C_Mystery_NotifyLook.look_type",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERY_NOTIFYLOOK_ME, {
	"S2C_Mystery_NotifyLook",
	".cs.S2C_Mystery_NotifyLook",
	{},
	{},
	{
		var_0_10.S2C_MYSTERY_NOTIFYLOOK_UID_F,
		var_0_10.S2C_MYSTERY_NOTIFYLOOK_LOOK_F,
		var_0_10.S2C_MYSTERY_NOTIFYLOOK_LOOK_TYPE_F
	},
	false,
	{}
})

return var_0_10
