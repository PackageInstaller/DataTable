local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_9 = {
	C2S_NEWDEMONBOSS_GETINFO_ME = protobuf.Descriptor(),
	C2S_NEWDEMONBOSS_GETINFO_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_ME = protobuf.Descriptor(),
	S2C_NEWDEMONBOSS_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_TOTAL_POINT_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_SELF_RANK_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_TALENT_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_GETINFO_AWARD_IDS_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_BEGINCHALLENGE_ME = protobuf.Descriptor(),
	C2S_NEWDEMONBOSS_BEGINCHALLENGE_ACT_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_BEGINCHALLENGE_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_BEGINCHALLENGE_PHASE_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_BEGINCHALLENGE_ME = protobuf.Descriptor(),
	S2C_NEWDEMONBOSS_BEGINCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_BEGINCHALLENGE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_BEGINCHALLENGE_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_NEWDEMONBOSS_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_CHALLENGEFINISH_POINT_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_CHALLENGEFINISH_TOTAL_POINT_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_CHALLENGEFINISH_ACT_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_ACTIVETALENT_ME = protobuf.Descriptor(),
	C2S_NEWDEMONBOSS_ACTIVETALENT_ACT_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_ACTIVETALENT_TALENT_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_ACTIVETALENT_ME = protobuf.Descriptor(),
	S2C_NEWDEMONBOSS_ACTIVETALENT_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_ACTIVETALENT_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_ACTIVETALENT_TALENT_IDS_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_RESETTALENT_ME = protobuf.Descriptor(),
	C2S_NEWDEMONBOSS_RESETTALENT_ACT_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWDEMONBOSS_RESETTALENT_TALENT_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_RESETTALENT_ME = protobuf.Descriptor(),
	S2C_NEWDEMONBOSS_RESETTALENT_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_RESETTALENT_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWDEMONBOSS_RESETTALENT_TALENT_IDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_GETINFO_ACT_ID_F, {
	"act_id",
	".cs.C2S_NewDemonBoss_GetInfo.act_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_NEWDEMONBOSS_GETINFO_ME, {
	"C2S_NewDemonBoss_GetInfo",
	".cs.C2S_NewDemonBoss_GetInfo",
	{},
	{},
	{
		var_0_9.C2S_NEWDEMONBOSS_GETINFO_ACT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_RET_F, {
	"ret",
	".cs.S2C_NewDemonBoss_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_ACT_ID_F, {
	"act_id",
	".cs.S2C_NewDemonBoss_GetInfo.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_NUM_F, {
	"num",
	".cs.S2C_NewDemonBoss_GetInfo.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_TOTAL_POINT_F, {
	"total_point",
	".cs.S2C_NewDemonBoss_GetInfo.total_point",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_SELF_RANK_F, {
	"self_rank",
	".cs.S2C_NewDemonBoss_GetInfo.self_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_TALENT_IDS_F, {
	"talent_ids",
	".cs.S2C_NewDemonBoss_GetInfo.talent_ids",
	6,
	5,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_AWARD_IDS_F, {
	"award_ids",
	".cs.S2C_NewDemonBoss_GetInfo.award_ids",
	7,
	6,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.S2C_NEWDEMONBOSS_GETINFO_ME, {
	"S2C_NewDemonBoss_GetInfo",
	".cs.S2C_NewDemonBoss_GetInfo",
	{},
	{},
	{
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_RET_F,
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_ACT_ID_F,
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_NUM_F,
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_TOTAL_POINT_F,
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_SELF_RANK_F,
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_TALENT_IDS_F,
		var_0_9.S2C_NEWDEMONBOSS_GETINFO_AWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_ACT_ID_F, {
	"act_id",
	".cs.C2S_NewDemonBoss_BeginChallenge.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_NewDemonBoss_BeginChallenge.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_PHASE_F, {
	"phase",
	".cs.C2S_NewDemonBoss_BeginChallenge.phase",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_ME, {
	"C2S_NewDemonBoss_BeginChallenge",
	".cs.C2S_NewDemonBoss_BeginChallenge",
	{},
	{},
	{
		var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_ACT_ID_F,
		var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_BOSS_ID_F,
		var_0_9.C2S_NEWDEMONBOSS_BEGINCHALLENGE_PHASE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_NewDemonBoss_BeginChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_NewDemonBoss_BeginChallenge.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_ACT_ID_F, {
	"act_id",
	".cs.S2C_NewDemonBoss_BeginChallenge.act_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_ME, {
	"S2C_NewDemonBoss_BeginChallenge",
	".cs.S2C_NewDemonBoss_BeginChallenge",
	{},
	{},
	{
		var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_RET_F,
		var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_BATTLE_ID_F,
		var_0_9.S2C_NEWDEMONBOSS_BEGINCHALLENGE_ACT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_NewDemonBoss_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_POINT_F, {
	"point",
	".cs.S2C_NewDemonBoss_ChallengeFinish.point",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_TOTAL_POINT_F, {
	"total_point",
	".cs.S2C_NewDemonBoss_ChallengeFinish.total_point",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_NewDemonBoss_ChallengeFinish.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_1("pb_out_base").AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_ACT_ID_F, {
	"act_id",
	".cs.S2C_NewDemonBoss_ChallengeFinish.act_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_ME, {
	"S2C_NewDemonBoss_ChallengeFinish",
	".cs.S2C_NewDemonBoss_ChallengeFinish",
	{},
	{},
	{
		var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_RET_F,
		var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_POINT_F,
		var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_TOTAL_POINT_F,
		var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_AWARDS_F,
		var_0_9.S2C_NEWDEMONBOSS_CHALLENGEFINISH_ACT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_ACTIVETALENT_ACT_ID_F, {
	"act_id",
	".cs.C2S_NewDemonBoss_ActiveTalent.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_ACTIVETALENT_TALENT_IDS_F, {
	"talent_ids",
	".cs.C2S_NewDemonBoss_ActiveTalent.talent_ids",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_NEWDEMONBOSS_ACTIVETALENT_ME, {
	"C2S_NewDemonBoss_ActiveTalent",
	".cs.C2S_NewDemonBoss_ActiveTalent",
	{},
	{},
	{
		var_0_9.C2S_NEWDEMONBOSS_ACTIVETALENT_ACT_ID_F,
		var_0_9.C2S_NEWDEMONBOSS_ACTIVETALENT_TALENT_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_RET_F, {
	"ret",
	".cs.S2C_NewDemonBoss_ActiveTalent.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_ACT_ID_F, {
	"act_id",
	".cs.S2C_NewDemonBoss_ActiveTalent.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_TALENT_IDS_F, {
	"talent_ids",
	".cs.S2C_NewDemonBoss_ActiveTalent.talent_ids",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_ME, {
	"S2C_NewDemonBoss_ActiveTalent",
	".cs.S2C_NewDemonBoss_ActiveTalent",
	{},
	{},
	{
		var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_RET_F,
		var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_ACT_ID_F,
		var_0_9.S2C_NEWDEMONBOSS_ACTIVETALENT_TALENT_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_RESETTALENT_ACT_ID_F, {
	"act_id",
	".cs.C2S_NewDemonBoss_ResetTalent.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_NEWDEMONBOSS_RESETTALENT_TALENT_IDS_F, {
	"talent_ids",
	".cs.C2S_NewDemonBoss_ResetTalent.talent_ids",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_NEWDEMONBOSS_RESETTALENT_ME, {
	"C2S_NewDemonBoss_ResetTalent",
	".cs.C2S_NewDemonBoss_ResetTalent",
	{},
	{},
	{
		var_0_9.C2S_NEWDEMONBOSS_RESETTALENT_ACT_ID_F,
		var_0_9.C2S_NEWDEMONBOSS_RESETTALENT_TALENT_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_RET_F, {
	"ret",
	".cs.S2C_NewDemonBoss_ResetTalent.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_ACT_ID_F, {
	"act_id",
	".cs.S2C_NewDemonBoss_ResetTalent.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_TALENT_IDS_F, {
	"talent_ids",
	".cs.S2C_NewDemonBoss_ResetTalent.talent_ids",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_ME, {
	"S2C_NewDemonBoss_ResetTalent",
	".cs.S2C_NewDemonBoss_ResetTalent",
	{},
	{},
	{
		var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_RET_F,
		var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_ACT_ID_F,
		var_0_9.S2C_NEWDEMONBOSS_RESETTALENT_TALENT_IDS_F
	},
	false,
	{}
})

return var_0_9
