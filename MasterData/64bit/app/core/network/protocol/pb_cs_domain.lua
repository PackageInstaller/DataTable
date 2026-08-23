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
	C2S_DOMAIN_GETINFO_ME = protobuf.Descriptor(),
	S2C_DOMAIN_GETINFO_ME = protobuf.Descriptor(),
	S2C_DOMAIN_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_GETINFO_DOMAIN_F = protobuf.FieldDescriptor(),
	C2S_DOMAIN_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_DOMAIN_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_DOMAIN_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEBEGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_ID_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_GRADE_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_GRADE_PARAM_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_FIRST_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_GRADE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_CHALLENGEFINISH_SURPRISE_F = protobuf.FieldDescriptor(),
	C2S_DOMAIN_SWEEP_ME = protobuf.Descriptor(),
	C2S_DOMAIN_SWEEP_ID_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_SWEEP_ME = protobuf.Descriptor(),
	S2C_DOMAIN_SWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_SWEEP_ID_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_SWEEP_GRADE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DOMAIN_SWEEP_SURPRISE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_DOMAIN_GETINFO_ME, {
	"C2S_Domain_GetInfo",
	".cs.C2S_Domain_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Domain_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_GETINFO_DOMAIN_F, {
	"domain",
	".cs.S2C_Domain_GetInfo.domain",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.DOMAIN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DOMAIN_GETINFO_ME, {
	"S2C_Domain_GetInfo",
	".cs.S2C_Domain_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_DOMAIN_GETINFO_RET_F,
		var_0_10.S2C_DOMAIN_GETINFO_DOMAIN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DOMAIN_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.C2S_Domain_ChallengeBegin.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DOMAIN_CHALLENGEBEGIN_ME, {
	"C2S_Domain_ChallengeBegin",
	".cs.C2S_Domain_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_DOMAIN_CHALLENGEBEGIN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Domain_ChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_ID_F, {
	"id",
	".cs.S2C_Domain_ChallengeBegin.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Domain_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_ME, {
	"S2C_Domain_ChallengeBegin",
	".cs.S2C_Domain_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_ID_F,
		var_0_10.S2C_DOMAIN_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Domain_ChallengeFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_ID_F, {
	"id",
	".cs.S2C_Domain_ChallengeFinish.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Domain_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_GRADE_F, {
	"grade",
	".cs.S2C_Domain_ChallengeFinish.grade",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_GRADE_PARAM_F, {
	"grade_param",
	".cs.S2C_Domain_ChallengeFinish.grade_param",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_FIRST_AWARDS_F, {
	"first_awards",
	".cs.S2C_Domain_ChallengeFinish.first_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_GRADE_AWARDS_F, {
	"grade_awards",
	".cs.S2C_Domain_ChallengeFinish.grade_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_SURPRISE_F, {
	"surprise",
	".cs.S2C_Domain_ChallengeFinish.surprise",
	8,
	7,
	1,
	false,
	nil,
	var_0_3.DOMAINSURPRISE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DOMAIN_CHALLENGEFINISH_ME, {
	"S2C_Domain_ChallengeFinish",
	".cs.S2C_Domain_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_ID_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_GRADE_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_GRADE_PARAM_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_FIRST_AWARDS_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_GRADE_AWARDS_F,
		var_0_10.S2C_DOMAIN_CHALLENGEFINISH_SURPRISE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DOMAIN_SWEEP_ID_F, {
	"id",
	".cs.C2S_Domain_Sweep.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DOMAIN_SWEEP_ME, {
	"C2S_Domain_Sweep",
	".cs.C2S_Domain_Sweep",
	{},
	{},
	{
		var_0_10.C2S_DOMAIN_SWEEP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_SWEEP_RET_F, {
	"ret",
	".cs.S2C_Domain_Sweep.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_SWEEP_ID_F, {
	"id",
	".cs.S2C_Domain_Sweep.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_SWEEP_GRADE_AWARDS_F, {
	"grade_awards",
	".cs.S2C_Domain_Sweep.grade_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DOMAIN_SWEEP_SURPRISE_F, {
	"surprise",
	".cs.S2C_Domain_Sweep.surprise",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.DOMAINSURPRISE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DOMAIN_SWEEP_ME, {
	"S2C_Domain_Sweep",
	".cs.S2C_Domain_Sweep",
	{},
	{},
	{
		var_0_10.S2C_DOMAIN_SWEEP_RET_F,
		var_0_10.S2C_DOMAIN_SWEEP_ID_F,
		var_0_10.S2C_DOMAIN_SWEEP_GRADE_AWARDS_F,
		var_0_10.S2C_DOMAIN_SWEEP_SURPRISE_F
	},
	false,
	{}
})

return var_0_10
