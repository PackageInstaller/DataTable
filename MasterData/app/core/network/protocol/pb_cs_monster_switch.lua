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
	S2C_MONSTERSWITCH_FLUSH_ME = protobuf.Descriptor(),
	S2C_MONSTERSWITCH_FLUSH_MONSTER_SWITCH_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_MONSTERSWITCH_FLUSH_MONSTER_SWITCH_F, {
	"monster_switch",
	".cs.S2C_MonsterSwitch_Flush.monster_switch",
	1,
	0,
	1,
	false,
	nil,
	var_0_1("pb_out_base").MONSTERSWITCH_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_MONSTERSWITCH_FLUSH_ME, {
	"S2C_MonsterSwitch_Flush",
	".cs.S2C_MonsterSwitch_Flush",
	{},
	{},
	{
		var_0_9.S2C_MONSTERSWITCH_FLUSH_MONSTER_SWITCH_F
	},
	false,
	{}
})

return var_0_9
