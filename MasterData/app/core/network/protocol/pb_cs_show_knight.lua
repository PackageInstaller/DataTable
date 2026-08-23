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
	C2S_SHOWKNIGHT_SET_ME = protobuf.Descriptor(),
	C2S_SHOWKNIGHT_SET_SHOW_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_SHOWKNIGHT_SET_ME = protobuf.Descriptor(),
	S2C_SHOWKNIGHT_SET_RET_F = protobuf.FieldDescriptor(),
	S2C_SHOWKNIGHT_SET_SHOW_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_SHOWKNIGHT_FLUSH_ME = protobuf.Descriptor(),
	S2C_SHOWKNIGHT_FLUSH_SHOW_KNIGHTS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SHOWKNIGHT_SET_SHOW_KNIGHTS_F, {
	"show_knights",
	".cs.C2S_ShowKnight_Set.show_knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.SHOWKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SHOWKNIGHT_SET_ME, {
	"C2S_ShowKnight_Set",
	".cs.C2S_ShowKnight_Set",
	{},
	{},
	{
		var_0_10.C2S_SHOWKNIGHT_SET_SHOW_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SHOWKNIGHT_SET_RET_F, {
	"ret",
	".cs.S2C_ShowKnight_Set.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SHOWKNIGHT_SET_SHOW_KNIGHTS_F, {
	"show_knights",
	".cs.S2C_ShowKnight_Set.show_knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SHOWKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SHOWKNIGHT_SET_ME, {
	"S2C_ShowKnight_Set",
	".cs.S2C_ShowKnight_Set",
	{},
	{},
	{
		var_0_10.S2C_SHOWKNIGHT_SET_RET_F,
		var_0_10.S2C_SHOWKNIGHT_SET_SHOW_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SHOWKNIGHT_FLUSH_SHOW_KNIGHTS_F, {
	"show_knights",
	".cs.S2C_ShowKnight_Flush.show_knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.SHOWKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SHOWKNIGHT_FLUSH_ME, {
	"S2C_ShowKnight_Flush",
	".cs.S2C_ShowKnight_Flush",
	{},
	{},
	{
		var_0_10.S2C_SHOWKNIGHT_FLUSH_SHOW_KNIGHTS_F
	},
	false,
	{}
})

return var_0_10
