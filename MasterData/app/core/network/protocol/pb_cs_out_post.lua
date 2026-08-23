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
	C2S_OUTPOST_USEVIT_ME = protobuf.Descriptor(),
	C2S_OUTPOST_USEVIT_USE_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_USEVIT_ME = protobuf.Descriptor(),
	S2C_OUTPOST_USEVIT_RET_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_DONATEKNIGHT_ME = protobuf.Descriptor(),
	C2S_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_DONATEKNIGHT_COIN_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_DONATEKNIGHT_ME = protobuf.Descriptor(),
	S2C_OUTPOST_DONATEKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_DONATEKNIGHT_COIN_NUM_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BATTLEFINISH_MAP_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BATTLEFINISH_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BATTLEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_DROPS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BATTLEFINISH_NEW_MONSTER_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_LEVELUP_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_LEVELUP_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_LEVELUP_BUILD_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_USE_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_USE_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_BUILD_CALLBOSS_ME = protobuf.Descriptor(),
	C2S_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CALLBOSS_ME = protobuf.Descriptor(),
	S2C_OUTPOST_BUILD_CALLBOSS_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_ME = protobuf.Descriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_MAP_TP_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_TARGET_X_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_MAP_CLICKDROP_TARGET_Y_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_ME = protobuf.Descriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_MAP_TP_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_TARGET_X_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_MAP_CLICKDROP_TARGET_Y_F = protobuf.FieldDescriptor(),
	C2S_OUTPOST_GETTASKAWARD_ME = protobuf.Descriptor(),
	C2S_OUTPOST_GETTASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_ME = protobuf.Descriptor(),
	S2C_OUTPOST_GETTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_GETTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_OUTPOST_SYNCTASK_ME = protobuf.Descriptor(),
	S2C_OUTPOST_SYNCTASK_TASKS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_GETINFO_ME, {
	"C2S_OutPost_GetInfo",
	".cs.C2S_OutPost_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETINFO_RET_F, {
	"ret",
	".cs.S2C_OutPost_GetInfo.ret",
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
	".cs.S2C_OutPost_GetInfo.data",
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
	"S2C_OutPost_GetInfo",
	".cs.S2C_OutPost_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_GETINFO_RET_F,
		var_0_10.S2C_OUTPOST_GETINFO_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_USEVIT_USE_NUM_F, {
	"use_num",
	".cs.C2S_OutPost_UseVit.use_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_USEVIT_ME, {
	"C2S_OutPost_UseVit",
	".cs.C2S_OutPost_UseVit",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_USEVIT_USE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_USEVIT_RET_F, {
	"ret",
	".cs.S2C_OutPost_UseVit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_USEVIT_ME, {
	"S2C_OutPost_UseVit",
	".cs.S2C_OutPost_UseVit",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_USEVIT_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_OutPost_DonateKnight.knight_id",
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
	".cs.C2S_OutPost_DonateKnight.coin_num",
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
	"C2S_OutPost_DonateKnight",
	".cs.C2S_OutPost_DonateKnight",
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
	".cs.S2C_OutPost_DonateKnight.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_OutPost_DonateKnight.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_DONATEKNIGHT_COIN_NUM_F, {
	"coin_num",
	".cs.S2C_OutPost_DonateKnight.coin_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_DONATEKNIGHT_ME, {
	"S2C_OutPost_DonateKnight",
	".cs.S2C_OutPost_DonateKnight",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_DONATEKNIGHT_RET_F,
		var_0_10.S2C_OUTPOST_DONATEKNIGHT_KNIGHT_ID_F,
		var_0_10.S2C_OUTPOST_DONATEKNIGHT_COIN_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_MAP_TP_F, {
	"map_tp",
	".cs.C2S_OutPost_BattleFinish.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_OutPost_BattleFinish.monster_id",
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
	".cs.C2S_OutPost_BattleFinish.knights",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BATTLEFINISH_ME, {
	"C2S_OutPost_BattleFinish",
	".cs.C2S_OutPost_BattleFinish",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BATTLEFINISH_MAP_TP_F,
		var_0_10.C2S_OUTPOST_BATTLEFINISH_MONSTER_ID_F,
		var_0_10.C2S_OUTPOST_BATTLEFINISH_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_RET_F, {
	"ret",
	".cs.S2C_OutPost_BattleFinish.ret",
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
	".cs.S2C_OutPost_BattleFinish.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_OutPost_BattleFinish.monster_id",
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
	".cs.S2C_OutPost_BattleFinish.knights",
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
	".cs.S2C_OutPost_BattleFinish.drops",
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
	".cs.S2C_OutPost_BattleFinish.new_monster",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BATTLEFINISH_ME, {
	"S2C_OutPost_BattleFinish",
	".cs.S2C_OutPost_BattleFinish",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BATTLEFINISH_RET_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_MAP_TP_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_MONSTER_ID_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_KNIGHTS_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_DROPS_F,
		var_0_10.S2C_OUTPOST_BATTLEFINISH_NEW_MONSTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_LEVELUP_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_OutPost_Build_LevelUp.build_tp",
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
	"C2S_OutPost_Build_LevelUp",
	".cs.C2S_OutPost_Build_LevelUp",
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
	".cs.S2C_OutPost_Build_LevelUp.ret",
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
	".cs.S2C_OutPost_Build_LevelUp.build_tp",
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
	".cs.S2C_OutPost_Build_LevelUp.build",
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
	"S2C_OutPost_Build_LevelUp",
	".cs.S2C_OutPost_Build_LevelUp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_USE_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_OutPost_Build_Use.build_tp",
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
	".cs.C2S_OutPost_Build_Use.knight_id",
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
	".cs.C2S_OutPost_Build_Use.target_item_id",
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
	"C2S_OutPost_Build_Use",
	".cs.C2S_OutPost_Build_Use",
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
	".cs.S2C_OutPost_Build_Use.ret",
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
	".cs.S2C_OutPost_Build_Use.build_tp",
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
	".cs.S2C_OutPost_Build_Use.knight_id",
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
	".cs.S2C_OutPost_Build_Use.target_item_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_USE_ME, {
	"S2C_OutPost_Build_Use",
	".cs.S2C_OutPost_Build_Use",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_USE_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_KNIGHT_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_USE_TARGET_ITEM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F, {
	"build_tp",
	".cs.C2S_OutPost_Build_OrderProcess.build_tp",
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
	".cs.C2S_OutPost_Build_OrderProcess.order_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F, {
	"target_id",
	".cs.C2S_OutPost_Build_OrderProcess.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F, {
	"target_num",
	".cs.C2S_OutPost_Build_OrderProcess.target_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_ME, {
	"C2S_OutPost_Build_OrderProcess",
	".cs.C2S_OutPost_Build_OrderProcess",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F,
		var_0_10.C2S_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_RET_F, {
	"ret",
	".cs.S2C_OutPost_Build_OrderProcess.ret",
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
	".cs.S2C_OutPost_Build_OrderProcess.build_tp",
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
	".cs.S2C_OutPost_Build_OrderProcess.order_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F, {
	"target_id",
	".cs.S2C_OutPost_Build_OrderProcess.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F, {
	"target_num",
	".cs.S2C_OutPost_Build_OrderProcess.target_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_ME, {
	"S2C_OutPost_Build_OrderProcess",
	".cs.S2C_OutPost_Build_OrderProcess",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_BUILD_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_ORDER_TP_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_ID_F,
		var_0_10.S2C_OUTPOST_BUILD_ORDERPROCESS_TARGET_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_OutPost_Build_CallBoss.boss_id",
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
	"C2S_OutPost_Build_CallBoss",
	".cs.C2S_OutPost_Build_CallBoss",
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
	".cs.S2C_OutPost_Build_CallBoss.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_OutPost_Build_CallBoss.boss_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_ME, {
	"S2C_OutPost_Build_CallBoss",
	".cs.S2C_OutPost_Build_CallBoss",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_RET_F,
		var_0_10.S2C_OUTPOST_BUILD_CALLBOSS_BOSS_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_MAP_TP_F, {
	"map_tp",
	".cs.C2S_OutPost_Map_ClickDrop.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_ID_F, {
	"target_id",
	".cs.C2S_OutPost_Map_ClickDrop.target_id",
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
	".cs.C2S_OutPost_Map_ClickDrop.target_x",
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
	".cs.C2S_OutPost_Map_ClickDrop.target_y",
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
	"C2S_OutPost_Map_ClickDrop",
	".cs.C2S_OutPost_Map_ClickDrop",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_MAP_TP_F,
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_ID_F,
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_X_F,
		var_0_10.C2S_OUTPOST_MAP_CLICKDROP_TARGET_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_RET_F, {
	"ret",
	".cs.S2C_OutPost_Map_ClickDrop.ret",
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
	".cs.S2C_OutPost_Map_ClickDrop.map_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_ID_F, {
	"target_id",
	".cs.S2C_OutPost_Map_ClickDrop.target_id",
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
	".cs.S2C_OutPost_Map_ClickDrop.target_x",
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
	".cs.S2C_OutPost_Map_ClickDrop.target_y",
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
	"S2C_OutPost_Map_ClickDrop",
	".cs.S2C_OutPost_Map_ClickDrop",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_RET_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_MAP_TP_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_ID_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_X_F,
		var_0_10.S2C_OUTPOST_MAP_CLICKDROP_TARGET_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_OUTPOST_GETTASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_OutPost_GetTaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_OUTPOST_GETTASKAWARD_ME, {
	"C2S_OutPost_GetTaskAward",
	".cs.C2S_OutPost_GetTaskAward",
	{},
	{},
	{
		var_0_10.C2S_OUTPOST_GETTASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_OutPost_GetTaskAward.ret",
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
	".cs.S2C_OutPost_GetTaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_OutPost_GetTaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_GETTASKAWARD_ME, {
	"S2C_OutPost_GetTaskAward",
	".cs.S2C_OutPost_GetTaskAward",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_GETTASKAWARD_RET_F,
		var_0_10.S2C_OUTPOST_GETTASKAWARD_TASK_ID_F,
		var_0_10.S2C_OUTPOST_GETTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OUTPOST_SYNCTASK_TASKS_F, {
	"tasks",
	".cs.S2C_OutPost_SyncTask.tasks",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OUTPOST_SYNCTASK_ME, {
	"S2C_OutPost_SyncTask",
	".cs.S2C_OutPost_SyncTask",
	{},
	{},
	{
		var_0_10.S2C_OUTPOST_SYNCTASK_TASKS_F
	},
	false,
	{}
})

return var_0_10
