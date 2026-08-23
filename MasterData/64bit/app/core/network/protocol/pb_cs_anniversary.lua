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
	C2S_ANNIVERSARY_GETINFO_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETINFO_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETINFO_DATA_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETFLOORAWARD_ME = protobuf.Descriptor(),
	C2S_ANNIVERSARY_GETFLOORAWARD_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETFLOORAWARD_TARGET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETFLOORAWARD_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETFLOORAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETFLOORAWARD_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETFLOORAWARD_TARGET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETFLOORAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETTASKAWARD_ME = protobuf.Descriptor(),
	C2S_ANNIVERSARY_GETTASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETTASKAWARD_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETTASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_TASKNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_TASKNOTIFY_TASKS_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_DRAWJIGSAW_ME = protobuf.Descriptor(),
	C2S_ANNIVERSARY_DRAWJIGSAW_TP_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_DRAWJIGSAW_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_DRAWJIGSAW_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_DRAWJIGSAW_TP_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_DRAWJIGSAW_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_DRAWJIGSAW_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_DRAWJIGSAW_REAL_NUM_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETSHAREJIGSAW_ME = protobuf.Descriptor(),
	C2S_ANNIVERSARY_GETSHAREJIGSAW_UID_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETSHAREJIGSAW_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETSHAREJIGSAW_TIME_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETSHAREJIGSAW_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETSHAREJIGSAW_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETSHAREJIGSAW_UID_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETSHAREJIGSAW_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETSHAREJIGSAW_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETSHAREJIGSAW_TIME_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETDRAWNUMAWARD_ME = protobuf.Descriptor(),
	C2S_ANNIVERSARY_GETDRAWNUMAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETDRAWNUMAWARD_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETDRAWNUMAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETDRAWNUMAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETDRAWNUMAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETTOTALSCOREAWARD_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETTOTALSCOREAWARD_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETTOTALSCOREAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETTOTALSCOREAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_SIGNDAY_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_SIGNDAY_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_SIGNDAY_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_SIGNDAY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_SIGNDAY_EXTRA_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ANNIVERSARY_GETJIGSAWGROUPAWARD_ME = protobuf.Descriptor(),
	C2S_ANNIVERSARY_GETJIGSAWGROUPAWARD_GROUP_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_ME = protobuf.Descriptor(),
	S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_GROUP_F = protobuf.FieldDescriptor(),
	S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETINFO_ME, {
	"C2S_Anniversary_GetInfo",
	".cs.C2S_Anniversary_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETINFO_INFO_F, {
	"info",
	".cs.S2C_Anniversary_GetInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANNIVERSARYACTIVITYINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETINFO_DATA_F, {
	"data",
	".cs.S2C_Anniversary_GetInfo.data",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.ANNIVERSARYACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETINFO_ME, {
	"S2C_Anniversary_GetInfo",
	".cs.S2C_Anniversary_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETINFO_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETINFO_INFO_F,
		var_0_10.S2C_ANNIVERSARY_GETINFO_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETFLOORAWARD_FLOOR_F, {
	"floor",
	".cs.C2S_Anniversary_GetFloorAward.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETFLOORAWARD_TARGET_F, {
	"target",
	".cs.C2S_Anniversary_GetFloorAward.target",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETFLOORAWARD_ME, {
	"C2S_Anniversary_GetFloorAward",
	".cs.C2S_Anniversary_GetFloorAward",
	{},
	{},
	{
		var_0_10.C2S_ANNIVERSARY_GETFLOORAWARD_FLOOR_F,
		var_0_10.C2S_ANNIVERSARY_GETFLOORAWARD_TARGET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetFloorAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_FLOOR_F, {
	"floor",
	".cs.S2C_Anniversary_GetFloorAward.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_TARGET_F, {
	"target",
	".cs.S2C_Anniversary_GetFloorAward.target",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_GetFloorAward.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_ME, {
	"S2C_Anniversary_GetFloorAward",
	".cs.S2C_Anniversary_GetFloorAward",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_FLOOR_F,
		var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_TARGET_F,
		var_0_10.S2C_ANNIVERSARY_GETFLOORAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETTASKAWARD_ID_F, {
	"id",
	".cs.C2S_Anniversary_GetTaskAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETTASKAWARD_ME, {
	"C2S_Anniversary_GetTaskAward",
	".cs.C2S_Anniversary_GetTaskAward",
	{},
	{},
	{
		var_0_10.C2S_ANNIVERSARY_GETTASKAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetTaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_ID_F, {
	"id",
	".cs.S2C_Anniversary_GetTaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_GetTaskAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_ME, {
	"S2C_Anniversary_GetTaskAward",
	".cs.S2C_Anniversary_GetTaskAward",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_ID_F,
		var_0_10.S2C_ANNIVERSARY_GETTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_TASKNOTIFY_TASKS_F, {
	"tasks",
	".cs.S2C_Anniversary_TaskNotify.tasks",
	1,
	0,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_TASKNOTIFY_ME, {
	"S2C_Anniversary_TaskNotify",
	".cs.S2C_Anniversary_TaskNotify",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_TASKNOTIFY_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_DRAWJIGSAW_TP_F, {
	"tp",
	".cs.C2S_Anniversary_DrawJigsaw.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_DRAWJIGSAW_ME, {
	"C2S_Anniversary_DrawJigsaw",
	".cs.C2S_Anniversary_DrawJigsaw",
	{},
	{},
	{
		var_0_10.C2S_ANNIVERSARY_DRAWJIGSAW_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_RET_F, {
	"ret",
	".cs.S2C_Anniversary_DrawJigsaw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_TP_F, {
	"tp",
	".cs.S2C_Anniversary_DrawJigsaw.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_IDS_F, {
	"ids",
	".cs.S2C_Anniversary_DrawJigsaw.ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_DrawJigsaw.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_REAL_NUM_F, {
	"real_num",
	".cs.S2C_Anniversary_DrawJigsaw.real_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_ME, {
	"S2C_Anniversary_DrawJigsaw",
	".cs.S2C_Anniversary_DrawJigsaw",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_RET_F,
		var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_TP_F,
		var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_IDS_F,
		var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_AWARDS_F,
		var_0_10.S2C_ANNIVERSARY_DRAWJIGSAW_REAL_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_UID_F, {
	"uid",
	".cs.C2S_Anniversary_GetShareJigsaw.uid",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_ITEM_ID_F, {
	"item_id",
	".cs.C2S_Anniversary_GetShareJigsaw.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_TIME_F, {
	"time",
	".cs.C2S_Anniversary_GetShareJigsaw.time",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_ME, {
	"C2S_Anniversary_GetShareJigsaw",
	".cs.C2S_Anniversary_GetShareJigsaw",
	{},
	{},
	{
		var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_UID_F,
		var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_ITEM_ID_F,
		var_0_10.C2S_ANNIVERSARY_GETSHAREJIGSAW_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetShareJigsaw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_UID_F, {
	"uid",
	".cs.S2C_Anniversary_GetShareJigsaw.uid",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_ITEM_ID_F, {
	"item_id",
	".cs.S2C_Anniversary_GetShareJigsaw.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_GetShareJigsaw.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_TIME_F, {
	"time",
	".cs.S2C_Anniversary_GetShareJigsaw.time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_ME, {
	"S2C_Anniversary_GetShareJigsaw",
	".cs.S2C_Anniversary_GetShareJigsaw",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_UID_F,
		var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_ITEM_ID_F,
		var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_AWARDS_F,
		var_0_10.S2C_ANNIVERSARY_GETSHAREJIGSAW_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETDRAWNUMAWARD_ID_F, {
	"id",
	".cs.C2S_Anniversary_GetDrawNumAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETDRAWNUMAWARD_ME, {
	"C2S_Anniversary_GetDrawNumAward",
	".cs.C2S_Anniversary_GetDrawNumAward",
	{},
	{},
	{
		var_0_10.C2S_ANNIVERSARY_GETDRAWNUMAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetDrawNumAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_ID_F, {
	"id",
	".cs.S2C_Anniversary_GetDrawNumAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_GetDrawNumAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_ME, {
	"S2C_Anniversary_GetDrawNumAward",
	".cs.S2C_Anniversary_GetDrawNumAward",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_ID_F,
		var_0_10.S2C_ANNIVERSARY_GETDRAWNUMAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETTOTALSCOREAWARD_ME, {
	"C2S_Anniversary_GetTotalScoreAward",
	".cs.C2S_Anniversary_GetTotalScoreAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTOTALSCOREAWARD_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetTotalScoreAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTOTALSCOREAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_GetTotalScoreAward.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETTOTALSCOREAWARD_ME, {
	"S2C_Anniversary_GetTotalScoreAward",
	".cs.S2C_Anniversary_GetTotalScoreAward",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETTOTALSCOREAWARD_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETTOTALSCOREAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_SIGNDAY_ME, {
	"C2S_Anniversary_SignDay",
	".cs.C2S_Anniversary_SignDay",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_SIGNDAY_RET_F, {
	"ret",
	".cs.S2C_Anniversary_SignDay.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_SIGNDAY_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_SignDay.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_SIGNDAY_EXTRA_AWARDS_F, {
	"extra_awards",
	".cs.S2C_Anniversary_SignDay.extra_awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_SIGNDAY_ME, {
	"S2C_Anniversary_SignDay",
	".cs.S2C_Anniversary_SignDay",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_SIGNDAY_RET_F,
		var_0_10.S2C_ANNIVERSARY_SIGNDAY_AWARDS_F,
		var_0_10.S2C_ANNIVERSARY_SIGNDAY_EXTRA_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANNIVERSARY_GETJIGSAWGROUPAWARD_GROUP_F, {
	"group",
	".cs.C2S_Anniversary_GetJigsawGroupAward.group",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANNIVERSARY_GETJIGSAWGROUPAWARD_ME, {
	"C2S_Anniversary_GetJigsawGroupAward",
	".cs.C2S_Anniversary_GetJigsawGroupAward",
	{},
	{},
	{
		var_0_10.C2S_ANNIVERSARY_GETJIGSAWGROUPAWARD_GROUP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_RET_F, {
	"ret",
	".cs.S2C_Anniversary_GetJigsawGroupAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_GROUP_F, {
	"group",
	".cs.S2C_Anniversary_GetJigsawGroupAward.group",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Anniversary_GetJigsawGroupAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_ME, {
	"S2C_Anniversary_GetJigsawGroupAward",
	".cs.S2C_Anniversary_GetJigsawGroupAward",
	{},
	{},
	{
		var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_RET_F,
		var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_GROUP_F,
		var_0_10.S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
