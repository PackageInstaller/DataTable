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
	C2S_DAILYTASK_GETINFO_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_GETINFO_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_CUR_DEGREE_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_DEGREE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_FINISH_REWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_DEGREE_REWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_PROFILE_EXP_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_GETINFO_PROFILE_IDS_F = protobuf.FieldDescriptor(),
	C2S_DAILYTASK_FINISHAWARD_ME = protobuf.Descriptor(),
	C2S_DAILYTASK_FINISHAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_FINISHAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_CUR_DEGREE_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_DEGREE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_FINISH_REWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_FINISHAWARD_PROFILE_EXP_F = protobuf.FieldDescriptor(),
	C2S_DAILYTASK_DEGREEAWARD_ME = protobuf.Descriptor(),
	C2S_DAILYTASK_DEGREEAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_DEGREEAWARD_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_DEGREEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_DEGREEAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_DEGREEAWARD_DEGREE_REWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_DEGREEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_DAILYTASK_ONEKEY_FINISHAWARD_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_CUR_DEGREE_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_DEGREE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_FINISH_REWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_ONEKEY_FINISHAWARD_PROFILE_EXP_F = protobuf.FieldDescriptor(),
	C2S_DAILYTASK_PROFILEAWARD_ME = protobuf.Descriptor(),
	C2S_DAILYTASK_PROFILEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_PROFILEAWARD_ME = protobuf.Descriptor(),
	S2C_DAILYTASK_PROFILEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_PROFILEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_PROFILEAWARD_DEGREE_REWARDS_F = protobuf.FieldDescriptor(),
	S2C_DAILYTASK_PROFILEAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_DAILYTASK_GETINFO_ME, {
	"C2S_DailyTask_GetInfo",
	".cs.C2S_DailyTask_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_RET_F, {
	"ret",
	".cs.S2C_DailyTask_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_CUR_DEGREE_F, {
	"cur_degree",
	".cs.S2C_DailyTask_GetInfo.cur_degree",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_DEGREE_LEVEL_F, {
	"degree_level",
	".cs.S2C_DailyTask_GetInfo.degree_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_FINISH_REWARDS_F, {
	"finish_rewards",
	".cs.S2C_DailyTask_GetInfo.finish_rewards",
	5,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_DEGREE_REWARDS_F, {
	"degree_rewards",
	".cs.S2C_DailyTask_GetInfo.degree_rewards",
	6,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_DailyTask_GetInfo.tasks",
	7,
	5,
	3,
	false,
	{},
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_PROFILE_EXP_F, {
	"profile_exp",
	".cs.S2C_DailyTask_GetInfo.profile_exp",
	8,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_PROFILE_IDS_F, {
	"profile_ids",
	".cs.S2C_DailyTask_GetInfo.profile_ids",
	9,
	7,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DAILYTASK_GETINFO_ME, {
	"S2C_DailyTask_GetInfo",
	".cs.S2C_DailyTask_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_DAILYTASK_GETINFO_RET_F,
		var_0_10.S2C_DAILYTASK_GETINFO_CUR_DEGREE_F,
		var_0_10.S2C_DAILYTASK_GETINFO_DEGREE_LEVEL_F,
		var_0_10.S2C_DAILYTASK_GETINFO_FINISH_REWARDS_F,
		var_0_10.S2C_DAILYTASK_GETINFO_DEGREE_REWARDS_F,
		var_0_10.S2C_DAILYTASK_GETINFO_TASKS_F,
		var_0_10.S2C_DAILYTASK_GETINFO_PROFILE_EXP_F,
		var_0_10.S2C_DAILYTASK_GETINFO_PROFILE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DAILYTASK_FINISHAWARD_ID_F, {
	"id",
	".cs.C2S_DailyTask_FinishAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DAILYTASK_FINISHAWARD_ME, {
	"C2S_DailyTask_FinishAward",
	".cs.C2S_DailyTask_FinishAward",
	{},
	{},
	{
		var_0_10.C2S_DAILYTASK_FINISHAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_RET_F, {
	"ret",
	".cs.S2C_DailyTask_FinishAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_ID_F, {
	"id",
	".cs.S2C_DailyTask_FinishAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_CUR_DEGREE_F, {
	"cur_degree",
	".cs.S2C_DailyTask_FinishAward.cur_degree",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_DEGREE_LEVEL_F, {
	"degree_level",
	".cs.S2C_DailyTask_FinishAward.degree_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_FINISH_REWARDS_F, {
	"finish_rewards",
	".cs.S2C_DailyTask_FinishAward.finish_rewards",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_DailyTask_FinishAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_PROFILE_EXP_F, {
	"profile_exp",
	".cs.S2C_DailyTask_FinishAward.profile_exp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DAILYTASK_FINISHAWARD_ME, {
	"S2C_DailyTask_FinishAward",
	".cs.S2C_DailyTask_FinishAward",
	{},
	{},
	{
		var_0_10.S2C_DAILYTASK_FINISHAWARD_RET_F,
		var_0_10.S2C_DAILYTASK_FINISHAWARD_ID_F,
		var_0_10.S2C_DAILYTASK_FINISHAWARD_CUR_DEGREE_F,
		var_0_10.S2C_DAILYTASK_FINISHAWARD_DEGREE_LEVEL_F,
		var_0_10.S2C_DAILYTASK_FINISHAWARD_FINISH_REWARDS_F,
		var_0_10.S2C_DAILYTASK_FINISHAWARD_AWARDS_F,
		var_0_10.S2C_DAILYTASK_FINISHAWARD_PROFILE_EXP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DAILYTASK_DEGREEAWARD_IDS_F, {
	"ids",
	".cs.C2S_DailyTask_DegreeAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DAILYTASK_DEGREEAWARD_ME, {
	"C2S_DailyTask_DegreeAward",
	".cs.C2S_DailyTask_DegreeAward",
	{},
	{},
	{
		var_0_10.C2S_DAILYTASK_DEGREEAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_DEGREEAWARD_RET_F, {
	"ret",
	".cs.S2C_DailyTask_DegreeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_DEGREEAWARD_IDS_F, {
	"ids",
	".cs.S2C_DailyTask_DegreeAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_DEGREEAWARD_DEGREE_REWARDS_F, {
	"degree_rewards",
	".cs.S2C_DailyTask_DegreeAward.degree_rewards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_DEGREEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_DailyTask_DegreeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DAILYTASK_DEGREEAWARD_ME, {
	"S2C_DailyTask_DegreeAward",
	".cs.S2C_DailyTask_DegreeAward",
	{},
	{},
	{
		var_0_10.S2C_DAILYTASK_DEGREEAWARD_RET_F,
		var_0_10.S2C_DAILYTASK_DEGREEAWARD_IDS_F,
		var_0_10.S2C_DAILYTASK_DEGREEAWARD_DEGREE_REWARDS_F,
		var_0_10.S2C_DAILYTASK_DEGREEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_DAILYTASK_ONEKEY_FINISHAWARD_ME, {
	"C2S_DailyTask_OneKey_FinishAward",
	".cs.C2S_DailyTask_OneKey_FinishAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_RET_F, {
	"ret",
	".cs.S2C_DailyTask_OneKey_FinishAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_CUR_DEGREE_F, {
	"cur_degree",
	".cs.S2C_DailyTask_OneKey_FinishAward.cur_degree",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_DEGREE_LEVEL_F, {
	"degree_level",
	".cs.S2C_DailyTask_OneKey_FinishAward.degree_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_FINISH_REWARDS_F, {
	"finish_rewards",
	".cs.S2C_DailyTask_OneKey_FinishAward.finish_rewards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_DailyTask_OneKey_FinishAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_PROFILE_EXP_F, {
	"profile_exp",
	".cs.S2C_DailyTask_OneKey_FinishAward.profile_exp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_ME, {
	"S2C_DailyTask_OneKey_FinishAward",
	".cs.S2C_DailyTask_OneKey_FinishAward",
	{},
	{},
	{
		var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_RET_F,
		var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_CUR_DEGREE_F,
		var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_DEGREE_LEVEL_F,
		var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_FINISH_REWARDS_F,
		var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_AWARDS_F,
		var_0_10.S2C_DAILYTASK_ONEKEY_FINISHAWARD_PROFILE_EXP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DAILYTASK_PROFILEAWARD_ID_F, {
	"id",
	".cs.C2S_DailyTask_ProfileAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DAILYTASK_PROFILEAWARD_ME, {
	"C2S_DailyTask_ProfileAward",
	".cs.C2S_DailyTask_ProfileAward",
	{},
	{},
	{
		var_0_10.C2S_DAILYTASK_PROFILEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_PROFILEAWARD_RET_F, {
	"ret",
	".cs.S2C_DailyTask_ProfileAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_PROFILEAWARD_ID_F, {
	"id",
	".cs.S2C_DailyTask_ProfileAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_PROFILEAWARD_DEGREE_REWARDS_F, {
	"degree_rewards",
	".cs.S2C_DailyTask_ProfileAward.degree_rewards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DAILYTASK_PROFILEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_DailyTask_ProfileAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DAILYTASK_PROFILEAWARD_ME, {
	"S2C_DailyTask_ProfileAward",
	".cs.S2C_DailyTask_ProfileAward",
	{},
	{},
	{
		var_0_10.S2C_DAILYTASK_PROFILEAWARD_RET_F,
		var_0_10.S2C_DAILYTASK_PROFILEAWARD_ID_F,
		var_0_10.S2C_DAILYTASK_PROFILEAWARD_DEGREE_REWARDS_F,
		var_0_10.S2C_DAILYTASK_PROFILEAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
