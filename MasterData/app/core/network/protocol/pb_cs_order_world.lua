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
	C2S_ORDERWORLD_INFO_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_INFO_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_GUILD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_GUILD_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_GUILD_LEVEL_AWARD_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_TASK_LIST_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_RECORDS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_BUYS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_GUILD_MARS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_SERVER_MARS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_SELF_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_INFO_JOIN_GUILD_TIME_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_DONATE_ME = protobuf.Descriptor(),
	C2S_ORDERWORLD_DONATE_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_DONATE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_DONATE_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_GUILD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_GUILD_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_SELF_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_DONATE_GUILD_LEVEL_AWARD_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_OPTABUSER_ME = protobuf.Descriptor(),
	C2S_ORDERWORLD_OPTABUSER_OP_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_OPTABUSER_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_OPTABUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_OPTABUSER_OP_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_GUILDLEVELAWARD_ME = protobuf.Descriptor(),
	C2S_ORDERWORLD_GUILDLEVELAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GUILDLEVELAWARD_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_GUILDLEVELAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GUILDLEVELAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GUILDLEVELAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_RECORD_BROADCAST_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_RECORD_BROADCAST_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_RECORD_BROADCAST_RECORD_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_ORDERWORLD_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_TASKAWARD_TASK_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_SHOPBUY_ME = protobuf.Descriptor(),
	C2S_ORDERWORLD_SHOPBUY_GOODS_ID_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_SHOPBUY_NUM_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_SHOPBUY_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_SHOPBUY_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_SHOPBUY_GOODS_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_SHOPBUY_NUM_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_SHOPBUY_BOUGHT_NUM_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_SHOPBUY_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_MARSAWARD_ME = protobuf.Descriptor(),
	C2S_ORDERWORLD_MARSAWARD_GENRE_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_MARSAWARD_RANK_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_MARSAWARD_RANK_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_MARSAWARD_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_MARSAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_MARSAWARD_GENRE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_MARSAWARD_RANK_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_MARSAWARD_RANK_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_MARSAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GUILDNOTIFY_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_GUILDNOTIFY_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GUILDNOTIFY_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_NOTIFYRANK_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_NOTIFYRANK_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_NOTIFYRANK_TIME_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_NOTIFYRANK_ID_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_GUILDALLAWARD_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_GUILDALLAWARD_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_GUILDALLAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GUILDALLAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ORDERWORLD_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_ORDERWORLD_GETSERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GETSERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_ORDERWORLD_GETSERVERINFOS_SID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_INFO_ME, {
	"C2S_OrderWorld_Info",
	".cs.C2S_OrderWorld_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_OrderWorld_Info.activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ORDERWORLDACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_GUILD_LEVEL_F, {
	"guild_level",
	".cs.S2C_OrderWorld_Info.guild_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_GUILD_SCORE_F, {
	"guild_score",
	".cs.S2C_OrderWorld_Info.guild_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_GUILD_LEVEL_AWARD_F, {
	"guild_level_award",
	".cs.S2C_OrderWorld_Info.guild_level_award",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_TASK_LIST_F, {
	"task_list",
	".cs.S2C_OrderWorld_Info.task_list",
	6,
	5,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_RECORDS_F, {
	"records",
	".cs.S2C_OrderWorld_Info.records",
	7,
	6,
	3,
	false,
	{},
	var_0_3.ORDERWORLDRECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_BUYS_F, {
	"buys",
	".cs.S2C_OrderWorld_Info.buys",
	8,
	7,
	3,
	false,
	{},
	var_0_3.ORDERWORLDBUYNUM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_GUILD_MARS_F, {
	"guild_mars",
	".cs.S2C_OrderWorld_Info.guild_mars",
	9,
	8,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_SERVER_MARS_F, {
	"server_mars",
	".cs.S2C_OrderWorld_Info.server_mars",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_SELF_SCORE_F, {
	"self_score",
	".cs.S2C_OrderWorld_Info.self_score",
	11,
	10,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_JOIN_GUILD_TIME_F, {
	"join_guild_time",
	".cs.S2C_OrderWorld_Info.join_guild_time",
	12,
	11,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_INFO_ME, {
	"S2C_OrderWorld_Info",
	".cs.S2C_OrderWorld_Info",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_INFO_RET_F,
		var_0_10.S2C_ORDERWORLD_INFO_ACTIVITY_F,
		var_0_10.S2C_ORDERWORLD_INFO_GUILD_LEVEL_F,
		var_0_10.S2C_ORDERWORLD_INFO_GUILD_SCORE_F,
		var_0_10.S2C_ORDERWORLD_INFO_GUILD_LEVEL_AWARD_F,
		var_0_10.S2C_ORDERWORLD_INFO_TASK_LIST_F,
		var_0_10.S2C_ORDERWORLD_INFO_RECORDS_F,
		var_0_10.S2C_ORDERWORLD_INFO_BUYS_F,
		var_0_10.S2C_ORDERWORLD_INFO_GUILD_MARS_F,
		var_0_10.S2C_ORDERWORLD_INFO_SERVER_MARS_F,
		var_0_10.S2C_ORDERWORLD_INFO_SELF_SCORE_F,
		var_0_10.S2C_ORDERWORLD_INFO_JOIN_GUILD_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_DONATE_ITEM_ID_F, {
	"item_id",
	".cs.C2S_OrderWorld_Donate.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_DONATE_NUM_F, {
	"num",
	".cs.C2S_OrderWorld_Donate.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_DONATE_ME, {
	"C2S_OrderWorld_Donate",
	".cs.C2S_OrderWorld_Donate",
	{},
	{},
	{
		var_0_10.C2S_ORDERWORLD_DONATE_ITEM_ID_F,
		var_0_10.C2S_ORDERWORLD_DONATE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_Donate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_ITEM_ID_F, {
	"item_id",
	".cs.S2C_OrderWorld_Donate.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_NUM_F, {
	"num",
	".cs.S2C_OrderWorld_Donate.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_GUILD_LEVEL_F, {
	"guild_level",
	".cs.S2C_OrderWorld_Donate.guild_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_GUILD_SCORE_F, {
	"guild_score",
	".cs.S2C_OrderWorld_Donate.guild_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_SELF_SCORE_F, {
	"self_score",
	".cs.S2C_OrderWorld_Donate.self_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_AWARDS_F, {
	"awards",
	".cs.S2C_OrderWorld_Donate.awards",
	7,
	6,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_GUILD_LEVEL_AWARD_F, {
	"guild_level_award",
	".cs.S2C_OrderWorld_Donate.guild_level_award",
	8,
	7,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_DONATE_ME, {
	"S2C_OrderWorld_Donate",
	".cs.S2C_OrderWorld_Donate",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_DONATE_RET_F,
		var_0_10.S2C_ORDERWORLD_DONATE_ITEM_ID_F,
		var_0_10.S2C_ORDERWORLD_DONATE_NUM_F,
		var_0_10.S2C_ORDERWORLD_DONATE_GUILD_LEVEL_F,
		var_0_10.S2C_ORDERWORLD_DONATE_GUILD_SCORE_F,
		var_0_10.S2C_ORDERWORLD_DONATE_SELF_SCORE_F,
		var_0_10.S2C_ORDERWORLD_DONATE_AWARDS_F,
		var_0_10.S2C_ORDERWORLD_DONATE_GUILD_LEVEL_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_OPTABUSER_OP_F, {
	"Op",
	".cs.C2S_OrderWorld_OpTabUser.Op",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_OPTABUSER_ME, {
	"C2S_OrderWorld_OpTabUser",
	".cs.C2S_OrderWorld_OpTabUser",
	{},
	{},
	{
		var_0_10.C2S_ORDERWORLD_OPTABUSER_OP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_OPTABUSER_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_OpTabUser.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_OPTABUSER_OP_F, {
	"Op",
	".cs.S2C_OrderWorld_OpTabUser.Op",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_OPTABUSER_ME, {
	"S2C_OrderWorld_OpTabUser",
	".cs.S2C_OrderWorld_OpTabUser",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_OPTABUSER_RET_F,
		var_0_10.S2C_ORDERWORLD_OPTABUSER_OP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_GUILDLEVELAWARD_LEVEL_F, {
	"level",
	".cs.C2S_OrderWorld_GuildLevelAward.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_GUILDLEVELAWARD_ME, {
	"C2S_OrderWorld_GuildLevelAward",
	".cs.C2S_OrderWorld_GuildLevelAward",
	{},
	{},
	{
		var_0_10.C2S_ORDERWORLD_GUILDLEVELAWARD_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_GuildLevelAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_LEVEL_F, {
	"level",
	".cs.S2C_OrderWorld_GuildLevelAward.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_OrderWorld_GuildLevelAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_ME, {
	"S2C_OrderWorld_GuildLevelAward",
	".cs.S2C_OrderWorld_GuildLevelAward",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_RET_F,
		var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_LEVEL_F,
		var_0_10.S2C_ORDERWORLD_GUILDLEVELAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_RECORD_BROADCAST_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_OrderWorld_Record_Broadcast.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_RECORD_BROADCAST_RECORD_F, {
	"record",
	".cs.S2C_OrderWorld_Record_Broadcast.record",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ORDERWORLDRECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_RECORD_BROADCAST_ME, {
	"S2C_OrderWorld_Record_Broadcast",
	".cs.S2C_OrderWorld_Record_Broadcast",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_RECORD_BROADCAST_ACTIVITY_ID_F,
		var_0_10.S2C_ORDERWORLD_RECORD_BROADCAST_RECORD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_OrderWorld_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_TASKAWARD_ME, {
	"C2S_OrderWorld_TaskAward",
	".cs.C2S_OrderWorld_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_ORDERWORLD_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_OrderWorld_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_TASKAWARD_TASK_F, {
	"task",
	".cs.S2C_OrderWorld_TaskAward.task",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_OrderWorld_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_TASKAWARD_ME, {
	"S2C_OrderWorld_TaskAward",
	".cs.S2C_OrderWorld_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_TASKAWARD_RET_F,
		var_0_10.S2C_ORDERWORLD_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_ORDERWORLD_TASKAWARD_TASK_F,
		var_0_10.S2C_ORDERWORLD_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_SHOPBUY_GOODS_ID_F, {
	"goods_id",
	".cs.C2S_OrderWorld_ShopBuy.goods_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_SHOPBUY_NUM_F, {
	"num",
	".cs.C2S_OrderWorld_ShopBuy.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_SHOPBUY_ME, {
	"C2S_OrderWorld_ShopBuy",
	".cs.C2S_OrderWorld_ShopBuy",
	{},
	{},
	{
		var_0_10.C2S_ORDERWORLD_SHOPBUY_GOODS_ID_F,
		var_0_10.C2S_ORDERWORLD_SHOPBUY_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_SHOPBUY_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_ShopBuy.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_SHOPBUY_GOODS_ID_F, {
	"goods_id",
	".cs.S2C_OrderWorld_ShopBuy.goods_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_SHOPBUY_NUM_F, {
	"num",
	".cs.S2C_OrderWorld_ShopBuy.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_SHOPBUY_BOUGHT_NUM_F, {
	"bought_num",
	".cs.S2C_OrderWorld_ShopBuy.bought_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_SHOPBUY_AWARDS_F, {
	"awards",
	".cs.S2C_OrderWorld_ShopBuy.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_SHOPBUY_ME, {
	"S2C_OrderWorld_ShopBuy",
	".cs.S2C_OrderWorld_ShopBuy",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_SHOPBUY_RET_F,
		var_0_10.S2C_ORDERWORLD_SHOPBUY_GOODS_ID_F,
		var_0_10.S2C_ORDERWORLD_SHOPBUY_NUM_F,
		var_0_10.S2C_ORDERWORLD_SHOPBUY_BOUGHT_NUM_F,
		var_0_10.S2C_ORDERWORLD_SHOPBUY_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_MARSAWARD_GENRE_F, {
	"genre",
	".cs.C2S_OrderWorld_MarsAward.genre",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_MARSAWARD_RANK_F, {
	"rank",
	".cs.C2S_OrderWorld_MarsAward.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ORDERWORLD_MARSAWARD_RANK_USER_ID_F, {
	"rank_user_id",
	".cs.C2S_OrderWorld_MarsAward.rank_user_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_MARSAWARD_ME, {
	"C2S_OrderWorld_MarsAward",
	".cs.C2S_OrderWorld_MarsAward",
	{},
	{},
	{
		var_0_10.C2S_ORDERWORLD_MARSAWARD_GENRE_F,
		var_0_10.C2S_ORDERWORLD_MARSAWARD_RANK_F,
		var_0_10.C2S_ORDERWORLD_MARSAWARD_RANK_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_MARSAWARD_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_MarsAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_MARSAWARD_GENRE_F, {
	"genre",
	".cs.S2C_OrderWorld_MarsAward.genre",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_MARSAWARD_RANK_F, {
	"rank",
	".cs.S2C_OrderWorld_MarsAward.rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_MARSAWARD_RANK_USER_ID_F, {
	"rank_user_id",
	".cs.S2C_OrderWorld_MarsAward.rank_user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_MARSAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_OrderWorld_MarsAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_MARSAWARD_ME, {
	"S2C_OrderWorld_MarsAward",
	".cs.S2C_OrderWorld_MarsAward",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_MARSAWARD_RET_F,
		var_0_10.S2C_ORDERWORLD_MARSAWARD_GENRE_F,
		var_0_10.S2C_ORDERWORLD_MARSAWARD_RANK_F,
		var_0_10.S2C_ORDERWORLD_MARSAWARD_RANK_USER_ID_F,
		var_0_10.S2C_ORDERWORLD_MARSAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDNOTIFY_LEVEL_F, {
	"level",
	".cs.S2C_OrderWorld_GuildNotify.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDNOTIFY_SCORE_F, {
	"score",
	".cs.S2C_OrderWorld_GuildNotify.score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDNOTIFY_ME, {
	"S2C_OrderWorld_GuildNotify",
	".cs.S2C_OrderWorld_GuildNotify",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_GUILDNOTIFY_LEVEL_F,
		var_0_10.S2C_ORDERWORLD_GUILDNOTIFY_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_NOTIFYRANK_SCORE_F, {
	"score",
	".cs.S2C_OrderWorld_NotifyRank.score",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_NOTIFYRANK_TIME_F, {
	"time",
	".cs.S2C_OrderWorld_NotifyRank.time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_NOTIFYRANK_ID_F, {
	"id",
	".cs.S2C_OrderWorld_NotifyRank.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_NOTIFYRANK_ME, {
	"S2C_OrderWorld_NotifyRank",
	".cs.S2C_OrderWorld_NotifyRank",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_NOTIFYRANK_SCORE_F,
		var_0_10.S2C_ORDERWORLD_NOTIFYRANK_TIME_F,
		var_0_10.S2C_ORDERWORLD_NOTIFYRANK_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_GUILDALLAWARD_ME, {
	"C2S_OrderWorld_GuildAllAward",
	".cs.C2S_OrderWorld_GuildAllAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDALLAWARD_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_GuildAllAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDALLAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_OrderWorld_GuildAllAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_GUILDALLAWARD_ME, {
	"S2C_OrderWorld_GuildAllAward",
	".cs.S2C_OrderWorld_GuildAllAward",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_GUILDALLAWARD_RET_F,
		var_0_10.S2C_ORDERWORLD_GUILDALLAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ORDERWORLD_GETSERVERINFOS_ME, {
	"C2S_OrderWorld_GetServerInfos",
	".cs.C2S_OrderWorld_GetServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_OrderWorld_GetServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_OrderWorld_GetServerInfos.server_infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SERVERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_OrderWorld_GetServerInfos.sid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_ME, {
	"S2C_OrderWorld_GetServerInfos",
	".cs.S2C_OrderWorld_GetServerInfos",
	{},
	{},
	{
		var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_RET_F,
		var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_SERVER_INFOS_F,
		var_0_10.S2C_ORDERWORLD_GETSERVERINFOS_SID_F
	},
	false,
	{}
})

return var_0_10
