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
	C2S_HANDBOOKCOMPETITION_GETINFO_ME = protobuf.Descriptor(),
	S2C_HANDBOOKCOMPETITION_GETINFO_ME = protobuf.Descriptor(),
	S2C_HANDBOOKCOMPETITION_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_GETINFO_INFO_F = protobuf.FieldDescriptor(),
	C2S_HANDBOOKCOMPETITION_GETAWARD_ME = protobuf.Descriptor(),
	C2S_HANDBOOKCOMPETITION_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_HANDBOOKCOMPETITION_GETAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_GETAWARD_ME = protobuf.Descriptor(),
	S2C_HANDBOOKCOMPETITION_GETAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_GETAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_GETAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_GETAWARD_AWARDED_TASKS_F = protobuf.FieldDescriptor(),
	S2C_HANDBOOKCOMPETITION_SYNCTASK_ME = protobuf.Descriptor(),
	S2C_HANDBOOKCOMPETITION_SYNCTASK_TASK_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_HANDBOOKCOMPETITION_GETINFO_ME, {
	"C2S_HandbookCompetition_GetInfo",
	".cs.C2S_HandbookCompetition_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETINFO_RET_F, {
	"ret",
	".cs.S2C_HandbookCompetition_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETINFO_INFO_F, {
	"info",
	".cs.S2C_HandbookCompetition_GetInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.HANDBOOKCOMPETITION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETINFO_ME, {
	"S2C_HandbookCompetition_GetInfo",
	".cs.S2C_HandbookCompetition_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_HANDBOOKCOMPETITION_GETINFO_RET_F,
		var_0_10.S2C_HANDBOOKCOMPETITION_GETINFO_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_HANDBOOKCOMPETITION_GETAWARD_ID_F, {
	"id",
	".cs.C2S_HandbookCompetition_GetAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_HANDBOOKCOMPETITION_GETAWARD_TYPE_F, {
	"type",
	".cs.C2S_HandbookCompetition_GetAward.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_HANDBOOKCOMPETITION_GETAWARD_ME, {
	"C2S_HandbookCompetition_GetAward",
	".cs.C2S_HandbookCompetition_GetAward",
	{},
	{},
	{
		var_0_10.C2S_HANDBOOKCOMPETITION_GETAWARD_ID_F,
		var_0_10.C2S_HANDBOOKCOMPETITION_GETAWARD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_RET_F, {
	"ret",
	".cs.S2C_HandbookCompetition_GetAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_ID_F, {
	"id",
	".cs.S2C_HandbookCompetition_GetAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_TYPE_F, {
	"type",
	".cs.S2C_HandbookCompetition_GetAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_HandbookCompetition_GetAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_AWARDED_TASKS_F, {
	"awarded_tasks",
	".cs.S2C_HandbookCompetition_GetAward.awarded_tasks",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_ME, {
	"S2C_HandbookCompetition_GetAward",
	".cs.S2C_HandbookCompetition_GetAward",
	{},
	{},
	{
		var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_RET_F,
		var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_ID_F,
		var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_TYPE_F,
		var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_AWARDS_F,
		var_0_10.S2C_HANDBOOKCOMPETITION_GETAWARD_AWARDED_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_SYNCTASK_TASK_F, {
	"task",
	".cs.S2C_HandbookCompetition_SyncTask.task",
	1,
	0,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HANDBOOKCOMPETITION_SYNCTASK_ME, {
	"S2C_HandbookCompetition_SyncTask",
	".cs.S2C_HandbookCompetition_SyncTask",
	{},
	{},
	{
		var_0_10.S2C_HANDBOOKCOMPETITION_SYNCTASK_TASK_F
	},
	false,
	{}
})

return var_0_10
