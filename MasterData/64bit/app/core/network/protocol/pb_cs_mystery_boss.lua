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
	C2S_MYSTERYBOSS_GETINFO_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GETINFO_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETINFO_ROOMS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_ENTERROOM_ME = protobuf.Descriptor(),
	C2S_MYSTERYBOSS_ENTERROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_ENTERROOM_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_ENTERROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_ENTERROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_ENTERROOM_ROOM_SNAPSHOT_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_ENTERROOM_USERS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_LEAVEROOM_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_LEAVEROOM_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_LEAVEROOM_RET_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_GETRANKLIST_ME = protobuf.Descriptor(),
	C2S_MYSTERYBOSS_GETRANKLIST_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GETRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETRANKLIST_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETRANKLIST_UNITS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_GETSERVERINFO_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GETSERVERINFO_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GETSERVERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETSERVERINFO_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_GETSERVERINFO_SID_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_POSCHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_MYSTERYBOSS_POSCHALLENGEBEGIN_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEFINISH_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_POSCHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_BOSSCHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_MYSTERYBOSS_BOSSCHALLENGEBEGIN_REAL_BATTLE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_REAL_BATTLE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_HP_LEFT_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_TOTAL_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_REAL_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_BOSS_DAMAGE_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_RECVAWARD_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_RECVAWARD_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_RECVAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_RECVAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MYSTERYBOSS_GIVEAWARD_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GIVEAWARD_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_GIVEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_ROOM_SNAPSHOT_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_REAL_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_BOSS_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_ROOM_SNAPSHOT_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_IS_SYSTEM_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYLEAVE_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_NOTIFYLEAVE_ROOM_SNAPSHOT_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYLEAVE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_ME = protobuf.Descriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_ID_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_RANK_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_POS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_RANK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYAWARDS_POS_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_MYSTERYBOSS_NOTIFYDISBAND_ME = protobuf.Descriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_GETINFO_ME, {
	"C2S_MysteryBoss_GetInfo",
	".cs.C2S_MysteryBoss_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETINFO_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETINFO_INFO_F, {
	"info",
	".cs.S2C_MysteryBoss_GetInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.MYSTERYBOSSUSERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETINFO_ROOMS_F, {
	"rooms",
	".cs.S2C_MysteryBoss_GetInfo.rooms",
	3,
	2,
	3,
	false,
	{},
	var_0_3.MYSTERYBOSSROOMSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETINFO_ME, {
	"S2C_MysteryBoss_GetInfo",
	".cs.S2C_MysteryBoss_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_GETINFO_RET_F,
		var_0_10.S2C_MYSTERYBOSS_GETINFO_INFO_F,
		var_0_10.S2C_MYSTERYBOSS_GETINFO_ROOMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERYBOSS_ENTERROOM_ID_F, {
	"id",
	".cs.C2S_MysteryBoss_EnterRoom.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_ENTERROOM_ME, {
	"C2S_MysteryBoss_EnterRoom",
	".cs.C2S_MysteryBoss_EnterRoom",
	{},
	{},
	{
		var_0_10.C2S_MYSTERYBOSS_ENTERROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_ENTERROOM_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_EnterRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_ENTERROOM_ID_F, {
	"id",
	".cs.S2C_MysteryBoss_EnterRoom.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_ENTERROOM_ROOM_SNAPSHOT_F, {
	"room_snapshot",
	".cs.S2C_MysteryBoss_EnterRoom.room_snapshot",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.MYSTERYBOSSROOMSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_ENTERROOM_USERS_F, {
	"users",
	".cs.S2C_MysteryBoss_EnterRoom.users",
	4,
	3,
	3,
	false,
	{},
	var_0_3.MYSTERYBOSSROOMUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_ENTERROOM_ME, {
	"S2C_MysteryBoss_EnterRoom",
	".cs.S2C_MysteryBoss_EnterRoom",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_ENTERROOM_RET_F,
		var_0_10.S2C_MYSTERYBOSS_ENTERROOM_ID_F,
		var_0_10.S2C_MYSTERYBOSS_ENTERROOM_ROOM_SNAPSHOT_F,
		var_0_10.S2C_MYSTERYBOSS_ENTERROOM_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_LEAVEROOM_ME, {
	"C2S_MysteryBoss_LeaveRoom",
	".cs.C2S_MysteryBoss_LeaveRoom",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_LEAVEROOM_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_LeaveRoom.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_LEAVEROOM_ME, {
	"S2C_MysteryBoss_LeaveRoom",
	".cs.S2C_MysteryBoss_LeaveRoom",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_LEAVEROOM_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERYBOSS_GETRANKLIST_ID_F, {
	"id",
	".cs.C2S_MysteryBoss_GetRankList.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_GETRANKLIST_ME, {
	"C2S_MysteryBoss_GetRankList",
	".cs.C2S_MysteryBoss_GetRankList",
	{},
	{},
	{
		var_0_10.C2S_MYSTERYBOSS_GETRANKLIST_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_GetRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_ID_F, {
	"id",
	".cs.S2C_MysteryBoss_GetRankList.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_UNITS_F, {
	"units",
	".cs.S2C_MysteryBoss_GetRankList.units",
	3,
	2,
	3,
	false,
	{},
	var_0_3.MYSTERYBOSSUSERRANK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_ME, {
	"S2C_MysteryBoss_GetRankList",
	".cs.S2C_MysteryBoss_GetRankList",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_RET_F,
		var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_ID_F,
		var_0_10.S2C_MYSTERYBOSS_GETRANKLIST_UNITS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_GETSERVERINFO_ME, {
	"C2S_MysteryBoss_GetServerInfo",
	".cs.C2S_MysteryBoss_GetServerInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_GetServerInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_MysteryBoss_GetServerInfo.server_infos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_SID_F, {
	"sid",
	".cs.S2C_MysteryBoss_GetServerInfo.sid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_ME, {
	"S2C_MysteryBoss_GetServerInfo",
	".cs.S2C_MysteryBoss_GetServerInfo",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_RET_F,
		var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_SERVER_INFOS_F,
		var_0_10.S2C_MYSTERYBOSS_GETSERVERINFO_SID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERYBOSS_POSCHALLENGEBEGIN_POS_F, {
	"pos",
	".cs.C2S_MysteryBoss_PosChallengeBegin.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_POSCHALLENGEBEGIN_ME, {
	"C2S_MysteryBoss_PosChallengeBegin",
	".cs.C2S_MysteryBoss_PosChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_MYSTERYBOSS_POSCHALLENGEBEGIN_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_PosChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_POS_F, {
	"pos",
	".cs.S2C_MysteryBoss_PosChallengeBegin.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_MysteryBoss_PosChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_ME, {
	"S2C_MysteryBoss_PosChallengeBegin",
	".cs.S2C_MysteryBoss_PosChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_RET_F,
		var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_POS_F,
		var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_PosChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_POS_F, {
	"pos",
	".cs.S2C_MysteryBoss_PosChallengeFinish.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_MysteryBoss_PosChallengeFinish.is_win",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_ME, {
	"S2C_MysteryBoss_PosChallengeFinish",
	".cs.S2C_MysteryBoss_PosChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_RET_F,
		var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_POS_F,
		var_0_10.S2C_MYSTERYBOSS_POSCHALLENGEFINISH_IS_WIN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MYSTERYBOSS_BOSSCHALLENGEBEGIN_REAL_BATTLE_F, {
	"real_battle",
	".cs.C2S_MysteryBoss_BossChallengeBegin.real_battle",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_BOSSCHALLENGEBEGIN_ME, {
	"C2S_MysteryBoss_BossChallengeBegin",
	".cs.C2S_MysteryBoss_BossChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_MYSTERYBOSS_BOSSCHALLENGEBEGIN_REAL_BATTLE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_BossChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_REAL_BATTLE_F, {
	"real_battle",
	".cs.S2C_MysteryBoss_BossChallengeBegin.real_battle",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_ME, {
	"S2C_MysteryBoss_BossChallengeBegin",
	".cs.S2C_MysteryBoss_BossChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_RET_F,
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEBEGIN_REAL_BATTLE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_BossChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_HP_LEFT_F, {
	"hp_left",
	".cs.S2C_MysteryBoss_BossChallengeFinish.hp_left",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_TOTAL_DAMAGE_F, {
	"total_damage",
	".cs.S2C_MysteryBoss_BossChallengeFinish.total_damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_DAMAGE_F, {
	"damage",
	".cs.S2C_MysteryBoss_BossChallengeFinish.damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_REAL_DAMAGE_F, {
	"real_damage",
	".cs.S2C_MysteryBoss_BossChallengeFinish.real_damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_BOSS_DAMAGE_F, {
	"boss_damage",
	".cs.S2C_MysteryBoss_BossChallengeFinish.boss_damage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_ME, {
	"S2C_MysteryBoss_BossChallengeFinish",
	".cs.S2C_MysteryBoss_BossChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_RET_F,
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_HP_LEFT_F,
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_TOTAL_DAMAGE_F,
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_DAMAGE_F,
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_REAL_DAMAGE_F,
		var_0_10.S2C_MYSTERYBOSS_BOSSCHALLENGEFINISH_BOSS_DAMAGE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_RECVAWARD_ME, {
	"C2S_MysteryBoss_RecvAward",
	".cs.C2S_MysteryBoss_RecvAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_RECVAWARD_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_RecvAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_RECVAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_MysteryBoss_RecvAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_RECVAWARD_ME, {
	"S2C_MysteryBoss_RecvAward",
	".cs.S2C_MysteryBoss_RecvAward",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_RECVAWARD_RET_F,
		var_0_10.S2C_MYSTERYBOSS_RECVAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MYSTERYBOSS_GIVEAWARD_ME, {
	"C2S_MysteryBoss_GiveAward",
	".cs.C2S_MysteryBoss_GiveAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_GIVEAWARD_RET_F, {
	"ret",
	".cs.S2C_MysteryBoss_GiveAward.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_GIVEAWARD_ME, {
	"S2C_MysteryBoss_GiveAward",
	".cs.S2C_MysteryBoss_GiveAward",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_GIVEAWARD_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_ID_F, {
	"id",
	".cs.S2C_MysteryBoss_NotifyPosChallenge.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_USER_ID_F, {
	"user_id",
	".cs.S2C_MysteryBoss_NotifyPosChallenge.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_TARGET_POS_F, {
	"target_pos",
	".cs.S2C_MysteryBoss_NotifyPosChallenge.target_pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_ME, {
	"S2C_MysteryBoss_NotifyPosChallenge",
	".cs.S2C_MysteryBoss_NotifyPosChallenge",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_ID_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_USER_ID_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYPOSCHALLENGE_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_ROOM_SNAPSHOT_F, {
	"room_snapshot",
	".cs.S2C_MysteryBoss_NotifyBossChallenge.room_snapshot",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.MYSTERYBOSSROOMSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_USER_ID_F, {
	"user_id",
	".cs.S2C_MysteryBoss_NotifyBossChallenge.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_REAL_DAMAGE_F, {
	"real_damage",
	".cs.S2C_MysteryBoss_NotifyBossChallenge.real_damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_BOSS_DAMAGE_F, {
	"boss_damage",
	".cs.S2C_MysteryBoss_NotifyBossChallenge.boss_damage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_ME, {
	"S2C_MysteryBoss_NotifyBossChallenge",
	".cs.S2C_MysteryBoss_NotifyBossChallenge",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_ROOM_SNAPSHOT_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_USER_ID_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_REAL_DAMAGE_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSCHALLENGE_BOSS_DAMAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_ROOM_SNAPSHOT_F, {
	"room_snapshot",
	".cs.S2C_MysteryBoss_NotifyBossDead.room_snapshot",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.MYSTERYBOSSROOMSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_IS_SYSTEM_F, {
	"is_system",
	".cs.S2C_MysteryBoss_NotifyBossDead.is_system",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_ME, {
	"S2C_MysteryBoss_NotifyBossDead",
	".cs.S2C_MysteryBoss_NotifyBossDead",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_ROOM_SNAPSHOT_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYBOSSDEAD_IS_SYSTEM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYLEAVE_ROOM_SNAPSHOT_F, {
	"room_snapshot",
	".cs.S2C_MysteryBoss_NotifyLeave.room_snapshot",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.MYSTERYBOSSROOMSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYLEAVE_USER_ID_F, {
	"user_id",
	".cs.S2C_MysteryBoss_NotifyLeave.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYLEAVE_ME, {
	"S2C_MysteryBoss_NotifyLeave",
	".cs.S2C_MysteryBoss_NotifyLeave",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_NOTIFYLEAVE_ROOM_SNAPSHOT_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYLEAVE_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_ID_F, {
	"id",
	".cs.S2C_MysteryBoss_NotifyAwards.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_RANK_F, {
	"rank",
	".cs.S2C_MysteryBoss_NotifyAwards.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_POS_F, {
	"pos",
	".cs.S2C_MysteryBoss_NotifyAwards.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_DAMAGE_F, {
	"damage",
	".cs.S2C_MysteryBoss_NotifyAwards.damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_RANK_AWARDS_F, {
	"rank_awards",
	".cs.S2C_MysteryBoss_NotifyAwards.rank_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_POS_AWARDS_F, {
	"pos_awards",
	".cs.S2C_MysteryBoss_NotifyAwards.pos_awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_ME, {
	"S2C_MysteryBoss_NotifyAwards",
	".cs.S2C_MysteryBoss_NotifyAwards",
	{},
	{},
	{
		var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_ID_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_RANK_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_POS_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_DAMAGE_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_RANK_AWARDS_F,
		var_0_10.S2C_MYSTERYBOSS_NOTIFYAWARDS_POS_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MYSTERYBOSS_NOTIFYDISBAND_ME, {
	"S2C_MysteryBoss_NotifyDisband",
	".cs.S2C_MysteryBoss_NotifyDisband",
	{},
	{},
	{},
	false,
	{}
})

return var_0_10
