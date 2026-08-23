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
	C2S_DEADTOWER_ENTERINFO_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_ENTERINFO_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_ENTERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_NEXT_RESET_TIME_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_ZONE_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_NOW_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_CHALLENGE_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_NEXT_RECOVER_TIME_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_CARDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_GRIDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_USER_HP_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_PASS_GRIDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_TASKS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_RESET_NOTICE_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ENTERINFO_PASS_MAX_ZONE_ID_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_CHOOSEGRID_ME = protobuf.Descriptor(),
	C2S_DEADTOWER_CHOOSEGRID_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_CHOOSEGRID_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_CHOOSEGRID_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_CHOOSEGRID_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_BATTLESTART_ME = protobuf.Descriptor(),
	C2S_DEADTOWER_BATTLESTART_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_BATTLESTART_CARDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLESTART_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_BATTLESTART_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLESTART_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLESTART_CARDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLESTART_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_BATTLEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_ZONE_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_BATTLEFINISH_USER_HP_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_GETCARD_ME = protobuf.Descriptor(),
	C2S_DEADTOWER_GETCARD_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_GETCARD_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_GETCARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_GETCARD_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_GETCARD_CARD_ID_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_DEADTOWER_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_TASKUPDATE_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_TASKUPDATE_TASKS_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_NEXTGRIDS_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_NEXTGRIDS_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_NEXTGRIDS_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_NEXTGRIDS_GRIDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_NEXTGRIDS_RESET_HP_NOTICE_F = protobuf.FieldDescriptor(),
	C2S_DEADTOWER_ONEKEYSWEEP_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_ONEKEYSWEEP_ME = protobuf.Descriptor(),
	S2C_DEADTOWER_ONEKEYSWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ONEKEYSWEEP_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ONEKEYSWEEP_CHALLENGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ONEKEYSWEEP_ZONE_ID_F = protobuf.FieldDescriptor(),
	S2C_DEADTOWER_ONEKEYSWEEP_GRID_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_ENTERINFO_ME, {
	"C2S_DeadTower_EnterInfo",
	".cs.C2S_DeadTower_EnterInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_RET_F, {
	"ret",
	".cs.S2C_DeadTower_EnterInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_NEXT_RESET_TIME_F, {
	"next_reset_time",
	".cs.S2C_DeadTower_EnterInfo.next_reset_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_ZONE_ID_F, {
	"zone_id",
	".cs.S2C_DeadTower_EnterInfo.zone_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_NOW_GRID_ID_F, {
	"now_grid_id",
	".cs.S2C_DeadTower_EnterInfo.now_grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_CHALLENGE_NUM_F, {
	"challenge_num",
	".cs.S2C_DeadTower_EnterInfo.challenge_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_CHALLENGE_FLOOR_F, {
	"challenge_floor",
	".cs.S2C_DeadTower_EnterInfo.challenge_floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_NEXT_RECOVER_TIME_F, {
	"next_recover_time",
	".cs.S2C_DeadTower_EnterInfo.next_recover_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_CARDS_F, {
	"cards",
	".cs.S2C_DeadTower_EnterInfo.cards",
	8,
	7,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_GRIDS_F, {
	"grids",
	".cs.S2C_DeadTower_EnterInfo.grids",
	9,
	8,
	3,
	false,
	{},
	var_0_3.DEADTOWERGRID_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_USER_HP_F, {
	"user_hp",
	".cs.S2C_DeadTower_EnterInfo.user_hp",
	10,
	9,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_PASS_GRIDS_F, {
	"pass_grids",
	".cs.S2C_DeadTower_EnterInfo.pass_grids",
	11,
	10,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_TASKS_F, {
	"tasks",
	".cs.S2C_DeadTower_EnterInfo.tasks",
	12,
	11,
	3,
	false,
	{},
	var_0_3.DEADTOWERTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_RESET_NOTICE_F, {
	"reset_notice",
	".cs.S2C_DeadTower_EnterInfo.reset_notice",
	13,
	12,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_PASS_MAX_ZONE_ID_F, {
	"pass_max_zone_id",
	".cs.S2C_DeadTower_EnterInfo.pass_max_zone_id",
	14,
	13,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_ENTERINFO_ME, {
	"S2C_DeadTower_EnterInfo",
	".cs.S2C_DeadTower_EnterInfo",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_ENTERINFO_RET_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_NEXT_RESET_TIME_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_ZONE_ID_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_NOW_GRID_ID_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_CHALLENGE_NUM_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_CHALLENGE_FLOOR_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_NEXT_RECOVER_TIME_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_CARDS_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_GRIDS_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_USER_HP_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_PASS_GRIDS_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_TASKS_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_RESET_NOTICE_F,
		var_0_10.S2C_DEADTOWER_ENTERINFO_PASS_MAX_ZONE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEADTOWER_CHOOSEGRID_GRID_ID_F, {
	"grid_id",
	".cs.C2S_DeadTower_ChooseGrid.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_CHOOSEGRID_ME, {
	"C2S_DeadTower_ChooseGrid",
	".cs.C2S_DeadTower_ChooseGrid",
	{},
	{},
	{
		var_0_10.C2S_DEADTOWER_CHOOSEGRID_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_CHOOSEGRID_RET_F, {
	"ret",
	".cs.S2C_DeadTower_ChooseGrid.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_CHOOSEGRID_GRID_ID_F, {
	"grid_id",
	".cs.S2C_DeadTower_ChooseGrid.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_CHOOSEGRID_ME, {
	"S2C_DeadTower_ChooseGrid",
	".cs.S2C_DeadTower_ChooseGrid",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_CHOOSEGRID_RET_F,
		var_0_10.S2C_DEADTOWER_CHOOSEGRID_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEADTOWER_BATTLESTART_GRID_ID_F, {
	"grid_id",
	".cs.C2S_DeadTower_BattleStart.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEADTOWER_BATTLESTART_CARDS_F, {
	"cards",
	".cs.C2S_DeadTower_BattleStart.cards",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_BATTLESTART_ME, {
	"C2S_DeadTower_BattleStart",
	".cs.C2S_DeadTower_BattleStart",
	{},
	{},
	{
		var_0_10.C2S_DEADTOWER_BATTLESTART_GRID_ID_F,
		var_0_10.C2S_DEADTOWER_BATTLESTART_CARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLESTART_RET_F, {
	"ret",
	".cs.S2C_DeadTower_BattleStart.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLESTART_GRID_ID_F, {
	"grid_id",
	".cs.S2C_DeadTower_BattleStart.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLESTART_CARDS_F, {
	"cards",
	".cs.S2C_DeadTower_BattleStart.cards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLESTART_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_DeadTower_BattleStart.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_BATTLESTART_ME, {
	"S2C_DeadTower_BattleStart",
	".cs.S2C_DeadTower_BattleStart",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_BATTLESTART_RET_F,
		var_0_10.S2C_DEADTOWER_BATTLESTART_GRID_ID_F,
		var_0_10.S2C_DEADTOWER_BATTLESTART_CARDS_F,
		var_0_10.S2C_DEADTOWER_BATTLESTART_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_RET_F, {
	"ret",
	".cs.S2C_DeadTower_BattleFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_ZONE_ID_F, {
	"zone_id",
	".cs.S2C_DeadTower_BattleFinish.zone_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_DeadTower_BattleFinish.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_DeadTower_BattleFinish.is_win",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_CHALLENGE_NUM_F, {
	"challenge_num",
	".cs.S2C_DeadTower_BattleFinish.challenge_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_DeadTower_BattleFinish.awards",
	6,
	5,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_USER_HP_F, {
	"user_hp",
	".cs.S2C_DeadTower_BattleFinish.user_hp",
	7,
	6,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_BATTLEFINISH_ME, {
	"S2C_DeadTower_BattleFinish",
	".cs.S2C_DeadTower_BattleFinish",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_RET_F,
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_ZONE_ID_F,
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_GRID_ID_F,
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_IS_WIN_F,
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_CHALLENGE_NUM_F,
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_AWARDS_F,
		var_0_10.S2C_DEADTOWER_BATTLEFINISH_USER_HP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEADTOWER_GETCARD_GRID_ID_F, {
	"grid_id",
	".cs.C2S_DeadTower_GetCard.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_GETCARD_ME, {
	"C2S_DeadTower_GetCard",
	".cs.C2S_DeadTower_GetCard",
	{},
	{},
	{
		var_0_10.C2S_DEADTOWER_GETCARD_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_GETCARD_RET_F, {
	"ret",
	".cs.S2C_DeadTower_GetCard.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_GETCARD_GRID_ID_F, {
	"grid_id",
	".cs.S2C_DeadTower_GetCard.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_GETCARD_CARD_ID_F, {
	"card_id",
	".cs.S2C_DeadTower_GetCard.card_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_GETCARD_ME, {
	"S2C_DeadTower_GetCard",
	".cs.S2C_DeadTower_GetCard",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_GETCARD_RET_F,
		var_0_10.S2C_DEADTOWER_GETCARD_GRID_ID_F,
		var_0_10.S2C_DEADTOWER_GETCARD_CARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_DEADTOWER_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_DeadTower_TaskAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_TASKAWARD_ME, {
	"C2S_DeadTower_TaskAward",
	".cs.C2S_DeadTower_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_DEADTOWER_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_DeadTower_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_DeadTower_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_DeadTower_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_TASKAWARD_ME, {
	"S2C_DeadTower_TaskAward",
	".cs.S2C_DeadTower_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_TASKAWARD_RET_F,
		var_0_10.S2C_DEADTOWER_TASKAWARD_IDS_F,
		var_0_10.S2C_DEADTOWER_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_TASKUPDATE_TASKS_F, {
	"tasks",
	".cs.S2C_DeadTower_TaskUpdate.tasks",
	1,
	0,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_TASKUPDATE_ME, {
	"S2C_DeadTower_TaskUpdate",
	".cs.S2C_DeadTower_TaskUpdate",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_TASKUPDATE_TASKS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_NEXTGRIDS_ME, {
	"C2S_DeadTower_NextGrids",
	".cs.C2S_DeadTower_NextGrids",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_NEXTGRIDS_RET_F, {
	"ret",
	".cs.S2C_DeadTower_NextGrids.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_NEXTGRIDS_GRIDS_F, {
	"grids",
	".cs.S2C_DeadTower_NextGrids.grids",
	2,
	1,
	3,
	false,
	{},
	var_0_3.DEADTOWERGRID_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_NEXTGRIDS_RESET_HP_NOTICE_F, {
	"reset_hp_notice",
	".cs.S2C_DeadTower_NextGrids.reset_hp_notice",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_NEXTGRIDS_ME, {
	"S2C_DeadTower_NextGrids",
	".cs.S2C_DeadTower_NextGrids",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_NEXTGRIDS_RET_F,
		var_0_10.S2C_DEADTOWER_NEXTGRIDS_GRIDS_F,
		var_0_10.S2C_DEADTOWER_NEXTGRIDS_RESET_HP_NOTICE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_DEADTOWER_ONEKEYSWEEP_ME, {
	"C2S_DeadTower_OneKeySweep",
	".cs.C2S_DeadTower_OneKeySweep",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_RET_F, {
	"ret",
	".cs.S2C_DeadTower_OneKeySweep.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_AWARDS_F, {
	"awards",
	".cs.S2C_DeadTower_OneKeySweep.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_CHALLENGE_NUM_F, {
	"challenge_num",
	".cs.S2C_DeadTower_OneKeySweep.challenge_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_ZONE_ID_F, {
	"zone_id",
	".cs.S2C_DeadTower_OneKeySweep.zone_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_GRID_ID_F, {
	"grid_id",
	".cs.S2C_DeadTower_OneKeySweep.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_ME, {
	"S2C_DeadTower_OneKeySweep",
	".cs.S2C_DeadTower_OneKeySweep",
	{},
	{},
	{
		var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_RET_F,
		var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_AWARDS_F,
		var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_CHALLENGE_NUM_F,
		var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_ZONE_ID_F,
		var_0_10.S2C_DEADTOWER_ONEKEYSWEEP_GRID_ID_F
	},
	false,
	{}
})

return var_0_10
