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
	C2S_MAINTASK_GETINFO_ME = protobuf.Descriptor(),
	S2C_MAINTASK_GETINFO_ME = protobuf.Descriptor(),
	S2C_MAINTASK_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MAINTASK_GETINFO_TASK_F = protobuf.FieldDescriptor(),
	C2S_MAINTASK_GETAWARD_ME = protobuf.Descriptor(),
	C2S_MAINTASK_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MAINTASK_GETAWARD_ME = protobuf.Descriptor(),
	S2C_MAINTASK_GETAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MAINTASK_GETAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MAINTASK_GETAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_MAINTASK_NOTIFY_ME = protobuf.Descriptor(),
	S2C_MAINTASK_NOTIFY_TASK_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_MAINTASK_GETINFO_ME, {
	"C2S_MainTask_GetInfo",
	".cs.C2S_MainTask_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MAINTASK_GETINFO_RET_F, {
	"ret",
	".cs.S2C_MainTask_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MAINTASK_GETINFO_TASK_F, {
	"task",
	".cs.S2C_MainTask_GetInfo.task",
	2,
	1,
	3,
	false,
	{},
	var_0_3.TASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MAINTASK_GETINFO_ME, {
	"S2C_MainTask_GetInfo",
	".cs.S2C_MainTask_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_MAINTASK_GETINFO_RET_F,
		var_0_10.S2C_MAINTASK_GETINFO_TASK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MAINTASK_GETAWARD_ID_F, {
	"id",
	".cs.C2S_MainTask_GetAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MAINTASK_GETAWARD_ME, {
	"C2S_MainTask_GetAward",
	".cs.C2S_MainTask_GetAward",
	{},
	{},
	{
		var_0_10.C2S_MAINTASK_GETAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MAINTASK_GETAWARD_RET_F, {
	"ret",
	".cs.S2C_MainTask_GetAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MAINTASK_GETAWARD_ID_F, {
	"id",
	".cs.S2C_MainTask_GetAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MAINTASK_GETAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_MainTask_GetAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MAINTASK_GETAWARD_ME, {
	"S2C_MainTask_GetAward",
	".cs.S2C_MainTask_GetAward",
	{},
	{},
	{
		var_0_10.S2C_MAINTASK_GETAWARD_RET_F,
		var_0_10.S2C_MAINTASK_GETAWARD_ID_F,
		var_0_10.S2C_MAINTASK_GETAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MAINTASK_NOTIFY_TASK_F, {
	"task",
	".cs.S2C_MainTask_Notify.task",
	1,
	0,
	3,
	false,
	{},
	var_0_3.TASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MAINTASK_NOTIFY_ME, {
	"S2C_MainTask_Notify",
	".cs.S2C_MainTask_Notify",
	{},
	{},
	{
		var_0_10.S2C_MAINTASK_NOTIFY_TASK_F
	},
	false,
	{}
})

return var_0_10
