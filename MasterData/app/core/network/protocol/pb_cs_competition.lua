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
	C2S_COMPETITION_GETINFO_ME = protobuf.Descriptor(),
	C2S_COMPETITION_GETINFO_ACTIVITY_SUB_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_GETINFO_ME = protobuf.Descriptor(),
	S2C_COMPETITION_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_GETINFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	C2S_COMPETITION_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_COMPETITION_TASKAWARD_ACTIVITY_SUB_ID_F = protobuf.FieldDescriptor(),
	C2S_COMPETITION_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_COMPETITION_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_TASKAWARD_ACTIVITY_SUB_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_COMPETITION_SCOREAWARD_ME = protobuf.Descriptor(),
	C2S_COMPETITION_SCOREAWARD_ACTIVITY_SUB_ID_F = protobuf.FieldDescriptor(),
	C2S_COMPETITION_SCOREAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_SCOREAWARD_ME = protobuf.Descriptor(),
	S2C_COMPETITION_SCOREAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_SCOREAWARD_ACTIVITY_SUB_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_SCOREAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_COMPETITION_SCOREAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMPETITION_GETINFO_ACTIVITY_SUB_ID_F, {
	"activity_sub_id",
	".cs.C2S_Competition_GetInfo.activity_sub_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMPETITION_GETINFO_ME, {
	"C2S_Competition_GetInfo",
	".cs.C2S_Competition_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_COMPETITION_GETINFO_ACTIVITY_SUB_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Competition_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_GETINFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_Competition_GetInfo.activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.COMPETITION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_COMPETITION_GETINFO_ME, {
	"S2C_Competition_GetInfo",
	".cs.S2C_Competition_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_COMPETITION_GETINFO_RET_F,
		var_0_10.S2C_COMPETITION_GETINFO_ACTIVITY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMPETITION_TASKAWARD_ACTIVITY_SUB_ID_F, {
	"activity_sub_id",
	".cs.C2S_Competition_TaskAward.activity_sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMPETITION_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Competition_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMPETITION_TASKAWARD_ME, {
	"C2S_Competition_TaskAward",
	".cs.C2S_Competition_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_COMPETITION_TASKAWARD_ACTIVITY_SUB_ID_F,
		var_0_10.C2S_COMPETITION_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Competition_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_TASKAWARD_ACTIVITY_SUB_ID_F, {
	"activity_sub_id",
	".cs.S2C_Competition_TaskAward.activity_sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Competition_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Competition_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_COMPETITION_TASKAWARD_ME, {
	"S2C_Competition_TaskAward",
	".cs.S2C_Competition_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_COMPETITION_TASKAWARD_RET_F,
		var_0_10.S2C_COMPETITION_TASKAWARD_ACTIVITY_SUB_ID_F,
		var_0_10.S2C_COMPETITION_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_COMPETITION_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMPETITION_SCOREAWARD_ACTIVITY_SUB_ID_F, {
	"activity_sub_id",
	".cs.C2S_Competition_ScoreAward.activity_sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMPETITION_SCOREAWARD_ID_F, {
	"id",
	".cs.C2S_Competition_ScoreAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMPETITION_SCOREAWARD_ME, {
	"C2S_Competition_ScoreAward",
	".cs.C2S_Competition_ScoreAward",
	{},
	{},
	{
		var_0_10.C2S_COMPETITION_SCOREAWARD_ACTIVITY_SUB_ID_F,
		var_0_10.C2S_COMPETITION_SCOREAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_SCOREAWARD_RET_F, {
	"ret",
	".cs.S2C_Competition_ScoreAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_SCOREAWARD_ACTIVITY_SUB_ID_F, {
	"activity_sub_id",
	".cs.S2C_Competition_ScoreAward.activity_sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_SCOREAWARD_ID_F, {
	"id",
	".cs.S2C_Competition_ScoreAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMPETITION_SCOREAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Competition_ScoreAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_COMPETITION_SCOREAWARD_ME, {
	"S2C_Competition_ScoreAward",
	".cs.S2C_Competition_ScoreAward",
	{},
	{},
	{
		var_0_10.S2C_COMPETITION_SCOREAWARD_RET_F,
		var_0_10.S2C_COMPETITION_SCOREAWARD_ACTIVITY_SUB_ID_F,
		var_0_10.S2C_COMPETITION_SCOREAWARD_ID_F,
		var_0_10.S2C_COMPETITION_SCOREAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
