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
	C2S_PUBG_GETINFO_ME = protobuf.Descriptor(),
	S2C_PUBG_GETINFO_ME = protobuf.Descriptor(),
	S2C_PUBG_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GETINFO_SCORE_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GETINFO_RANK_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GETINFO_PLAY_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GETINFO_MATCH_NUM_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GETINFO_DAILY_MAX_SCORE_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GETINFO_DAILY_MAX_RANK_F = protobuf.FieldDescriptor(),
	C2S_PUBG_MATCH_ME = protobuf.Descriptor(),
	S2C_PUBG_MATCH_ME = protobuf.Descriptor(),
	S2C_PUBG_MATCH_RET_F = protobuf.FieldDescriptor(),
	C2S_PUBG_CANCELMATCH_ME = protobuf.Descriptor(),
	S2C_PUBG_CANCELMATCH_ME = protobuf.Descriptor(),
	S2C_PUBG_CANCELMATCH_RET_F = protobuf.FieldDescriptor(),
	C2S_PUBG_ENTER_ME = protobuf.Descriptor(),
	S2C_PUBG_ENTER_ME = protobuf.Descriptor(),
	S2C_PUBG_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_ENTER_ROOM_F = protobuf.FieldDescriptor(),
	C2S_PUBG_EXIT_ME = protobuf.Descriptor(),
	S2C_PUBG_EXIT_ME = protobuf.Descriptor(),
	S2C_PUBG_EXIT_RET_F = protobuf.FieldDescriptor(),
	C2S_PUBG_MOVE_ME = protobuf.Descriptor(),
	C2S_PUBG_MOVE_X_F = protobuf.FieldDescriptor(),
	C2S_PUBG_MOVE_Y_F = protobuf.FieldDescriptor(),
	S2C_PUBG_MOVE_ME = protobuf.Descriptor(),
	S2C_PUBG_MOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_MOVE_X_F = protobuf.FieldDescriptor(),
	S2C_PUBG_MOVE_Y_F = protobuf.FieldDescriptor(),
	S2C_PUBG_MOVENOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_MOVENOTICE_LIST_F = protobuf.FieldDescriptor(),
	C2S_PUBG_CHALLENGE_ME = protobuf.Descriptor(),
	C2S_PUBG_CHALLENGE_TP_F = protobuf.FieldDescriptor(),
	C2S_PUBG_CHALLENGE_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_CHALLENGE_ME = protobuf.Descriptor(),
	S2C_PUBG_CHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_CHALLENGE_TP_F = protobuf.FieldDescriptor(),
	S2C_PUBG_CHALLENGE_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_CHALLENGE_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_PUBG_CHALLENGE_ADD_SCORE_F = protobuf.FieldDescriptor(),
	S2C_PUBG_UPDATEUSER_ME = protobuf.Descriptor(),
	S2C_PUBG_UPDATEUSER_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_UPDATEUSER_LIST_F = protobuf.FieldDescriptor(),
	S2C_PUBG_DEADNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_DEADNOTICE_TP_F = protobuf.FieldDescriptor(),
	S2C_PUBG_DEADNOTICE_ATTACK_F = protobuf.FieldDescriptor(),
	S2C_PUBG_DEADNOTICE_DEFEND_F = protobuf.FieldDescriptor(),
	S2C_PUBG_DEADNOTICE_DEAD_F = protobuf.FieldDescriptor(),
	S2C_PUBG_DEADNOTICE_DROP_BUFF_F = protobuf.FieldDescriptor(),
	S2C_PUBG_RECOVERNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_RECOVERNOTICE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_RECOVERNOTICE_X_F = protobuf.FieldDescriptor(),
	S2C_PUBG_RECOVERNOTICE_Y_F = protobuf.FieldDescriptor(),
	C2S_PUBG_PICKBUFF_ME = protobuf.Descriptor(),
	C2S_PUBG_PICKBUFF_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKBUFF_ME = protobuf.Descriptor(),
	S2C_PUBG_PICKBUFF_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKBUFFNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_PICKBUFFNOTICE_USERID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKBUFFNOTICE_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKBUFFNOTICE_BUFF_F = protobuf.FieldDescriptor(),
	S2C_PUBG_REMOVEBUFFNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_REMOVEBUFFNOTICE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_REMOVEBUFFNOTICE_TP_F = protobuf.FieldDescriptor(),
	S2C_PUBG_SHRINKCIRCLE_ME = protobuf.Descriptor(),
	S2C_PUBG_SHRINKCIRCLE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_PUBG_REFRESH_ME = protobuf.Descriptor(),
	S2C_PUBG_REFRESH_LAST_REFRESH_TIME_F = protobuf.FieldDescriptor(),
	S2C_PUBG_REFRESH_MONSTERS_F = protobuf.FieldDescriptor(),
	S2C_PUBG_REFRESH_BUFFS_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GAMEBEGIN_ME = protobuf.Descriptor(),
	S2C_PUBG_GAMEEND_ME = protobuf.Descriptor(),
	S2C_PUBG_GAMEEND_SCORE_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GAMEEND_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_PUBG_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_PUBG_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_PUBG_SERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_SERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_PUBG_ADDEXPNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_ADDEXPNOTICE_ADD_EXP_F = protobuf.FieldDescriptor(),
	S2C_PUBG_ADDEXPNOTICE_EXP_F = protobuf.FieldDescriptor(),
	S2C_PUBG_REFRESHAIRDROP_ME = protobuf.Descriptor(),
	S2C_PUBG_REFRESHAIRDROP_AIRDROP_F = protobuf.FieldDescriptor(),
	C2S_PUBG_PICKAIRDROP_ME = protobuf.Descriptor(),
	C2S_PUBG_PICKAIRDROP_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKAIRDROP_ME = protobuf.Descriptor(),
	S2C_PUBG_PICKAIRDROP_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKAIRDROP_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKAIRDROPNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_PICKAIRDROPNOTICE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKAIRDROPNOTICE_PICK_TIME_F = protobuf.FieldDescriptor(),
	S2C_PUBG_PICKAIRDROPNOTICE_AIRDROP_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GAINAIRDROP_ME = protobuf.Descriptor(),
	S2C_PUBG_GAINAIRDROP_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GAINAIRDROP_AIRDROP_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_GAINAIRDROP_EFFECT_F = protobuf.FieldDescriptor(),
	C2S_PUBG_TASKINFO_ME = protobuf.Descriptor(),
	S2C_PUBG_TASKINFO_ME = protobuf.Descriptor(),
	S2C_PUBG_TASKINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TASKINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_PUBG_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_PUBG_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_PUBG_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TEXTNOTICE_ME = protobuf.Descriptor(),
	S2C_PUBG_TEXTNOTICE_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TEXTNOTICE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_PUBG_TEXTNOTICE_TARGET_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_GETINFO_ME, {
	"C2S_Pubg_GetInfo",
	".cs.C2S_Pubg_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Pubg_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_SCORE_F, {
	"score",
	".cs.S2C_Pubg_GetInfo.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_RANK_F, {
	"rank",
	".cs.S2C_Pubg_GetInfo.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_PLAY_F, {
	"play",
	".cs.S2C_Pubg_GetInfo.play",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_MATCH_NUM_F, {
	"match_num",
	".cs.S2C_Pubg_GetInfo.match_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_DAILY_MAX_SCORE_F, {
	"daily_max_score",
	".cs.S2C_Pubg_GetInfo.daily_max_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GETINFO_DAILY_MAX_RANK_F, {
	"daily_max_rank",
	".cs.S2C_Pubg_GetInfo.daily_max_rank",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_GETINFO_ME, {
	"S2C_Pubg_GetInfo",
	".cs.S2C_Pubg_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_PUBG_GETINFO_RET_F,
		var_0_10.S2C_PUBG_GETINFO_SCORE_F,
		var_0_10.S2C_PUBG_GETINFO_RANK_F,
		var_0_10.S2C_PUBG_GETINFO_PLAY_F,
		var_0_10.S2C_PUBG_GETINFO_MATCH_NUM_F,
		var_0_10.S2C_PUBG_GETINFO_DAILY_MAX_SCORE_F,
		var_0_10.S2C_PUBG_GETINFO_DAILY_MAX_RANK_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_MATCH_ME, {
	"C2S_Pubg_Match",
	".cs.C2S_Pubg_Match",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_MATCH_RET_F, {
	"ret",
	".cs.S2C_Pubg_Match.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_MATCH_ME, {
	"S2C_Pubg_Match",
	".cs.S2C_Pubg_Match",
	{},
	{},
	{
		var_0_10.S2C_PUBG_MATCH_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_CANCELMATCH_ME, {
	"C2S_Pubg_CancelMatch",
	".cs.C2S_Pubg_CancelMatch",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_CANCELMATCH_RET_F, {
	"ret",
	".cs.S2C_Pubg_CancelMatch.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_CANCELMATCH_ME, {
	"S2C_Pubg_CancelMatch",
	".cs.S2C_Pubg_CancelMatch",
	{},
	{},
	{
		var_0_10.S2C_PUBG_CANCELMATCH_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_ENTER_ME, {
	"C2S_Pubg_Enter",
	".cs.C2S_Pubg_Enter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_ENTER_RET_F, {
	"ret",
	".cs.S2C_Pubg_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_ENTER_ROOM_F, {
	"room",
	".cs.S2C_Pubg_Enter.room",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.PUBGROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_ENTER_ME, {
	"S2C_Pubg_Enter",
	".cs.S2C_Pubg_Enter",
	{},
	{},
	{
		var_0_10.S2C_PUBG_ENTER_RET_F,
		var_0_10.S2C_PUBG_ENTER_ROOM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_EXIT_ME, {
	"C2S_Pubg_Exit",
	".cs.C2S_Pubg_Exit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_EXIT_RET_F, {
	"ret",
	".cs.S2C_Pubg_Exit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_EXIT_ME, {
	"S2C_Pubg_Exit",
	".cs.S2C_Pubg_Exit",
	{},
	{},
	{
		var_0_10.S2C_PUBG_EXIT_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_MOVE_X_F, {
	"x",
	".cs.C2S_Pubg_Move.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_MOVE_Y_F, {
	"y",
	".cs.C2S_Pubg_Move.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_MOVE_ME, {
	"C2S_Pubg_Move",
	".cs.C2S_Pubg_Move",
	{},
	{},
	{
		var_0_10.C2S_PUBG_MOVE_X_F,
		var_0_10.C2S_PUBG_MOVE_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_MOVE_RET_F, {
	"ret",
	".cs.S2C_Pubg_Move.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_MOVE_X_F, {
	"x",
	".cs.S2C_Pubg_Move.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_MOVE_Y_F, {
	"y",
	".cs.S2C_Pubg_Move.y",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_MOVE_ME, {
	"S2C_Pubg_Move",
	".cs.S2C_Pubg_Move",
	{},
	{},
	{
		var_0_10.S2C_PUBG_MOVE_RET_F,
		var_0_10.S2C_PUBG_MOVE_X_F,
		var_0_10.S2C_PUBG_MOVE_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_MOVENOTICE_LIST_F, {
	"list",
	".cs.S2C_Pubg_MoveNotice.list",
	1,
	0,
	3,
	false,
	{},
	var_0_3.PUBGUSERMOVE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_MOVENOTICE_ME, {
	"S2C_Pubg_MoveNotice",
	".cs.S2C_Pubg_MoveNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_MOVENOTICE_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_CHALLENGE_TP_F, {
	"tp",
	".cs.C2S_Pubg_Challenge.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_CHALLENGE_ID_F, {
	"id",
	".cs.C2S_Pubg_Challenge.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_CHALLENGE_ME, {
	"C2S_Pubg_Challenge",
	".cs.C2S_Pubg_Challenge",
	{},
	{},
	{
		var_0_10.C2S_PUBG_CHALLENGE_TP_F,
		var_0_10.C2S_PUBG_CHALLENGE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_CHALLENGE_RET_F, {
	"ret",
	".cs.S2C_Pubg_Challenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_CHALLENGE_TP_F, {
	"tp",
	".cs.S2C_Pubg_Challenge.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_CHALLENGE_ID_F, {
	"id",
	".cs.S2C_Pubg_Challenge.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_CHALLENGE_IS_WIN_F, {
	"is_win",
	".cs.S2C_Pubg_Challenge.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_CHALLENGE_ADD_SCORE_F, {
	"add_score",
	".cs.S2C_Pubg_Challenge.add_score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_CHALLENGE_ME, {
	"S2C_Pubg_Challenge",
	".cs.S2C_Pubg_Challenge",
	{},
	{},
	{
		var_0_10.S2C_PUBG_CHALLENGE_RET_F,
		var_0_10.S2C_PUBG_CHALLENGE_TP_F,
		var_0_10.S2C_PUBG_CHALLENGE_ID_F,
		var_0_10.S2C_PUBG_CHALLENGE_IS_WIN_F,
		var_0_10.S2C_PUBG_CHALLENGE_ADD_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_UPDATEUSER_USER_ID_F, {
	"user_id",
	".cs.S2C_Pubg_UpdateUser.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_UPDATEUSER_LIST_F, {
	"list",
	".cs.S2C_Pubg_UpdateUser.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_UPDATEUSER_ME, {
	"S2C_Pubg_UpdateUser",
	".cs.S2C_Pubg_UpdateUser",
	{},
	{},
	{
		var_0_10.S2C_PUBG_UPDATEUSER_USER_ID_F,
		var_0_10.S2C_PUBG_UPDATEUSER_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_DEADNOTICE_TP_F, {
	"tp",
	".cs.S2C_Pubg_DeadNotice.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_DEADNOTICE_ATTACK_F, {
	"attack",
	".cs.S2C_Pubg_DeadNotice.attack",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.PUBGOBJECT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_DEADNOTICE_DEFEND_F, {
	"defend",
	".cs.S2C_Pubg_DeadNotice.defend",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.PUBGOBJECT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_DEADNOTICE_DEAD_F, {
	"dead",
	".cs.S2C_Pubg_DeadNotice.dead",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.PUBGOBJECT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_DEADNOTICE_DROP_BUFF_F, {
	"drop_buff",
	".cs.S2C_Pubg_DeadNotice.drop_buff",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.PUBGDROPBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_DEADNOTICE_ME, {
	"S2C_Pubg_DeadNotice",
	".cs.S2C_Pubg_DeadNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_DEADNOTICE_TP_F,
		var_0_10.S2C_PUBG_DEADNOTICE_ATTACK_F,
		var_0_10.S2C_PUBG_DEADNOTICE_DEFEND_F,
		var_0_10.S2C_PUBG_DEADNOTICE_DEAD_F,
		var_0_10.S2C_PUBG_DEADNOTICE_DROP_BUFF_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_RECOVERNOTICE_USER_ID_F, {
	"user_id",
	".cs.S2C_Pubg_RecoverNotice.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_RECOVERNOTICE_X_F, {
	"x",
	".cs.S2C_Pubg_RecoverNotice.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_RECOVERNOTICE_Y_F, {
	"y",
	".cs.S2C_Pubg_RecoverNotice.y",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_RECOVERNOTICE_ME, {
	"S2C_Pubg_RecoverNotice",
	".cs.S2C_Pubg_RecoverNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_RECOVERNOTICE_USER_ID_F,
		var_0_10.S2C_PUBG_RECOVERNOTICE_X_F,
		var_0_10.S2C_PUBG_RECOVERNOTICE_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_PICKBUFF_ID_F, {
	"id",
	".cs.C2S_Pubg_PickBuff.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_PICKBUFF_ME, {
	"C2S_Pubg_PickBuff",
	".cs.C2S_Pubg_PickBuff",
	{},
	{},
	{
		var_0_10.C2S_PUBG_PICKBUFF_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKBUFF_RET_F, {
	"ret",
	".cs.S2C_Pubg_PickBuff.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_PICKBUFF_ME, {
	"S2C_Pubg_PickBuff",
	".cs.S2C_Pubg_PickBuff",
	{},
	{},
	{
		var_0_10.S2C_PUBG_PICKBUFF_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKBUFFNOTICE_USERID_F, {
	"userId",
	".cs.S2C_Pubg_PickBuffNotice.userId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKBUFFNOTICE_ID_F, {
	"id",
	".cs.S2C_Pubg_PickBuffNotice.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKBUFFNOTICE_BUFF_F, {
	"buff",
	".cs.S2C_Pubg_PickBuffNotice.buff",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.PUBGUSERBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_PICKBUFFNOTICE_ME, {
	"S2C_Pubg_PickBuffNotice",
	".cs.S2C_Pubg_PickBuffNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_PICKBUFFNOTICE_USERID_F,
		var_0_10.S2C_PUBG_PICKBUFFNOTICE_ID_F,
		var_0_10.S2C_PUBG_PICKBUFFNOTICE_BUFF_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_REMOVEBUFFNOTICE_USER_ID_F, {
	"user_id",
	".cs.S2C_Pubg_RemoveBuffNotice.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_REMOVEBUFFNOTICE_TP_F, {
	"tp",
	".cs.S2C_Pubg_RemoveBuffNotice.tp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_REMOVEBUFFNOTICE_ME, {
	"S2C_Pubg_RemoveBuffNotice",
	".cs.S2C_Pubg_RemoveBuffNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_REMOVEBUFFNOTICE_USER_ID_F,
		var_0_10.S2C_PUBG_REMOVEBUFFNOTICE_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_SHRINKCIRCLE_LEVEL_F, {
	"level",
	".cs.S2C_Pubg_ShrinkCircle.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_SHRINKCIRCLE_ME, {
	"S2C_Pubg_ShrinkCircle",
	".cs.S2C_Pubg_ShrinkCircle",
	{},
	{},
	{
		var_0_10.S2C_PUBG_SHRINKCIRCLE_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_REFRESH_LAST_REFRESH_TIME_F, {
	"last_refresh_time",
	".cs.S2C_Pubg_Refresh.last_refresh_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_REFRESH_MONSTERS_F, {
	"monsters",
	".cs.S2C_Pubg_Refresh.monsters",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PUBGMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_REFRESH_BUFFS_F, {
	"buffs",
	".cs.S2C_Pubg_Refresh.buffs",
	3,
	2,
	3,
	false,
	{},
	var_0_3.PUBGBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_REFRESH_ME, {
	"S2C_Pubg_Refresh",
	".cs.S2C_Pubg_Refresh",
	{},
	{},
	{
		var_0_10.S2C_PUBG_REFRESH_LAST_REFRESH_TIME_F,
		var_0_10.S2C_PUBG_REFRESH_MONSTERS_F,
		var_0_10.S2C_PUBG_REFRESH_BUFFS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_GAMEBEGIN_ME, {
	"S2C_Pubg_GameBegin",
	".cs.S2C_Pubg_GameBegin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GAMEEND_SCORE_F, {
	"score",
	".cs.S2C_Pubg_GameEnd.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GAMEEND_AWARDS_F, {
	"awards",
	".cs.S2C_Pubg_GameEnd.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_GAMEEND_ME, {
	"S2C_Pubg_GameEnd",
	".cs.S2C_Pubg_GameEnd",
	{},
	{},
	{
		var_0_10.S2C_PUBG_GAMEEND_SCORE_F,
		var_0_10.S2C_PUBG_GAMEEND_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_SERVERINFOS_ME, {
	"C2S_Pubg_ServerInfos",
	".cs.C2S_Pubg_ServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_SERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_Pubg_ServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_SERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_Pubg_ServerInfos.server_infos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_SERVERINFOS_ME, {
	"S2C_Pubg_ServerInfos",
	".cs.S2C_Pubg_ServerInfos",
	{},
	{},
	{
		var_0_10.S2C_PUBG_SERVERINFOS_RET_F,
		var_0_10.S2C_PUBG_SERVERINFOS_SERVER_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_ADDEXPNOTICE_ADD_EXP_F, {
	"add_exp",
	".cs.S2C_Pubg_AddExpNotice.add_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_ADDEXPNOTICE_EXP_F, {
	"exp",
	".cs.S2C_Pubg_AddExpNotice.exp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_ADDEXPNOTICE_ME, {
	"S2C_Pubg_AddExpNotice",
	".cs.S2C_Pubg_AddExpNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_ADDEXPNOTICE_ADD_EXP_F,
		var_0_10.S2C_PUBG_ADDEXPNOTICE_EXP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_REFRESHAIRDROP_AIRDROP_F, {
	"airdrop",
	".cs.S2C_Pubg_RefreshAirdrop.airdrop",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.PUBGAIRDROP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_REFRESHAIRDROP_ME, {
	"S2C_Pubg_RefreshAirdrop",
	".cs.S2C_Pubg_RefreshAirdrop",
	{},
	{},
	{
		var_0_10.S2C_PUBG_REFRESHAIRDROP_AIRDROP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_PICKAIRDROP_ID_F, {
	"id",
	".cs.C2S_Pubg_PickAirdrop.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_PICKAIRDROP_ME, {
	"C2S_Pubg_PickAirdrop",
	".cs.C2S_Pubg_PickAirdrop",
	{},
	{},
	{
		var_0_10.C2S_PUBG_PICKAIRDROP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROP_RET_F, {
	"ret",
	".cs.S2C_Pubg_PickAirdrop.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROP_ID_F, {
	"id",
	".cs.S2C_Pubg_PickAirdrop.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROP_ME, {
	"S2C_Pubg_PickAirdrop",
	".cs.S2C_Pubg_PickAirdrop",
	{},
	{},
	{
		var_0_10.S2C_PUBG_PICKAIRDROP_RET_F,
		var_0_10.S2C_PUBG_PICKAIRDROP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_USER_ID_F, {
	"user_id",
	".cs.S2C_Pubg_PickAirdropNotice.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_PICK_TIME_F, {
	"pick_time",
	".cs.S2C_Pubg_PickAirdropNotice.pick_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_AIRDROP_ID_F, {
	"airdrop_id",
	".cs.S2C_Pubg_PickAirdropNotice.airdrop_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_ME, {
	"S2C_Pubg_PickAirdropNotice",
	".cs.S2C_Pubg_PickAirdropNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_USER_ID_F,
		var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_PICK_TIME_F,
		var_0_10.S2C_PUBG_PICKAIRDROPNOTICE_AIRDROP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GAINAIRDROP_USER_ID_F, {
	"user_id",
	".cs.S2C_Pubg_GainAirdrop.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GAINAIRDROP_AIRDROP_ID_F, {
	"airdrop_id",
	".cs.S2C_Pubg_GainAirdrop.airdrop_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_GAINAIRDROP_EFFECT_F, {
	"effect",
	".cs.S2C_Pubg_GainAirdrop.effect",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.PUBGUSEREFFECT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_GAINAIRDROP_ME, {
	"S2C_Pubg_GainAirdrop",
	".cs.S2C_Pubg_GainAirdrop",
	{},
	{},
	{
		var_0_10.S2C_PUBG_GAINAIRDROP_USER_ID_F,
		var_0_10.S2C_PUBG_GAINAIRDROP_AIRDROP_ID_F,
		var_0_10.S2C_PUBG_GAINAIRDROP_EFFECT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_TASKINFO_ME, {
	"C2S_Pubg_TaskInfo",
	".cs.C2S_Pubg_TaskInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TASKINFO_RET_F, {
	"ret",
	".cs.S2C_Pubg_TaskInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TASKINFO_TASKS_F, {
	"tasks",
	".cs.S2C_Pubg_TaskInfo.tasks",
	2,
	1,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_TASKINFO_ME, {
	"S2C_Pubg_TaskInfo",
	".cs.S2C_Pubg_TaskInfo",
	{},
	{},
	{
		var_0_10.S2C_PUBG_TASKINFO_RET_F,
		var_0_10.S2C_PUBG_TASKINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PUBG_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Pubg_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PUBG_TASKAWARD_ME, {
	"C2S_Pubg_TaskAward",
	".cs.C2S_Pubg_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_PUBG_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Pubg_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Pubg_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Pubg_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_TASKAWARD_ME, {
	"S2C_Pubg_TaskAward",
	".cs.S2C_Pubg_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_PUBG_TASKAWARD_RET_F,
		var_0_10.S2C_PUBG_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_PUBG_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TEXTNOTICE_BASE_ID_F, {
	"base_id",
	".cs.S2C_Pubg_TextNotice.base_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TEXTNOTICE_USER_ID_F, {
	"user_id",
	".cs.S2C_Pubg_TextNotice.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PUBG_TEXTNOTICE_TARGET_ID_F, {
	"target_id",
	".cs.S2C_Pubg_TextNotice.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PUBG_TEXTNOTICE_ME, {
	"S2C_Pubg_TextNotice",
	".cs.S2C_Pubg_TextNotice",
	{},
	{},
	{
		var_0_10.S2C_PUBG_TEXTNOTICE_BASE_ID_F,
		var_0_10.S2C_PUBG_TEXTNOTICE_USER_ID_F,
		var_0_10.S2C_PUBG_TEXTNOTICE_TARGET_ID_F
	},
	false,
	{}
})

return var_0_10
