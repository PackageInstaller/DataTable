class = var_0_10000

local var_0_0 = var_0_10000("GuildConst")

var_0_0.DEBUG = true
var_0_0.POLICY_TYPE_POWER = 1
var_0_0.POLICY_TYPE_RELAXATION = 2
var_0_0.FACTION_TYPE_BLHX = 1
var_0_0.FACTION_TYPE_CSZZ = 2
var_0_0.REFRESH_ACTIVATION_EVENT_TIME = 30
var_0_0.WEEKLY_TASK_PROGRESS_REFRESH_TIME = 60
var_0_0.REFRESH_CAPITAL_TIME = 30
var_0_0.REQUEST_ASSAULT_TIME = 30
var_0_0.REQUEST_REPORT_TIME = 30

local var_0_1 = {}

i18n = var_2
var_0_1[1] = var_2("guild_policy_power")
i18n = var_2
var_0_1[2] = var_2("guild_policy_relax")
var_0_0.POLICY_NAME = var_0_1

local var_0_2 = {}

i18n = var_2
var_0_2[1] = var_2("guild_faction_blhx")
i18n = var_2
var_0_2[2] = var_2("guild_faction_cszz")
var_0_0.FACTION_NAME = var_0_2
var_0_0.CHAT_LOG_MAX_COUNT = 100
var_0_0.REQUEST_LOG_TIME = 300
var_0_0.REQUEST_BOSS_TIME = 60
var_0_0.MAX_SUPPLY_CNT = 3
var_0_0.TYPE_DONATE = 1
var_0_0.TYPE_SUPPLY = 2
var_0_0.WEEKLY_TASK = 3
var_0_0.START_BATTLE = 4
var_0_0.SWITCH_TOGGLE = 5
var_0_0.TECHNOLOGY = 6
var_0_0.TECHNOLOGY_OVER = 7
var_0_0.CMD_TYPE_JOIN = 1
var_0_0.CMD_TYPE_SET_DUTY = 2
var_0_0.CMD_TYPE_QUIT = 3
var_0_0.CMD_TYPE_FIRE = 4
var_0_0.CMD_TYPE_GET_SHIP = 5
var_0_0.CMD_TYPE_FACILITY_CONTRIBUTION = 6
var_0_0.CMD_TYPE_FACILITY_CONSUME = 7
var_0_0.DUTY_COMMANDER = 1
var_0_0.DUTY_DEPUTY_COMMANDER = 2
var_0_0.DYTY_PICKED = 3
var_0_0.DUTY_ORDINARY = 4
var_0_0.DUTY_RECRUIT = 5
var_0_0.GET_SHOP = 0
var_0_0.AUTO_REFRESH = 1
var_0_0.MANUAL_REFRESH = 2
var_0_0.MAX_DISPLAY_MEMBER_SHIP = 10
var_0_0.REPORT_STATE_LOCK = 0
var_0_0.REPORT_STATE_UNlOCK = 1
var_0_0.REPORT_STATE_SUBMITED = 2
var_0_0.REPORT_TYPE_MISSION = 1
var_0_0.REPORT_TYPE_BOSS = 2
var_0_0.BASE_EVENT_TYPE_COMMON = 1
var_0_0.BASE_EVENT_TYPE_ELITE = 2

function var_0_0.MAX_REPORT_CNT()
	pg = var_1_10000

	return var_1_10000.guildset.operation_report_max.key_value
end

var_0_0.REQUEST_REPORT_CD = 30
var_0_0.REQUEST_FORMATION_CD = 5
var_0_0.MISSION_MAX_SHIP_CNT = 4
var_0_0.FORMATION_CD_TIME = 21600
var_0_0.MISSION_MAX_FLEET_CNT = 4
var_0_0.RECOMMAND_SHIP = 0
var_0_0.CANCEL_RECOMMAND_SHIP = 1

function var_0_0.MISSION_BOSS_MAX_CNT()
	pg = var_1_10000

	return var_1_10000.guildset.operation_daily_boss_count.key_value
end

var_0_0.REFRESH_MISSION_BOSS_RANK_TIME = 300
var_0_0.FORCE_REFRESH_MISSION_BOSS_RANK_TIME = 1800
var_0_0.REFRESH_MISSION_TIME = 30
var_0_0.REFRESH_LATELY_NODE_TIME = 60
var_0_0.FORCE_REFRESH_MISSION_TREE_TIME = 1800
var_0_0.REFRESH_BOSS_TIME = 60
var_0_0.FORCE_REFRESH_BOSS_TIME = 300
var_0_0.TYPE_GUILD_MEMBER_CNT = "bigfleet_seats"
var_0_0.TYPE_GOLD_MAX = "gold_max"
var_0_0.TYPE_OIL_MAX = "oil_max"
var_0_0.TYPE_SHIP_BAG = "ship_bag_size"
var_0_0.TYPE_EQUIPMENT_BAG = "equip_bag_size"
var_0_0.TYPE_CATBOX_GOLD_COST = "catbox_gold_cost"
var_0_0.TYPE_CATBOX_TIME_COST_R = "catbox_time_cost_R"
var_0_0.TYPE_CATBOX_TIME_COST_SR = "catbox_time_cost_SR"
var_0_0.TYPE_CATBOX_TIME_COST_SSR = "catbox_time_cost_SSR"
var_0_0.TYPE_TO_GROUP = {
	[var_0_0.TYPE_GUILD_MEMBER_CNT] = 1,
	[var_0_0.TYPE_GOLD_MAX] = 2,
	[var_0_0.TYPE_OIL_MAX] = 3,
	[var_0_0.TYPE_SHIP_BAG] = 4,
	[var_0_0.TYPE_EQUIPMENT_BAG] = 5,
	[var_0_0.TYPE_CATBOX_GOLD_COST] = 6,
	[var_0_0.TYPE_CATBOX_TIME_COST_R] = 7,
	[var_0_0.TYPE_CATBOX_TIME_COST_SR] = 8,
	[var_0_0.TYPE_CATBOX_TIME_COST_SSR] = 9
}

function var_0_0.GET_TECHNOLOGY_GROUP_DESC(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[1]
	local var_3_1 = "<color="

	COLOR_GREEN = var_1_10005

	local var_3_2 = var_3_1 .. var_1_10005 .. ">" .. arg_3_2 .. "</color>"

	if arg_3_1 == arg_3_2 then
		var_3_2 = arg_3_1
	end

	GuildConst = var_1_10005

	if var_3_0 == var_1_10005.TYPE_GOLD_MAX then
		i18n = var_5

		return var_5("guild_tech_gold_desc", var_3_2)
	else
		GuildConst = var_5

		if var_3_0 == var_5.TYPE_OIL_MAX then
			i18n = var_5

			return var_5("guild_tech_oil_desc", var_3_2)
		else
			GuildConst = var_5

			if var_3_0 == var_5.TYPE_SHIP_BAG then
				i18n = var_5

				return var_5("guild_tech_shipbag_desc", var_3_2)
			else
				GuildConst = var_5

				if var_3_0 == var_5.TYPE_EQUIPMENT_BAG then
					i18n = var_5

					return var_5("guild_tech_equipbag_desc", var_3_2)
				else
					GuildConst = var_5

					if var_3_0 == var_5.TYPE_CATBOX_GOLD_COST then
						i18n = var_5

						return var_5("guild_box_gold_desc", var_3_2)
					else
						GuildConst = var_5

						if var_3_0 == var_5.TYPE_CATBOX_TIME_COST_R then
							i18n = var_5

							return var_5("guidl_r_box_time_desc", var_3_2)
						else
							GuildConst = var_5

							if var_3_0 == var_5.TYPE_CATBOX_TIME_COST_SR then
								i18n = var_5

								return var_5("guidl_sr_box_time_desc", var_3_2)
							else
								GuildConst = var_5

								if var_3_0 == var_5.TYPE_CATBOX_TIME_COST_SSR then
									i18n = var_5

									return var_5("guidl_ssr_box_time_desc", var_3_2)
								else
									GuildConst = var_5

									if var_3_0 == var_5.TYPE_GUILD_MEMBER_CNT then
										i18n = var_5

										return var_5("guild_member_max_cnt_desc", var_3_2)
									else
										local var_3_3 = arg_3_0[2]

										_ = var_6

										local var_3_4 = var_6.map(var_3_3, function(arg_4_0)
											pg = var_2_10001

											return var_2_10001.ship_data_by_type[arg_4_0].type_name
										end)

										table = var_7

										local var_3_5 = var_7.concat(var_3_4, ",")

										i18n = var_8

										local var_3_6 = "guild_ship_attr_desc"
										local var_3_7 = var_3_5

										AttributeType = var_1_10012

										return var_8(var_3_6, var_3_7, var_1_10012.Type2Name(var_3_0), var_3_2)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.GET_TECHNOLOGY_DESC(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0[1]
	local var_5_1 = "<color="

	COLOR_GREEN = var_1_10004
	arg_5_1 = var_5_1 .. var_1_10004 .. ">" .. arg_5_1 .. "</color>"
	GuildConst = var_5_1

	if var_5_0 == var_5_1.TYPE_GOLD_MAX then
		i18n = var_3

		return var_3("guild_tech_gold_desc", arg_5_1)
	else
		GuildConst = var_3

		if var_5_0 == var_3.TYPE_OIL_MAX then
			i18n = var_3

			return var_3("guild_tech_oil_desc", arg_5_1)
		else
			GuildConst = var_3

			if var_5_0 == var_3.TYPE_SHIP_BAG then
				i18n = var_3

				return var_3("guild_tech_shipbag_desc", arg_5_1)
			else
				GuildConst = var_3

				if var_5_0 == var_3.TYPE_EQUIPMENT_BAG then
					i18n = var_3

					return var_3("guild_tech_equipbag_desc", arg_5_1)
				else
					GuildConst = var_3

					if var_5_0 == var_3.TYPE_CATBOX_GOLD_COST then
						i18n = var_3

						return var_3("guild_box_gold_desc", arg_5_1)
					else
						GuildConst = var_3

						if var_5_0 == var_3.TYPE_CATBOX_TIME_COST_R then
							i18n = var_3

							return var_3("guidl_r_box_time_desc", arg_5_1)
						else
							GuildConst = var_3

							if var_5_0 == var_3.TYPE_CATBOX_TIME_COST_SR then
								i18n = var_3

								return var_3("guidl_sr_box_time_desc", arg_5_1)
							else
								GuildConst = var_3

								if var_5_0 == var_3.TYPE_CATBOX_TIME_COST_SSR then
									i18n = var_3

									return var_3("guidl_ssr_box_time_desc", arg_5_1)
								else
									GuildConst = var_3

									if var_5_0 == var_3.TYPE_GUILD_MEMBER_CNT then
										i18n = var_3

										return var_3("guild_member_max_cnt_desc", arg_5_1)
									else
										local var_5_2 = arg_5_0[2]

										_ = var_1_10004

										local var_5_3 = var_1_10004.map(var_5_2, function(arg_6_0)
											pg = var_2_10001

											return var_2_10001.ship_data_by_type[arg_6_0].type_name
										end)

										table = var_5

										local var_5_4 = var_5.concat(var_5_3, ",")

										i18n = var_6

										local var_5_5 = "guild_ship_attr_desc"
										local var_5_6 = var_5_4

										AttributeType = var_1_10010

										return var_6(var_5_5, var_5_6, var_1_10010.Type2Name(var_5_0), arg_5_1)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_0
