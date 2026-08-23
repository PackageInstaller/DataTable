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
	C2S_REBORN_PREVIEW_ME = protobuf.Descriptor(),
	C2S_REBORN_PREVIEW_SYS_TYPE_F = protobuf.FieldDescriptor(),
	C2S_REBORN_PREVIEW_OP_TYPE_F = protobuf.FieldDescriptor(),
	C2S_REBORN_PREVIEW_IDS_F = protobuf.FieldDescriptor(),
	C2S_REBORN_PREVIEW_NUMS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_PREVIEW_ME = protobuf.Descriptor(),
	S2C_REBORN_PREVIEW_RET_F = protobuf.FieldDescriptor(),
	S2C_REBORN_PREVIEW_SYS_TYPE_F = protobuf.FieldDescriptor(),
	S2C_REBORN_PREVIEW_OP_TYPE_F = protobuf.FieldDescriptor(),
	S2C_REBORN_PREVIEW_IDS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_PREVIEW_NUMS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_PREVIEW_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_REBORN_EXECUTE_ME = protobuf.Descriptor(),
	C2S_REBORN_EXECUTE_SYS_TYPE_F = protobuf.FieldDescriptor(),
	C2S_REBORN_EXECUTE_OP_TYPE_F = protobuf.FieldDescriptor(),
	C2S_REBORN_EXECUTE_IDS_F = protobuf.FieldDescriptor(),
	C2S_REBORN_EXECUTE_NUMS_F = protobuf.FieldDescriptor(),
	C2S_REBORN_EXECUTE_FRAGMENTS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_ME = protobuf.Descriptor(),
	S2C_REBORN_EXECUTE_RET_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_SYS_TYPE_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_OP_TYPE_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_IDS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_NUMS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_KNIGHT_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_UNITE_TOKEN_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_TREASURE_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_DRESS_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_PE_F = protobuf.FieldDescriptor(),
	S2C_REBORN_EXECUTE_KB_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_PREVIEW_SYS_TYPE_F, {
	"sys_type",
	".cs.C2S_Reborn_Preview.sys_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_PREVIEW_OP_TYPE_F, {
	"op_type",
	".cs.C2S_Reborn_Preview.op_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_PREVIEW_IDS_F, {
	"ids",
	".cs.C2S_Reborn_Preview.ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_PREVIEW_NUMS_F, {
	"nums",
	".cs.C2S_Reborn_Preview.nums",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_REBORN_PREVIEW_ME, {
	"C2S_Reborn_Preview",
	".cs.C2S_Reborn_Preview",
	{},
	{},
	{
		var_0_10.C2S_REBORN_PREVIEW_SYS_TYPE_F,
		var_0_10.C2S_REBORN_PREVIEW_OP_TYPE_F,
		var_0_10.C2S_REBORN_PREVIEW_IDS_F,
		var_0_10.C2S_REBORN_PREVIEW_NUMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_PREVIEW_RET_F, {
	"ret",
	".cs.S2C_Reborn_Preview.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_PREVIEW_SYS_TYPE_F, {
	"sys_type",
	".cs.S2C_Reborn_Preview.sys_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_PREVIEW_OP_TYPE_F, {
	"op_type",
	".cs.S2C_Reborn_Preview.op_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_PREVIEW_IDS_F, {
	"ids",
	".cs.S2C_Reborn_Preview.ids",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_PREVIEW_NUMS_F, {
	"nums",
	".cs.S2C_Reborn_Preview.nums",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_PREVIEW_AWARDS_F, {
	"awards",
	".cs.S2C_Reborn_Preview.awards",
	6,
	5,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_REBORN_PREVIEW_ME, {
	"S2C_Reborn_Preview",
	".cs.S2C_Reborn_Preview",
	{},
	{},
	{
		var_0_10.S2C_REBORN_PREVIEW_RET_F,
		var_0_10.S2C_REBORN_PREVIEW_SYS_TYPE_F,
		var_0_10.S2C_REBORN_PREVIEW_OP_TYPE_F,
		var_0_10.S2C_REBORN_PREVIEW_IDS_F,
		var_0_10.S2C_REBORN_PREVIEW_NUMS_F,
		var_0_10.S2C_REBORN_PREVIEW_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_EXECUTE_SYS_TYPE_F, {
	"sys_type",
	".cs.C2S_Reborn_Execute.sys_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_EXECUTE_OP_TYPE_F, {
	"op_type",
	".cs.C2S_Reborn_Execute.op_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_EXECUTE_IDS_F, {
	"ids",
	".cs.C2S_Reborn_Execute.ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_EXECUTE_NUMS_F, {
	"nums",
	".cs.C2S_Reborn_Execute.nums",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_REBORN_EXECUTE_FRAGMENTS_F, {
	"fragments",
	".cs.C2S_Reborn_Execute.fragments",
	5,
	4,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_REBORN_EXECUTE_ME, {
	"C2S_Reborn_Execute",
	".cs.C2S_Reborn_Execute",
	{},
	{},
	{
		var_0_10.C2S_REBORN_EXECUTE_SYS_TYPE_F,
		var_0_10.C2S_REBORN_EXECUTE_OP_TYPE_F,
		var_0_10.C2S_REBORN_EXECUTE_IDS_F,
		var_0_10.C2S_REBORN_EXECUTE_NUMS_F,
		var_0_10.C2S_REBORN_EXECUTE_FRAGMENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_RET_F, {
	"ret",
	".cs.S2C_Reborn_Execute.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_SYS_TYPE_F, {
	"sys_type",
	".cs.S2C_Reborn_Execute.sys_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_OP_TYPE_F, {
	"op_type",
	".cs.S2C_Reborn_Execute.op_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_IDS_F, {
	"ids",
	".cs.S2C_Reborn_Execute.ids",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_NUMS_F, {
	"nums",
	".cs.S2C_Reborn_Execute.nums",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_AWARDS_F, {
	"awards",
	".cs.S2C_Reborn_Execute.awards",
	6,
	5,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_KNIGHT_F, {
	"knight",
	".cs.S2C_Reborn_Execute.knight",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.KNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_UNITE_TOKEN_F, {
	"unite_token",
	".cs.S2C_Reborn_Execute.unite_token",
	8,
	7,
	1,
	false,
	nil,
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_EQUIPMENT_F, {
	"equipment",
	".cs.S2C_Reborn_Execute.equipment",
	9,
	8,
	3,
	false,
	{},
	var_0_3.EQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_TREASURE_F, {
	"treasure",
	".cs.S2C_Reborn_Execute.treasure",
	10,
	9,
	3,
	false,
	{},
	var_0_3.TREASURE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_DRESS_F, {
	"dress",
	".cs.S2C_Reborn_Execute.dress",
	11,
	10,
	1,
	false,
	nil,
	var_0_3.DRESS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_PE_F, {
	"pe",
	".cs.S2C_Reborn_Execute.pe",
	12,
	11,
	1,
	false,
	nil,
	var_0_3.PETEQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_REBORN_EXECUTE_KB_F, {
	"kb",
	".cs.S2C_Reborn_Execute.kb",
	13,
	12,
	1,
	false,
	nil,
	var_0_3.KSOULBOOK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_REBORN_EXECUTE_ME, {
	"S2C_Reborn_Execute",
	".cs.S2C_Reborn_Execute",
	{},
	{},
	{
		var_0_10.S2C_REBORN_EXECUTE_RET_F,
		var_0_10.S2C_REBORN_EXECUTE_SYS_TYPE_F,
		var_0_10.S2C_REBORN_EXECUTE_OP_TYPE_F,
		var_0_10.S2C_REBORN_EXECUTE_IDS_F,
		var_0_10.S2C_REBORN_EXECUTE_NUMS_F,
		var_0_10.S2C_REBORN_EXECUTE_AWARDS_F,
		var_0_10.S2C_REBORN_EXECUTE_KNIGHT_F,
		var_0_10.S2C_REBORN_EXECUTE_UNITE_TOKEN_F,
		var_0_10.S2C_REBORN_EXECUTE_EQUIPMENT_F,
		var_0_10.S2C_REBORN_EXECUTE_TREASURE_F,
		var_0_10.S2C_REBORN_EXECUTE_DRESS_F,
		var_0_10.S2C_REBORN_EXECUTE_PE_F,
		var_0_10.S2C_REBORN_EXECUTE_KB_F
	},
	false,
	{}
})

return var_0_10
