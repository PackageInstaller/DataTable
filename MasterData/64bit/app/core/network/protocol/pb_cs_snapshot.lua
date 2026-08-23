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
	C2S_SNAPSHOT_ONLINEUSERS_ME = protobuf.Descriptor(),
	C2S_SNAPSHOT_ONLINEUSERS_TP_F = protobuf.FieldDescriptor(),
	S2C_SNAPSHOT_ONLINEUSERS_ME = protobuf.Descriptor(),
	S2C_SNAPSHOT_ONLINEUSERS_RET_F = protobuf.FieldDescriptor(),
	S2C_SNAPSHOT_ONLINEUSERS_TP_F = protobuf.FieldDescriptor(),
	S2C_SNAPSHOT_ONLINEUSERS_SNAPSHOTS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SNAPSHOT_ONLINEUSERS_TP_F, {
	"tp",
	".cs.C2S_Snapshot_OnlineUsers.tp",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_SNAPSHOT_ONLINEUSERS_ME, {
	"C2S_Snapshot_OnlineUsers",
	".cs.C2S_Snapshot_OnlineUsers",
	{},
	{},
	{
		var_0_9.C2S_SNAPSHOT_ONLINEUSERS_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SNAPSHOT_ONLINEUSERS_RET_F, {
	"ret",
	".cs.S2C_Snapshot_OnlineUsers.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SNAPSHOT_ONLINEUSERS_TP_F, {
	"tp",
	".cs.S2C_Snapshot_OnlineUsers.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SNAPSHOT_ONLINEUSERS_SNAPSHOTS_F, {
	"snapshots",
	".cs.S2C_Snapshot_OnlineUsers.snapshots",
	3,
	2,
	3,
	false,
	{},
	var_0_1("pb_out_base").USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_SNAPSHOT_ONLINEUSERS_ME, {
	"S2C_Snapshot_OnlineUsers",
	".cs.S2C_Snapshot_OnlineUsers",
	{},
	{},
	{
		var_0_9.S2C_SNAPSHOT_ONLINEUSERS_RET_F,
		var_0_9.S2C_SNAPSHOT_ONLINEUSERS_TP_F,
		var_0_9.S2C_SNAPSHOT_ONLINEUSERS_SNAPSHOTS_F
	},
	false,
	{}
})

return var_0_9
