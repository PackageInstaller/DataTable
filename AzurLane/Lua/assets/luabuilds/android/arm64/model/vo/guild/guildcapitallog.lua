local var_0_0 = class("GuildCapitalLog", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.memberId = arg_1_1.member_id
	arg_1_0.name = arg_1_1.name
	arg_1_0.eventType = arg_1_1.event_type
	arg_1_0.eventTarget = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.event_target) do
		table.insert(arg_1_0.eventTarget, iter_1_1)
	end

	arg_1_0.time = arg_1_1.time
	arg_1_0.text = arg_1_0:buildText()

	return
end

function var_0_0.buildText(arg_2_0)
	local var_2_0 = ""
	local var_2_1 = pg.TimeMgr.GetInstance():STimeDescC(arg_2_0.time)

	if arg_2_0.eventType == GuildConst.TYPE_DONATE then
		local var_2_2 = pg.guild_contribution_template[arg_2_0.eventTarget[1]]
		local var_2_3 = pg.guild_contribution_template[arg_2_0.eventTarget[1]].type == DROP_TYPE_RESOURCE and Item.New({
			id = id2ItemId(var_2_2.type_id)
		}):getConfig("name") or Item.New({
			id = var_2_2.type_id
		}):getConfig("name")

		var_2_0 = i18n("guild_donate_log", var_2_1, arg_2_0.name, var_2_2.consume, var_2_3, var_2_2.award_capital)
	elseif arg_2_0.eventType == GuildConst.TYPE_SUPPLY then
		local var_2_4 = getProxy(GuildProxy):getRawData()

		if var_2_4 then
			local var_2_5, var_2_6 = var_2_4:getSupplyConsume()

			var_2_0 = i18n("guild_supply_log", var_2_1, arg_2_0.name, var_2_5, var_2_6)
		end
	elseif arg_2_0.eventType == GuildConst.WEEKLY_TASK then
		var_2_0 = i18n("guild_weektask_log", var_2_1, arg_2_0.eventTarget[1])
	elseif arg_2_0.eventType == GuildConst.START_BATTLE then
		var_2_0 = i18n("guild_battle_log", var_2_1, arg_2_0.name, arg_2_0.eventTarget[1])
	elseif arg_2_0.eventType == GuildConst.TECHNOLOGY then
		assert(pg.guild_technology_template[arg_2_0.eventTarget[1]], arg_2_0.eventTarget[1])

		var_2_0 = i18n("guild_tech_log", var_2_1, arg_2_0.name, pg.guild_technology_template[arg_2_0.eventTarget[1]].contribution_consume, pg.guild_technology_template[arg_2_0.eventTarget[1]].name, level)
	elseif arg_2_0.eventType == GuildConst.TECHNOLOGY_OVER then
		assert(pg.guild_technology_template[arg_2_0.eventTarget[1]], arg_2_0.eventTarget[1])

		var_2_0 = i18n("guild_tech_over_log", var_2_1, arg_2_0.name, pg.guild_technology_template[arg_2_0.eventTarget[1]].name)
	elseif arg_2_0.eventType == GuildConst.SWITCH_TOGGLE then
		var_2_0 = i18n("guild_tech_change_log", var_2_1, arg_2_0.name, pg.guild_technology_template[arg_2_0.eventTarget[1]].name)
	end

	return var_2_0
end

function var_0_0.getText(arg_3_0)
	return arg_3_0.text
end

function var_0_0.IsSameType(arg_4_0, arg_4_1)
	return _.any(arg_4_1, function(arg_5_0)
		return arg_4_0.eventType == arg_5_0
	end)
end

return var_0_0
