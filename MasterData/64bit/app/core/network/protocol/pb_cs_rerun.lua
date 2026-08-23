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
	C2S_RERUN_GETINFO_ME = protobuf.Descriptor(),
	S2C_RERUN_GETINFO_ME = protobuf.Descriptor(),
	S2C_RERUN_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RERUN_GETINFO_CHOOSE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RERUN_GETINFO_GUARANTEE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_RERUN_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_RERUN_CHOOSEAWARD_ME = protobuf.Descriptor(),
	C2S_RERUN_CHOOSEAWARD_TYPE_F = protobuf.FieldDescriptor(),
	C2S_RERUN_CHOOSEAWARD_VALUE_F = protobuf.FieldDescriptor(),
	S2C_RERUN_CHOOSEAWARD_ME = protobuf.Descriptor(),
	S2C_RERUN_CHOOSEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RERUN_CHOOSEAWARD_CHOOSE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RERUN_DRAW_ME = protobuf.Descriptor(),
	C2S_RERUN_DRAW_TYPE_F = protobuf.FieldDescriptor(),
	S2C_RERUN_DRAW_ME = protobuf.Descriptor(),
	S2C_RERUN_DRAW_RET_F = protobuf.FieldDescriptor(),
	S2C_RERUN_DRAW_TYPE_F = protobuf.FieldDescriptor(),
	S2C_RERUN_DRAW_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RERUN_DRAW_GUARANTEE_TIMES_F = protobuf.FieldDescriptor(),
	C2S_RERUN_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_RERUN_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_RERUN_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_RERUN_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RERUN_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_RERUN_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_RERUN_GETINFO_ME, {
	"C2S_Rerun_GetInfo",
	".cs.C2S_Rerun_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Rerun_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_GETINFO_CHOOSE_AWARDS_F, {
	"choose_awards",
	".cs.S2C_Rerun_GetInfo.choose_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_GETINFO_GUARANTEE_TIMES_F, {
	"guarantee_times",
	".cs.S2C_Rerun_GetInfo.guarantee_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_Rerun_GetInfo.tasks",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RERUN_GETINFO_ME, {
	"S2C_Rerun_GetInfo",
	".cs.S2C_Rerun_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_RERUN_GETINFO_RET_F,
		var_0_10.S2C_RERUN_GETINFO_CHOOSE_AWARDS_F,
		var_0_10.S2C_RERUN_GETINFO_GUARANTEE_TIMES_F,
		var_0_10.S2C_RERUN_GETINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RERUN_CHOOSEAWARD_TYPE_F, {
	"type",
	".cs.C2S_Rerun_ChooseAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RERUN_CHOOSEAWARD_VALUE_F, {
	"value",
	".cs.C2S_Rerun_ChooseAward.value",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RERUN_CHOOSEAWARD_ME, {
	"C2S_Rerun_ChooseAward",
	".cs.C2S_Rerun_ChooseAward",
	{},
	{},
	{
		var_0_10.C2S_RERUN_CHOOSEAWARD_TYPE_F,
		var_0_10.C2S_RERUN_CHOOSEAWARD_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_CHOOSEAWARD_RET_F, {
	"ret",
	".cs.S2C_Rerun_ChooseAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_CHOOSEAWARD_CHOOSE_AWARDS_F, {
	"choose_awards",
	".cs.S2C_Rerun_ChooseAward.choose_awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RERUN_CHOOSEAWARD_ME, {
	"S2C_Rerun_ChooseAward",
	".cs.S2C_Rerun_ChooseAward",
	{},
	{},
	{
		var_0_10.S2C_RERUN_CHOOSEAWARD_RET_F,
		var_0_10.S2C_RERUN_CHOOSEAWARD_CHOOSE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RERUN_DRAW_TYPE_F, {
	"type",
	".cs.C2S_Rerun_Draw.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RERUN_DRAW_ME, {
	"C2S_Rerun_Draw",
	".cs.C2S_Rerun_Draw",
	{},
	{},
	{
		var_0_10.C2S_RERUN_DRAW_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_DRAW_RET_F, {
	"ret",
	".cs.S2C_Rerun_Draw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_DRAW_TYPE_F, {
	"type",
	".cs.S2C_Rerun_Draw.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_DRAW_AWARDS_F, {
	"awards",
	".cs.S2C_Rerun_Draw.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_DRAW_GUARANTEE_TIMES_F, {
	"guarantee_times",
	".cs.S2C_Rerun_Draw.guarantee_times",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RERUN_DRAW_ME, {
	"S2C_Rerun_Draw",
	".cs.S2C_Rerun_Draw",
	{},
	{},
	{
		var_0_10.S2C_RERUN_DRAW_RET_F,
		var_0_10.S2C_RERUN_DRAW_TYPE_F,
		var_0_10.S2C_RERUN_DRAW_AWARDS_F,
		var_0_10.S2C_RERUN_DRAW_GUARANTEE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RERUN_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_Rerun_TaskAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RERUN_TASKAWARD_ME, {
	"C2S_Rerun_TaskAward",
	".cs.C2S_Rerun_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_RERUN_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Rerun_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_Rerun_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RERUN_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Rerun_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RERUN_TASKAWARD_ME, {
	"S2C_Rerun_TaskAward",
	".cs.S2C_Rerun_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_RERUN_TASKAWARD_RET_F,
		var_0_10.S2C_RERUN_TASKAWARD_IDS_F,
		var_0_10.S2C_RERUN_TASKAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
