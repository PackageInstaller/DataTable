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
	C2S_CUSTOMACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_CUSTOMACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_CUSTOMACTIVITY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_GETINFO_INFOS_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_GETINFO_HIDES_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_UPDATEINFO_ME = protobuf.Descriptor(),
	S2C_CUSTOMACTIVITY_UPDATEINFO_UPDATES_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_UPDATEINFO_DELETES_F = protobuf.FieldDescriptor(),
	C2S_CUSTOMACTIVITY_REQINFO_ME = protobuf.Descriptor(),
	C2S_CUSTOMACTIVITY_REQINFO_IDS_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_REQINFO_ME = protobuf.Descriptor(),
	S2C_CUSTOMACTIVITY_REQINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_REQINFO_IDS_F = protobuf.FieldDescriptor(),
	S2C_CUSTOMACTIVITY_REQINFO_SHOWS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_CUSTOMACTIVITY_GETINFO_ME, {
	"C2S_CustomActivity_GetInfo",
	".cs.C2S_CustomActivity_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_CustomActivity_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_GETINFO_INFOS_F, {
	"infos",
	".cs.S2C_CustomActivity_GetInfo.infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CUSTOMACTIVITYINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_GETINFO_HIDES_F, {
	"hides",
	".cs.S2C_CustomActivity_GetInfo.hides",
	4,
	2,
	3,
	false,
	{},
	var_0_3.CUSTOMACTIVITYHIDEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_GETINFO_ME, {
	"S2C_CustomActivity_GetInfo",
	".cs.S2C_CustomActivity_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_CUSTOMACTIVITY_GETINFO_RET_F,
		var_0_10.S2C_CUSTOMACTIVITY_GETINFO_INFOS_F,
		var_0_10.S2C_CUSTOMACTIVITY_GETINFO_HIDES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_UPDATEINFO_UPDATES_F, {
	"updates",
	".cs.S2C_CustomActivity_UpdateInfo.updates",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CUSTOMACTIVITYHIDEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_UPDATEINFO_DELETES_F, {
	"deletes",
	".cs.S2C_CustomActivity_UpdateInfo.deletes",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_UPDATEINFO_ME, {
	"S2C_CustomActivity_UpdateInfo",
	".cs.S2C_CustomActivity_UpdateInfo",
	{},
	{},
	{
		var_0_10.S2C_CUSTOMACTIVITY_UPDATEINFO_UPDATES_F,
		var_0_10.S2C_CUSTOMACTIVITY_UPDATEINFO_DELETES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CUSTOMACTIVITY_REQINFO_IDS_F, {
	"ids",
	".cs.C2S_CustomActivity_ReqInfo.ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_CUSTOMACTIVITY_REQINFO_ME, {
	"C2S_CustomActivity_ReqInfo",
	".cs.C2S_CustomActivity_ReqInfo",
	{},
	{},
	{
		var_0_10.C2S_CUSTOMACTIVITY_REQINFO_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_REQINFO_RET_F, {
	"ret",
	".cs.S2C_CustomActivity_ReqInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_REQINFO_IDS_F, {
	"ids",
	".cs.S2C_CustomActivity_ReqInfo.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_REQINFO_SHOWS_F, {
	"shows",
	".cs.S2C_CustomActivity_ReqInfo.shows",
	3,
	2,
	3,
	false,
	{},
	var_0_3.CUSTOMACTIVITYINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CUSTOMACTIVITY_REQINFO_ME, {
	"S2C_CustomActivity_ReqInfo",
	".cs.S2C_CustomActivity_ReqInfo",
	{},
	{},
	{
		var_0_10.S2C_CUSTOMACTIVITY_REQINFO_RET_F,
		var_0_10.S2C_CUSTOMACTIVITY_REQINFO_IDS_F,
		var_0_10.S2C_CUSTOMACTIVITY_REQINFO_SHOWS_F
	},
	false,
	{}
})

return var_0_10
