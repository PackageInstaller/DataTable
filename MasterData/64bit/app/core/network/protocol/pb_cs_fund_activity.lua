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
	C2S_FUNDACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	C2S_FUNDACTIVITY_GETINFO_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_FUNDACTIVITY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_GETINFO_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_GETINFO_ACTIONS_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_GETINFO_PAY_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_GETINFO_FREE_AWARD_LVS_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_GETINFO_PAY_AWARD_LVS_F = protobuf.FieldDescriptor(),
	C2S_FUNDACTIVITY_LEVELAWARD_ME = protobuf.Descriptor(),
	C2S_FUNDACTIVITY_LEVELAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_FUNDACTIVITY_LEVELAWARD_LV_F = protobuf.FieldDescriptor(),
	C2S_FUNDACTIVITY_LEVELAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_LEVELAWARD_ME = protobuf.Descriptor(),
	S2C_FUNDACTIVITY_LEVELAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_LEVELAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_LEVELAWARD_LV_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_LEVELAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_LEVELAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FUNDACTIVITY_UPDATEACTION_ME = protobuf.Descriptor(),
	S2C_FUNDACTIVITY_UPDATEACTION_ACTIONS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FUNDACTIVITY_GETINFO_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_FundActivity_GetInfo.activity_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FUNDACTIVITY_GETINFO_ME, {
	"C2S_FundActivity_GetInfo",
	".cs.C2S_FundActivity_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_FUNDACTIVITY_GETINFO_ACTIVITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_FundActivity_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_FundActivity_GetInfo.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_ACTIONS_F, {
	"actions",
	".cs.S2C_FundActivity_GetInfo.actions",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_PAY_F, {
	"pay",
	".cs.S2C_FundActivity_GetInfo.pay",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_FREE_AWARD_LVS_F, {
	"free_award_lvs",
	".cs.S2C_FundActivity_GetInfo.free_award_lvs",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_PAY_AWARD_LVS_F, {
	"pay_award_lvs",
	".cs.S2C_FundActivity_GetInfo.pay_award_lvs",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FUNDACTIVITY_GETINFO_ME, {
	"S2C_FundActivity_GetInfo",
	".cs.S2C_FundActivity_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_FUNDACTIVITY_GETINFO_RET_F,
		var_0_10.S2C_FUNDACTIVITY_GETINFO_ACTIVITY_ID_F,
		var_0_10.S2C_FUNDACTIVITY_GETINFO_ACTIONS_F,
		var_0_10.S2C_FUNDACTIVITY_GETINFO_PAY_F,
		var_0_10.S2C_FUNDACTIVITY_GETINFO_FREE_AWARD_LVS_F,
		var_0_10.S2C_FUNDACTIVITY_GETINFO_PAY_AWARD_LVS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_FundActivity_LevelAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_LV_F, {
	"lv",
	".cs.C2S_FundActivity_LevelAward.lv",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_TYPE_F, {
	"type",
	".cs.C2S_FundActivity_LevelAward.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_ME, {
	"C2S_FundActivity_LevelAward",
	".cs.C2S_FundActivity_LevelAward",
	{},
	{},
	{
		var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_ACTIVITY_ID_F,
		var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_LV_F,
		var_0_10.C2S_FUNDACTIVITY_LEVELAWARD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_RET_F, {
	"ret",
	".cs.S2C_FundActivity_LevelAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_FundActivity_LevelAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_LV_F, {
	"lv",
	".cs.S2C_FundActivity_LevelAward.lv",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_TYPE_F, {
	"type",
	".cs.S2C_FundActivity_LevelAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_FundActivity_LevelAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_ME, {
	"S2C_FundActivity_LevelAward",
	".cs.S2C_FundActivity_LevelAward",
	{},
	{},
	{
		var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_RET_F,
		var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_ACTIVITY_ID_F,
		var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_LV_F,
		var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_TYPE_F,
		var_0_10.S2C_FUNDACTIVITY_LEVELAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FUNDACTIVITY_UPDATEACTION_ACTIONS_F, {
	"actions",
	".cs.S2C_FundActivity_UpdateAction.actions",
	1,
	0,
	3,
	false,
	{},
	var_0_3.FUNDACTIVITYACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FUNDACTIVITY_UPDATEACTION_ME, {
	"S2C_FundActivity_UpdateAction",
	".cs.S2C_FundActivity_UpdateAction",
	{},
	{},
	{
		var_0_10.S2C_FUNDACTIVITY_UPDATEACTION_ACTIONS_F
	},
	false,
	{}
})

return var_0_10
