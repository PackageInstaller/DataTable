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
	C2S_SERVERPASS_INFO_ME = protobuf.Descriptor(),
	S2C_SERVERPASS_INFO_ME = protobuf.Descriptor(),
	S2C_SERVERPASS_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_INFO_ORDER_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_INFO_TIER_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_INFO_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_SERVERPASS_AWARD_ME = protobuf.Descriptor(),
	C2S_SERVERPASS_AWARD_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_SERVERPASS_AWARD_TIER_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_AWARD_ME = protobuf.Descriptor(),
	S2C_SERVERPASS_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_AWARD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_AWARD_TIER_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_AWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_SERVERPASS_AWARDALL_ME = protobuf.Descriptor(),
	S2C_SERVERPASS_AWARDALL_ME = protobuf.Descriptor(),
	S2C_SERVERPASS_AWARDALL_RET_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_AWARDALL_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_SERVERPASS_AWARDALL_AWARDED_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_SERVERPASS_INFO_ME, {
	"C2S_ServerPass_Info",
	".cs.C2S_ServerPass_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_INFO_RET_F, {
	"ret",
	".cs.S2C_ServerPass_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_INFO_ORDER_F, {
	"order",
	".cs.S2C_ServerPass_Info.order",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_INFO_TIER_F, {
	"tier",
	".cs.S2C_ServerPass_Info.tier",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_INFO_AWARDS_F, {
	"awards",
	".cs.S2C_ServerPass_Info.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.SERVERPASSAWARDTIER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SERVERPASS_INFO_ME, {
	"S2C_ServerPass_Info",
	".cs.S2C_ServerPass_Info",
	{},
	{},
	{
		var_0_10.S2C_SERVERPASS_INFO_RET_F,
		var_0_10.S2C_SERVERPASS_INFO_ORDER_F,
		var_0_10.S2C_SERVERPASS_INFO_TIER_F,
		var_0_10.S2C_SERVERPASS_INFO_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SERVERPASS_AWARD_LEVEL_F, {
	"level",
	".cs.C2S_ServerPass_Award.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SERVERPASS_AWARD_TIER_F, {
	"tier",
	".cs.C2S_ServerPass_Award.tier",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SERVERPASS_AWARD_ME, {
	"C2S_ServerPass_Award",
	".cs.C2S_ServerPass_Award",
	{},
	{},
	{
		var_0_10.C2S_SERVERPASS_AWARD_LEVEL_F,
		var_0_10.C2S_SERVERPASS_AWARD_TIER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARD_RET_F, {
	"ret",
	".cs.S2C_ServerPass_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARD_LEVEL_F, {
	"level",
	".cs.S2C_ServerPass_Award.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARD_TIER_F, {
	"tier",
	".cs.S2C_ServerPass_Award.tier",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_ServerPass_Award.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SERVERPASS_AWARD_ME, {
	"S2C_ServerPass_Award",
	".cs.S2C_ServerPass_Award",
	{},
	{},
	{
		var_0_10.S2C_SERVERPASS_AWARD_RET_F,
		var_0_10.S2C_SERVERPASS_AWARD_LEVEL_F,
		var_0_10.S2C_SERVERPASS_AWARD_TIER_F,
		var_0_10.S2C_SERVERPASS_AWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SERVERPASS_AWARDALL_ME, {
	"C2S_ServerPass_AwardAll",
	".cs.C2S_ServerPass_AwardAll",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARDALL_RET_F, {
	"ret",
	".cs.S2C_ServerPass_AwardAll.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARDALL_AWARDS_F, {
	"awards",
	".cs.S2C_ServerPass_AwardAll.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SERVERPASS_AWARDALL_AWARDED_F, {
	"awarded",
	".cs.S2C_ServerPass_AwardAll.awarded",
	3,
	2,
	3,
	false,
	{},
	var_0_3.SERVERPASSAWARDTIER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SERVERPASS_AWARDALL_ME, {
	"S2C_ServerPass_AwardAll",
	".cs.S2C_ServerPass_AwardAll",
	{},
	{},
	{
		var_0_10.S2C_SERVERPASS_AWARDALL_RET_F,
		var_0_10.S2C_SERVERPASS_AWARDALL_AWARDS_F,
		var_0_10.S2C_SERVERPASS_AWARDALL_AWARDED_F
	},
	false,
	{}
})

return var_0_10
