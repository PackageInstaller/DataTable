local GuildConst = class("GuildConst")

GuildConst.DEBUG = true
GuildConst.POLICY_TYPE_POWER = 1
GuildConst.POLICY_TYPE_RELAXATION = 2
GuildConst.FACTION_TYPE_BLHX = 1
GuildConst.FACTION_TYPE_CSZZ = 2
GuildConst.REFRESH_ACTIVATION_EVENT_TIME = 30
GuildConst.WEEKLY_TASK_PROGRESS_REFRESH_TIME = 60
GuildConst.REFRESH_CAPITAL_TIME = 30
GuildConst.REQUEST_ASSAULT_TIME = 30
GuildConst.REQUEST_REPORT_TIME = 30
GuildConst.POLICY_NAME = {
	i18n("guild_policy_power"),
	i18n("guild_policy_relax")
}
GuildConst.FACTION_NAME = {
	i18n("guild_faction_blhx"),
	i18n("guild_faction_cszz")
}
GuildConst.CHAT_LOG_MAX_COUNT = 100
GuildConst.REQUEST_LOG_TIME = 300
GuildConst.REQUEST_BOSS_TIME = 60
GuildConst.MAX_SUPPLY_CNT = 3
GuildConst.TYPE_DONATE = 1
GuildConst.TYPE_SUPPLY = 2
GuildConst.WEEKLY_TASK = 3
GuildConst.START_BATTLE = 4
GuildConst.SWITCH_TOGGLE = 5
GuildConst.TECHNOLOGY = 6
GuildConst.TECHNOLOGY_OVER = 7
GuildConst.CMD_TYPE_JOIN = 1
GuildConst.CMD_TYPE_SET_DUTY = 2
GuildConst.CMD_TYPE_QUIT = 3
GuildConst.CMD_TYPE_FIRE = 4
GuildConst.CMD_TYPE_GET_SHIP = 5
GuildConst.CMD_TYPE_FACILITY_CONTRIBUTION = 6
GuildConst.CMD_TYPE_FACILITY_CONSUME = 7
GuildConst.DUTY_COMMANDER = 1
GuildConst.DUTY_DEPUTY_COMMANDER = 2
GuildConst.DYTY_PICKED = 3
GuildConst.DUTY_ORDINARY = 4
GuildConst.DUTY_RECRUIT = 5
GuildConst.GET_SHOP = 0
GuildConst.AUTO_REFRESH = 1
GuildConst.MANUAL_REFRESH = 2
GuildConst.MAX_DISPLAY_MEMBER_SHIP = 10
GuildConst.REPORT_STATE_LOCK = 0
GuildConst.REPORT_STATE_UNlOCK = 1
GuildConst.REPORT_STATE_SUBMITED = 2
GuildConst.REPORT_TYPE_MISSION = 1
GuildConst.REPORT_TYPE_BOSS = 2
GuildConst.BASE_EVENT_TYPE_COMMON = 1
GuildConst.BASE_EVENT_TYPE_ELITE = 2

function GuildConst.MAX_REPORT_CNT()
	return pg.guildset.operation_report_max.key_value
end

GuildConst.REQUEST_REPORT_CD = 30
GuildConst.REQUEST_FORMATION_CD = 5
GuildConst.MISSION_MAX_SHIP_CNT = 4
GuildConst.FORMATION_CD_TIME = 21600
GuildConst.MISSION_MAX_FLEET_CNT = 4
GuildConst.RECOMMAND_SHIP = 0
GuildConst.CANCEL_RECOMMAND_SHIP = 1

function GuildConst.MISSION_BOSS_MAX_CNT()
	return pg.guildset.operation_daily_boss_count.key_value
end

GuildConst.REFRESH_MISSION_BOSS_RANK_TIME = 300
GuildConst.FORCE_REFRESH_MISSION_BOSS_RANK_TIME = 1800
GuildConst.REFRESH_MISSION_TIME = 30
GuildConst.REFRESH_LATELY_NODE_TIME = 60
GuildConst.FORCE_REFRESH_MISSION_TREE_TIME = 1800
GuildConst.REFRESH_BOSS_TIME = 60
GuildConst.FORCE_REFRESH_BOSS_TIME = 300
GuildConst.TYPE_GUILD_MEMBER_CNT = "bigfleet_seats"
GuildConst.TYPE_GOLD_MAX = "gold_max"
GuildConst.TYPE_OIL_MAX = "oil_max"
GuildConst.TYPE_SHIP_BAG = "ship_bag_size"
GuildConst.TYPE_EQUIPMENT_BAG = "equip_bag_size"
GuildConst.TYPE_CATBOX_GOLD_COST = "catbox_gold_cost"
GuildConst.TYPE_CATBOX_TIME_COST_R = "catbox_time_cost_R"
GuildConst.TYPE_CATBOX_TIME_COST_SR = "catbox_time_cost_SR"
GuildConst.TYPE_CATBOX_TIME_COST_SSR = "catbox_time_cost_SSR"
GuildConst.TYPE_TO_GROUP = {
	[GuildConst.TYPE_GUILD_MEMBER_CNT] = 1,
	[GuildConst.TYPE_GOLD_MAX] = 2,
	[GuildConst.TYPE_OIL_MAX] = 3,
	[GuildConst.TYPE_SHIP_BAG] = 4,
	[GuildConst.TYPE_EQUIPMENT_BAG] = 5,
	[GuildConst.TYPE_CATBOX_GOLD_COST] = 6,
	[GuildConst.TYPE_CATBOX_TIME_COST_R] = 7,
	[GuildConst.TYPE_CATBOX_TIME_COST_SR] = 8,
	[GuildConst.TYPE_CATBOX_TIME_COST_SSR] = 9
}

function GuildConst:GET_TECHNOLOGY_GROUP_DESC(arg_3_1, arg_3_2)
	local var_3_0 = "<color=" .. COLOR_GREEN .. ">" .. arg_3_2 .. "</color>"

	if arg_3_1 == arg_3_2 then
		var_3_0 = arg_3_1
	end

	if self[1] == GuildConst.TYPE_GOLD_MAX then
		return i18n("guild_tech_gold_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_OIL_MAX then
		return i18n("guild_tech_oil_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_SHIP_BAG then
		return i18n("guild_tech_shipbag_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_EQUIPMENT_BAG then
		return i18n("guild_tech_equipbag_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_CATBOX_GOLD_COST then
		return i18n("guild_box_gold_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_CATBOX_TIME_COST_R then
		return i18n("guidl_r_box_time_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_CATBOX_TIME_COST_SR then
		return i18n("guidl_sr_box_time_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_CATBOX_TIME_COST_SSR then
		return i18n("guidl_ssr_box_time_desc", var_3_0)
	elseif self[1] == GuildConst.TYPE_GUILD_MEMBER_CNT then
		return i18n("guild_member_max_cnt_desc", var_3_0)
	else
		return i18n("guild_ship_attr_desc", table.concat(_.map(self[2], function(arg_4_0)
			return pg.ship_data_by_type[arg_4_0].type_name
		end), ","), AttributeType.Type2Name(self[1]), var_3_0)
	end

	return
end

function GuildConst:GET_TECHNOLOGY_DESC(arg_5_1)
	arg_5_1 = "<color=" .. COLOR_GREEN .. ">" .. arg_5_1 .. "</color>"

	if self[1] == GuildConst.TYPE_GOLD_MAX then
		return i18n("guild_tech_gold_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_OIL_MAX then
		return i18n("guild_tech_oil_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_SHIP_BAG then
		return i18n("guild_tech_shipbag_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_EQUIPMENT_BAG then
		return i18n("guild_tech_equipbag_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_CATBOX_GOLD_COST then
		return i18n("guild_box_gold_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_CATBOX_TIME_COST_R then
		return i18n("guidl_r_box_time_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_CATBOX_TIME_COST_SR then
		return i18n("guidl_sr_box_time_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_CATBOX_TIME_COST_SSR then
		return i18n("guidl_ssr_box_time_desc", arg_5_1)
	elseif self[1] == GuildConst.TYPE_GUILD_MEMBER_CNT then
		return i18n("guild_member_max_cnt_desc", arg_5_1)
	else
		return i18n("guild_ship_attr_desc", table.concat(_.map(self[2], function(arg_6_0)
			return pg.ship_data_by_type[arg_6_0].type_name
		end), ","), AttributeType.Type2Name(self[1]), arg_5_1)
	end

	return
end

return GuildConst
