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
	C2S_NEWDOWNLOAD_AWARD_ME = protobuf.Descriptor(),
	S2C_NEWDOWNLOAD_AWARD_ME = protobuf.Descriptor(),
	S2C_NEWDOWNLOAD_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWDOWNLOAD_AWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_NEWDOWNLOAD_AWARD_ME, {
	"C2S_NewDownload_Award",
	".cs.C2S_NewDownload_Award",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDOWNLOAD_AWARD_RET_F, {
	"ret",
	".cs.S2C_NewDownload_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_NEWDOWNLOAD_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewDownload_Award.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_1("pb_out_base").AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_NEWDOWNLOAD_AWARD_ME, {
	"S2C_NewDownload_Award",
	".cs.S2C_NewDownload_Award",
	{},
	{},
	{
		var_0_9.S2C_NEWDOWNLOAD_AWARD_RET_F,
		var_0_9.S2C_NEWDOWNLOAD_AWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_9
