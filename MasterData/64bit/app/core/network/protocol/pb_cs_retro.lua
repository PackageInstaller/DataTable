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
	C2S_RETRO_GETINFO_ME = protobuf.Descriptor(),
	S2C_RETRO_GETINFO_ME = protobuf.Descriptor(),
	S2C_RETRO_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RETRO_GETINFO_RETRO_F = protobuf.FieldDescriptor(),
	S2C_RETRO_GETINFO_RETRO_BOX_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RETRO_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_RETRO_BOXAWARD_ME = protobuf.Descriptor(),
	C2S_RETRO_BOXAWARD_TP_F = protobuf.FieldDescriptor(),
	C2S_RETRO_BOXAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_ME = protobuf.Descriptor(),
	S2C_RETRO_BOXAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_TP_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_GUARANTEE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_BOXES_F = protobuf.FieldDescriptor(),
	S2C_RETRO_BOXAWARD_BOX_GUARANTEE_TIMES_F = protobuf.FieldDescriptor(),
	C2S_RETRO_REFRESHBOX_ME = protobuf.Descriptor(),
	S2C_RETRO_REFRESHBOX_ME = protobuf.Descriptor(),
	S2C_RETRO_REFRESHBOX_RET_F = protobuf.FieldDescriptor(),
	S2C_RETRO_REFRESHBOX_BOXES_F = protobuf.FieldDescriptor(),
	C2S_RETRO_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_RETRO_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_RETRO_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_RETRO_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RETRO_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_RETRO_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_RETRO_GETINFO_ME, {
	"C2S_Retro_GetInfo",
	".cs.C2S_Retro_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Retro_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_GETINFO_RETRO_F, {
	"retro",
	".cs.S2C_Retro_GetInfo.retro",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RETRO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_GETINFO_RETRO_BOX_AWARDS_F, {
	"retro_box_awards",
	".cs.S2C_Retro_GetInfo.retro_box_awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.RETROBOXAWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_Retro_GetInfo.tasks",
	4,
	3,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RETRO_GETINFO_ME, {
	"S2C_Retro_GetInfo",
	".cs.S2C_Retro_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_RETRO_GETINFO_RET_F,
		var_0_10.S2C_RETRO_GETINFO_RETRO_F,
		var_0_10.S2C_RETRO_GETINFO_RETRO_BOX_AWARDS_F,
		var_0_10.S2C_RETRO_GETINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RETRO_BOXAWARD_TP_F, {
	"tp",
	".cs.C2S_Retro_BoxAward.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RETRO_BOXAWARD_INDEX_F, {
	"index",
	".cs.C2S_Retro_BoxAward.index",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RETRO_BOXAWARD_ME, {
	"C2S_Retro_BoxAward",
	".cs.C2S_Retro_BoxAward",
	{},
	{},
	{
		var_0_10.C2S_RETRO_BOXAWARD_TP_F,
		var_0_10.C2S_RETRO_BOXAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_RET_F, {
	"ret",
	".cs.S2C_Retro_BoxAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_TP_F, {
	"tp",
	".cs.S2C_Retro_BoxAward.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_INDEX_F, {
	"index",
	".cs.S2C_Retro_BoxAward.index",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Retro_BoxAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_GUARANTEE_AWARDS_F, {
	"guarantee_awards",
	".cs.S2C_Retro_BoxAward.guarantee_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_BOXES_F, {
	"boxes",
	".cs.S2C_Retro_BoxAward.boxes",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_BOX_GUARANTEE_TIMES_F, {
	"box_guarantee_times",
	".cs.S2C_Retro_BoxAward.box_guarantee_times",
	7,
	6,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RETRO_BOXAWARD_ME, {
	"S2C_Retro_BoxAward",
	".cs.S2C_Retro_BoxAward",
	{},
	{},
	{
		var_0_10.S2C_RETRO_BOXAWARD_RET_F,
		var_0_10.S2C_RETRO_BOXAWARD_TP_F,
		var_0_10.S2C_RETRO_BOXAWARD_INDEX_F,
		var_0_10.S2C_RETRO_BOXAWARD_AWARDS_F,
		var_0_10.S2C_RETRO_BOXAWARD_GUARANTEE_AWARDS_F,
		var_0_10.S2C_RETRO_BOXAWARD_BOXES_F,
		var_0_10.S2C_RETRO_BOXAWARD_BOX_GUARANTEE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RETRO_REFRESHBOX_ME, {
	"C2S_Retro_RefreshBox",
	".cs.C2S_Retro_RefreshBox",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_REFRESHBOX_RET_F, {
	"ret",
	".cs.S2C_Retro_RefreshBox.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_REFRESHBOX_BOXES_F, {
	"boxes",
	".cs.S2C_Retro_RefreshBox.boxes",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RETRO_REFRESHBOX_ME, {
	"S2C_Retro_RefreshBox",
	".cs.S2C_Retro_RefreshBox",
	{},
	{},
	{
		var_0_10.S2C_RETRO_REFRESHBOX_RET_F,
		var_0_10.S2C_RETRO_REFRESHBOX_BOXES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RETRO_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Retro_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RETRO_TASKAWARD_ME, {
	"C2S_Retro_TaskAward",
	".cs.C2S_Retro_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_RETRO_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Retro_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Retro_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RETRO_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Retro_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RETRO_TASKAWARD_ME, {
	"S2C_Retro_TaskAward",
	".cs.S2C_Retro_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_RETRO_TASKAWARD_RET_F,
		var_0_10.S2C_RETRO_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_RETRO_TASKAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
