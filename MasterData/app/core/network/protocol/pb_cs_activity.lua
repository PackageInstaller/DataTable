local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_9 = {
	C2S_ACTIVITY_COMMON_GETINFOSERVER_ME = protobuf.Descriptor(),
	S2C_ACTIVITY_COMMON_GETINFOSERVER_ME = protobuf.Descriptor(),
	S2C_ACTIVITY_COMMON_GETINFOSERVER_RET_F = protobuf.FieldDescriptor(),
	S2C_ACTIVITY_COMMON_GETINFOSERVER_ACTIVITYINFO_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_ACTIVITY_COMMON_GETINFOSERVER_ME, {
	"C2S_Activity_Common_GetInfoServer",
	".cs.C2S_Activity_Common_GetInfoServer",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_ACTIVITY_COMMON_GETINFOSERVER_RET_F, {
	"ret",
	".cs.S2C_Activity_Common_GetInfoServer.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_ACTIVITY_COMMON_GETINFOSERVER_ACTIVITYINFO_F, {
	"activityInfo",
	".cs.S2C_Activity_Common_GetInfoServer.activityInfo",
	2,
	1,
	3,
	false,
	{},
	var_0_1("pb_out_base").SERVERTYPEACTIVITYINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_ACTIVITY_COMMON_GETINFOSERVER_ME, {
	"S2C_Activity_Common_GetInfoServer",
	".cs.S2C_Activity_Common_GetInfoServer",
	{},
	{},
	{
		var_0_9.S2C_ACTIVITY_COMMON_GETINFOSERVER_RET_F,
		var_0_9.S2C_ACTIVITY_COMMON_GETINFOSERVER_ACTIVITYINFO_F
	},
	false,
	{}
})

return var_0_9
