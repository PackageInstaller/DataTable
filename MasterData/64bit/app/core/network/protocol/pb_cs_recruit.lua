local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_9 = {
	C2S_RECRUIT_INFO_ME = protobuf.Descriptor(),
	S2C_RECRUIT_INFO_ME = protobuf.Descriptor(),
	S2C_RECRUIT_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_INFO_FREE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_INFO_FREE_TIME_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_INFO_TOTAL_COUNT_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_INFO_DAILY_COUNT_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_INFO_GROUP_COUNT_F = protobuf.FieldDescriptor(),
	C2S_RECRUIT_RECRUIT_ME = protobuf.Descriptor(),
	C2S_RECRUIT_RECRUIT_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	C2S_RECRUIT_RECRUIT_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	C2S_RECRUIT_RECRUIT_NUM_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_RECRUIT_ME = protobuf.Descriptor(),
	S2C_RECRUIT_RECRUIT_RET_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_RECRUIT_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_RECRUIT_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_RECRUIT_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_RECRUIT_NUM_F = protobuf.FieldDescriptor(),
	S2C_RECRUIT_RECRUIT_DAILY_NUM_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_RECRUIT_INFO_ME, {
	"C2S_Recruit_Info",
	".cs.C2S_Recruit_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_INFO_RET_F, {
	"ret",
	".cs.S2C_Recruit_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_INFO_FREE_COUNT_F, {
	"free_count",
	".cs.S2C_Recruit_Info.free_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_INFO_FREE_TIME_F, {
	"free_time",
	".cs.S2C_Recruit_Info.free_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_INFO_TOTAL_COUNT_F, {
	"total_count",
	".cs.S2C_Recruit_Info.total_count",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_INFO_DAILY_COUNT_F, {
	"daily_count",
	".cs.S2C_Recruit_Info.daily_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_INFO_GROUP_COUNT_F, {
	"group_count",
	".cs.S2C_Recruit_Info.group_count",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_RECRUIT_INFO_ME, {
	"S2C_Recruit_Info",
	".cs.S2C_Recruit_Info",
	{},
	{},
	{
		var_0_9.S2C_RECRUIT_INFO_RET_F,
		var_0_9.S2C_RECRUIT_INFO_FREE_COUNT_F,
		var_0_9.S2C_RECRUIT_INFO_FREE_TIME_F,
		var_0_9.S2C_RECRUIT_INFO_TOTAL_COUNT_F,
		var_0_9.S2C_RECRUIT_INFO_DAILY_COUNT_F,
		var_0_9.S2C_RECRUIT_INFO_GROUP_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RECRUIT_RECRUIT_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.C2S_Recruit_Recruit.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RECRUIT_RECRUIT_CONSUME_TYPE_F, {
	"consume_type",
	".cs.C2S_Recruit_Recruit.consume_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_RECRUIT_RECRUIT_NUM_F, {
	"num",
	".cs.C2S_Recruit_Recruit.num",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_RECRUIT_RECRUIT_ME, {
	"C2S_Recruit_Recruit",
	".cs.C2S_Recruit_Recruit",
	{},
	{},
	{
		var_0_9.C2S_RECRUIT_RECRUIT_RECRUIT_TYPE_F,
		var_0_9.C2S_RECRUIT_RECRUIT_CONSUME_TYPE_F,
		var_0_9.C2S_RECRUIT_RECRUIT_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_RET_F, {
	"ret",
	".cs.S2C_Recruit_Recruit.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_AWARDS_F, {
	"awards",
	".cs.S2C_Recruit_Recruit.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_1("pb_out_base").AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.S2C_Recruit_Recruit.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_CONSUME_TYPE_F, {
	"consume_type",
	".cs.S2C_Recruit_Recruit.consume_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_NUM_F, {
	"num",
	".cs.S2C_Recruit_Recruit.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_DAILY_NUM_F, {
	"daily_num",
	".cs.S2C_Recruit_Recruit.daily_num",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_RECRUIT_RECRUIT_ME, {
	"S2C_Recruit_Recruit",
	".cs.S2C_Recruit_Recruit",
	{},
	{},
	{
		var_0_9.S2C_RECRUIT_RECRUIT_RET_F,
		var_0_9.S2C_RECRUIT_RECRUIT_AWARDS_F,
		var_0_9.S2C_RECRUIT_RECRUIT_RECRUIT_TYPE_F,
		var_0_9.S2C_RECRUIT_RECRUIT_CONSUME_TYPE_F,
		var_0_9.S2C_RECRUIT_RECRUIT_NUM_F,
		var_0_9.S2C_RECRUIT_RECRUIT_DAILY_NUM_F
	},
	false,
	{}
})

return var_0_9
