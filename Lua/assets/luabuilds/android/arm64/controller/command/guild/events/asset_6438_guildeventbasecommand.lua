local GuildEventBaseCommand = class("GuildEventBaseCommand", pm.SimpleCommand)

function GuildEventBaseCommand:ExistGuild()
	if not getProxy(GuildProxy):getRawData() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist"))

		return false
	end

	return true
end

function GuildEventBaseCommand:ExistEvent(arg_2_1)
	if not getProxy(GuildProxy):getRawData():GetEventById(arg_2_1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_battle"))

		return false
	end

	return true
end

function GuildEventBaseCommand:ExistActiveEvent()
	if not self:ExistGuild() then
		return false
	end

	local var_3_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	if not var_3_0 or var_3_0 and var_3_0:IsExpired() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

		return false
	end

	return true
end

function GuildEventBaseCommand:NotExistActiveEvent()
	if getProxy(GuildProxy):getRawData():GetActiveEvent() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_exist"))

		return false
	end

	return true
end

function GuildEventBaseCommand:ExistMission(arg_5_1)
	if not self:ExistActiveEvent() then
		return false
	end

	if arg_5_1 and getProxy(GuildProxy):getRawData():GetActiveEvent():GetMissionById(arg_5_1) == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_not_exist"))

		return false
	end

	return true
end

function GuildEventBaseCommand:GetMissionById(arg_6_1)
	if self:ExistMission(arg_6_1) then
		return getProxy(GuildProxy):getRawData():GetActiveEvent():GetMissionById(arg_6_1)
	end

	return
end

function GuildEventBaseCommand:CanFormationMission(arg_7_1)
	if not self:ExistMission(arg_7_1) then
		return false
	end

	local var_7_0 = getProxy(GuildProxy)

	if var_7_0:getRawData():GetActiveEvent():GetMissionById(arg_7_1).GetCanFormationIndex(var_7_0) == -1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_fleet_can_not_edit"))

		return false
	end

	return true
end

function GuildEventBaseCommand:ExistBoss()
	if not self:ExistActiveEvent() then
		return false
	end

	local var_8_0 = getProxy(GuildProxy)

	if not var_8_0 or not var_8_0:getRawData():GetActiveEvent():GetBossMission():IsActive() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_boss"))

		return false
	end

	return true
end

function GuildEventBaseCommand:IsAnim()
	if not GuildMember.IsAdministrator(getProxy(GuildProxy):getRawData():getSelfDuty()) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_commander_and_sub_op"))

		return false
	end

	return true
end

function GuildEventBaseCommand:CheckCapital(arg_10_1, arg_10_2)
	if getProxy(GuildProxy):getRawData():getCapital() < arg_10_1:GetConsume() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_guildgold_no_enough_for_battle"))

		return false
	end

	return true
end

return GuildEventBaseCommand
