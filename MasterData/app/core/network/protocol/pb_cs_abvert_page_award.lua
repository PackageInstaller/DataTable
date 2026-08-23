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
	C2S_ABVERTPAGEAWARD_GETINFO_ME = protobuf.Descriptor(),
	S2C_ABVERTPAGEAWARD_GETINFO_ME = protobuf.Descriptor(),
	S2C_ABVERTPAGEAWARD_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_GETINFO_AWARD_PAGES_F = protobuf.FieldDescriptor(),
	C2S_ABVERTPAGEAWARD_AWARD_ME = protobuf.Descriptor(),
	C2S_ABVERTPAGEAWARD_AWARD_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_AWARD_ME = protobuf.Descriptor(),
	S2C_ABVERTPAGEAWARD_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_AWARD_ACT_ID_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_AWARD_SUB_ID_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_AWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_NOTIFY_ME = protobuf.Descriptor(),
	S2C_ABVERTPAGEAWARD_NOTIFY_UPDATE_F = protobuf.FieldDescriptor(),
	S2C_ABVERTPAGEAWARD_NOTIFY_DEL_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ABVERTPAGEAWARD_GETINFO_ME, {
	"C2S_AbvertPageAward_GetInfo",
	".cs.C2S_AbvertPageAward_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_GETINFO_RET_F, {
	"ret",
	".cs.S2C_AbvertPageAward_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_GETINFO_AWARD_PAGES_F, {
	"award_pages",
	".cs.S2C_AbvertPageAward_GetInfo.award_pages",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ABVERTPAGEAWARDACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_GETINFO_ME, {
	"S2C_AbvertPageAward_GetInfo",
	".cs.S2C_AbvertPageAward_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_ABVERTPAGEAWARD_GETINFO_RET_F,
		var_0_10.S2C_ABVERTPAGEAWARD_GETINFO_AWARD_PAGES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ABVERTPAGEAWARD_AWARD_ACT_ID_F, {
	"act_id",
	".cs.C2S_AbvertPageAward_Award.act_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ABVERTPAGEAWARD_AWARD_ME, {
	"C2S_AbvertPageAward_Award",
	".cs.C2S_AbvertPageAward_Award",
	{},
	{},
	{
		var_0_10.C2S_ABVERTPAGEAWARD_AWARD_ACT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_AWARD_RET_F, {
	"ret",
	".cs.S2C_AbvertPageAward_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_AWARD_ACT_ID_F, {
	"act_id",
	".cs.S2C_AbvertPageAward_Award.act_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_AWARD_SUB_ID_F, {
	"sub_id",
	".cs.S2C_AbvertPageAward_Award.sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_AbvertPageAward_Award.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_AWARD_ME, {
	"S2C_AbvertPageAward_Award",
	".cs.S2C_AbvertPageAward_Award",
	{},
	{},
	{
		var_0_10.S2C_ABVERTPAGEAWARD_AWARD_RET_F,
		var_0_10.S2C_ABVERTPAGEAWARD_AWARD_ACT_ID_F,
		var_0_10.S2C_ABVERTPAGEAWARD_AWARD_SUB_ID_F,
		var_0_10.S2C_ABVERTPAGEAWARD_AWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_NOTIFY_UPDATE_F, {
	"update",
	".cs.S2C_AbvertPageAward_Notify.update",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.ABVERTPAGEAWARDACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_NOTIFY_DEL_ID_F, {
	"del_id",
	".cs.S2C_AbvertPageAward_Notify.del_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ABVERTPAGEAWARD_NOTIFY_ME, {
	"S2C_AbvertPageAward_Notify",
	".cs.S2C_AbvertPageAward_Notify",
	{},
	{},
	{
		var_0_10.S2C_ABVERTPAGEAWARD_NOTIFY_UPDATE_F,
		var_0_10.S2C_ABVERTPAGEAWARD_NOTIFY_DEL_ID_F
	},
	false,
	{}
})

return var_0_10
