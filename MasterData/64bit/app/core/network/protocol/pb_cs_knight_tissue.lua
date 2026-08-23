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
	C2S_KNIGHTTISSUE_INFO_ME = protobuf.Descriptor(),
	S2C_KNIGHTTISSUE_INFO_ME = protobuf.Descriptor(),
	S2C_KNIGHTTISSUE_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_INFO_TISSUES_F = protobuf.FieldDescriptor(),
	C2S_KNIGHTTISSUE_ACTIVE_ME = protobuf.Descriptor(),
	C2S_KNIGHTTISSUE_ACTIVE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_ACTIVE_ME = protobuf.Descriptor(),
	S2C_KNIGHTTISSUE_ACTIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_ACTIVE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_ACTIVE_TISSUE_F = protobuf.FieldDescriptor(),
	C2S_KNIGHTTISSUE_UPLV_ME = protobuf.Descriptor(),
	C2S_KNIGHTTISSUE_UPLV_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHTTISSUE_UPLV_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_UPLV_ME = protobuf.Descriptor(),
	S2C_KNIGHTTISSUE_UPLV_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_UPLV_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHTTISSUE_UPLV_TISSUE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHTTISSUE_INFO_ME, {
	"C2S_KnightTissue_Info",
	".cs.C2S_KnightTissue_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_INFO_RET_F, {
	"ret",
	".cs.S2C_KnightTissue_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_INFO_TISSUES_F, {
	"tissues",
	".cs.S2C_KnightTissue_Info.tissues",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KNIGHTTISSUE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHTTISSUE_INFO_ME, {
	"S2C_KnightTissue_Info",
	".cs.S2C_KnightTissue_Info",
	{},
	{},
	{
		var_0_10.S2C_KNIGHTTISSUE_INFO_RET_F,
		var_0_10.S2C_KNIGHTTISSUE_INFO_TISSUES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHTTISSUE_ACTIVE_ID_F, {
	"id",
	".cs.C2S_KnightTissue_Active.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHTTISSUE_ACTIVE_ME, {
	"C2S_KnightTissue_Active",
	".cs.C2S_KnightTissue_Active",
	{},
	{},
	{
		var_0_10.C2S_KNIGHTTISSUE_ACTIVE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_ACTIVE_RET_F, {
	"ret",
	".cs.S2C_KnightTissue_Active.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_ACTIVE_ID_F, {
	"id",
	".cs.S2C_KnightTissue_Active.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_ACTIVE_TISSUE_F, {
	"tissue",
	".cs.S2C_KnightTissue_Active.tissue",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.KNIGHTTISSUE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHTTISSUE_ACTIVE_ME, {
	"S2C_KnightTissue_Active",
	".cs.S2C_KnightTissue_Active",
	{},
	{},
	{
		var_0_10.S2C_KNIGHTTISSUE_ACTIVE_RET_F,
		var_0_10.S2C_KNIGHTTISSUE_ACTIVE_ID_F,
		var_0_10.S2C_KNIGHTTISSUE_ACTIVE_TISSUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHTTISSUE_UPLV_ID_F, {
	"id",
	".cs.C2S_KnightTissue_UpLv.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHTTISSUE_UPLV_LEVEL_F, {
	"level",
	".cs.C2S_KnightTissue_UpLv.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHTTISSUE_UPLV_ME, {
	"C2S_KnightTissue_UpLv",
	".cs.C2S_KnightTissue_UpLv",
	{},
	{},
	{
		var_0_10.C2S_KNIGHTTISSUE_UPLV_ID_F,
		var_0_10.C2S_KNIGHTTISSUE_UPLV_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_UPLV_RET_F, {
	"ret",
	".cs.S2C_KnightTissue_UpLv.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_UPLV_ID_F, {
	"id",
	".cs.S2C_KnightTissue_UpLv.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHTTISSUE_UPLV_TISSUE_F, {
	"tissue",
	".cs.S2C_KnightTissue_UpLv.tissue",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.KNIGHTTISSUE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHTTISSUE_UPLV_ME, {
	"S2C_KnightTissue_UpLv",
	".cs.S2C_KnightTissue_UpLv",
	{},
	{},
	{
		var_0_10.S2C_KNIGHTTISSUE_UPLV_RET_F,
		var_0_10.S2C_KNIGHTTISSUE_UPLV_ID_F,
		var_0_10.S2C_KNIGHTTISSUE_UPLV_TISSUE_F
	},
	false,
	{}
})

return var_0_10
