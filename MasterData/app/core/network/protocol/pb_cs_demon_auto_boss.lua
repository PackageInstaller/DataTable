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
	C2S_DEMONAUTOBOSS_GETINFO_ME = protobuf.Descriptor(),
	C2S_DEMONAUTOBOSS_GETINFO_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_GETINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_ME = protobuf.Descriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_NUM_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_DAILY_POINT_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_TOTAL_POINT_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETINFO_SELF_RANK_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_BEGINCHALLENGE_ME = protobuf.Descriptor(),
	C2S_DEMONAUTOBOSS_BEGINCHALLENGE_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_BEGINCHALLENGE_ACT_ID_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_BEGINCHALLENGE_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_BEGINCHALLENGE_PHASE_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_BEGINCHALLENGE_ME = protobuf.Descriptor(),
	S2C_DEMONAUTOBOSS_BEGINCHALLENGE_RET_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_BEGINCHALLENGE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_BEGINCHALLENGE_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_DEMONAUTOBOSS_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_CHALLENGEFINISH_POINT_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_CHALLENGEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_CHALLENGEFINISH_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_CHALLENGEFINISH_BOSS_AWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_GETAWARD_ME = protobuf.Descriptor(),
	C2S_DEMONAUTOBOSS_GETAWARD_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_DEMONAUTOBOSS_GETAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETAWARD_ME = protobuf.Descriptor(),
	S2C_DEMONAUTOBOSS_GETAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETAWARD_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	S2C_DEMONAUTOBOSS_GETAWARD_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETINFO_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.C2S_DemonAutoBoss_GetInfo.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETINFO_ID_F, {
	"id",
	".cs.C2S_DemonAutoBoss_GetInfo.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETINFO_ME, {
	"C2S_DemonAutoBoss_GetInfo",
	".cs.C2S_DemonAutoBoss_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_DEMONAUTOBOSS_GETINFO_RECRUIT_TYPE_F,
		var_0_10.C2S_DEMONAUTOBOSS_GETINFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_RET_F, {
	"ret",
	".cs.S2C_DemonAutoBoss_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_NUM_F, {
	"num",
	".cs.S2C_DemonAutoBoss_GetInfo.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_DAILY_POINT_F, {
	"daily_point",
	".cs.S2C_DemonAutoBoss_GetInfo.daily_point",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_TOTAL_POINT_F, {
	"total_point",
	".cs.S2C_DemonAutoBoss_GetInfo.total_point",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_ID_F, {
	"id",
	".cs.S2C_DemonAutoBoss_GetInfo.id",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_AWARD_IDS_F, {
	"award_ids",
	".cs.S2C_DemonAutoBoss_GetInfo.award_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_SELF_RANK_F, {
	"self_rank",
	".cs.S2C_DemonAutoBoss_GetInfo.self_rank",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETINFO_ME, {
	"S2C_DemonAutoBoss_GetInfo",
	".cs.S2C_DemonAutoBoss_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_RET_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_NUM_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_DAILY_POINT_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_TOTAL_POINT_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_ID_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_AWARD_IDS_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETINFO_SELF_RANK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.C2S_DemonAutoBoss_BeginChallenge.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_ACT_ID_F, {
	"act_id",
	".cs.C2S_DemonAutoBoss_BeginChallenge.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_DemonAutoBoss_BeginChallenge.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_PHASE_F, {
	"phase",
	".cs.C2S_DemonAutoBoss_BeginChallenge.phase",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_ME, {
	"C2S_DemonAutoBoss_BeginChallenge",
	".cs.C2S_DemonAutoBoss_BeginChallenge",
	{},
	{},
	{
		var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_RECRUIT_TYPE_F,
		var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_ACT_ID_F,
		var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_BOSS_ID_F,
		var_0_10.C2S_DEMONAUTOBOSS_BEGINCHALLENGE_PHASE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_RET_F, {
	"ret",
	".cs.S2C_DemonAutoBoss_BeginChallenge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_DemonAutoBoss_BeginChallenge.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_ACT_ID_F, {
	"act_id",
	".cs.S2C_DemonAutoBoss_BeginChallenge.act_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_ME, {
	"S2C_DemonAutoBoss_BeginChallenge",
	".cs.S2C_DemonAutoBoss_BeginChallenge",
	{},
	{},
	{
		var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_RET_F,
		var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_BATTLE_ID_F,
		var_0_10.S2C_DEMONAUTOBOSS_BEGINCHALLENGE_ACT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_DemonAutoBoss_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_POINT_F, {
	"point",
	".cs.S2C_DemonAutoBoss_ChallengeFinish.point",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_DemonAutoBoss_ChallengeFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_ACT_ID_F, {
	"act_id",
	".cs.S2C_DemonAutoBoss_ChallengeFinish.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_BOSS_AWARD_ID_F, {
	"boss_award_id",
	".cs.S2C_DemonAutoBoss_ChallengeFinish.boss_award_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_ME, {
	"S2C_DemonAutoBoss_ChallengeFinish",
	".cs.S2C_DemonAutoBoss_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_POINT_F,
		var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_AWARDS_F,
		var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_ACT_ID_F,
		var_0_10.S2C_DEMONAUTOBOSS_CHALLENGEFINISH_BOSS_AWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.C2S_DemonAutoBoss_GetAward.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_ID_F, {
	"id",
	".cs.C2S_DemonAutoBoss_GetAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_IDS_F, {
	"ids",
	".cs.C2S_DemonAutoBoss_GetAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_ME, {
	"C2S_DemonAutoBoss_GetAward",
	".cs.C2S_DemonAutoBoss_GetAward",
	{},
	{},
	{
		var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_RECRUIT_TYPE_F,
		var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_ID_F,
		var_0_10.C2S_DEMONAUTOBOSS_GETAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_RET_F, {
	"ret",
	".cs.S2C_DemonAutoBoss_GetAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_IDS_F, {
	"ids",
	".cs.S2C_DemonAutoBoss_GetAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_DemonAutoBoss_GetAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.S2C_DemonAutoBoss_GetAward.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_ID_F, {
	"id",
	".cs.S2C_DemonAutoBoss_GetAward.id",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_ME, {
	"S2C_DemonAutoBoss_GetAward",
	".cs.S2C_DemonAutoBoss_GetAward",
	{},
	{},
	{
		var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_RET_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_IDS_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_AWARDS_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_RECRUIT_TYPE_F,
		var_0_10.S2C_DEMONAUTOBOSS_GETAWARD_ID_F
	},
	false,
	{}
})

return var_0_10
