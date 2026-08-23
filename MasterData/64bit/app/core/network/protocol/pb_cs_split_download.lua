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
	C2S_SPLITDOWNLOAD_AWARD_ME = protobuf.Descriptor(),
	C2S_SPLITDOWNLOAD_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_SPLITDOWNLOAD_AWARD_ME = protobuf.Descriptor(),
	S2C_SPLITDOWNLOAD_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_SPLITDOWNLOAD_AWARD_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SPLITDOWNLOAD_AWARD_ID_F, {
	"id",
	".cs.C2S_SplitDownload_Award.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SPLITDOWNLOAD_AWARD_ME, {
	"C2S_SplitDownload_Award",
	".cs.C2S_SplitDownload_Award",
	{},
	{},
	{
		var_0_10.C2S_SPLITDOWNLOAD_AWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPLITDOWNLOAD_AWARD_RET_F, {
	"ret",
	".cs.S2C_SplitDownload_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SPLITDOWNLOAD_AWARD_ID_F, {
	"id",
	".cs.S2C_SplitDownload_Award.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SPLITDOWNLOAD_AWARD_ME, {
	"S2C_SplitDownload_Award",
	".cs.S2C_SplitDownload_Award",
	{},
	{},
	{
		var_0_10.S2C_SPLITDOWNLOAD_AWARD_RET_F,
		var_0_10.S2C_SPLITDOWNLOAD_AWARD_ID_F
	},
	false,
	{}
})

return var_0_10
