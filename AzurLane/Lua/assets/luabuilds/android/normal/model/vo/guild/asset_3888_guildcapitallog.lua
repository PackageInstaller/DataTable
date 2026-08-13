class = var_0_10000

local var_0_0 = "GuildCapitalLog"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.memberId = arg_1_1.member_id
	arg_1_0.name = arg_1_1.name
	arg_1_0.eventType = arg_1_1.event_type
	arg_1_0.eventTarget = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.event_target) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.eventTarget, iter_1_1)
	end

	arg_1_0.time = arg_1_1.time
	arg_1_0.text = arg_1_0:buildText()

	return
end

function var_0_1.buildText(arg_2_0)
	local var_2_0 = ""

	pg = var_1_10002

	local var_2_1 = var_1_10002.TimeMgr.GetInstance()
	local var_2_2 = var_2.STimeDescC(var_2_1, arg_2_0.time)
	local var_2_3 = arg_2_0.eventTarget[1]
	local var_2_4 = arg_2_0.eventType

	GuildConst = var_1_10005

	local var_2_6

	if var_2_4 == var_1_10005.TYPE_DONATE then
		pg = var_2_4

		local var_2_5 = var_2_4.guild_contribution_template[var_2_3]

		var_2_6 = nil
		var_1_10006 = var_2_5.type
		DROP_TYPE_RESOURCE = var_1_10007

		if var_1_10006 == var_1_10007 then
			Item = var_1_10006
			var_1_10006 = var_1_10006.New
			var_1_10007 = {}
			id2ItemId = var_1_10008
			var_1_10007.id = var_1_10008(var_2_5.type_id)
			var_1_10007 = var_1_10006(var_1_10007)
			var_2_6 = var_1_10006.getConfig(var_1_10007, "name")
		else
			Item = var_1_10006
			var_1_10007 = var_1_10006.New({
				id = var_2_5.type_id
			})
			var_2_6 = var_1_10006.getConfig(var_1_10007, "name")
		end

		i18n = var_1_10006
		var_2_0 = var_1_10006("guild_donate_log", var_2_2, arg_2_0.name, var_2_5.consume, var_2_6, var_2_5.award_capital)
	else
		local var_2_7 = arg_2_0.eventType

		GuildConst = var_2_6

		local var_2_8

		if var_2_7 == var_2_6.TYPE_SUPPLY then
			getProxy = var_2_7
			GuildProxy = var_2_8
			var_2_8 = var_2_7(var_2_8)

			if var_4.getRawData(var_2_8) then
				var_1_10006 = var_4
				var_2_8, var_1_10006 = var_4.getSupplyConsume(var_1_10006)
				i18n = var_1_10007
				var_2_0 = var_1_10007("guild_supply_log", var_2_2, arg_2_0.name, var_2_8, var_1_10006)
			end
		else
			local var_2_9 = arg_2_0.eventType

			GuildConst = var_2_8

			if var_2_9 == var_2_8.WEEKLY_TASK then
				i18n = var_2_9
				var_2_0 = var_2_9("guild_weektask_log", var_2_2, var_2_3)
			else
				local var_2_10 = arg_2_0.eventType

				GuildConst = var_5

				if var_2_10 == var_5.START_BATTLE then
					i18n = var_2_10
					var_2_0 = var_2_10("guild_battle_log", var_2_2, arg_2_0.name, var_2_3)
				else
					local var_2_11 = arg_2_0.eventType

					GuildConst = var_5

					local var_2_13

					if var_2_11 == var_5.TECHNOLOGY then
						pg = var_2_11

						local var_2_12 = var_2_11.guild_technology_template[var_2_3]

						assert = var_2_13

						var_2_13(var_2_12, var_2_3)

						var_2_13 = var_2_12.contribution_consume
						var_1_10006 = var_2_12.name
						i18n = var_7

						local var_2_14 = "guild_tech_log"
						local var_2_15 = var_2_2
						local var_2_16 = arg_2_0.name
						local var_2_17 = var_2_13
						local var_2_18 = var_1_10006

						level = var_1_10013
						var_2_0 = var_7(var_2_14, var_2_15, var_2_16, var_2_17, var_2_18, var_1_10013)
					else
						local var_2_19 = arg_2_0.eventType

						GuildConst = var_2_13

						local var_2_21

						if var_2_19 == var_2_13.TECHNOLOGY_OVER then
							pg = var_2_19

							local var_2_20 = var_2_19.guild_technology_template[var_2_3]

							assert = var_2_21

							var_2_21(var_2_20, var_2_3)

							var_2_21 = var_2_20.contribution_consume
							var_1_10006 = var_2_20.name
							i18n = var_7
							var_2_0 = var_7("guild_tech_over_log", var_2_2, arg_2_0.name, var_1_10006)
						else
							local var_2_22 = arg_2_0.eventType

							GuildConst = var_2_21

							if var_2_22 == var_2_21.SWITCH_TOGGLE then
								pg = var_2_22

								local var_2_23 = var_2_22.guild_technology_template[var_2_3].name

								i18n = var_1_10006
								var_2_0 = var_1_10006("guild_tech_change_log", var_2_2, arg_2_0.name, var_2_23)
							end
						end
					end
				end
			end
		end
	end

	return var_2_0
end

function var_0_1.getText(arg_3_0)
	return arg_3_0.text
end

function var_0_1.IsSameType(arg_4_0, arg_4_1)
	_ = var_1_10002

	return var_1_10002.any(arg_4_1, function(arg_5_0)
		return arg_4_0.eventType == arg_5_0
	end)
end

return var_0_1
