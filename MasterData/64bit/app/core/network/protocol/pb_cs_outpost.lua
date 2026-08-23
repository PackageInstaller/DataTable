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
	C2S_OUTPOST_GETINFO_ME = protobuf.Descriptor(),
	S2C_OUTPOST_GETINFO_ME = protobuf.Descriptor(),
	S2C_OUTPOST_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETINFO_DATA_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_LEAVE_ME = protobuf.Descriptor(),
	C2S_OUTPOST_LEAVE_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_LEAVE_ME = protobuf.Descriptor(),
	S2C_OUTPOST_LEAVE_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_LEAVE_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_DONATEKNIGHT_ME = protobuf.Descriptor(),
	C2S_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_DONATEKNIGHT_COIN_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_DONATEKNIGHT_ME = protobuf.Descriptor(),
	S2C_OUTPOST_DONATEKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_DONATEKNIGHT_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_KNIGHT_ENTRANCE_ME = protobuf.Descriptor(),
	C2S_OUTPOST_KNIGHT_ENTRANCE_ADVANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHT_ENTRANCE_ME = protobuf.Descriptor(),
	S2C_OUTPOST_KNIGHT_ENTRANCE_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHT_ENTRANCE_ADVANCE_IDS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHT_ENTRANCE_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHT_ENTRANCE_SLOTS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_KNIGHT_EXIT_ME = protobuf.Descriptor(),
	C2S_OUTPOST_KNIGHT_EXIT_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHT_EXIT_ME = protobuf.Descriptor(),
	S2C_OUTPOST_KNIGHT_EXIT_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHT_EXIT_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_KNIGHTCHANGEMAP_ME = protobuf.Descriptor(),
	C2S_OUTPOST_KNIGHTCHANGEMAP_POS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_KNIGHTCHANGEMAP_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHTCHANGEMAP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_KNIGHTCHANGEMAP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_KNIGHTCHANGEMAP_SLOTS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BATTLEFINISH_MAP_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_X_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_Y_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BATTLEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_DROPS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_NEW_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_X_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_Y_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_DROPTOKNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_LEFT_VIT_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_BOSS_BOXES_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_LEVELUP_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_LEVELUP_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_BUILD_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_UNLOCK_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_UNLOCK_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_UNLOCK_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_UNLOCK_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_UNLOCK_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_UNLOCK_BUILD_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_USE_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_USE_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_LEAVE_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_USE_LEAVE_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_LEAVE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_LEAVE_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_USE_LEAVE_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_LEAVE_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_LEAVE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_LEAVE_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_CALLBOSS_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CALLBOSS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_CALLBOSS_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CALLBOSS_BOSS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_ME = protobuf.Descriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_MAP_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_SEQ_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_TARGET_X_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_TARGET_Y_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_SEQ_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_TARGET_X_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_TARGET_Y_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_GETTASKAWARD_ME = protobuf.Descriptor(),
	C2S_OUTPOST_GETTASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_GETTASKAWARD_TASK_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_ME = protobuf.Descriptor(),
	S2C_OUTPOST_GETTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_TASK_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_SYNCTASK_ME = protobuf.Descriptor(),
	S2C_OUTPOST_SYNCTASK_TASK_TYPE_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_SYNCTASK_ACTIONS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_UNLOCK_ME = protobuf.Descriptor(),
	C2S_OUTPOST_MAP_UNLOCK_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_UNLOCK_ME = protobuf.Descriptor(),
	S2C_OUTPOST_MAP_UNLOCK_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_UNLOCK_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_UNLOCK_MAP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_CHANGEBUILDPOS_ME = protobuf.Descriptor(),
	C2S_OUTPOST_CHANGEBUILDPOS_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_CHANGEBUILDPOS_POS_X_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_CHANGEBUILDPOS_POS_Y_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_CHANGEBUILDPOS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_CHANGEBUILDPOS_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_CHANGEBUILDPOS_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_CHANGEBUILDPOS_POS_X_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_CHANGEBUILDPOS_POS_Y_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_CHANGEORDER_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_CHANGEORDER_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_CHANGEORDER_ORDER_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_CHANGEORDER_ORDER_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CHANGEORDER_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_CHANGEORDER_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CHANGEORDER_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CHANGEORDER_ORDER_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CHANGEORDER_ORDER_NUM_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BOSS_SWEEP_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BOSS_SWEEP_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BOSS_SWEEP_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BOSS_SWEEP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BOSS_SWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BOSS_SWEEP_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BOSS_SWEEP_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BOSS_SWEEP_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BOSS_SWEEP_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BOSS_SWEEP_BOX_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_ONEKEYCLICKDROP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_ONEKEYCLICKDROP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_ONEKEYCLICKDROP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_ONEKEYCLICKDROP_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_GETBOSSBOX_ME = protobuf.Descriptor(),
	C2S_OUTPOST_GETBOSSBOX_BOX_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_GETBOSSBOX_AREA_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETBOSSBOX_ME = protobuf.Descriptor(),
	S2C_OUTPOST_GETBOSSBOX_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETBOSSBOX_BOX_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETBOSSBOX_AREA_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETBOSSBOX_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_DELBOSS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_DELBOSS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_DELBOSS_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_DELBOSS_BOSS_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_GETINFO_ME, {
	"C2S_Outpost_GetInfo",
	".cs.C2S_Outpost_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Outpost_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETINFO_DATA_F, {
	"data",
	".cs.S2C_Outpost_GetInfo.data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.OUTPOSTDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_GETINFO_ME, {
	"S2C_Outpost_GetInfo",
	".cs.S2C_Outpost_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_GETINFO_RET_F,
		var_0_10.S2C_OUTPOST_GETINFO_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_LEAVE_KNIGHTS_F, {
	"knights",
	".cs.C2S_Outpost_Leave.knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_LEAVE_ME, {
	"C2S_Outpost_Leave",
	".cs.C2S_Outpost_Leave",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_LEAVE_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_LEAVE_RET_F, {
	"ret",
	".cs.S2C_Outpost_Leave.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_LEAVE_KNIGHTS_F, {
	"knights",
	".cs.S2C_Outpost_Leave.knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_LEAVE_ME, {
	"S2C_Outpost_Leave",
	".cs.S2C_Outpost_Leave",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_LEAVE_RET_F,
		var_0_10.S2C_OUTPOST_LEAVE_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Outpost_DonateKnight.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_DONATEKNIGHT_COIN_NUM_F, {
	"coin_num",
	".cs.C2S_Outpost_DonateKnight.coin_num",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_DONATEKNIGHT_ME, {
	"C2S_Outpost_DonateKnight",
	".cs.C2S_Outpost_DonateKnight",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F,
		var_0_10.C2S_OUTPOST_DONATEKNIGHT_COIN_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_DONATEKNIGHT_RET_F, {
	"ret",
	".cs.S2C_Outpost_DonateKnight.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_DONATEKNIGHT_KNIGHT_F, {
	"knight",
	".cs.S2C_Outpost_DonateKnight.knight",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_DONATEKNIGHT_ME, {
	"S2C_Outpost_DonateKnight",
	".cs.S2C_Outpost_DonateKnight",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_DONATEKNIGHT_RET_F,
		var_0_10.S2C_OUTPOST_DONATEKNIGHT_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_KNIGHT_ENTRANCE_ADVANCE_IDS_F, {
	"advance_ids",
	".cs.C2S_Outpost_Knight_Entrance.advance_ids",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_KNIGHT_ENTRANCE_ME, {
	"C2S_Outpost_Knight_Entrance",
	".cs.C2S_Outpost_Knight_Entrance",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_KNIGHT_ENTRANCE_ADVANCE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_RET_F, {
	"ret",
	".cs.S2C_Outpost_Knight_Entrance.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_ADVANCE_IDS_F, {
	"advance_ids",
	".cs.S2C_Outpost_Knight_Entrance.advance_ids",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_KNIGHTS_F, {
	"knights",
	".cs.S2C_Outpost_Knight_Entrance.knights",
	3,
	2,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_SLOTS_F, {
	"slots",
	".cs.S2C_Outpost_Knight_Entrance.slots",
	4,
	3,
	3,
	false,
	{},
	var_0_3.OUTPOSTSLOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_ME, {
	"S2C_Outpost_Knight_Entrance",
	".cs.S2C_Outpost_Knight_Entrance",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_RET_F,
		var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_ADVANCE_IDS_F,
		var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_KNIGHTS_F,
		var_0_10.S2C_OUTPOST_KNIGHT_ENTRANCE_SLOTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_KNIGHT_EXIT_KNIGHTS_F, {
	"knights",
	".cs.C2S_Outpost_Knight_Exit.knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_KNIGHT_EXIT_ME, {
	"C2S_Outpost_Knight_Exit",
	".cs.C2S_Outpost_Knight_Exit",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_KNIGHT_EXIT_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_EXIT_RET_F, {
	"ret",
	".cs.S2C_Outpost_Knight_Exit.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_EXIT_KNIGHTS_F, {
	"knights",
	".cs.S2C_Outpost_Knight_Exit.knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_KNIGHT_EXIT_ME, {
	"S2C_Outpost_Knight_Exit",
	".cs.S2C_Outpost_Knight_Exit",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_KNIGHT_EXIT_RET_F,
		var_0_10.S2C_OUTPOST_KNIGHT_EXIT_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_KNIGHTCHANGEMAP_POS_F, {
	"pos",
	".cs.C2S_Outpost_KnightChangeMap.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_KNIGHTCHANGEMAP_MAP_TP_F, {
	"map_tp",
	".cs.C2S_Outpost_KnightChangeMap.map_tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_KNIGHTCHANGEMAP_ME, {
	"C2S_Outpost_KnightChangeMap",
	".cs.C2S_Outpost_KnightChangeMap",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_KNIGHTCHANGEMAP_POS_F,
		var_0_10.C2S_OUTPOST_KNIGHTCHANGEMAP_MAP_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHTCHANGEMAP_RET_F, {
	"ret",
	".cs.S2C_Outpost_KnightChangeMap.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_KNIGHTCHANGEMAP_SLOTS_F, {
	"slots",
	".cs.S2C_Outpost_KnightChangeMap.slots",
	2,
	1,
	3,
	false,
	{},
	var_0_3.OUTPOSTSLOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_KNIGHTCHANGEMAP_ME, {
	"S2C_Outpost_KnightChangeMap",
	".cs.S2C_Outpost_KnightChangeMap",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_KNIGHTCHANGEMAP_RET_F,
		var_0_10.S2C_OUTPOST_KNIGHTCHANGEMAP_SLOTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_MAP_TP_F, {
	"map_tp",
	".cs.C2S_Outpost_BattleFinish.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_UNIQUE_ID_F, {
	"unique_id",
	".cs.C2S_Outpost_BattleFinish.unique_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_KNIGHTS_F, {
	"knights",
	".cs.C2S_Outpost_BattleFinish.knights",
	3,
	2,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_X_F, {
	"x",
	".cs.C2S_Outpost_BattleFinish.x",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_Y_F, {
	"y",
	".cs.C2S_Outpost_BattleFinish.y",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_ME, {
	"C2S_Outpost_BattleFinish",
	".cs.C2S_Outpost_BattleFinish",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BATTLEFINISH_MAP_TP_F,
		var_0_10.C2S_OUTPOST_BATTLEFINISH_UNIQUE_ID_F,
		var_0_10.C2S_OUTPOST_BATTLEFINISH_KNIGHTS_F,
		var_0_10.C2S_OUTPOST_BATTLEFINISH_X_F,
		var_0_10.C2S_OUTPOST_BATTLEFINISH_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_RET_F, {
	"ret",
	".cs.S2C_Outpost_BattleFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_MAP_TP_F, {
	"map_tp",
	".cs.S2C_Outpost_BattleFinish.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_UNIQUE_ID_F, {
	"unique_id",
	".cs.S2C_Outpost_BattleFinish.unique_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_KNIGHTS_F, {
	"knights",
	".cs.S2C_Outpost_BattleFinish.knights",
	4,
	3,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_DROPS_F, {
	"drops",
	".cs.S2C_Outpost_BattleFinish.drops",
	5,
	4,
	3,
	false,
	{},
	var_0_3.OUTPOSTITEM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_NEW_MONSTER_F, {
	"new_monster",
	".cs.S2C_Outpost_BattleFinish.new_monster",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.OUTPOSTMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_X_F, {
	"x",
	".cs.S2C_Outpost_BattleFinish.x",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_Y_F, {
	"y",
	".cs.S2C_Outpost_BattleFinish.y",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_DROPTOKNIGHTS_F, {
	"dropToKnights",
	".cs.S2C_Outpost_BattleFinish.dropToKnights",
	9,
	8,
	3,
	false,
	{},
	var_0_3.OUTPOSTDROPTOKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_LEFT_VIT_F, {
	"left_vit",
	".cs.S2C_Outpost_BattleFinish.left_vit",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_BOSS_BOXES_F, {
	"boss_boxes",
	".cs.S2C_Outpost_BattleFinish.boss_boxes",
	11,
	10,
	3,
	false,
	{},
	var_0_3.OUTPOSTBOSSBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_ME, {
	"S2C_Outpost_BattleFinish",
	".cs.S2C_Outpost_BattleFinish",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BATTLEFINISH_RET_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_MAP_TP_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_UNIQUE_ID_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_KNIGHTS_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_DROPS_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_NEW_MONSTER_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_X_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_Y_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_DROPTOKNIGHTS_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_LEFT_VIT_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_BOSS_BOXES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_LEVELUP_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_Build_LevelUp.build_tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_LEVELUP_ME, {
	"C2S_Outpost_Build_LevelUp",
	".cs.C2S_Outpost_Build_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_LEVELUP_BUILD_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_LevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_LEVELUP_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_Build_LevelUp.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_LEVELUP_BUILD_F, {
	"build",
	".cs.S2C_Outpost_Build_LevelUp.build",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.OUTPOSTBUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_LEVELUP_ME, {
	"S2C_Outpost_Build_LevelUp",
	".cs.S2C_Outpost_Build_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_LEVELUP_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_LEVELUP_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_LEVELUP_BUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_UNLOCK_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_Build_Unlock.build_tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_UNLOCK_ME, {
	"C2S_Outpost_Build_Unlock",
	".cs.C2S_Outpost_Build_Unlock",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_UNLOCK_BUILD_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_UNLOCK_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_Unlock.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_UNLOCK_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_Build_Unlock.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_UNLOCK_BUILD_F, {
	"build",
	".cs.S2C_Outpost_Build_Unlock.build",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.OUTPOSTBUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_UNLOCK_ME, {
	"S2C_Outpost_Build_Unlock",
	".cs.S2C_Outpost_Build_Unlock",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_UNLOCK_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_UNLOCK_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_UNLOCK_BUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_Build_Use.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Outpost_Build_Use.knight_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F, {
	"target_item_id",
	".cs.C2S_Outpost_Build_Use.target_item_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_ME, {
	"C2S_Outpost_Build_Use",
	".cs.C2S_Outpost_Build_Use",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_USE_BUILD_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_USE_KNIGHT_ID_F,
		var_0_10.C2S_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_Use.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_Build_Use.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Outpost_Build_Use.knight_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F, {
	"target_item_id",
	".cs.S2C_Outpost_Build_Use.target_item_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_KNIGHT_F, {
	"knight",
	".cs.S2C_Outpost_Build_Use.knight",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_ME, {
	"S2C_Outpost_Build_Use",
	".cs.S2C_Outpost_Build_Use",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_USE_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_KNIGHT_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_LEAVE_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_Build_Use_Leave.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_LEAVE_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Outpost_Build_Use_Leave.knight_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_LEAVE_ME, {
	"C2S_Outpost_Build_Use_Leave",
	".cs.C2S_Outpost_Build_Use_Leave",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_USE_LEAVE_BUILD_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_USE_LEAVE_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_Use_Leave.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_Build_Use_Leave.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Outpost_Build_Use_Leave.knight_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_KNIGHT_F, {
	"knight",
	".cs.S2C_Outpost_Build_Use_Leave.knight",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_ME, {
	"S2C_Outpost_Build_Use_Leave",
	".cs.S2C_Outpost_Build_Use_Leave",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_KNIGHT_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_LEAVE_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_Build_OrderProcess.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F, {
	"order_tp",
	".cs.C2S_Outpost_Build_OrderProcess.order_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Outpost_Build_OrderProcess.knight_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F, {
	"target_id",
	".cs.C2S_Outpost_Build_OrderProcess.target_id",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F, {
	"target_num",
	".cs.C2S_Outpost_Build_OrderProcess.target_num",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_ME, {
	"C2S_Outpost_Build_OrderProcess",
	".cs.C2S_Outpost_Build_OrderProcess",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_ID_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_OrderProcess.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_Build_OrderProcess.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F, {
	"order_tp",
	".cs.S2C_Outpost_Build_OrderProcess.order_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Outpost_Build_OrderProcess.knight_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F, {
	"target_id",
	".cs.S2C_Outpost_Build_OrderProcess.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F, {
	"target_num",
	".cs.S2C_Outpost_Build_OrderProcess.target_num",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_F, {
	"knight",
	".cs.S2C_Outpost_Build_OrderProcess.knight",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_ME, {
	"S2C_Outpost_Build_OrderProcess",
	".cs.S2C_Outpost_Build_OrderProcess",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_Outpost_Build_CallBoss.boss_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CALLBOSS_ME, {
	"C2S_Outpost_Build_CallBoss",
	".cs.C2S_Outpost_Build_CallBoss",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_CallBoss.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_BOSS_F, {
	"boss",
	".cs.S2C_Outpost_Build_CallBoss.boss",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.OUTPOSTMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_ME, {
	"S2C_Outpost_Build_CallBoss",
	".cs.S2C_Outpost_Build_CallBoss",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_BOSS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_MAP_TP_F, {
	"map_tp",
	".cs.C2S_Outpost_Map_ClickDrop.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_SEQ_F, {
	"seq",
	".cs.C2S_Outpost_Map_ClickDrop.seq",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_X_F, {
	"target_x",
	".cs.C2S_Outpost_Map_ClickDrop.target_x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_Y_F, {
	"target_y",
	".cs.C2S_Outpost_Map_ClickDrop.target_y",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_ME, {
	"C2S_Outpost_Map_ClickDrop",
	".cs.C2S_Outpost_Map_ClickDrop",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_MAP_TP_F,
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_SEQ_F,
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_X_F,
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_RET_F, {
	"ret",
	".cs.S2C_Outpost_Map_ClickDrop.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_MAP_TP_F, {
	"map_tp",
	".cs.S2C_Outpost_Map_ClickDrop.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_SEQ_F, {
	"seq",
	".cs.S2C_Outpost_Map_ClickDrop.seq",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_X_F, {
	"target_x",
	".cs.S2C_Outpost_Map_ClickDrop.target_x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_Y_F, {
	"target_y",
	".cs.S2C_Outpost_Map_ClickDrop.target_y",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_ME, {
	"S2C_Outpost_Map_ClickDrop",
	".cs.S2C_Outpost_Map_ClickDrop",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_RET_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_MAP_TP_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_SEQ_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_X_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_GETTASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Outpost_GetTaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_GETTASKAWARD_TASK_TP_F, {
	"task_tp",
	".cs.C2S_Outpost_GetTaskAward.task_tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_GETTASKAWARD_ME, {
	"C2S_Outpost_GetTaskAward",
	".cs.C2S_Outpost_GetTaskAward",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_GETTASKAWARD_TASK_ID_F,
		var_0_10.C2S_OUTPOST_GETTASKAWARD_TASK_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Outpost_GetTaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Outpost_GetTaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_TASK_TP_F, {
	"task_tp",
	".cs.S2C_Outpost_GetTaskAward.task_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Outpost_GetTaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_ME, {
	"S2C_Outpost_GetTaskAward",
	".cs.S2C_Outpost_GetTaskAward",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_GETTASKAWARD_RET_F,
		var_0_10.S2C_OUTPOST_GETTASKAWARD_TASK_ID_F,
		var_0_10.S2C_OUTPOST_GETTASKAWARD_TASK_TP_F,
		var_0_10.S2C_OUTPOST_GETTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_SYNCTASK_TASK_TYPE_F, {
	"task_type",
	".cs.S2C_Outpost_SyncTask.task_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_SYNCTASK_ACTIONS_F, {
	"actions",
	".cs.S2C_Outpost_SyncTask.actions",
	2,
	1,
	3,
	false,
	{},
	var_0_3.OUTPOSTACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_SYNCTASK_ME, {
	"S2C_Outpost_SyncTask",
	".cs.S2C_Outpost_SyncTask",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_SYNCTASK_TASK_TYPE_F,
		var_0_10.S2C_OUTPOST_SYNCTASK_ACTIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_UNLOCK_MAP_TP_F, {
	"map_tp",
	".cs.C2S_Outpost_Map_Unlock.map_tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_MAP_UNLOCK_ME, {
	"C2S_Outpost_Map_Unlock",
	".cs.C2S_Outpost_Map_Unlock",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_MAP_UNLOCK_MAP_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_UNLOCK_RET_F, {
	"ret",
	".cs.S2C_Outpost_Map_Unlock.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_UNLOCK_MAP_TP_F, {
	"map_tp",
	".cs.S2C_Outpost_Map_Unlock.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_UNLOCK_MAP_F, {
	"map",
	".cs.S2C_Outpost_Map_Unlock.map",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.OUTPOSTMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_MAP_UNLOCK_ME, {
	"S2C_Outpost_Map_Unlock",
	".cs.S2C_Outpost_Map_Unlock",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_MAP_UNLOCK_RET_F,
		var_0_10.S2C_OUTPOST_MAP_UNLOCK_MAP_TP_F,
		var_0_10.S2C_OUTPOST_MAP_UNLOCK_MAP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_ChangeBuildPos.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_POS_X_F, {
	"pos_x",
	".cs.C2S_Outpost_ChangeBuildPos.pos_x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_POS_Y_F, {
	"pos_y",
	".cs.C2S_Outpost_ChangeBuildPos.pos_y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_ME, {
	"C2S_Outpost_ChangeBuildPos",
	".cs.C2S_Outpost_ChangeBuildPos",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_BUILD_TP_F,
		var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_POS_X_F,
		var_0_10.C2S_OUTPOST_CHANGEBUILDPOS_POS_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_RET_F, {
	"ret",
	".cs.S2C_Outpost_ChangeBuildPos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_ChangeBuildPos.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_POS_X_F, {
	"pos_x",
	".cs.S2C_Outpost_ChangeBuildPos.pos_x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_POS_Y_F, {
	"pos_y",
	".cs.S2C_Outpost_ChangeBuildPos.pos_y",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_ME, {
	"S2C_Outpost_ChangeBuildPos",
	".cs.S2C_Outpost_ChangeBuildPos",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_RET_F,
		var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_POS_X_F,
		var_0_10.S2C_OUTPOST_CHANGEBUILDPOS_POS_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_Outpost_Build_ChangeOrder.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_ORDER_ID_F, {
	"order_id",
	".cs.C2S_Outpost_Build_ChangeOrder.order_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_ORDER_NUM_F, {
	"order_num",
	".cs.C2S_Outpost_Build_ChangeOrder.order_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_ME, {
	"C2S_Outpost_Build_ChangeOrder",
	".cs.C2S_Outpost_Build_ChangeOrder",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_BUILD_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_ORDER_ID_F,
		var_0_10.C2S_OUTPOST_BUILD_CHANGEORDER_ORDER_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_RET_F, {
	"ret",
	".cs.S2C_Outpost_Build_ChangeOrder.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_BUILD_TP_F, {
	"build_tp",
	".cs.S2C_Outpost_Build_ChangeOrder.build_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_ORDER_ID_F, {
	"order_id",
	".cs.S2C_Outpost_Build_ChangeOrder.order_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_ORDER_NUM_F, {
	"order_num",
	".cs.S2C_Outpost_Build_ChangeOrder.order_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_ME, {
	"S2C_Outpost_Build_ChangeOrder",
	".cs.S2C_Outpost_Build_ChangeOrder",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_ORDER_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_CHANGEORDER_ORDER_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BOSS_SWEEP_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_Outpost_Boss_Sweep.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BOSS_SWEEP_NUM_F, {
	"num",
	".cs.C2S_Outpost_Boss_Sweep.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BOSS_SWEEP_ME, {
	"C2S_Outpost_Boss_Sweep",
	".cs.C2S_Outpost_Boss_Sweep",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BOSS_SWEEP_BOSS_ID_F,
		var_0_10.C2S_OUTPOST_BOSS_SWEEP_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_RET_F, {
	"ret",
	".cs.S2C_Outpost_Boss_Sweep.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_Outpost_Boss_Sweep.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_NUM_F, {
	"num",
	".cs.S2C_Outpost_Boss_Sweep.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_KNIGHTS_F, {
	"knights",
	".cs.S2C_Outpost_Boss_Sweep.knights",
	4,
	3,
	3,
	false,
	{},
	var_0_3.OUTPOSTKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_AWARDS_F, {
	"awards",
	".cs.S2C_Outpost_Boss_Sweep.awards",
	5,
	4,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_BOX_F, {
	"box",
	".cs.S2C_Outpost_Boss_Sweep.box",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.OUTPOSTBOSSBOX_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BOSS_SWEEP_ME, {
	"S2C_Outpost_Boss_Sweep",
	".cs.S2C_Outpost_Boss_Sweep",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BOSS_SWEEP_RET_F,
		var_0_10.S2C_OUTPOST_BOSS_SWEEP_BOSS_ID_F,
		var_0_10.S2C_OUTPOST_BOSS_SWEEP_NUM_F,
		var_0_10.S2C_OUTPOST_BOSS_SWEEP_KNIGHTS_F,
		var_0_10.S2C_OUTPOST_BOSS_SWEEP_AWARDS_F,
		var_0_10.S2C_OUTPOST_BOSS_SWEEP_BOX_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_ONEKEYCLICKDROP_ME, {
	"C2S_Outpost_OneKeyClickDrop",
	".cs.C2S_Outpost_OneKeyClickDrop",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_ONEKEYCLICKDROP_RET_F, {
	"ret",
	".cs.S2C_Outpost_OneKeyClickDrop.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_ONEKEYCLICKDROP_AWARDS_F, {
	"awards",
	".cs.S2C_Outpost_OneKeyClickDrop.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_ONEKEYCLICKDROP_ME, {
	"S2C_Outpost_OneKeyClickDrop",
	".cs.S2C_Outpost_OneKeyClickDrop",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_ONEKEYCLICKDROP_RET_F,
		var_0_10.S2C_OUTPOST_ONEKEYCLICKDROP_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_GETBOSSBOX_BOX_ID_F, {
	"box_id",
	".cs.C2S_Outpost_GetBossBox.box_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_GETBOSSBOX_AREA_F, {
	"area",
	".cs.C2S_Outpost_GetBossBox.area",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_GETBOSSBOX_ME, {
	"C2S_Outpost_GetBossBox",
	".cs.C2S_Outpost_GetBossBox",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_GETBOSSBOX_BOX_ID_F,
		var_0_10.C2S_OUTPOST_GETBOSSBOX_AREA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETBOSSBOX_RET_F, {
	"ret",
	".cs.S2C_Outpost_GetBossBox.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETBOSSBOX_BOX_ID_F, {
	"box_id",
	".cs.S2C_Outpost_GetBossBox.box_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETBOSSBOX_AREA_F, {
	"area",
	".cs.S2C_Outpost_GetBossBox.area",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETBOSSBOX_AWARDS_F, {
	"awards",
	".cs.S2C_Outpost_GetBossBox.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_GETBOSSBOX_ME, {
	"S2C_Outpost_GetBossBox",
	".cs.S2C_Outpost_GetBossBox",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_GETBOSSBOX_RET_F,
		var_0_10.S2C_OUTPOST_GETBOSSBOX_BOX_ID_F,
		var_0_10.S2C_OUTPOST_GETBOSSBOX_AREA_F,
		var_0_10.S2C_OUTPOST_GETBOSSBOX_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_DELBOSS_ME, {
	"C2S_Outpost_DelBoss",
	".cs.C2S_Outpost_DelBoss",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_DELBOSS_RET_F, {
	"ret",
	".cs.S2C_Outpost_DelBoss.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_DELBOSS_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_Outpost_DelBoss.boss_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_DELBOSS_ME, {
	"S2C_Outpost_DelBoss",
	".cs.S2C_Outpost_DelBoss",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_DELBOSS_RET_F,
		var_0_10.S2C_OUTPOST_DELBOSS_BOSS_ID_F
	},
	false,
	{}
})

return var_0_10
