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
	C2S_SPIRITHELP_GETINFO_ME = protobuf.Descriptor(),
	S2C_SPIRITHELP_GETINFO_ME = protobuf.Descriptor(),
	S2C_SPIRITHELP_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SPIRITHELP_GETINFO_DEADBATTLE_STATE_F = protobuf.FieldDescriptor(),
	S2C_SPIRITHELP_GETINFO_GUILDSTATUE_STATE_F = protobuf.FieldDescriptor(),
	S2C_SPIRITHELP_GETINFO_GUILDSENDGIFT_STATE_F = protobuf.FieldDescriptor(),
	S2C_SPIRITHELP_GETINFO_GUILD_WORSHIP_PROCESS_STATE_F = protobuf.FieldDescriptor(),
	S2C_SPIRITHELP_GETINFO_DEAD_TOWER_STATE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_SPIRITHELP_GETINFO_ME, {
	"C2S_SpiritHelp_GetInfo",
	".cs.C2S_SpiritHelp_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_RET_F, {
	"ret",
	".cs.S2C_SpiritHelp_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_DEADBATTLE_STATE_F, {
	"deadBattle_state",
	".cs.S2C_SpiritHelp_GetInfo.deadBattle_state",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_GUILDSTATUE_STATE_F, {
	"guildStatue_state",
	".cs.S2C_SpiritHelp_GetInfo.guildStatue_state",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_GUILDSENDGIFT_STATE_F, {
	"guildSendGift_state",
	".cs.S2C_SpiritHelp_GetInfo.guildSendGift_state",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_GUILD_WORSHIP_PROCESS_STATE_F, {
	"guild_worship_process_state",
	".cs.S2C_SpiritHelp_GetInfo.guild_worship_process_state",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_DEAD_TOWER_STATE_F, {
	"dead_tower_state",
	".cs.S2C_SpiritHelp_GetInfo.dead_tower_state",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPIRITHELP_GETINFO_ME, {
	"S2C_SpiritHelp_GetInfo",
	".cs.S2C_SpiritHelp_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_SPIRITHELP_GETINFO_RET_F,
		var_0_10.S2C_SPIRITHELP_GETINFO_DEADBATTLE_STATE_F,
		var_0_10.S2C_SPIRITHELP_GETINFO_GUILDSTATUE_STATE_F,
		var_0_10.S2C_SPIRITHELP_GETINFO_GUILDSENDGIFT_STATE_F,
		var_0_10.S2C_SPIRITHELP_GETINFO_GUILD_WORSHIP_PROCESS_STATE_F,
		var_0_10.S2C_SPIRITHELP_GETINFO_DEAD_TOWER_STATE_F
	},
	false,
	{}
})

return var_0_10
