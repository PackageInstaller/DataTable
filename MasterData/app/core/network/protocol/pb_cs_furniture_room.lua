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
	C2S_FURNITUREROOM_GETINFO_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_GETINFO_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETINFO_FURNITURE_ROOM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETINFO_FRIEND_SWEEP_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETINFO_WEEK_CHARM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETINFO_FRIEND_SWEEP_SNAP_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETINFO_SUM_CHARM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETINFO_RECORDS_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_PLACE_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_PLACE_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_PLACE_ADD_FURNITURE_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_PLACE_DEL_FURNITURE_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PLACE_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_PLACE_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PLACE_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PLACE_ADD_FURNITURE_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PLACE_DEL_FURNITURE_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_FRIENDGETINFO_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_FRIENDGETINFO_FRIEND_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_FRIEND_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_FURNITURE_ROOM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_WEEK_CHARM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_SUM_CHARM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_PRAISE_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FRIENDGETINFO_FRIEND_SWEEP_SNAP_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_PLACEKNIGHT_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_PLACEKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PLACEKNIGHT_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_PLACEKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PLACEKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_UPGRADE_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_UPGRADE_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_UPGRADE_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_UPGRADE_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_UPGRADE_ROOM_LV_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_BATH_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_BATH_ROOM_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_BATH_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_BATH_BATHTBU_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_BATH_X_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_BATH_Y_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_BATH_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_BATH_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_BATHTUB_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_X_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_Y_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_BATH_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_SWEEP_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_SWEEP_FRIEND_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_SWEEP_NUM_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_SWEEP_CHARM_NUM_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_SWEEP_COMFORT_MAX_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_SWEEP_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_SWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_SWEEP_FRIEND_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_SWEEP_NUM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_SWEEP_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_SWEEP_CHARM_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_FURNISHINGNUMRANK_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_FURNISHINGNUMRANK_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_FURNISHINGNUMRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FURNISHINGNUMRANK_RANK_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_FURNISHINGNUMRANK_SUM_PERSON_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_PRAISE_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_PRAISE_FRIEND_ID_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_PRAISE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PRAISE_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_PRAISE_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PRAISE_FRIEND_ID_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PRAISE_NUM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PRAISE_WEEK_CHARM_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_PRAISE_SUM_CHARM_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_GETPRAISEUSER_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_GETPRAISEUSER_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_GETPRAISEUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_GETPRAISEUSER_USER_PRAISE_TIMES_F = protobuf.FieldDescriptor(),
	C2S_FURNITUREROOM_ONEKEYSWEEP_ME = protobuf.Descriptor(),
	C2S_FURNITUREROOM_ONEKEYSWEEP_FRIEND_IDS_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_ONEKEYSWEEP_ME = protobuf.Descriptor(),
	S2C_FURNITUREROOM_ONEKEYSWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_ONEKEYSWEEP_FRIEND_CHARMS_F = protobuf.FieldDescriptor(),
	S2C_FURNITUREROOM_ONEKEYSWEEP_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_GETINFO_ME, {
	"C2S_FurnitureRoom_GetInfo",
	".cs.C2S_FurnitureRoom_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_FURNITURE_ROOM_F, {
	"furniture_room",
	".cs.S2C_FurnitureRoom_GetInfo.furniture_room",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FURNITUREROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_FRIEND_SWEEP_F, {
	"friend_sweep",
	".cs.S2C_FurnitureRoom_GetInfo.friend_sweep",
	3,
	2,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_WEEK_CHARM_F, {
	"week_charm",
	".cs.S2C_FurnitureRoom_GetInfo.week_charm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_FRIEND_SWEEP_SNAP_F, {
	"friend_sweep_snap",
	".cs.S2C_FurnitureRoom_GetInfo.friend_sweep_snap",
	5,
	4,
	3,
	false,
	{},
	var_0_3.FRIENDFURNITUREROOMSWEEP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_SUM_CHARM_F, {
	"sum_charm",
	".cs.S2C_FurnitureRoom_GetInfo.sum_charm",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_RECORDS_F, {
	"records",
	".cs.S2C_FurnitureRoom_GetInfo.records",
	7,
	6,
	3,
	false,
	{},
	var_0_3.FURNITUREROOMRECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_GETINFO_ME, {
	"S2C_FurnitureRoom_GetInfo",
	".cs.S2C_FurnitureRoom_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_GETINFO_RET_F,
		var_0_10.S2C_FURNITUREROOM_GETINFO_FURNITURE_ROOM_F,
		var_0_10.S2C_FURNITUREROOM_GETINFO_FRIEND_SWEEP_F,
		var_0_10.S2C_FURNITUREROOM_GETINFO_WEEK_CHARM_F,
		var_0_10.S2C_FURNITUREROOM_GETINFO_FRIEND_SWEEP_SNAP_F,
		var_0_10.S2C_FURNITUREROOM_GETINFO_SUM_CHARM_F,
		var_0_10.S2C_FURNITUREROOM_GETINFO_RECORDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_PLACE_ROOM_ID_F, {
	"room_id",
	".cs.C2S_FurnitureRoom_Place.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_PLACE_ADD_FURNITURE_F, {
	"add_furniture",
	".cs.C2S_FurnitureRoom_Place.add_furniture",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FURNITURE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_PLACE_DEL_FURNITURE_F, {
	"del_furniture",
	".cs.C2S_FurnitureRoom_Place.del_furniture",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FURNITURE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_PLACE_ME, {
	"C2S_FurnitureRoom_Place",
	".cs.C2S_FurnitureRoom_Place",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_PLACE_ROOM_ID_F,
		var_0_10.C2S_FURNITUREROOM_PLACE_ADD_FURNITURE_F,
		var_0_10.C2S_FURNITUREROOM_PLACE_DEL_FURNITURE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACE_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_Place.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACE_ROOM_ID_F, {
	"room_id",
	".cs.S2C_FurnitureRoom_Place.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACE_ADD_FURNITURE_F, {
	"add_furniture",
	".cs.S2C_FurnitureRoom_Place.add_furniture",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FURNITURE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACE_DEL_FURNITURE_F, {
	"del_furniture",
	".cs.S2C_FurnitureRoom_Place.del_furniture",
	4,
	3,
	3,
	false,
	{},
	var_0_3.FURNITURE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACE_ME, {
	"S2C_FurnitureRoom_Place",
	".cs.S2C_FurnitureRoom_Place",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_PLACE_RET_F,
		var_0_10.S2C_FURNITUREROOM_PLACE_ROOM_ID_F,
		var_0_10.S2C_FURNITUREROOM_PLACE_ADD_FURNITURE_F,
		var_0_10.S2C_FURNITUREROOM_PLACE_DEL_FURNITURE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_FRIENDGETINFO_FRIEND_ID_F, {
	"friend_id",
	".cs.C2S_FurnitureRoom_FriendGetInfo.friend_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_FRIENDGETINFO_ME, {
	"C2S_FurnitureRoom_FriendGetInfo",
	".cs.C2S_FurnitureRoom_FriendGetInfo",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_FRIENDGETINFO_FRIEND_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_FriendGetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_FRIEND_ID_F, {
	"friend_id",
	".cs.S2C_FurnitureRoom_FriendGetInfo.friend_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_FURNITURE_ROOM_F, {
	"furniture_room",
	".cs.S2C_FurnitureRoom_FriendGetInfo.furniture_room",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FURNITUREROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_WEEK_CHARM_F, {
	"week_charm",
	".cs.S2C_FurnitureRoom_FriendGetInfo.week_charm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_SUM_CHARM_F, {
	"sum_charm",
	".cs.S2C_FurnitureRoom_FriendGetInfo.sum_charm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_PRAISE_F, {
	"praise",
	".cs.S2C_FurnitureRoom_FriendGetInfo.praise",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_FRIEND_SWEEP_SNAP_F, {
	"friend_sweep_snap",
	".cs.S2C_FurnitureRoom_FriendGetInfo.friend_sweep_snap",
	7,
	6,
	3,
	false,
	{},
	var_0_3.FRIENDFURNITUREROOMSWEEP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_ME, {
	"S2C_FurnitureRoom_FriendGetInfo",
	".cs.S2C_FurnitureRoom_FriendGetInfo",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_RET_F,
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_FRIEND_ID_F,
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_FURNITURE_ROOM_F,
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_WEEK_CHARM_F,
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_SUM_CHARM_F,
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_PRAISE_F,
		var_0_10.S2C_FURNITUREROOM_FRIENDGETINFO_FRIEND_SWEEP_SNAP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_PLACEKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_FurnitureRoom_PlaceKnight.knight_id",
	1,
	0,
	3,
	false,
	{},
	var_0_3.FURNITUREROOMKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_PLACEKNIGHT_ME, {
	"C2S_FurnitureRoom_PlaceKnight",
	".cs.C2S_FurnitureRoom_PlaceKnight",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_PLACEKNIGHT_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACEKNIGHT_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_PlaceKnight.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACEKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_FurnitureRoom_PlaceKnight.knight_id",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FURNITUREROOMKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_PLACEKNIGHT_ME, {
	"S2C_FurnitureRoom_PlaceKnight",
	".cs.S2C_FurnitureRoom_PlaceKnight",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_PLACEKNIGHT_RET_F,
		var_0_10.S2C_FURNITUREROOM_PLACEKNIGHT_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_UPGRADE_ROOM_ID_F, {
	"room_id",
	".cs.C2S_FurnitureRoom_Upgrade.room_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_UPGRADE_ME, {
	"C2S_FurnitureRoom_Upgrade",
	".cs.C2S_FurnitureRoom_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_UPGRADE_ROOM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_UPGRADE_ROOM_ID_F, {
	"room_id",
	".cs.S2C_FurnitureRoom_Upgrade.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_UPGRADE_ROOM_LV_F, {
	"room_lv",
	".cs.S2C_FurnitureRoom_Upgrade.room_lv",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_UPGRADE_ME, {
	"S2C_FurnitureRoom_Upgrade",
	".cs.S2C_FurnitureRoom_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_UPGRADE_RET_F,
		var_0_10.S2C_FURNITUREROOM_UPGRADE_ROOM_ID_F,
		var_0_10.S2C_FURNITUREROOM_UPGRADE_ROOM_LV_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_ROOM_ID_F, {
	"room_id",
	".cs.C2S_FurnitureRoom_Bath.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_FurnitureRoom_Bath.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_BATHTBU_ID_F, {
	"bathtbu_id",
	".cs.C2S_FurnitureRoom_Bath.bathtbu_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_X_F, {
	"x",
	".cs.C2S_FurnitureRoom_Bath.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_Y_F, {
	"y",
	".cs.C2S_FurnitureRoom_Bath.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_LEVEL_F, {
	"level",
	".cs.C2S_FurnitureRoom_Bath.level",
	6,
	5,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_BATH_ME, {
	"C2S_FurnitureRoom_Bath",
	".cs.C2S_FurnitureRoom_Bath",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_BATH_ROOM_ID_F,
		var_0_10.C2S_FURNITUREROOM_BATH_KNIGHT_ID_F,
		var_0_10.C2S_FURNITUREROOM_BATH_BATHTBU_ID_F,
		var_0_10.C2S_FURNITUREROOM_BATH_X_F,
		var_0_10.C2S_FURNITUREROOM_BATH_Y_F,
		var_0_10.C2S_FURNITUREROOM_BATH_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_Bath.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_ROOM_ID_F, {
	"room_id",
	".cs.S2C_FurnitureRoom_Bath.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_FurnitureRoom_Bath.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_BATHTUB_F, {
	"bathtub",
	".cs.S2C_FurnitureRoom_Bath.bathtub",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.FURNITURE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_X_F, {
	"x",
	".cs.S2C_FurnitureRoom_Bath.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_Y_F, {
	"y",
	".cs.S2C_FurnitureRoom_Bath.y",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_LEVEL_F, {
	"level",
	".cs.S2C_FurnitureRoom_Bath.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_BATH_ME, {
	"S2C_FurnitureRoom_Bath",
	".cs.S2C_FurnitureRoom_Bath",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_BATH_RET_F,
		var_0_10.S2C_FURNITUREROOM_BATH_ROOM_ID_F,
		var_0_10.S2C_FURNITUREROOM_BATH_KNIGHT_ID_F,
		var_0_10.S2C_FURNITUREROOM_BATH_BATHTUB_F,
		var_0_10.S2C_FURNITUREROOM_BATH_X_F,
		var_0_10.S2C_FURNITUREROOM_BATH_Y_F,
		var_0_10.S2C_FURNITUREROOM_BATH_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_SWEEP_FRIEND_ID_F, {
	"friend_id",
	".cs.C2S_FurnitureRoom_Sweep.friend_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_SWEEP_NUM_F, {
	"num",
	".cs.C2S_FurnitureRoom_Sweep.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_SWEEP_CHARM_NUM_F, {
	"charm_num",
	".cs.C2S_FurnitureRoom_Sweep.charm_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_SWEEP_COMFORT_MAX_F, {
	"comfort_max",
	".cs.C2S_FurnitureRoom_Sweep.comfort_max",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_SWEEP_ME, {
	"C2S_FurnitureRoom_Sweep",
	".cs.C2S_FurnitureRoom_Sweep",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_SWEEP_FRIEND_ID_F,
		var_0_10.C2S_FURNITUREROOM_SWEEP_NUM_F,
		var_0_10.C2S_FURNITUREROOM_SWEEP_CHARM_NUM_F,
		var_0_10.C2S_FURNITUREROOM_SWEEP_COMFORT_MAX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_SWEEP_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_Sweep.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_SWEEP_FRIEND_ID_F, {
	"friend_id",
	".cs.S2C_FurnitureRoom_Sweep.friend_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_SWEEP_NUM_F, {
	"num",
	".cs.S2C_FurnitureRoom_Sweep.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_SWEEP_AWARDS_F, {
	"awards",
	".cs.S2C_FurnitureRoom_Sweep.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_SWEEP_CHARM_F, {
	"charm",
	".cs.S2C_FurnitureRoom_Sweep.charm",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_SWEEP_ME, {
	"S2C_FurnitureRoom_Sweep",
	".cs.S2C_FurnitureRoom_Sweep",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_SWEEP_RET_F,
		var_0_10.S2C_FURNITUREROOM_SWEEP_FRIEND_ID_F,
		var_0_10.S2C_FURNITUREROOM_SWEEP_NUM_F,
		var_0_10.S2C_FURNITUREROOM_SWEEP_AWARDS_F,
		var_0_10.S2C_FURNITUREROOM_SWEEP_CHARM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_FURNISHINGNUMRANK_ME, {
	"C2S_FurnitureRoom_FurnishingNumRank",
	".cs.C2S_FurnitureRoom_FurnishingNumRank",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_FurnishingNumRank.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_RANK_F, {
	"rank",
	".cs.S2C_FurnitureRoom_FurnishingNumRank.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_SUM_PERSON_F, {
	"sum_person",
	".cs.S2C_FurnitureRoom_FurnishingNumRank.sum_person",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_ME, {
	"S2C_FurnitureRoom_FurnishingNumRank",
	".cs.S2C_FurnitureRoom_FurnishingNumRank",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_RET_F,
		var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_RANK_F,
		var_0_10.S2C_FURNITUREROOM_FURNISHINGNUMRANK_SUM_PERSON_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_PRAISE_FRIEND_ID_F, {
	"friend_id",
	".cs.C2S_FurnitureRoom_Praise.friend_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_PRAISE_NUM_F, {
	"num",
	".cs.C2S_FurnitureRoom_Praise.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_PRAISE_ME, {
	"C2S_FurnitureRoom_Praise",
	".cs.C2S_FurnitureRoom_Praise",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_PRAISE_FRIEND_ID_F,
		var_0_10.C2S_FURNITUREROOM_PRAISE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PRAISE_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_Praise.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PRAISE_FRIEND_ID_F, {
	"friend_id",
	".cs.S2C_FurnitureRoom_Praise.friend_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PRAISE_NUM_F, {
	"num",
	".cs.S2C_FurnitureRoom_Praise.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PRAISE_WEEK_CHARM_F, {
	"week_charm",
	".cs.S2C_FurnitureRoom_Praise.week_charm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_PRAISE_SUM_CHARM_F, {
	"sum_charm",
	".cs.S2C_FurnitureRoom_Praise.sum_charm",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_PRAISE_ME, {
	"S2C_FurnitureRoom_Praise",
	".cs.S2C_FurnitureRoom_Praise",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_PRAISE_RET_F,
		var_0_10.S2C_FURNITUREROOM_PRAISE_FRIEND_ID_F,
		var_0_10.S2C_FURNITUREROOM_PRAISE_NUM_F,
		var_0_10.S2C_FURNITUREROOM_PRAISE_WEEK_CHARM_F,
		var_0_10.S2C_FURNITUREROOM_PRAISE_SUM_CHARM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_GETPRAISEUSER_ME, {
	"C2S_FurnitureRoom_GetPraiseUser",
	".cs.C2S_FurnitureRoom_GetPraiseUser",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETPRAISEUSER_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_GetPraiseUser.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_GETPRAISEUSER_USER_PRAISE_TIMES_F, {
	"user_praise_times",
	".cs.S2C_FurnitureRoom_GetPraiseUser.user_praise_times",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_GETPRAISEUSER_ME, {
	"S2C_FurnitureRoom_GetPraiseUser",
	".cs.S2C_FurnitureRoom_GetPraiseUser",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_GETPRAISEUSER_RET_F,
		var_0_10.S2C_FURNITUREROOM_GETPRAISEUSER_USER_PRAISE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FURNITUREROOM_ONEKEYSWEEP_FRIEND_IDS_F, {
	"friend_ids",
	".cs.C2S_FurnitureRoom_OneKeySweep.friend_ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FURNITUREROOM_ONEKEYSWEEP_ME, {
	"C2S_FurnitureRoom_OneKeySweep",
	".cs.C2S_FurnitureRoom_OneKeySweep",
	{},
	{},
	{
		var_0_10.C2S_FURNITUREROOM_ONEKEYSWEEP_FRIEND_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_RET_F, {
	"ret",
	".cs.S2C_FurnitureRoom_OneKeySweep.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_FRIEND_CHARMS_F, {
	"friend_charms",
	".cs.S2C_FurnitureRoom_OneKeySweep.friend_charms",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_AWARDS_F, {
	"awards",
	".cs.S2C_FurnitureRoom_OneKeySweep.awards",
	4,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_ME, {
	"S2C_FurnitureRoom_OneKeySweep",
	".cs.S2C_FurnitureRoom_OneKeySweep",
	{},
	{},
	{
		var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_RET_F,
		var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_FRIEND_CHARMS_F,
		var_0_10.S2C_FURNITUREROOM_ONEKEYSWEEP_AWARDS_F
	},
	false,
	{}
})

return var_0_10
