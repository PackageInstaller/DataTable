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
	C2S_OLDPLAYERBACK_GETINFO_ME = protobuf.Descriptor(),
	S2C_OLDPLAYERBACK_GETINFO_ME = protobuf.Descriptor(),
	S2C_OLDPLAYERBACK_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_OLDPLAYERBACK_GETINFO_RECHARGE_AMOUNT_F = protobuf.FieldDescriptor(),
	S2C_OLDPLAYERBACK_GETINFO_IS_SUBSCRIBE_F = protobuf.FieldDescriptor(),
	S2C_OLDPLAYERBACK_GETINFO_IS_OLD_PLAYER_F = protobuf.FieldDescriptor(),
	S2C_OLDPLAYERBACK_GETINFO_INHERIT_SERVER_ID_F = protobuf.FieldDescriptor(),
	S2C_OLDPLAYERBACK_GETINFO_OFFLINE_DAY_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_OLDPLAYERBACK_GETINFO_ME, {
	"C2S_OldPlayerBack_GetInfo",
	".cs.C2S_OldPlayerBack_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_RET_F, {
	"ret",
	".cs.S2C_OldPlayerBack_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_RECHARGE_AMOUNT_F, {
	"recharge_amount",
	".cs.S2C_OldPlayerBack_GetInfo.recharge_amount",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_IS_SUBSCRIBE_F, {
	"is_subscribe",
	".cs.S2C_OldPlayerBack_GetInfo.is_subscribe",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_IS_OLD_PLAYER_F, {
	"is_old_player",
	".cs.S2C_OldPlayerBack_GetInfo.is_old_player",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_INHERIT_SERVER_ID_F, {
	"inherit_server_id",
	".cs.S2C_OldPlayerBack_GetInfo.inherit_server_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_OFFLINE_DAY_F, {
	"offline_day",
	".cs.S2C_OldPlayerBack_GetInfo.offline_day",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OLDPLAYERBACK_GETINFO_ME, {
	"S2C_OldPlayerBack_GetInfo",
	".cs.S2C_OldPlayerBack_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_OLDPLAYERBACK_GETINFO_RET_F,
		var_0_10.S2C_OLDPLAYERBACK_GETINFO_RECHARGE_AMOUNT_F,
		var_0_10.S2C_OLDPLAYERBACK_GETINFO_IS_SUBSCRIBE_F,
		var_0_10.S2C_OLDPLAYERBACK_GETINFO_IS_OLD_PLAYER_F,
		var_0_10.S2C_OLDPLAYERBACK_GETINFO_INHERIT_SERVER_ID_F,
		var_0_10.S2C_OLDPLAYERBACK_GETINFO_OFFLINE_DAY_F
	},
	false,
	{}
})

return var_0_10
