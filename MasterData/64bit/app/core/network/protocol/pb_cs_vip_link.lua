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
	C2S_VIPLINK_GETINFO_ME = protobuf.Descriptor(),
	S2C_VIPLINK_GETINFO_ME = protobuf.Descriptor(),
	S2C_VIPLINK_GETINFO_VIEW_INFO_F = protobuf.FieldDescriptor(),
	S2C_VIPLINK_GETINFO_CONTACT_INFO_F = protobuf.FieldDescriptor(),
	S2C_VIPLINK_GETINFO_BIND_TIME_F = protobuf.FieldDescriptor(),
	S2C_VIPLINK_GETINFO_CAN_SHOW_F = protobuf.FieldDescriptor(),
	S2C_VIPLINK_NOTIFYBIND_ME = protobuf.Descriptor(),
	S2C_VIPLINK_NOTIFYBIND_CONTACT_INFO_F = protobuf.FieldDescriptor(),
	S2C_VIPLINK_NOTIFYBIND_BIND_TIME_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_VIPLINK_GETINFO_ME, {
	"C2S_VipLink_GetInfo",
	".cs.C2S_VipLink_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_VIPLINK_GETINFO_VIEW_INFO_F, {
	"view_info",
	".cs.S2C_VipLink_GetInfo.view_info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.VIPLINKVIEWINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_VIPLINK_GETINFO_CONTACT_INFO_F, {
	"contact_info",
	".cs.S2C_VipLink_GetInfo.contact_info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.VIPLINKCONTACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_VIPLINK_GETINFO_BIND_TIME_F, {
	"bind_time",
	".cs.S2C_VipLink_GetInfo.bind_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_VIPLINK_GETINFO_CAN_SHOW_F, {
	"can_show",
	".cs.S2C_VipLink_GetInfo.can_show",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_VIPLINK_GETINFO_ME, {
	"S2C_VipLink_GetInfo",
	".cs.S2C_VipLink_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_VIPLINK_GETINFO_VIEW_INFO_F,
		var_0_10.S2C_VIPLINK_GETINFO_CONTACT_INFO_F,
		var_0_10.S2C_VIPLINK_GETINFO_BIND_TIME_F,
		var_0_10.S2C_VIPLINK_GETINFO_CAN_SHOW_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_VIPLINK_NOTIFYBIND_CONTACT_INFO_F, {
	"contact_info",
	".cs.S2C_VipLink_NotifyBind.contact_info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.VIPLINKCONTACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_VIPLINK_NOTIFYBIND_BIND_TIME_F, {
	"bind_time",
	".cs.S2C_VipLink_NotifyBind.bind_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_VIPLINK_NOTIFYBIND_ME, {
	"S2C_VipLink_NotifyBind",
	".cs.S2C_VipLink_NotifyBind",
	{},
	{},
	{
		var_0_10.S2C_VIPLINK_NOTIFYBIND_CONTACT_INFO_F,
		var_0_10.S2C_VIPLINK_NOTIFYBIND_BIND_TIME_F
	},
	false,
	{}
})

return var_0_10
