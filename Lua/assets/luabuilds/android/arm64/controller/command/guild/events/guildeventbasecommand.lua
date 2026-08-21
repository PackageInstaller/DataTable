local var_0_0 = class("GuildEventBaseCommand", pm.SimpleCommand)

function var_0_0.ExistGuild(arg_1_0)
	if not getProxy(GuildProxy):getRawData() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist"))

		return false
	end

	return true
end

function var_0_0.ExistEvent(arg_2_0, arg_2_1)
	if not getProxy(GuildProxy):getRawData():GetEventById(arg_2_1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_battle"))

		return false
	end

	return true
end

function var_0_0.ExistActiveEvent(arg_3_0)
	if not arg_3_0:ExistGuild() then
		return false
	end

	local var_3_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	if not var_3_0 or var_3_0 and var_3_0:IsExpired() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

		return false
	end

	return true
end

function var_0_0.NotExistActiveEvent(arg_4_0)
	if getProxy(GuildProxy):getRawData():GetActiveEvent() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_exist"))

		return false
	end

	return true
end

function var_0_0.ExistMission(arg_5_0, arg_5_1)
	if not arg_5_0:ExistActiveEvent() then
		return false
	end

	local var_5_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	if arg_5_1 and var_5_0:GetMissionById(arg_5_1) == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_not_exist"))

		return false
	end

	return true
end

function var_0_0.GetMissionById(arg_6_0, arg_6_1)
	if arg_6_0:ExistMission(arg_6_1) then
		return getProxy(GuildProxy):getRawData():GetActiveEvent():GetMissionById(arg_6_1)
	end

	return
end

function var_0_0.CanFormationMission(arg_7_0, arg_7_1)
	local var_7_9000

	if not arg_7_0:ExistMission(arg_7_1) then
		return false
	end

	local var_7_0 = getProxy(GuildProxy)

	if var_7_0.getRawData(var_7_9000):GetActiveEvent():GetMissionById(arg_7_1).GetCanFormationIndex(var_7_0) == -1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_fleet_can_not_edit"))

		return false
	end

	return true
end

function var_0_0.ExistBoss(arg_8_0)
	local var_8_9000

	if not arg_8_0:ExistActiveEvent() then
		return false
	end

	local var_8_0 = getProxy(GuildProxy)

	if not var_8_0 or not var_8_0.getRawData(var_8_9000):GetActiveEvent():GetBossMission():IsActive() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_boss"))

		return false
	end

	return true
end

function var_0_0.IsAnim(arg_9_0)
	if not GuildMember.IsAdministrator(getProxy(GuildProxy):getRawData():getSelfDuty()) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_commander_and_sub_op"))

		return false
	end

	return true
end

function var_0_0.CheckCapital(arg_10_0, arg_10_1, arg_10_2)
	if getProxy(GuildProxy):getRawData():getCapital() < arg_10_1:GetConsume() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_guildgold_no_enough_for_battle"))

		return false
	end

	return true
end

return var_0_0
