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
	C2S_CHIBI_GETINFO_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETINFO_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_ACT_INFO_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_IS_APPLY_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_SCORE_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_POOL_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_HALF_FINAL_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_DAILY_MATCH_MAX_SCORE_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_HAS_ACHIEVEMENT_IDS_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_LOCAL_RANK_LENGTH_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_CROSS_RANK_LENGTH_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_CROSS_ACHIEVEMENT_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_ALLSERVER_ACHIEVEMENT_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_MAX_SEASON_SCORE_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_WIN_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_TURN_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_JOIN_TURN_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_OCCUPY_CHIBI_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_OCCUPY_MEDIUM_NUM_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETINFO_OCCUPY_COMPONENT_NUM_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_APPLY_ME = protobuf.Descriptor(),
	S2C_CHIBI_APPLY_ME = protobuf.Descriptor(),
	S2C_CHIBI_APPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_APPLY_IS_APPLY_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_APPLY_APPLY_TIME_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_APPLY_POOL_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_GETFINALROOM_ME = protobuf.Descriptor(),
	C2S_CHIBI_GETFINALROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETFINALROOM_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETFINALROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETFINALROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETFINALROOM_USER_FINAL_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_ME = protobuf.Descriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_SCORE_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_POOL_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_LOCAL_RANK_LENGTH_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_CROSS_RANK_LENGTH_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_CROSS_ACHIEVEMENT_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_ALLSERVER_ACHIEVEMENT_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERINFO_HALF_FINAL_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_ENTERROOM_ME = protobuf.Descriptor(),
	S2C_CHIBI_ENTERROOM_ME = protobuf.Descriptor(),
	S2C_CHIBI_ENTERROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ENTERROOM_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ENTERROOM_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ENTERROOM_SELF_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ENTERROOM_CS_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ENTERROOM_USERS_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_LEVELROOM_ME = protobuf.Descriptor(),
	S2C_CHIBI_LEVELROOM_ME = protobuf.Descriptor(),
	S2C_CHIBI_LEVELROOM_RET_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_LEVELCOMPONENT_ME = protobuf.Descriptor(),
	S2C_CHIBI_LEVELCOMPONENT_ME = protobuf.Descriptor(),
	S2C_CHIBI_LEVELCOMPONENT_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_LEVELCOMPONENT_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_LEVELCOMPONENT_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_GETRANKINFO_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETRANKINFO_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETRANKINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETRANKINFO_MY_SCORE_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETRANKINFO_USERS_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETRANKINFO_MY_RANK_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETRANKINFO_SELF_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_BATTLE_ME = protobuf.Descriptor(),
	C2S_CHIBI_BATTLE_ENEMY_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_BATTLE_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_BATTLE_ME = protobuf.Descriptor(),
	S2C_CHIBI_BATTLE_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_BATTLE_ENEMY_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_BATTLE_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_BATTLE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_CHECKBATTLE_ME = protobuf.Descriptor(),
	C2S_CHIBI_CHECKBATTLE_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_CHECKBATTLE_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_CHECKBATTLE_BATTLE_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_ME = protobuf.Descriptor(),
	S2C_CHIBI_CHECKBATTLE_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_BATTLE_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_CHECK_STATUS_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLE_ENEMY_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLEFINISH_ME = protobuf.Descriptor(),
	S2C_CHIBI_CHECKBATTLEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLEFINISH_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_CHECKBATTLEFINISH_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERREVIVE_ME = protobuf.Descriptor(),
	S2C_CHIBI_NOTIFYUSERREVIVE_REVIVE_TIME_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERREVIVE_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYUSERREVIVE_ENEMY_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYOCCUPYCHANGE_ME = protobuf.Descriptor(),
	S2C_CHIBI_NOTIFYOCCUPYCHANGE_COMPONENT_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYOCCUPYCHANGE_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYOCCUPYCHANGE_BEFORE_USER_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYFERTILITY_ME = protobuf.Descriptor(),
	S2C_CHIBI_NOTIFYFERTILITY_FERTILITY_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYMATCHEND_ME = protobuf.Descriptor(),
	S2C_CHIBI_NOTIFYMATCHEND_USERS_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_ACHIEVEMENTAWARD_ME = protobuf.Descriptor(),
	C2S_CHIBI_ACHIEVEMENTAWARD_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ACHIEVEMENTAWARD_ME = protobuf.Descriptor(),
	S2C_CHIBI_ACHIEVEMENTAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ACHIEVEMENTAWARD_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_ACHIEVEMENTAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYPROMOTIONLIST_ME = protobuf.Descriptor(),
	S2C_CHIBI_NOTIFYPROMOTIONLIST_USERS_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_NOTIFYPROMOTIONLIST_POOL_ID_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_GETPROMOTIONLIST_ME = protobuf.Descriptor(),
	C2S_CHIBI_GETPROMOTIONLIST_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETPROMOTIONLIST_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETPROMOTIONLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETPROMOTIONLIST_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETPROMOTIONLIST_USERS_F = protobuf.FieldDescriptor(),
	C2S_CHIBI_GETROOMUSER_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETROOMUSER_ME = protobuf.Descriptor(),
	S2C_CHIBI_GETROOMUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_CHIBI_GETROOMUSER_USERS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_GETINFO_ME, {
	"C2S_ChiBi_GetInfo",
	".cs.C2S_ChiBi_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_RET_F, {
	"ret",
	".cs.S2C_ChiBi_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_ACT_INFO_F, {
	"act_info",
	".cs.S2C_ChiBi_GetInfo.act_info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.CHIBIACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_IS_APPLY_F, {
	"is_apply",
	".cs.S2C_ChiBi_GetInfo.is_apply",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_POOL_ID_F, {
	"pool_id",
	".cs.S2C_ChiBi_GetInfo.pool_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_SCORE_F, {
	"score",
	".cs.S2C_ChiBi_GetInfo.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_POOL_RANK_F, {
	"pool_rank",
	".cs.S2C_ChiBi_GetInfo.pool_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_HALF_FINAL_ROOM_ID_F, {
	"half_final_room_id",
	".cs.S2C_ChiBi_GetInfo.half_final_room_id",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_DAILY_MATCH_MAX_SCORE_F, {
	"daily_match_max_score",
	".cs.S2C_ChiBi_GetInfo.daily_match_max_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_HAS_ACHIEVEMENT_IDS_F, {
	"has_achievement_ids",
	".cs.S2C_ChiBi_GetInfo.has_achievement_ids",
	9,
	8,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_LOCAL_RANK_LENGTH_F, {
	"local_rank_length",
	".cs.S2C_ChiBi_GetInfo.local_rank_length",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_CROSS_RANK_LENGTH_F, {
	"cross_rank_length",
	".cs.S2C_ChiBi_GetInfo.cross_rank_length",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_CROSS_ACHIEVEMENT_RANK_F, {
	"cross_achievement_rank",
	".cs.S2C_ChiBi_GetInfo.cross_achievement_rank",
	12,
	11,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_ALLSERVER_ACHIEVEMENT_RANK_F, {
	"allserver_achievement_rank",
	".cs.S2C_ChiBi_GetInfo.allserver_achievement_rank",
	13,
	12,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_MAX_SEASON_SCORE_F, {
	"max_season_score",
	".cs.S2C_ChiBi_GetInfo.max_season_score",
	14,
	13,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_CHALLENGE_NUM_F, {
	"challenge_num",
	".cs.S2C_ChiBi_GetInfo.challenge_num",
	15,
	14,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_WIN_CHALLENGE_NUM_F, {
	"win_challenge_num",
	".cs.S2C_ChiBi_GetInfo.win_challenge_num",
	16,
	15,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_TURN_CHALLENGE_NUM_F, {
	"turn_challenge_num",
	".cs.S2C_ChiBi_GetInfo.turn_challenge_num",
	17,
	16,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_JOIN_TURN_NUM_F, {
	"join_turn_num",
	".cs.S2C_ChiBi_GetInfo.join_turn_num",
	18,
	17,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_OCCUPY_CHIBI_NUM_F, {
	"occupy_chibi_num",
	".cs.S2C_ChiBi_GetInfo.occupy_chibi_num",
	19,
	18,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_OCCUPY_MEDIUM_NUM_F, {
	"occupy_medium_num",
	".cs.S2C_ChiBi_GetInfo.occupy_medium_num",
	20,
	19,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETINFO_OCCUPY_COMPONENT_NUM_F, {
	"occupy_component_num",
	".cs.S2C_ChiBi_GetInfo.occupy_component_num",
	21,
	20,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_GETINFO_ME, {
	"S2C_ChiBi_GetInfo",
	".cs.S2C_ChiBi_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_GETINFO_RET_F,
		var_0_10.S2C_CHIBI_GETINFO_ACT_INFO_F,
		var_0_10.S2C_CHIBI_GETINFO_IS_APPLY_F,
		var_0_10.S2C_CHIBI_GETINFO_POOL_ID_F,
		var_0_10.S2C_CHIBI_GETINFO_SCORE_F,
		var_0_10.S2C_CHIBI_GETINFO_POOL_RANK_F,
		var_0_10.S2C_CHIBI_GETINFO_HALF_FINAL_ROOM_ID_F,
		var_0_10.S2C_CHIBI_GETINFO_DAILY_MATCH_MAX_SCORE_F,
		var_0_10.S2C_CHIBI_GETINFO_HAS_ACHIEVEMENT_IDS_F,
		var_0_10.S2C_CHIBI_GETINFO_LOCAL_RANK_LENGTH_F,
		var_0_10.S2C_CHIBI_GETINFO_CROSS_RANK_LENGTH_F,
		var_0_10.S2C_CHIBI_GETINFO_CROSS_ACHIEVEMENT_RANK_F,
		var_0_10.S2C_CHIBI_GETINFO_ALLSERVER_ACHIEVEMENT_RANK_F,
		var_0_10.S2C_CHIBI_GETINFO_MAX_SEASON_SCORE_F,
		var_0_10.S2C_CHIBI_GETINFO_CHALLENGE_NUM_F,
		var_0_10.S2C_CHIBI_GETINFO_WIN_CHALLENGE_NUM_F,
		var_0_10.S2C_CHIBI_GETINFO_TURN_CHALLENGE_NUM_F,
		var_0_10.S2C_CHIBI_GETINFO_JOIN_TURN_NUM_F,
		var_0_10.S2C_CHIBI_GETINFO_OCCUPY_CHIBI_NUM_F,
		var_0_10.S2C_CHIBI_GETINFO_OCCUPY_MEDIUM_NUM_F,
		var_0_10.S2C_CHIBI_GETINFO_OCCUPY_COMPONENT_NUM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_APPLY_ME, {
	"C2S_ChiBi_Apply",
	".cs.C2S_ChiBi_Apply",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_APPLY_RET_F, {
	"ret",
	".cs.S2C_ChiBi_Apply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_APPLY_IS_APPLY_F, {
	"is_apply",
	".cs.S2C_ChiBi_Apply.is_apply",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_APPLY_APPLY_TIME_F, {
	"apply_time",
	".cs.S2C_ChiBi_Apply.apply_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_APPLY_POOL_ID_F, {
	"pool_id",
	".cs.S2C_ChiBi_Apply.pool_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_APPLY_ME, {
	"S2C_ChiBi_Apply",
	".cs.S2C_ChiBi_Apply",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_APPLY_RET_F,
		var_0_10.S2C_CHIBI_APPLY_IS_APPLY_F,
		var_0_10.S2C_CHIBI_APPLY_APPLY_TIME_F,
		var_0_10.S2C_CHIBI_APPLY_POOL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_GETFINALROOM_ROOM_ID_F, {
	"room_id",
	".cs.C2S_ChiBi_GetFinalRoom.room_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_GETFINALROOM_ME, {
	"C2S_ChiBi_GetFinalRoom",
	".cs.C2S_ChiBi_GetFinalRoom",
	{},
	{},
	{
		var_0_10.C2S_CHIBI_GETFINALROOM_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETFINALROOM_RET_F, {
	"ret",
	".cs.S2C_ChiBi_GetFinalRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETFINALROOM_ROOM_ID_F, {
	"room_id",
	".cs.S2C_ChiBi_GetFinalRoom.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETFINALROOM_USER_FINAL_F, {
	"user_final",
	".cs.S2C_ChiBi_GetFinalRoom.user_final",
	3,
	2,
	3,
	false,
	{},
	var_0_3.CHIBIUSERFINAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_GETFINALROOM_ME, {
	"S2C_ChiBi_GetFinalRoom",
	".cs.S2C_ChiBi_GetFinalRoom",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_GETFINALROOM_RET_F,
		var_0_10.S2C_CHIBI_GETFINALROOM_ROOM_ID_F,
		var_0_10.S2C_CHIBI_GETFINALROOM_USER_FINAL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_POOL_ID_F, {
	"pool_id",
	".cs.S2C_ChiBi_NotifyUserInfo.pool_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_SCORE_F, {
	"score",
	".cs.S2C_ChiBi_NotifyUserInfo.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_POOL_RANK_F, {
	"pool_rank",
	".cs.S2C_ChiBi_NotifyUserInfo.pool_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_LOCAL_RANK_LENGTH_F, {
	"local_rank_length",
	".cs.S2C_ChiBi_NotifyUserInfo.local_rank_length",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_CROSS_RANK_LENGTH_F, {
	"cross_rank_length",
	".cs.S2C_ChiBi_NotifyUserInfo.cross_rank_length",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_CROSS_ACHIEVEMENT_RANK_F, {
	"cross_achievement_rank",
	".cs.S2C_ChiBi_NotifyUserInfo.cross_achievement_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_ALLSERVER_ACHIEVEMENT_RANK_F, {
	"allserver_achievement_rank",
	".cs.S2C_ChiBi_NotifyUserInfo.allserver_achievement_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_HALF_FINAL_ROOM_ID_F, {
	"half_final_room_id",
	".cs.S2C_ChiBi_NotifyUserInfo.half_final_room_id",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERINFO_ME, {
	"S2C_ChiBi_NotifyUserInfo",
	".cs.S2C_ChiBi_NotifyUserInfo",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_POOL_ID_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_SCORE_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_POOL_RANK_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_LOCAL_RANK_LENGTH_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_CROSS_RANK_LENGTH_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_CROSS_ACHIEVEMENT_RANK_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_ALLSERVER_ACHIEVEMENT_RANK_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERINFO_HALF_FINAL_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_ENTERROOM_ME, {
	"C2S_ChiBi_EnterRoom",
	".cs.C2S_ChiBi_EnterRoom",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_RET_F, {
	"ret",
	".cs.S2C_ChiBi_EnterRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_START_TIME_F, {
	"start_time",
	".cs.S2C_ChiBi_EnterRoom.start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_POOL_ID_F, {
	"pool_id",
	".cs.S2C_ChiBi_EnterRoom.pool_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_SELF_F, {
	"self",
	".cs.S2C_ChiBi_EnterRoom.self",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_CS_F, {
	"cs",
	".cs.S2C_ChiBi_EnterRoom.cs",
	5,
	4,
	3,
	false,
	{},
	var_0_3.CHIBICOMPONENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_USERS_F, {
	"users",
	".cs.S2C_ChiBi_EnterRoom.users",
	6,
	5,
	3,
	false,
	{},
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_ENTERROOM_ME, {
	"S2C_ChiBi_EnterRoom",
	".cs.S2C_ChiBi_EnterRoom",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_ENTERROOM_RET_F,
		var_0_10.S2C_CHIBI_ENTERROOM_START_TIME_F,
		var_0_10.S2C_CHIBI_ENTERROOM_POOL_ID_F,
		var_0_10.S2C_CHIBI_ENTERROOM_SELF_F,
		var_0_10.S2C_CHIBI_ENTERROOM_CS_F,
		var_0_10.S2C_CHIBI_ENTERROOM_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_LEVELROOM_ME, {
	"C2S_ChiBi_LevelRoom",
	".cs.C2S_ChiBi_LevelRoom",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_LEVELROOM_RET_F, {
	"ret",
	".cs.S2C_ChiBi_LevelRoom.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_LEVELROOM_ME, {
	"S2C_ChiBi_LevelRoom",
	".cs.S2C_ChiBi_LevelRoom",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_LEVELROOM_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_LEVELCOMPONENT_ME, {
	"C2S_ChiBi_LevelComponent",
	".cs.C2S_ChiBi_LevelComponent",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_LEVELCOMPONENT_RET_F, {
	"ret",
	".cs.S2C_ChiBi_LevelComponent.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_LEVELCOMPONENT_USER_F, {
	"user",
	".cs.S2C_ChiBi_LevelComponent.user",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_LEVELCOMPONENT_COMPONENT_ID_F, {
	"component_id",
	".cs.S2C_ChiBi_LevelComponent.component_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_LEVELCOMPONENT_ME, {
	"S2C_ChiBi_LevelComponent",
	".cs.S2C_ChiBi_LevelComponent",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_LEVELCOMPONENT_RET_F,
		var_0_10.S2C_CHIBI_LEVELCOMPONENT_USER_F,
		var_0_10.S2C_CHIBI_LEVELCOMPONENT_COMPONENT_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_GETRANKINFO_ME, {
	"C2S_ChiBi_GetRankInfo",
	".cs.C2S_ChiBi_GetRankInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETRANKINFO_RET_F, {
	"ret",
	".cs.S2C_ChiBi_GetRankInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETRANKINFO_MY_SCORE_F, {
	"my_score",
	".cs.S2C_ChiBi_GetRankInfo.my_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETRANKINFO_USERS_F, {
	"users",
	".cs.S2C_ChiBi_GetRankInfo.users",
	3,
	2,
	3,
	false,
	{},
	var_0_3.CHIBIFINALUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETRANKINFO_MY_RANK_F, {
	"my_rank",
	".cs.S2C_ChiBi_GetRankInfo.my_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETRANKINFO_SELF_F, {
	"self",
	".cs.S2C_ChiBi_GetRankInfo.self",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_GETRANKINFO_ME, {
	"S2C_ChiBi_GetRankInfo",
	".cs.S2C_ChiBi_GetRankInfo",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_GETRANKINFO_RET_F,
		var_0_10.S2C_CHIBI_GETRANKINFO_MY_SCORE_F,
		var_0_10.S2C_CHIBI_GETRANKINFO_USERS_F,
		var_0_10.S2C_CHIBI_GETRANKINFO_MY_RANK_F,
		var_0_10.S2C_CHIBI_GETRANKINFO_SELF_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_BATTLE_ENEMY_ID_F, {
	"enemy_id",
	".cs.C2S_ChiBi_Battle.enemy_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_BATTLE_COMPONENT_ID_F, {
	"component_id",
	".cs.C2S_ChiBi_Battle.component_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_BATTLE_ME, {
	"C2S_ChiBi_Battle",
	".cs.C2S_ChiBi_Battle",
	{},
	{},
	{
		var_0_10.C2S_CHIBI_BATTLE_ENEMY_ID_F,
		var_0_10.C2S_CHIBI_BATTLE_COMPONENT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_BATTLE_RET_F, {
	"ret",
	".cs.S2C_ChiBi_Battle.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_BATTLE_ENEMY_ID_F, {
	"enemy_id",
	".cs.S2C_ChiBi_Battle.enemy_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_BATTLE_COMPONENT_ID_F, {
	"component_id",
	".cs.S2C_ChiBi_Battle.component_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_BATTLE_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_ChiBi_Battle.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_BATTLE_ME, {
	"S2C_ChiBi_Battle",
	".cs.S2C_ChiBi_Battle",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_BATTLE_RET_F,
		var_0_10.S2C_CHIBI_BATTLE_ENEMY_ID_F,
		var_0_10.S2C_CHIBI_BATTLE_COMPONENT_ID_F,
		var_0_10.S2C_CHIBI_BATTLE_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_CHECKBATTLE_USER_ID_F, {
	"user_id",
	".cs.C2S_ChiBi_CheckBattle.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_CHECKBATTLE_COMPONENT_ID_F, {
	"component_id",
	".cs.C2S_ChiBi_CheckBattle.component_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_CHECKBATTLE_BATTLE_RESULT_F, {
	"battle_result",
	".cs.C2S_ChiBi_CheckBattle.battle_result",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_CHECKBATTLE_ME, {
	"C2S_ChiBi_CheckBattle",
	".cs.C2S_ChiBi_CheckBattle",
	{},
	{},
	{
		var_0_10.C2S_CHIBI_CHECKBATTLE_USER_ID_F,
		var_0_10.C2S_CHIBI_CHECKBATTLE_COMPONENT_ID_F,
		var_0_10.C2S_CHIBI_CHECKBATTLE_BATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_RET_F, {
	"ret",
	".cs.S2C_ChiBi_CheckBattle.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_USER_ID_F, {
	"user_id",
	".cs.S2C_ChiBi_CheckBattle.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_COMPONENT_ID_F, {
	"component_id",
	".cs.S2C_ChiBi_CheckBattle.component_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_BATTLE_RESULT_F, {
	"battle_result",
	".cs.S2C_ChiBi_CheckBattle.battle_result",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_CHECK_STATUS_F, {
	"check_status",
	".cs.S2C_ChiBi_CheckBattle.check_status",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_ChiBi_CheckBattle.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_ENEMY_USER_F, {
	"enemy_user",
	".cs.S2C_ChiBi_CheckBattle.enemy_user",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLE_ME, {
	"S2C_ChiBi_CheckBattle",
	".cs.S2C_ChiBi_CheckBattle",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_CHECKBATTLE_RET_F,
		var_0_10.S2C_CHIBI_CHECKBATTLE_USER_ID_F,
		var_0_10.S2C_CHIBI_CHECKBATTLE_COMPONENT_ID_F,
		var_0_10.S2C_CHIBI_CHECKBATTLE_BATTLE_RESULT_F,
		var_0_10.S2C_CHIBI_CHECKBATTLE_CHECK_STATUS_F,
		var_0_10.S2C_CHIBI_CHECKBATTLE_BATTLE_ID_F,
		var_0_10.S2C_CHIBI_CHECKBATTLE_ENEMY_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_RET_F, {
	"ret",
	".cs.S2C_ChiBi_CheckBattleFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_ChiBi_CheckBattleFinish.is_win",
	2,
	1,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_USER_F, {
	"user",
	".cs.S2C_ChiBi_CheckBattleFinish.user",
	3,
	2,
	2,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_COMPONENT_ID_F, {
	"component_id",
	".cs.S2C_ChiBi_CheckBattleFinish.component_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_ME, {
	"S2C_ChiBi_CheckBattleFinish",
	".cs.S2C_ChiBi_CheckBattleFinish",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_RET_F,
		var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_IS_WIN_F,
		var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_USER_F,
		var_0_10.S2C_CHIBI_CHECKBATTLEFINISH_COMPONENT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_REVIVE_TIME_F, {
	"revive_time",
	".cs.S2C_ChiBi_NotifyUserRevive.revive_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_USER_F, {
	"user",
	".cs.S2C_ChiBi_NotifyUserRevive.user",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.SIMPLEUSERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_ENEMY_USER_F, {
	"enemy_user",
	".cs.S2C_ChiBi_NotifyUserRevive.enemy_user",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.SIMPLEUSERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_ME, {
	"S2C_ChiBi_NotifyUserRevive",
	".cs.S2C_ChiBi_NotifyUserRevive",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_REVIVE_TIME_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_USER_F,
		var_0_10.S2C_CHIBI_NOTIFYUSERREVIVE_ENEMY_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_COMPONENT_ID_F, {
	"component_id",
	".cs.S2C_ChiBi_NotifyOccupyChange.component_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_USER_F, {
	"user",
	".cs.S2C_ChiBi_NotifyOccupyChange.user",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_BEFORE_USER_F, {
	"before_user",
	".cs.S2C_ChiBi_NotifyOccupyChange.before_user",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.CHIBIMATCHUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_ME, {
	"S2C_ChiBi_NotifyOccupyChange",
	".cs.S2C_ChiBi_NotifyOccupyChange",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_COMPONENT_ID_F,
		var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_USER_F,
		var_0_10.S2C_CHIBI_NOTIFYOCCUPYCHANGE_BEFORE_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYFERTILITY_FERTILITY_F, {
	"fertility",
	".cs.S2C_ChiBi_NotifyFertility.fertility",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CHIBICOMPONENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_NOTIFYFERTILITY_ME, {
	"S2C_ChiBi_NotifyFertility",
	".cs.S2C_ChiBi_NotifyFertility",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_NOTIFYFERTILITY_FERTILITY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYMATCHEND_USERS_F, {
	"users",
	".cs.S2C_ChiBi_NotifyMatchEnd.users",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CHIBIFINALUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_NOTIFYMATCHEND_ME, {
	"S2C_ChiBi_NotifyMatchEnd",
	".cs.S2C_ChiBi_NotifyMatchEnd",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_NOTIFYMATCHEND_USERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_ACHIEVEMENTAWARD_AWARD_ID_F, {
	"award_id",
	".cs.C2S_ChiBi_AchievementAward.award_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_ACHIEVEMENTAWARD_ME, {
	"C2S_ChiBi_AchievementAward",
	".cs.C2S_ChiBi_AchievementAward",
	{},
	{},
	{
		var_0_10.C2S_CHIBI_ACHIEVEMENTAWARD_AWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_RET_F, {
	"ret",
	".cs.S2C_ChiBi_AchievementAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_AWARD_ID_F, {
	"award_id",
	".cs.S2C_ChiBi_AchievementAward.award_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_ChiBi_AchievementAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_ME, {
	"S2C_ChiBi_AchievementAward",
	".cs.S2C_ChiBi_AchievementAward",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_RET_F,
		var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_AWARD_ID_F,
		var_0_10.S2C_CHIBI_ACHIEVEMENTAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYPROMOTIONLIST_USERS_F, {
	"users",
	".cs.S2C_ChiBi_NotifyPromotionList.users",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CHIBIFINALUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_NOTIFYPROMOTIONLIST_POOL_ID_F, {
	"pool_id",
	".cs.S2C_ChiBi_NotifyPromotionList.pool_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_NOTIFYPROMOTIONLIST_ME, {
	"S2C_ChiBi_NotifyPromotionList",
	".cs.S2C_ChiBi_NotifyPromotionList",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_NOTIFYPROMOTIONLIST_USERS_F,
		var_0_10.S2C_CHIBI_NOTIFYPROMOTIONLIST_POOL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CHIBI_GETPROMOTIONLIST_POOL_ID_F, {
	"pool_id",
	".cs.C2S_ChiBi_GetPromotionList.pool_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_GETPROMOTIONLIST_ME, {
	"C2S_ChiBi_GetPromotionList",
	".cs.C2S_ChiBi_GetPromotionList",
	{},
	{},
	{
		var_0_10.C2S_CHIBI_GETPROMOTIONLIST_POOL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETPROMOTIONLIST_RET_F, {
	"ret",
	".cs.S2C_ChiBi_GetPromotionList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETPROMOTIONLIST_POOL_ID_F, {
	"pool_id",
	".cs.S2C_ChiBi_GetPromotionList.pool_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETPROMOTIONLIST_USERS_F, {
	"users",
	".cs.S2C_ChiBi_GetPromotionList.users",
	3,
	2,
	3,
	false,
	{},
	var_0_3.CHIBIFINALUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_GETPROMOTIONLIST_ME, {
	"S2C_ChiBi_GetPromotionList",
	".cs.S2C_ChiBi_GetPromotionList",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_GETPROMOTIONLIST_RET_F,
		var_0_10.S2C_CHIBI_GETPROMOTIONLIST_POOL_ID_F,
		var_0_10.S2C_CHIBI_GETPROMOTIONLIST_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CHIBI_GETROOMUSER_ME, {
	"C2S_ChiBi_GetRoomUser",
	".cs.C2S_ChiBi_GetRoomUser",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETROOMUSER_RET_F, {
	"ret",
	".cs.S2C_ChiBi_GetRoomUser.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CHIBI_GETROOMUSER_USERS_F, {
	"users",
	".cs.S2C_ChiBi_GetRoomUser.users",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SIMPLEUSERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CHIBI_GETROOMUSER_ME, {
	"S2C_ChiBi_GetRoomUser",
	".cs.S2C_ChiBi_GetRoomUser",
	{},
	{},
	{
		var_0_10.S2C_CHIBI_GETROOMUSER_RET_F,
		var_0_10.S2C_CHIBI_GETROOMUSER_USERS_F
	},
	false,
	{}
})

return var_0_10
