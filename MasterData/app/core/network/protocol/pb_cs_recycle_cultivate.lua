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
	C2S_RECYCLECULTIVATE_GETINFO_ME = protobuf.Descriptor(),
	S2C_RECYCLECULTIVATE_GETINFO_ME = protobuf.Descriptor(),
	S2C_RECYCLECULTIVATE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_GETINFO_OPEN_STATES_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_GETINFO_DATA_F = protobuf.FieldDescriptor(),
	C2S_RECYCLECULTIVATE_RECYCLE_ME = protobuf.Descriptor(),
	C2S_RECYCLECULTIVATE_RECYCLE_GROUP_F = protobuf.FieldDescriptor(),
	C2S_RECYCLECULTIVATE_RECYCLE_COSTS_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_RECYCLE_ME = protobuf.Descriptor(),
	S2C_RECYCLECULTIVATE_RECYCLE_RET_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_RECYCLE_GROUP_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_RECYCLE_COSTS_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_RECYCLE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECYCLECULTIVATE_UPGRADE_ME = protobuf.Descriptor(),
	S2C_RECYCLECULTIVATE_UPGRADE_ME = protobuf.Descriptor(),
	S2C_RECYCLECULTIVATE_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_UPGRADE_CUR_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_RECYCLECULTIVATE_NOTIFY_ME = protobuf.Descriptor(),
	S2C_RECYCLECULTIVATE_NOTIFY_OPEN_STATES_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_RECYCLECULTIVATE_GETINFO_ME, {
	"C2S_RecycleCultivate_GetInfo",
	".cs.C2S_RecycleCultivate_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_RecycleCultivate_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_GETINFO_OPEN_STATES_F, {
	"open_states",
	".cs.S2C_RecycleCultivate_GetInfo.open_states",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_GETINFO_DATA_F, {
	"data",
	".cs.S2C_RecycleCultivate_GetInfo.data",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.RECYCLECULTIVATE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_GETINFO_ME, {
	"S2C_RecycleCultivate_GetInfo",
	".cs.S2C_RecycleCultivate_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_RECYCLECULTIVATE_GETINFO_RET_F,
		var_0_10.S2C_RECYCLECULTIVATE_GETINFO_OPEN_STATES_F,
		var_0_10.S2C_RECYCLECULTIVATE_GETINFO_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECYCLECULTIVATE_RECYCLE_GROUP_F, {
	"group",
	".cs.C2S_RecycleCultivate_Recycle.group",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECYCLECULTIVATE_RECYCLE_COSTS_F, {
	"costs",
	".cs.C2S_RecycleCultivate_Recycle.costs",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECYCLECULTIVATE_RECYCLE_ME, {
	"C2S_RecycleCultivate_Recycle",
	".cs.C2S_RecycleCultivate_Recycle",
	{},
	{},
	{
		var_0_10.C2S_RECYCLECULTIVATE_RECYCLE_GROUP_F,
		var_0_10.C2S_RECYCLECULTIVATE_RECYCLE_COSTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_RET_F, {
	"ret",
	".cs.S2C_RecycleCultivate_Recycle.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_GROUP_F, {
	"group",
	".cs.S2C_RecycleCultivate_Recycle.group",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_COSTS_F, {
	"costs",
	".cs.S2C_RecycleCultivate_Recycle.costs",
	3,
	2,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_AWARDS_F, {
	"awards",
	".cs.S2C_RecycleCultivate_Recycle.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_ME, {
	"S2C_RecycleCultivate_Recycle",
	".cs.S2C_RecycleCultivate_Recycle",
	{},
	{},
	{
		var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_RET_F,
		var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_GROUP_F,
		var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_COSTS_F,
		var_0_10.S2C_RECYCLECULTIVATE_RECYCLE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECYCLECULTIVATE_UPGRADE_ME, {
	"C2S_RecycleCultivate_Upgrade",
	".cs.C2S_RecycleCultivate_Upgrade",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_RecycleCultivate_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_UPGRADE_CUR_INFO_ID_F, {
	"cur_info_id",
	".cs.S2C_RecycleCultivate_Upgrade.cur_info_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_UPGRADE_ME, {
	"S2C_RecycleCultivate_Upgrade",
	".cs.S2C_RecycleCultivate_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_RECYCLECULTIVATE_UPGRADE_RET_F,
		var_0_10.S2C_RECYCLECULTIVATE_UPGRADE_CUR_INFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_NOTIFY_OPEN_STATES_F, {
	"open_states",
	".cs.S2C_RecycleCultivate_Notify.open_states",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECYCLECULTIVATE_NOTIFY_ME, {
	"S2C_RecycleCultivate_Notify",
	".cs.S2C_RecycleCultivate_Notify",
	{},
	{},
	{
		var_0_10.S2C_RECYCLECULTIVATE_NOTIFY_OPEN_STATES_F
	},
	false,
	{}
})

return var_0_10
