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
	C2S_KSOUL_INFO_ME = protobuf.Descriptor(),
	S2C_KSOUL_INFO_ME = protobuf.Descriptor(),
	S2C_KSOUL_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_INFO_HONOR_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_INFO_MAX_HONOR_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_INFO_CB_INFO_F = protobuf.FieldDescriptor(),
	C2S_KSOUL_CHAPTERINFO_ME = protobuf.Descriptor(),
	C2S_KSOUL_CHAPTERINFO_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_CHAPTERINFO_ME = protobuf.Descriptor(),
	S2C_KSOUL_CHAPTERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_CHAPTERINFO_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_CHAPTERINFO_BOOKS_F = protobuf.FieldDescriptor(),
	C2S_KSOUL_BOOKACTIVATE_ME = protobuf.Descriptor(),
	C2S_KSOUL_BOOKACTIVATE_BOOK_ID_F = protobuf.FieldDescriptor(),
	C2S_KSOUL_BOOKACTIVATE_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKACTIVATE_ME = protobuf.Descriptor(),
	S2C_KSOUL_BOOKACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKACTIVATE_BOOK_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKACTIVATE_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKACTIVATE_HONOR_F = protobuf.FieldDescriptor(),
	C2S_KSOUL_BOOKUPGRADE_ME = protobuf.Descriptor(),
	C2S_KSOUL_BOOKUPGRADE_BOOK_ID_F = protobuf.FieldDescriptor(),
	C2S_KSOUL_BOOKUPGRADE_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKUPGRADE_ME = protobuf.Descriptor(),
	S2C_KSOUL_BOOKUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKUPGRADE_BOOK_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKUPGRADE_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_BOOKUPGRADE_STAR_F = protobuf.FieldDescriptor(),
	C2S_KSOUL_HONORADVANCE_ME = protobuf.Descriptor(),
	C2S_KSOUL_HONORADVANCE_HONOR_ID_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_HONORADVANCE_ME = protobuf.Descriptor(),
	S2C_KSOUL_HONORADVANCE_RET_F = protobuf.FieldDescriptor(),
	S2C_KSOUL_HONORADVANCE_HONOR_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_KSOUL_INFO_ME, {
	"C2S_KSoul_Info",
	".cs.C2S_KSoul_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_INFO_RET_F, {
	"ret",
	".cs.S2C_KSoul_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_INFO_HONOR_F, {
	"honor",
	".cs.S2C_KSoul_Info.honor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_INFO_MAX_HONOR_ID_F, {
	"max_honor_id",
	".cs.S2C_KSoul_Info.max_honor_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_INFO_CB_INFO_F, {
	"cb_info",
	".cs.S2C_KSoul_Info.cb_info",
	4,
	3,
	3,
	false,
	{},
	var_0_3.KSOULCHAPTERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KSOUL_INFO_ME, {
	"S2C_KSoul_Info",
	".cs.S2C_KSoul_Info",
	{},
	{},
	{
		var_0_10.S2C_KSOUL_INFO_RET_F,
		var_0_10.S2C_KSOUL_INFO_HONOR_F,
		var_0_10.S2C_KSOUL_INFO_MAX_HONOR_ID_F,
		var_0_10.S2C_KSOUL_INFO_CB_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KSOUL_CHAPTERINFO_CHAPTER_ID_F, {
	"chapter_id",
	".cs.C2S_KSoul_ChapterInfo.chapter_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KSOUL_CHAPTERINFO_ME, {
	"C2S_KSoul_ChapterInfo",
	".cs.C2S_KSoul_ChapterInfo",
	{},
	{},
	{
		var_0_10.C2S_KSOUL_CHAPTERINFO_CHAPTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_CHAPTERINFO_RET_F, {
	"ret",
	".cs.S2C_KSoul_ChapterInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_CHAPTERINFO_CHAPTER_ID_F, {
	"chapter_id",
	".cs.S2C_KSoul_ChapterInfo.chapter_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_CHAPTERINFO_BOOKS_F, {
	"books",
	".cs.S2C_KSoul_ChapterInfo.books",
	3,
	2,
	3,
	false,
	{},
	var_0_3.KSOULBOOK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KSOUL_CHAPTERINFO_ME, {
	"S2C_KSoul_ChapterInfo",
	".cs.S2C_KSoul_ChapterInfo",
	{},
	{},
	{
		var_0_10.S2C_KSOUL_CHAPTERINFO_RET_F,
		var_0_10.S2C_KSOUL_CHAPTERINFO_CHAPTER_ID_F,
		var_0_10.S2C_KSOUL_CHAPTERINFO_BOOKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KSOUL_BOOKACTIVATE_BOOK_ID_F, {
	"book_id",
	".cs.C2S_KSoul_BookActivate.book_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KSOUL_BOOKACTIVATE_CHAPTER_ID_F, {
	"chapter_id",
	".cs.C2S_KSoul_BookActivate.chapter_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_KSOUL_BOOKACTIVATE_ME, {
	"C2S_KSoul_BookActivate",
	".cs.C2S_KSoul_BookActivate",
	{},
	{},
	{
		var_0_10.C2S_KSOUL_BOOKACTIVATE_BOOK_ID_F,
		var_0_10.C2S_KSOUL_BOOKACTIVATE_CHAPTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKACTIVATE_RET_F, {
	"ret",
	".cs.S2C_KSoul_BookActivate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKACTIVATE_BOOK_ID_F, {
	"book_id",
	".cs.S2C_KSoul_BookActivate.book_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKACTIVATE_CHAPTER_ID_F, {
	"chapter_id",
	".cs.S2C_KSoul_BookActivate.chapter_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKACTIVATE_HONOR_F, {
	"honor",
	".cs.S2C_KSoul_BookActivate.honor",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KSOUL_BOOKACTIVATE_ME, {
	"S2C_KSoul_BookActivate",
	".cs.S2C_KSoul_BookActivate",
	{},
	{},
	{
		var_0_10.S2C_KSOUL_BOOKACTIVATE_RET_F,
		var_0_10.S2C_KSOUL_BOOKACTIVATE_BOOK_ID_F,
		var_0_10.S2C_KSOUL_BOOKACTIVATE_CHAPTER_ID_F,
		var_0_10.S2C_KSOUL_BOOKACTIVATE_HONOR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KSOUL_BOOKUPGRADE_BOOK_ID_F, {
	"book_id",
	".cs.C2S_KSoul_BookUpgrade.book_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KSOUL_BOOKUPGRADE_CHAPTER_ID_F, {
	"chapter_id",
	".cs.C2S_KSoul_BookUpgrade.chapter_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_KSOUL_BOOKUPGRADE_ME, {
	"C2S_KSoul_BookUpgrade",
	".cs.C2S_KSoul_BookUpgrade",
	{},
	{},
	{
		var_0_10.C2S_KSOUL_BOOKUPGRADE_BOOK_ID_F,
		var_0_10.C2S_KSOUL_BOOKUPGRADE_CHAPTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKUPGRADE_RET_F, {
	"ret",
	".cs.S2C_KSoul_BookUpgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKUPGRADE_BOOK_ID_F, {
	"book_id",
	".cs.S2C_KSoul_BookUpgrade.book_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKUPGRADE_CHAPTER_ID_F, {
	"chapter_id",
	".cs.S2C_KSoul_BookUpgrade.chapter_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_BOOKUPGRADE_STAR_F, {
	"star",
	".cs.S2C_KSoul_BookUpgrade.star",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KSOUL_BOOKUPGRADE_ME, {
	"S2C_KSoul_BookUpgrade",
	".cs.S2C_KSoul_BookUpgrade",
	{},
	{},
	{
		var_0_10.S2C_KSOUL_BOOKUPGRADE_RET_F,
		var_0_10.S2C_KSOUL_BOOKUPGRADE_BOOK_ID_F,
		var_0_10.S2C_KSOUL_BOOKUPGRADE_CHAPTER_ID_F,
		var_0_10.S2C_KSOUL_BOOKUPGRADE_STAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KSOUL_HONORADVANCE_HONOR_ID_F, {
	"honor_id",
	".cs.C2S_KSoul_HonorAdvance.honor_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KSOUL_HONORADVANCE_ME, {
	"C2S_KSoul_HonorAdvance",
	".cs.C2S_KSoul_HonorAdvance",
	{},
	{},
	{
		var_0_10.C2S_KSOUL_HONORADVANCE_HONOR_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_HONORADVANCE_RET_F, {
	"ret",
	".cs.S2C_KSoul_HonorAdvance.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KSOUL_HONORADVANCE_HONOR_ID_F, {
	"honor_id",
	".cs.S2C_KSoul_HonorAdvance.honor_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KSOUL_HONORADVANCE_ME, {
	"S2C_KSoul_HonorAdvance",
	".cs.S2C_KSoul_HonorAdvance",
	{},
	{},
	{
		var_0_10.S2C_KSOUL_HONORADVANCE_RET_F,
		var_0_10.S2C_KSOUL_HONORADVANCE_HONOR_ID_F
	},
	false,
	{}
})

return var_0_10
