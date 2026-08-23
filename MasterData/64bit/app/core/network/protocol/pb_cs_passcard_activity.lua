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
	C2S_PASSCARDACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_EXP_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_NORMAL_AWARD_LVS_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_RECHARGE_AWARD_LVS_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_PASSCARDACTIVITY_LEVELAWARD_ME = protobuf.Descriptor(),
	C2S_PASSCARDACTIVITY_LEVELAWARD_LV_F = protobuf.FieldDescriptor(),
	C2S_PASSCARDACTIVITY_LEVELAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_LEVELAWARD_ME = protobuf.Descriptor(),
	S2C_PASSCARDACTIVITY_LEVELAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_LEVELAWARD_LV_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_LEVELAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_LEVELAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_PASSCARDACTIVITY_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_PASSCARDACTIVITY_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_PASSCARDACTIVITY_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_PASSCARDACTIVITY_BUYLEVEL_ME = protobuf.Descriptor(),
	C2S_PASSCARDACTIVITY_BUYLEVEL_NUM_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_BUYLEVEL_ME = protobuf.Descriptor(),
	S2C_PASSCARDACTIVITY_BUYLEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_BUYLEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_UPDATE_ME = protobuf.Descriptor(),
	S2C_PASSCARDACTIVITY_UPDATE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_PASSCARDACTIVITY_UPDATE_EXP_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_GETINFO_ME, {
	"C2S_PasscardActivity_GetInfo",
	".cs.C2S_PasscardActivity_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_PasscardActivity_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_LEVEL_F, {
	"level",
	".cs.S2C_PasscardActivity_GetInfo.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_EXP_F, {
	"exp",
	".cs.S2C_PasscardActivity_GetInfo.exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_RECHARGE_F, {
	"recharge",
	".cs.S2C_PasscardActivity_GetInfo.recharge",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_NORMAL_AWARD_LVS_F, {
	"normal_award_lvs",
	".cs.S2C_PasscardActivity_GetInfo.normal_award_lvs",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_RECHARGE_AWARD_LVS_F, {
	"recharge_award_lvs",
	".cs.S2C_PasscardActivity_GetInfo.recharge_award_lvs",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_PasscardActivity_GetInfo.tasks",
	7,
	6,
	3,
	false,
	{},
	var_0_3.MULTITASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_GETINFO_ME, {
	"S2C_PasscardActivity_GetInfo",
	".cs.S2C_PasscardActivity_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_RET_F,
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_LEVEL_F,
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_EXP_F,
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_RECHARGE_F,
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_NORMAL_AWARD_LVS_F,
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_RECHARGE_AWARD_LVS_F,
		var_0_10.S2C_PASSCARDACTIVITY_GETINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_LEVELAWARD_LV_F, {
	"lv",
	".cs.C2S_PasscardActivity_LevelAward.lv",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_LEVELAWARD_TYPE_F, {
	"type",
	".cs.C2S_PasscardActivity_LevelAward.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_LEVELAWARD_ME, {
	"C2S_PasscardActivity_LevelAward",
	".cs.C2S_PasscardActivity_LevelAward",
	{},
	{},
	{
		var_0_10.C2S_PASSCARDACTIVITY_LEVELAWARD_LV_F,
		var_0_10.C2S_PASSCARDACTIVITY_LEVELAWARD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_RET_F, {
	"ret",
	".cs.S2C_PasscardActivity_LevelAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_LV_F, {
	"lv",
	".cs.S2C_PasscardActivity_LevelAward.lv",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_TYPE_F, {
	"type",
	".cs.S2C_PasscardActivity_LevelAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_PasscardActivity_LevelAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_ME, {
	"S2C_PasscardActivity_LevelAward",
	".cs.S2C_PasscardActivity_LevelAward",
	{},
	{},
	{
		var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_RET_F,
		var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_LV_F,
		var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_TYPE_F,
		var_0_10.S2C_PASSCARDACTIVITY_LEVELAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_PasscardActivity_TaskAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_TASKAWARD_ME, {
	"C2S_PasscardActivity_TaskAward",
	".cs.C2S_PasscardActivity_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_PASSCARDACTIVITY_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_PasscardActivity_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_PasscardActivity_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_PasscardActivity_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_ME, {
	"S2C_PasscardActivity_TaskAward",
	".cs.S2C_PasscardActivity_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_RET_F,
		var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_IDS_F,
		var_0_10.S2C_PASSCARDACTIVITY_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_BUYLEVEL_NUM_F, {
	"num",
	".cs.C2S_PasscardActivity_BuyLevel.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PASSCARDACTIVITY_BUYLEVEL_ME, {
	"C2S_PasscardActivity_BuyLevel",
	".cs.C2S_PasscardActivity_BuyLevel",
	{},
	{},
	{
		var_0_10.C2S_PASSCARDACTIVITY_BUYLEVEL_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_BUYLEVEL_RET_F, {
	"ret",
	".cs.S2C_PasscardActivity_BuyLevel.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_BUYLEVEL_LEVEL_F, {
	"level",
	".cs.S2C_PasscardActivity_BuyLevel.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_BUYLEVEL_ME, {
	"S2C_PasscardActivity_BuyLevel",
	".cs.S2C_PasscardActivity_BuyLevel",
	{},
	{},
	{
		var_0_10.S2C_PASSCARDACTIVITY_BUYLEVEL_RET_F,
		var_0_10.S2C_PASSCARDACTIVITY_BUYLEVEL_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_UPDATE_LEVEL_F, {
	"level",
	".cs.S2C_PasscardActivity_Update.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_UPDATE_EXP_F, {
	"exp",
	".cs.S2C_PasscardActivity_Update.exp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PASSCARDACTIVITY_UPDATE_ME, {
	"S2C_PasscardActivity_Update",
	".cs.S2C_PasscardActivity_Update",
	{},
	{},
	{
		var_0_10.S2C_PASSCARDACTIVITY_UPDATE_LEVEL_F,
		var_0_10.S2C_PASSCARDACTIVITY_UPDATE_EXP_F
	},
	false,
	{}
})

return var_0_10
