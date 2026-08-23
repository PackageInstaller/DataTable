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
	C2S_WISHPOOL_FLUSH_ME = protobuf.Descriptor(),
	S2C_WISHPOOL_FLUSH_ME = protobuf.Descriptor(),
	S2C_WISHPOOL_FLUSH_RET_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_END_TIME_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_DAILY_PRESENT_TIMES_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_RECHARGE_MONEY_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_RECHARGE_AWARD_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_WISH_RECORD_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_RECHARGE_BAIT_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FLUSH_ACTIVE_BAIT_F = protobuf.FieldDescriptor(),
	C2S_WISHPOOL_DAILYPRESENTS_ME = protobuf.Descriptor(),
	S2C_WISHPOOL_DAILYPRESENTS_ME = protobuf.Descriptor(),
	S2C_WISHPOOL_DAILYPRESENTS_RET_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_DAILYPRESENTS_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_WISHPOOL_FISHING_ME = protobuf.Descriptor(),
	C2S_WISHPOOL_FISHING_NUM_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FISHING_ME = protobuf.Descriptor(),
	S2C_WISHPOOL_FISHING_RET_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FISHING_NUM_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FISHING_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_WISHPOOL_FISHING_DROP_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_WISHPOOL_FLUSH_ME, {
	"C2S_Wishpool_Flush",
	".cs.C2S_Wishpool_Flush",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_RET_F, {
	"ret",
	".cs.S2C_Wishpool_Flush.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_POOL_ID_F, {
	"pool_id",
	".cs.S2C_Wishpool_Flush.pool_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_END_TIME_F, {
	"end_time",
	".cs.S2C_Wishpool_Flush.end_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_DAILY_PRESENT_TIMES_F, {
	"daily_present_times",
	".cs.S2C_Wishpool_Flush.daily_present_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_RECHARGE_MONEY_F, {
	"recharge_money",
	".cs.S2C_Wishpool_Flush.recharge_money",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_RECHARGE_AWARD_F, {
	"recharge_award",
	".cs.S2C_Wishpool_Flush.recharge_award",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_WISH_RECORD_F, {
	"wish_record",
	".cs.S2C_Wishpool_Flush.wish_record",
	7,
	6,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_START_TIME_F, {
	"start_time",
	".cs.S2C_Wishpool_Flush.start_time",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_RECHARGE_BAIT_F, {
	"recharge_bait",
	".cs.S2C_Wishpool_Flush.recharge_bait",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_ACTIVE_BAIT_F, {
	"active_bait",
	".cs.S2C_Wishpool_Flush.active_bait",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WISHPOOL_FLUSH_ME, {
	"S2C_Wishpool_Flush",
	".cs.S2C_Wishpool_Flush",
	{},
	{},
	{
		var_0_10.S2C_WISHPOOL_FLUSH_RET_F,
		var_0_10.S2C_WISHPOOL_FLUSH_POOL_ID_F,
		var_0_10.S2C_WISHPOOL_FLUSH_END_TIME_F,
		var_0_10.S2C_WISHPOOL_FLUSH_DAILY_PRESENT_TIMES_F,
		var_0_10.S2C_WISHPOOL_FLUSH_RECHARGE_MONEY_F,
		var_0_10.S2C_WISHPOOL_FLUSH_RECHARGE_AWARD_F,
		var_0_10.S2C_WISHPOOL_FLUSH_WISH_RECORD_F,
		var_0_10.S2C_WISHPOOL_FLUSH_START_TIME_F,
		var_0_10.S2C_WISHPOOL_FLUSH_RECHARGE_BAIT_F,
		var_0_10.S2C_WISHPOOL_FLUSH_ACTIVE_BAIT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_WISHPOOL_DAILYPRESENTS_ME, {
	"C2S_Wishpool_DailyPresents",
	".cs.C2S_Wishpool_DailyPresents",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_DAILYPRESENTS_RET_F, {
	"ret",
	".cs.S2C_Wishpool_DailyPresents.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_DAILYPRESENTS_AWARDS_F, {
	"awards",
	".cs.S2C_Wishpool_DailyPresents.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_WISHPOOL_DAILYPRESENTS_ME, {
	"S2C_Wishpool_DailyPresents",
	".cs.S2C_Wishpool_DailyPresents",
	{},
	{},
	{
		var_0_10.S2C_WISHPOOL_DAILYPRESENTS_RET_F,
		var_0_10.S2C_WISHPOOL_DAILYPRESENTS_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WISHPOOL_FISHING_NUM_F, {
	"num",
	".cs.C2S_Wishpool_Fishing.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_WISHPOOL_FISHING_ME, {
	"C2S_Wishpool_Fishing",
	".cs.C2S_Wishpool_Fishing",
	{},
	{},
	{
		var_0_10.C2S_WISHPOOL_FISHING_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FISHING_RET_F, {
	"ret",
	".cs.S2C_Wishpool_Fishing.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FISHING_NUM_F, {
	"num",
	".cs.S2C_Wishpool_Fishing.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FISHING_AWARDS_F, {
	"awards",
	".cs.S2C_Wishpool_Fishing.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WISHPOOL_FISHING_DROP_ID_F, {
	"drop_id",
	".cs.S2C_Wishpool_Fishing.drop_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_WISHPOOL_FISHING_ME, {
	"S2C_Wishpool_Fishing",
	".cs.S2C_Wishpool_Fishing",
	{},
	{},
	{
		var_0_10.S2C_WISHPOOL_FISHING_RET_F,
		var_0_10.S2C_WISHPOOL_FISHING_NUM_F,
		var_0_10.S2C_WISHPOOL_FISHING_AWARDS_F,
		var_0_10.S2C_WISHPOOL_FISHING_DROP_ID_F
	},
	false,
	{}
})

return var_0_10
