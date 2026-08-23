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
	C2S_SPIRE_GETINFO_ME = protobuf.Descriptor(),
	S2C_SPIRE_GETINFO_ME = protobuf.Descriptor(),
	S2C_SPIRE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_GETINFO_SPIRES_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_GETINFO_BOSS_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_GETINFO_IDLE_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_GETINFO_PASS_STAGES_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_GETINFO_PASS_MAX_SPIRE_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_BOSSINFO_ME = protobuf.Descriptor(),
	S2C_SPIRE_BOSSINFO_ME = protobuf.Descriptor(),
	S2C_SPIRE_BOSSINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSINFO_BOSS_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_IDLEINFO_ME = protobuf.Descriptor(),
	S2C_SPIRE_IDLEINFO_ME = protobuf.Descriptor(),
	S2C_SPIRE_IDLEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_IDLEINFO_IDLE_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_STAGEBEGIN_ME = protobuf.Descriptor(),
	C2S_SPIRE_STAGEBEGIN_TP_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEBEGIN_ME = protobuf.Descriptor(),
	S2C_SPIRE_STAGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEBEGIN_TP_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEFINISH_ME = protobuf.Descriptor(),
	S2C_SPIRE_STAGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEFINISH_TP_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEFINISH_WIN_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_STAGEFINISH_PASS_TIME_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_BOSSBUFF_ME = protobuf.Descriptor(),
	C2S_SPIRE_BOSSBUFF_SET_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_BOSSBUFF_ID_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSBUFF_ME = protobuf.Descriptor(),
	S2C_SPIRE_BOSSBUFF_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSBUFF_SET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSBUFF_ID_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_BOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_SPIRE_BOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_SPIRE_BOSSBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSFINISH_ME = protobuf.Descriptor(),
	S2C_SPIRE_BOSSFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSFINISH_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSFINISH_SCORE_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSFINISH_RATE_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_BOSSFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_IDLEAWARD_ME = protobuf.Descriptor(),
	S2C_SPIRE_IDLEAWARD_ME = protobuf.Descriptor(),
	S2C_SPIRE_IDLEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_IDLEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_IDLEAWARD_START_TIME_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_FASTIDLE_ME = protobuf.Descriptor(),
	S2C_SPIRE_FASTIDLE_ME = protobuf.Descriptor(),
	S2C_SPIRE_FASTIDLE_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_FASTIDLE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_SPIRE_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_SPIRE_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_SPIRE_SERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRE_SERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_GETINFO_ME, {
	"C2S_Spire_GetInfo",
	".cs.C2S_Spire_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Spire_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_GETINFO_SPIRES_F, {
	"spires",
	".cs.S2C_Spire_GetInfo.spires",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SPIRE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_GETINFO_BOSS_F, {
	"boss",
	".cs.S2C_Spire_GetInfo.boss",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.SPIREBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_GETINFO_IDLE_F, {
	"idle",
	".cs.S2C_Spire_GetInfo.idle",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.SPIREIDLE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_GETINFO_PASS_STAGES_F, {
	"pass_stages",
	".cs.S2C_Spire_GetInfo.pass_stages",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_GETINFO_PASS_MAX_SPIRE_F, {
	"pass_max_spire",
	".cs.S2C_Spire_GetInfo.pass_max_spire",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_GETINFO_ME, {
	"S2C_Spire_GetInfo",
	".cs.S2C_Spire_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_GETINFO_RET_F,
		var_0_10.S2C_SPIRE_GETINFO_SPIRES_F,
		var_0_10.S2C_SPIRE_GETINFO_BOSS_F,
		var_0_10.S2C_SPIRE_GETINFO_IDLE_F,
		var_0_10.S2C_SPIRE_GETINFO_PASS_STAGES_F,
		var_0_10.S2C_SPIRE_GETINFO_PASS_MAX_SPIRE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_BOSSINFO_ME, {
	"C2S_Spire_BossInfo",
	".cs.C2S_Spire_BossInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSINFO_RET_F, {
	"ret",
	".cs.S2C_Spire_BossInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSINFO_BOSS_F, {
	"boss",
	".cs.S2C_Spire_BossInfo.boss",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.SPIREBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_BOSSINFO_ME, {
	"S2C_Spire_BossInfo",
	".cs.S2C_Spire_BossInfo",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_BOSSINFO_RET_F,
		var_0_10.S2C_SPIRE_BOSSINFO_BOSS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_IDLEINFO_ME, {
	"C2S_Spire_IdleInfo",
	".cs.C2S_Spire_IdleInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_IDLEINFO_RET_F, {
	"ret",
	".cs.S2C_Spire_IdleInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_IDLEINFO_IDLE_F, {
	"idle",
	".cs.S2C_Spire_IdleInfo.idle",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.SPIREIDLE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_IDLEINFO_ME, {
	"S2C_Spire_IdleInfo",
	".cs.S2C_Spire_IdleInfo",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_IDLEINFO_RET_F,
		var_0_10.S2C_SPIRE_IDLEINFO_IDLE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SPIRE_STAGEBEGIN_TP_F, {
	"tp",
	".cs.C2S_Spire_StageBegin.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_STAGEBEGIN_ME, {
	"C2S_Spire_StageBegin",
	".cs.C2S_Spire_StageBegin",
	{},
	{},
	{
		var_0_10.C2S_SPIRE_STAGEBEGIN_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Spire_StageBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEBEGIN_TP_F, {
	"tp",
	".cs.S2C_Spire_StageBegin.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Spire_StageBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_STAGEBEGIN_ME, {
	"S2C_Spire_StageBegin",
	".cs.S2C_Spire_StageBegin",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_STAGEBEGIN_RET_F,
		var_0_10.S2C_SPIRE_STAGEBEGIN_TP_F,
		var_0_10.S2C_SPIRE_STAGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Spire_StageFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEFINISH_TP_F, {
	"tp",
	".cs.S2C_Spire_StageFinish.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEFINISH_WIN_F, {
	"win",
	".cs.S2C_Spire_StageFinish.win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Spire_StageFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_STAGEFINISH_PASS_TIME_F, {
	"pass_time",
	".cs.S2C_Spire_StageFinish.pass_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_STAGEFINISH_ME, {
	"S2C_Spire_StageFinish",
	".cs.S2C_Spire_StageFinish",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_STAGEFINISH_RET_F,
		var_0_10.S2C_SPIRE_STAGEFINISH_TP_F,
		var_0_10.S2C_SPIRE_STAGEFINISH_WIN_F,
		var_0_10.S2C_SPIRE_STAGEFINISH_AWARDS_F,
		var_0_10.S2C_SPIRE_STAGEFINISH_PASS_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SPIRE_BOSSBUFF_SET_F, {
	"set",
	".cs.C2S_Spire_BossBuff.set",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SPIRE_BOSSBUFF_ID_F, {
	"id",
	".cs.C2S_Spire_BossBuff.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_BOSSBUFF_ME, {
	"C2S_Spire_BossBuff",
	".cs.C2S_Spire_BossBuff",
	{},
	{},
	{
		var_0_10.C2S_SPIRE_BOSSBUFF_SET_F,
		var_0_10.C2S_SPIRE_BOSSBUFF_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSBUFF_RET_F, {
	"ret",
	".cs.S2C_Spire_BossBuff.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSBUFF_SET_F, {
	"set",
	".cs.S2C_Spire_BossBuff.set",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSBUFF_ID_F, {
	"id",
	".cs.S2C_Spire_BossBuff.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_BOSSBUFF_ME, {
	"S2C_Spire_BossBuff",
	".cs.S2C_Spire_BossBuff",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_BOSSBUFF_RET_F,
		var_0_10.S2C_SPIRE_BOSSBUFF_SET_F,
		var_0_10.S2C_SPIRE_BOSSBUFF_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_BOSSBEGIN_ME, {
	"C2S_Spire_BossBegin",
	".cs.C2S_Spire_BossBegin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSBEGIN_RET_F, {
	"ret",
	".cs.S2C_Spire_BossBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Spire_BossBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_BOSSBEGIN_ME, {
	"S2C_Spire_BossBegin",
	".cs.S2C_Spire_BossBegin",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_BOSSBEGIN_RET_F,
		var_0_10.S2C_SPIRE_BOSSBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSFINISH_RET_F, {
	"ret",
	".cs.S2C_Spire_BossFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSFINISH_DAMAGE_F, {
	"damage",
	".cs.S2C_Spire_BossFinish.damage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSFINISH_SCORE_F, {
	"score",
	".cs.S2C_Spire_BossFinish.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSFINISH_RATE_F, {
	"rate",
	".cs.S2C_Spire_BossFinish.rate",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_BOSSFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Spire_BossFinish.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_BOSSFINISH_ME, {
	"S2C_Spire_BossFinish",
	".cs.S2C_Spire_BossFinish",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_BOSSFINISH_RET_F,
		var_0_10.S2C_SPIRE_BOSSFINISH_DAMAGE_F,
		var_0_10.S2C_SPIRE_BOSSFINISH_SCORE_F,
		var_0_10.S2C_SPIRE_BOSSFINISH_RATE_F,
		var_0_10.S2C_SPIRE_BOSSFINISH_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_IDLEAWARD_ME, {
	"C2S_Spire_IdleAward",
	".cs.C2S_Spire_IdleAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_IDLEAWARD_RET_F, {
	"ret",
	".cs.S2C_Spire_IdleAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_IDLEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Spire_IdleAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_IDLEAWARD_START_TIME_F, {
	"start_time",
	".cs.S2C_Spire_IdleAward.start_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_IDLEAWARD_ME, {
	"S2C_Spire_IdleAward",
	".cs.S2C_Spire_IdleAward",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_IDLEAWARD_RET_F,
		var_0_10.S2C_SPIRE_IDLEAWARD_AWARDS_F,
		var_0_10.S2C_SPIRE_IDLEAWARD_START_TIME_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_FASTIDLE_ME, {
	"C2S_Spire_FastIdle",
	".cs.C2S_Spire_FastIdle",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_FASTIDLE_RET_F, {
	"ret",
	".cs.S2C_Spire_FastIdle.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_FASTIDLE_AWARDS_F, {
	"awards",
	".cs.S2C_Spire_FastIdle.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_FASTIDLE_ME, {
	"S2C_Spire_FastIdle",
	".cs.S2C_Spire_FastIdle",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_FASTIDLE_RET_F,
		var_0_10.S2C_SPIRE_FASTIDLE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRE_SERVERINFOS_ME, {
	"C2S_Spire_ServerInfos",
	".cs.C2S_Spire_ServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_SERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_Spire_ServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRE_SERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_Spire_ServerInfos.server_infos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRE_SERVERINFOS_ME, {
	"S2C_Spire_ServerInfos",
	".cs.S2C_Spire_ServerInfos",
	{},
	{},
	{
		var_0_10.S2C_SPIRE_SERVERINFOS_RET_F,
		var_0_10.S2C_SPIRE_SERVERINFOS_SERVER_INFOS_F
	},
	false,
	{}
})

return var_0_10
