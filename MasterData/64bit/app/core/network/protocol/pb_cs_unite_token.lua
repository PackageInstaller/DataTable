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
	C2S_UNITETOKEN_AWAKEN_ME = protobuf.Descriptor(),
	C2S_UNITETOKEN_AWAKEN_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_AWAKEN_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_AWAKEN_RET_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_AWAKEN_ID_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_UPGRADE_ME = protobuf.Descriptor(),
	C2S_UNITETOKEN_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_UPGRADE_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_UPGRADE_TOKEN_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_GETATTRIBUTE_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_GETATTRIBUTE_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_GETATTRIBUTE_RET_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_GETATTRIBUTE_ADDITION_ATTRIBUTE_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_GETATTRIBUTE_COMBO_ATTRIBUTE_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_STARINCREASE_ME = protobuf.Descriptor(),
	C2S_UNITETOKEN_STARINCREASE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_STARINCREASE_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_STARINCREASE_RET_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_STARINCREASE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_STARINCREASE_TOKEN_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_RUNESACTIVATE_ME = protobuf.Descriptor(),
	C2S_UNITETOKEN_RUNESACTIVATE_ID_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_RUNESACTIVATE_HOLE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_RUNESACTIVATE_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_RUNESACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_RUNESACTIVATE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_RUNESACTIVATE_HOLE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_RUNESACTIVATE_TOKEN_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_ONEKEY_UPGRADE_ME = protobuf.Descriptor(),
	C2S_UNITETOKEN_ONEKEY_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_UNITETOKEN_ONEKEY_UPGRADE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_ONEKEY_UPGRADE_ME = protobuf.Descriptor(),
	S2C_UNITETOKEN_ONEKEY_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_ONEKEY_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_UNITETOKEN_ONEKEY_UPGRADE_LEVEL_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_AWAKEN_ID_F, {
	"id",
	".cs.C2S_UniteToken_Awaken.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_UNITETOKEN_AWAKEN_ME, {
	"C2S_UniteToken_Awaken",
	".cs.C2S_UniteToken_Awaken",
	{},
	{},
	{
		var_0_10.C2S_UNITETOKEN_AWAKEN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_AWAKEN_RET_F, {
	"ret",
	".cs.S2C_UniteToken_Awaken.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_AWAKEN_ID_F, {
	"id",
	".cs.S2C_UniteToken_Awaken.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_UNITETOKEN_AWAKEN_ME, {
	"S2C_UniteToken_Awaken",
	".cs.S2C_UniteToken_Awaken",
	{},
	{},
	{
		var_0_10.S2C_UNITETOKEN_AWAKEN_RET_F,
		var_0_10.S2C_UNITETOKEN_AWAKEN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_UPGRADE_ID_F, {
	"id",
	".cs.C2S_UniteToken_Upgrade.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_UNITETOKEN_UPGRADE_ME, {
	"C2S_UniteToken_Upgrade",
	".cs.C2S_UniteToken_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_UNITETOKEN_UPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_UniteToken_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_UPGRADE_ID_F, {
	"id",
	".cs.S2C_UniteToken_Upgrade.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_UPGRADE_TOKEN_F, {
	"token",
	".cs.S2C_UniteToken_Upgrade.token",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_UNITETOKEN_UPGRADE_ME, {
	"S2C_UniteToken_Upgrade",
	".cs.S2C_UniteToken_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_UNITETOKEN_UPGRADE_RET_F,
		var_0_10.S2C_UNITETOKEN_UPGRADE_ID_F,
		var_0_10.S2C_UNITETOKEN_UPGRADE_TOKEN_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_UNITETOKEN_GETATTRIBUTE_ME, {
	"C2S_UniteToken_GetAttribute",
	".cs.C2S_UniteToken_GetAttribute",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_RET_F, {
	"ret",
	".cs.S2C_UniteToken_GetAttribute.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_ADDITION_ATTRIBUTE_F, {
	"addition_attribute",
	".cs.S2C_UniteToken_GetAttribute.addition_attribute",
	2,
	1,
	3,
	false,
	{},
	var_0_4.ATTR_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_COMBO_ATTRIBUTE_F, {
	"combo_attribute",
	".cs.S2C_UniteToken_GetAttribute.combo_attribute",
	3,
	2,
	3,
	false,
	{},
	var_0_4.ATTR_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_ME, {
	"S2C_UniteToken_GetAttribute",
	".cs.S2C_UniteToken_GetAttribute",
	{},
	{},
	{
		var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_RET_F,
		var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_ADDITION_ATTRIBUTE_F,
		var_0_10.S2C_UNITETOKEN_GETATTRIBUTE_COMBO_ATTRIBUTE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_STARINCREASE_ID_F, {
	"id",
	".cs.C2S_UniteToken_StarIncrease.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_UNITETOKEN_STARINCREASE_ME, {
	"C2S_UniteToken_StarIncrease",
	".cs.C2S_UniteToken_StarIncrease",
	{},
	{},
	{
		var_0_10.C2S_UNITETOKEN_STARINCREASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_STARINCREASE_RET_F, {
	"ret",
	".cs.S2C_UniteToken_StarIncrease.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_STARINCREASE_ID_F, {
	"id",
	".cs.S2C_UniteToken_StarIncrease.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_STARINCREASE_TOKEN_F, {
	"token",
	".cs.S2C_UniteToken_StarIncrease.token",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_UNITETOKEN_STARINCREASE_ME, {
	"S2C_UniteToken_StarIncrease",
	".cs.S2C_UniteToken_StarIncrease",
	{},
	{},
	{
		var_0_10.S2C_UNITETOKEN_STARINCREASE_RET_F,
		var_0_10.S2C_UNITETOKEN_STARINCREASE_ID_F,
		var_0_10.S2C_UNITETOKEN_STARINCREASE_TOKEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_RUNESACTIVATE_ID_F, {
	"id",
	".cs.C2S_UniteToken_RunesActivate.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_RUNESACTIVATE_HOLE_ID_F, {
	"hole_id",
	".cs.C2S_UniteToken_RunesActivate.hole_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_UNITETOKEN_RUNESACTIVATE_ME, {
	"C2S_UniteToken_RunesActivate",
	".cs.C2S_UniteToken_RunesActivate",
	{},
	{},
	{
		var_0_10.C2S_UNITETOKEN_RUNESACTIVATE_ID_F,
		var_0_10.C2S_UNITETOKEN_RUNESACTIVATE_HOLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_RET_F, {
	"ret",
	".cs.S2C_UniteToken_RunesActivate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_ID_F, {
	"id",
	".cs.S2C_UniteToken_RunesActivate.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_HOLE_ID_F, {
	"hole_id",
	".cs.S2C_UniteToken_RunesActivate.hole_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_TOKEN_F, {
	"token",
	".cs.S2C_UniteToken_RunesActivate.token",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_ME, {
	"S2C_UniteToken_RunesActivate",
	".cs.S2C_UniteToken_RunesActivate",
	{},
	{},
	{
		var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_RET_F,
		var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_ID_F,
		var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_HOLE_ID_F,
		var_0_10.S2C_UNITETOKEN_RUNESACTIVATE_TOKEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_ONEKEY_UPGRADE_ID_F, {
	"id",
	".cs.C2S_UniteToken_OneKey_Upgrade.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_UNITETOKEN_ONEKEY_UPGRADE_LEVEL_F, {
	"level",
	".cs.C2S_UniteToken_OneKey_Upgrade.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_UNITETOKEN_ONEKEY_UPGRADE_ME, {
	"C2S_UniteToken_OneKey_Upgrade",
	".cs.C2S_UniteToken_OneKey_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_UNITETOKEN_ONEKEY_UPGRADE_ID_F,
		var_0_10.C2S_UNITETOKEN_ONEKEY_UPGRADE_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_UniteToken_OneKey_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_ID_F, {
	"id",
	".cs.S2C_UniteToken_OneKey_Upgrade.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_LEVEL_F, {
	"level",
	".cs.S2C_UniteToken_OneKey_Upgrade.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_ME, {
	"S2C_UniteToken_OneKey_Upgrade",
	".cs.S2C_UniteToken_OneKey_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_RET_F,
		var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_ID_F,
		var_0_10.S2C_UNITETOKEN_ONEKEY_UPGRADE_LEVEL_F
	},
	false,
	{}
})

return var_0_10
