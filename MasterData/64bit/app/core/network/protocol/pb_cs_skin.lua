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
	C2S_SKIN_WEAR_ME = protobuf.Descriptor(),
	C2S_SKIN_WEAR_BOOK_ID_F = protobuf.FieldDescriptor(),
	S2C_SKIN_WEAR_ME = protobuf.Descriptor(),
	S2C_SKIN_WEAR_RET_F = protobuf.FieldDescriptor(),
	S2C_SKIN_WEAR_BOOK_ID_F = protobuf.FieldDescriptor(),
	C2S_SKIN_TAKEOFF_ME = protobuf.Descriptor(),
	C2S_SKIN_TAKEOFF_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_SKIN_TAKEOFF_ME = protobuf.Descriptor(),
	S2C_SKIN_TAKEOFF_RET_F = protobuf.FieldDescriptor(),
	S2C_SKIN_TAKEOFF_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_SKIN_EXPIRE_NTF_ME = protobuf.Descriptor(),
	C2S_SKIN_EXPIRE_NTF_BOOK_ID_F = protobuf.FieldDescriptor(),
	S2C_SKIN_EXPIRE_NTF_ME = protobuf.Descriptor(),
	S2C_SKIN_EXPIRE_NTF_RET_F = protobuf.FieldDescriptor(),
	S2C_SKIN_EXPIRE_NTF_BOOK_ID_F = protobuf.FieldDescriptor(),
	C2S_SKIN_ADVANCECHECK_ME = protobuf.Descriptor(),
	C2S_SKIN_ADVANCECHECK_ADVANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_SKIN_ADVANCECHECK_ME = protobuf.Descriptor(),
	S2C_SKIN_ADVANCECHECK_RET_F = protobuf.FieldDescriptor(),
	S2C_SKIN_ADVANCECHECK_ADVANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_SKIN_ADVANCECHECK_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SKIN_WEAR_BOOK_ID_F, {
	"book_id",
	".cs.C2S_Skin_Wear.book_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_SKIN_WEAR_ME, {
	"C2S_Skin_Wear",
	".cs.C2S_Skin_Wear",
	{},
	{},
	{
		var_0_9.C2S_SKIN_WEAR_BOOK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_WEAR_RET_F, {
	"ret",
	".cs.S2C_Skin_Wear.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_WEAR_BOOK_ID_F, {
	"book_id",
	".cs.S2C_Skin_Wear.book_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_SKIN_WEAR_ME, {
	"S2C_Skin_Wear",
	".cs.S2C_Skin_Wear",
	{},
	{},
	{
		var_0_9.S2C_SKIN_WEAR_RET_F,
		var_0_9.S2C_SKIN_WEAR_BOOK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SKIN_TAKEOFF_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_Skin_TakeOff.advance_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_9.C2S_SKIN_TAKEOFF_ME, {
	"C2S_Skin_TakeOff",
	".cs.C2S_Skin_TakeOff",
	{},
	{},
	{
		var_0_9.C2S_SKIN_TAKEOFF_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_TAKEOFF_RET_F, {
	"ret",
	".cs.S2C_Skin_TakeOff.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_TAKEOFF_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_Skin_TakeOff.advance_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_SKIN_TAKEOFF_ME, {
	"S2C_Skin_TakeOff",
	".cs.S2C_Skin_TakeOff",
	{},
	{},
	{
		var_0_9.S2C_SKIN_TAKEOFF_RET_F,
		var_0_9.S2C_SKIN_TAKEOFF_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SKIN_EXPIRE_NTF_BOOK_ID_F, {
	"book_id",
	".cs.C2S_Skin_Expire_Ntf.book_id",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_SKIN_EXPIRE_NTF_ME, {
	"C2S_Skin_Expire_Ntf",
	".cs.C2S_Skin_Expire_Ntf",
	{},
	{},
	{
		var_0_9.C2S_SKIN_EXPIRE_NTF_BOOK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_EXPIRE_NTF_RET_F, {
	"ret",
	".cs.S2C_Skin_Expire_Ntf.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_EXPIRE_NTF_BOOK_ID_F, {
	"book_id",
	".cs.S2C_Skin_Expire_Ntf.book_id",
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
descriptor_helper.descriptorFunc(var_0_9.S2C_SKIN_EXPIRE_NTF_ME, {
	"S2C_Skin_Expire_Ntf",
	".cs.S2C_Skin_Expire_Ntf",
	{},
	{},
	{
		var_0_9.S2C_SKIN_EXPIRE_NTF_RET_F,
		var_0_9.S2C_SKIN_EXPIRE_NTF_BOOK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.C2S_SKIN_ADVANCECHECK_ADVANCE_IDS_F, {
	"advance_ids",
	".cs.C2S_Skin_AdvanceCheck.advance_ids",
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
descriptor_helper.descriptorFunc(var_0_9.C2S_SKIN_ADVANCECHECK_ME, {
	"C2S_Skin_AdvanceCheck",
	".cs.C2S_Skin_AdvanceCheck",
	{},
	{},
	{
		var_0_9.C2S_SKIN_ADVANCECHECK_ADVANCE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_ADVANCECHECK_RET_F, {
	"ret",
	".cs.S2C_Skin_AdvanceCheck.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_ADVANCECHECK_ADVANCE_IDS_F, {
	"advance_ids",
	".cs.S2C_Skin_AdvanceCheck.advance_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_9.S2C_SKIN_ADVANCECHECK_AWARDS_F, {
	"awards",
	".cs.S2C_Skin_AdvanceCheck.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_1("pb_out_base").AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_9.S2C_SKIN_ADVANCECHECK_ME, {
	"S2C_Skin_AdvanceCheck",
	".cs.S2C_Skin_AdvanceCheck",
	{},
	{},
	{
		var_0_9.S2C_SKIN_ADVANCECHECK_RET_F,
		var_0_9.S2C_SKIN_ADVANCECHECK_ADVANCE_IDS_F,
		var_0_9.S2C_SKIN_ADVANCECHECK_AWARDS_F
	},
	false,
	{}
})

return var_0_9
