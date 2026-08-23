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
	C2S_TIPS_FLUSH_ME = protobuf.Descriptor(),
	S2C_TIPS_FLUSH_ME = protobuf.Descriptor(),
	S2C_TIPS_FLUSH_TIPS_F = protobuf.FieldDescriptor(),
	C2S_TIPS_SET_ME = protobuf.Descriptor(),
	C2S_TIPS_SET_ID_F = protobuf.FieldDescriptor(),
	C2S_TIPS_SET_EXPIRE_TIME_F = protobuf.FieldDescriptor(),
	C2S_TIPS_SET_PARAMS_F = protobuf.FieldDescriptor(),
	C2S_TIPS_SET_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_TIPS_SET_ME = protobuf.Descriptor(),
	S2C_TIPS_SET_RET_F = protobuf.FieldDescriptor(),
	S2C_TIPS_SET_ID_F = protobuf.FieldDescriptor(),
	S2C_TIPS_SET_EXPIRE_TIME_F = protobuf.FieldDescriptor(),
	S2C_TIPS_SET_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_TIPS_SET_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_TIPS_DEL_ME = protobuf.Descriptor(),
	C2S_TIPS_DEL_UNIQUE_IDS_F = protobuf.FieldDescriptor(),
	S2C_TIPS_DEL_ME = protobuf.Descriptor(),
	S2C_TIPS_DEL_RET_F = protobuf.FieldDescriptor(),
	S2C_TIPS_DEL_UNIQUE_IDS_F = protobuf.FieldDescriptor(),
	S2C_TIPS_NOTIFY_ME = protobuf.Descriptor(),
	S2C_TIPS_NOTIFY_TIPS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_TIPS_FLUSH_ME, {
	"C2S_Tips_Flush",
	".cs.C2S_Tips_Flush",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_FLUSH_TIPS_F, {
	"tips",
	".cs.S2C_Tips_Flush.tips",
	1,
	0,
	3,
	false,
	{},
	var_0_3.USERTIPS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TIPS_FLUSH_ME, {
	"S2C_Tips_Flush",
	".cs.S2C_Tips_Flush",
	{},
	{},
	{
		var_0_10.S2C_TIPS_FLUSH_TIPS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TIPS_SET_ID_F, {
	"id",
	".cs.C2S_Tips_Set.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TIPS_SET_EXPIRE_TIME_F, {
	"expire_time",
	".cs.C2S_Tips_Set.expire_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TIPS_SET_PARAMS_F, {
	"params",
	".cs.C2S_Tips_Set.params",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TIPS_SET_TARGET_ID_F, {
	"target_id",
	".cs.C2S_Tips_Set.target_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TIPS_SET_ME, {
	"C2S_Tips_Set",
	".cs.C2S_Tips_Set",
	{},
	{},
	{
		var_0_10.C2S_TIPS_SET_ID_F,
		var_0_10.C2S_TIPS_SET_EXPIRE_TIME_F,
		var_0_10.C2S_TIPS_SET_PARAMS_F,
		var_0_10.C2S_TIPS_SET_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_SET_RET_F, {
	"ret",
	".cs.S2C_Tips_Set.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_SET_ID_F, {
	"id",
	".cs.S2C_Tips_Set.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_SET_EXPIRE_TIME_F, {
	"expire_time",
	".cs.S2C_Tips_Set.expire_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_SET_PARAMS_F, {
	"params",
	".cs.S2C_Tips_Set.params",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_SET_TARGET_ID_F, {
	"target_id",
	".cs.S2C_Tips_Set.target_id",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TIPS_SET_ME, {
	"S2C_Tips_Set",
	".cs.S2C_Tips_Set",
	{},
	{},
	{
		var_0_10.S2C_TIPS_SET_RET_F,
		var_0_10.S2C_TIPS_SET_ID_F,
		var_0_10.S2C_TIPS_SET_EXPIRE_TIME_F,
		var_0_10.S2C_TIPS_SET_PARAMS_F,
		var_0_10.S2C_TIPS_SET_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TIPS_DEL_UNIQUE_IDS_F, {
	"unique_ids",
	".cs.C2S_Tips_Del.unique_ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TIPS_DEL_ME, {
	"C2S_Tips_Del",
	".cs.C2S_Tips_Del",
	{},
	{},
	{
		var_0_10.C2S_TIPS_DEL_UNIQUE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_DEL_RET_F, {
	"ret",
	".cs.S2C_Tips_Del.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_DEL_UNIQUE_IDS_F, {
	"unique_ids",
	".cs.S2C_Tips_Del.unique_ids",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TIPS_DEL_ME, {
	"S2C_Tips_Del",
	".cs.S2C_Tips_Del",
	{},
	{},
	{
		var_0_10.S2C_TIPS_DEL_RET_F,
		var_0_10.S2C_TIPS_DEL_UNIQUE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TIPS_NOTIFY_TIPS_F, {
	"tips",
	".cs.S2C_Tips_Notify.tips",
	1,
	0,
	3,
	false,
	{},
	var_0_3.USERTIPS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TIPS_NOTIFY_ME, {
	"S2C_Tips_Notify",
	".cs.S2C_Tips_Notify",
	{},
	{},
	{
		var_0_10.S2C_TIPS_NOTIFY_TIPS_F
	},
	false,
	{}
})

return var_0_10
