local GuildCapitalLog = class("GuildCapitalLog", import("..BaseVO"))

function GuildCapitalLog:Ctor(arg_1_1)
	self.memberId = arg_1_1.member_id
	self.name = arg_1_1.name
	self.eventType = arg_1_1.event_type
	self.eventTarget = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.event_target) do
		table.insert(self.eventTarget, iter_1_1)
	end

	self.time = arg_1_1.time
	self.text = self:buildText()

	return
end

function GuildCapitalLog:buildText()
	local var_2_0 = ""
	local var_2_1 = pg.TimeMgr.GetInstance():STimeDescC(self.time)

	if self.eventType == GuildConst.TYPE_DONATE then
		local var_2_2 = pg.guild_contribution_template[self.eventTarget[1]]

		var_2_0 = i18n("guild_donate_log", var_2_1, self.name, var_2_2.consume, pg.guild_contribution_template[self.eventTarget[1]].type == DROP_TYPE_RESOURCE and Item.New({
			id = id2ItemId(var_2_2.type_id)
		}):getConfig("name") or Item.New({
			id = var_2_2.type_id
		}):getConfig("name"), var_2_2.award_capital)
	elseif self.eventType == GuildConst.TYPE_SUPPLY then
		local var_2_4 = getProxy(GuildProxy):getRawData()

		if var_2_4 then
			local var_2_5, var_2_6 = var_2_4:getSupplyConsume()

			var_2_0 = i18n("guild_supply_log", var_2_1, self.name, var_2_5, var_2_6)
		end
	elseif self.eventType == GuildConst.WEEKLY_TASK then
		var_2_0 = i18n("guild_weektask_log", var_2_1, self.eventTarget[1])
	elseif self.eventType == GuildConst.START_BATTLE then
		var_2_0 = i18n("guild_battle_log", var_2_1, self.name, self.eventTarget[1])
	elseif self.eventType == GuildConst.TECHNOLOGY then
		assert(pg.guild_technology_template[self.eventTarget[1]], self.eventTarget[1])

		var_2_0 = i18n("guild_tech_log", var_2_1, self.name, pg.guild_technology_template[self.eventTarget[1]].contribution_consume, pg.guild_technology_template[self.eventTarget[1]].name, level)
	elseif self.eventType == GuildConst.TECHNOLOGY_OVER then
		assert(pg.guild_technology_template[self.eventTarget[1]], self.eventTarget[1])

		var_2_0 = i18n("guild_tech_over_log", var_2_1, self.name, pg.guild_technology_template[self.eventTarget[1]].name)
	elseif self.eventType == GuildConst.SWITCH_TOGGLE then
		var_2_0 = i18n("guild_tech_change_log", var_2_1, self.name, pg.guild_technology_template[self.eventTarget[1]].name)
	end

	return var_2_0
end

function GuildCapitalLog:getText()
	return self.text
end

function GuildCapitalLog:IsSameType(arg_4_1)
	return _.any(arg_4_1, function(arg_5_0)
		return self.eventType == arg_5_0
	end)
end

return GuildCapitalLog
