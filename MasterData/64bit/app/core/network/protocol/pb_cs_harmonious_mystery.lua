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
	S2C_HARMONIOUSMYSTERY_NOTIFY_ME = protobuf.Descriptor(),
	S2C_HARMONIOUSMYSTERY_NOTIFY_SWITCH_INFO_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_NOTIFY_UPDATE_CODE_INFOS_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_NOTIFY_DEL_CODE_IDS_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_NOTIFY_UPDATE_USER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_NOTIFY_DEL_USER_ACT_IDS_F = protobuf.FieldDescriptor(),
	C2S_HARMONIOUSMYSTERY_INFOS_ME = protobuf.Descriptor(),
	S2C_HARMONIOUSMYSTERY_INFOS_ME = protobuf.Descriptor(),
	S2C_HARMONIOUSMYSTERY_INFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_INFOS_SWITCH_INFO_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_INFOS_CODE_INFOS_F = protobuf.FieldDescriptor(),
	S2C_HARMONIOUSMYSTERY_INFOS_USER_INFOS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_SWITCH_INFO_F, {
	"switch_info",
	".cs.S2C_HarmoniousMystery_Notify.switch_info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.HARMONIOUSMYSTERYSWITCH_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_UPDATE_CODE_INFOS_F, {
	"update_code_infos",
	".cs.S2C_HarmoniousMystery_Notify.update_code_infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.HARMONIOUSMYSTERYCODEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_DEL_CODE_IDS_F, {
	"del_code_ids",
	".cs.S2C_HarmoniousMystery_Notify.del_code_ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_UPDATE_USER_INFOS_F, {
	"update_user_infos",
	".cs.S2C_HarmoniousMystery_Notify.update_user_infos",
	4,
	3,
	3,
	false,
	{},
	var_0_3.HARMONIOUSMYSTERYUSERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_DEL_USER_ACT_IDS_F, {
	"del_user_act_ids",
	".cs.S2C_HarmoniousMystery_Notify.del_user_act_ids",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_ME, {
	"S2C_HarmoniousMystery_Notify",
	".cs.S2C_HarmoniousMystery_Notify",
	{},
	{},
	{
		var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_SWITCH_INFO_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_UPDATE_CODE_INFOS_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_DEL_CODE_IDS_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_UPDATE_USER_INFOS_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_NOTIFY_DEL_USER_ACT_IDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_HARMONIOUSMYSTERY_INFOS_ME, {
	"C2S_HarmoniousMystery_Infos",
	".cs.C2S_HarmoniousMystery_Infos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_RET_F, {
	"ret",
	".cs.S2C_HarmoniousMystery_Infos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_SWITCH_INFO_F, {
	"switch_info",
	".cs.S2C_HarmoniousMystery_Infos.switch_info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.HARMONIOUSMYSTERYSWITCH_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_CODE_INFOS_F, {
	"code_infos",
	".cs.S2C_HarmoniousMystery_Infos.code_infos",
	3,
	2,
	3,
	false,
	{},
	var_0_3.HARMONIOUSMYSTERYCODEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_USER_INFOS_F, {
	"user_infos",
	".cs.S2C_HarmoniousMystery_Infos.user_infos",
	4,
	3,
	3,
	false,
	{},
	var_0_3.HARMONIOUSMYSTERYUSERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_ME, {
	"S2C_HarmoniousMystery_Infos",
	".cs.S2C_HarmoniousMystery_Infos",
	{},
	{},
	{
		var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_RET_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_SWITCH_INFO_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_CODE_INFOS_F,
		var_0_10.S2C_HARMONIOUSMYSTERY_INFOS_USER_INFOS_F
	},
	false,
	{}
})

return var_0_10
