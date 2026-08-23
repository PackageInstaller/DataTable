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
	C2S_STARRYGIFT_GETINFO_ME = protobuf.Descriptor(),
	C2S_STARRYGIFT_GETINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_STARRYGIFT_GETINFO_ME = protobuf.Descriptor(),
	S2C_STARRYGIFT_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_STARRYGIFT_GETINFO_STARRY_GIFT_F = protobuf.FieldDescriptor(),
	C2S_STARRYGIFT_MILESTONEAWARD_ME = protobuf.Descriptor(),
	C2S_STARRYGIFT_MILESTONEAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_STARRYGIFT_MILESTONEAWARD_MILESTONE_IDS_F = protobuf.FieldDescriptor(),
	S2C_STARRYGIFT_MILESTONEAWARD_ME = protobuf.Descriptor(),
	S2C_STARRYGIFT_MILESTONEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_STARRYGIFT_MILESTONEAWARD_STARRY_GIFT_F = protobuf.FieldDescriptor(),
	S2C_STARRYGIFT_MILESTONEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_STARRYGIFT_NOTICE_ME = protobuf.Descriptor(),
	S2C_STARRYGIFT_NOTICE_STARRY_GIFTS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_STARRYGIFT_GETINFO_ID_F, {
	"id",
	".cs.C2S_StarryGift_GetInfo.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_STARRYGIFT_GETINFO_ME, {
	"C2S_StarryGift_GetInfo",
	".cs.C2S_StarryGift_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_STARRYGIFT_GETINFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_STARRYGIFT_GETINFO_RET_F, {
	"ret",
	".cs.S2C_StarryGift_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_STARRYGIFT_GETINFO_STARRY_GIFT_F, {
	"starry_gift",
	".cs.S2C_StarryGift_GetInfo.starry_gift",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.STARRYGIFT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_STARRYGIFT_GETINFO_ME, {
	"S2C_StarryGift_GetInfo",
	".cs.S2C_StarryGift_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_STARRYGIFT_GETINFO_RET_F,
		var_0_10.S2C_STARRYGIFT_GETINFO_STARRY_GIFT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_STARRYGIFT_MILESTONEAWARD_ID_F, {
	"id",
	".cs.C2S_StarryGift_MilestoneAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_STARRYGIFT_MILESTONEAWARD_MILESTONE_IDS_F, {
	"milestone_ids",
	".cs.C2S_StarryGift_MilestoneAward.milestone_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_STARRYGIFT_MILESTONEAWARD_ME, {
	"C2S_StarryGift_MilestoneAward",
	".cs.C2S_StarryGift_MilestoneAward",
	{},
	{},
	{
		var_0_10.C2S_STARRYGIFT_MILESTONEAWARD_ID_F,
		var_0_10.C2S_STARRYGIFT_MILESTONEAWARD_MILESTONE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_RET_F, {
	"ret",
	".cs.S2C_StarryGift_MilestoneAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_STARRY_GIFT_F, {
	"starry_gift",
	".cs.S2C_StarryGift_MilestoneAward.starry_gift",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.STARRYGIFT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_StarryGift_MilestoneAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_ME, {
	"S2C_StarryGift_MilestoneAward",
	".cs.S2C_StarryGift_MilestoneAward",
	{},
	{},
	{
		var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_RET_F,
		var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_STARRY_GIFT_F,
		var_0_10.S2C_STARRYGIFT_MILESTONEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_STARRYGIFT_NOTICE_STARRY_GIFTS_F, {
	"starry_gifts",
	".cs.S2C_StarryGift_Notice.starry_gifts",
	1,
	0,
	3,
	false,
	{},
	var_0_3.STARRYGIFT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_STARRYGIFT_NOTICE_ME, {
	"S2C_StarryGift_Notice",
	".cs.S2C_StarryGift_Notice",
	{},
	{},
	{
		var_0_10.S2C_STARRYGIFT_NOTICE_STARRY_GIFTS_F
	},
	false,
	{}
})

return var_0_10
