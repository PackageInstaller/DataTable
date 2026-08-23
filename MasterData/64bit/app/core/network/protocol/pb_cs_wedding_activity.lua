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
	C2S_WEDDINGACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_WEDDINGACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_WEDDINGACTIVITY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGACTIVITY_GETINFO_INFOS_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGACTIVITY_NOTIFY_ME = protobuf.Descriptor(),
	S2C_WEDDINGACTIVITY_NOTIFY_INFOS_F = protobuf.FieldDescriptor(),
	C2S_WEDDINGACTIVITY_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_WEDDINGACTIVITY_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGACTIVITY_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_WEDDINGACTIVITY_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGACTIVITY_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_WEDDINGACTIVITY_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_WEDDINGACTIVITY_GETINFO_ME, {
	"C2S_WeddingActivity_GetInfo",
	".cs.C2S_WeddingActivity_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_WeddingActivity_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_GETINFO_INFOS_F, {
	"infos",
	".cs.S2C_WeddingActivity_GetInfo.infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.USERWEDDINGACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_GETINFO_ME, {
	"S2C_WeddingActivity_GetInfo",
	".cs.S2C_WeddingActivity_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_WEDDINGACTIVITY_GETINFO_RET_F,
		var_0_10.S2C_WEDDINGACTIVITY_GETINFO_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_NOTIFY_INFOS_F, {
	"infos",
	".cs.S2C_WeddingActivity_Notify.infos",
	1,
	0,
	3,
	false,
	{},
	var_0_3.USERWEDDINGACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_NOTIFY_ME, {
	"S2C_WeddingActivity_Notify",
	".cs.S2C_WeddingActivity_Notify",
	{},
	{},
	{
		var_0_10.S2C_WEDDINGACTIVITY_NOTIFY_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEDDINGACTIVITY_TASKAWARD_ID_F, {
	"id",
	".cs.C2S_WeddingActivity_TaskAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_WEDDINGACTIVITY_TASKAWARD_ME, {
	"C2S_WeddingActivity_TaskAward",
	".cs.C2S_WeddingActivity_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_WEDDINGACTIVITY_TASKAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_WeddingActivity_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_ID_F, {
	"id",
	".cs.S2C_WeddingActivity_TaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_WeddingActivity_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_ME, {
	"S2C_WeddingActivity_TaskAward",
	".cs.S2C_WeddingActivity_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_RET_F,
		var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_ID_F,
		var_0_10.S2C_WEDDINGACTIVITY_TASKAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
