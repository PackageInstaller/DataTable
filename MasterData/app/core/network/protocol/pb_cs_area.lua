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
	C2S_AREA_MERGEINFO_ME = protobuf.Descriptor(),
	S2C_AREA_MERGEINFO_ME = protobuf.Descriptor(),
	S2C_AREA_MERGEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_AREA_MERGEINFO_MERGE_AREA_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_9.C2S_AREA_MERGEINFO_ME, {
	"C2S_Area_MergeInfo",
	".cs.C2S_Area_MergeInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_AREA_MERGEINFO_RET_F, {
	"ret",
	".cs.S2C_Area_MergeInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_AREA_MERGEINFO_MERGE_AREA_F, {
	"merge_area",
	".cs.S2C_Area_MergeInfo.merge_area",
	2,
	1,
	1,
	false,
	nil,
	var_0_1("pb_out_base").MERGEAREA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_AREA_MERGEINFO_ME, {
	"S2C_Area_MergeInfo",
	".cs.S2C_Area_MergeInfo",
	{},
	{},
	{
		var_0_9.S2C_AREA_MERGEINFO_RET_F,
		var_0_9.S2C_AREA_MERGEINFO_MERGE_AREA_F
	},
	false,
	{}
})

return var_0_9
