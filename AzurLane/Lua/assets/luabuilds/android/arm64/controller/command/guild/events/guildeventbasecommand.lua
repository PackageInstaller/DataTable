class = var_0_10000

local var_0_0 = "GuildEventBaseCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.ExistGuild(arg_1_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	if not var_1.getRawData(var_1_0) then
		pg = var_1_10002

		local var_1_1 = var_1_10002.TipsMgr.GetInstance()
		local var_1_2 = var_2.ShowTips

		i18n = var_1_10005

		var_1_2(var_1_1, var_1_10005("guild_not_exist"))

		return false
	end

	return true
end

function var_0_1.ExistEvent(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getRawData(var_2_0)

	if not var_2.GetEventById(var_2_1, arg_2_1) then
		pg = var_2_0

		local var_2_2 = var_2_0.TipsMgr.GetInstance()
		local var_2_3 = var_4.ShowTips

		i18n = var_1_10007

		var_2_3(var_2_2, var_1_10007("guild_not_exist_battle"))

		return false
	end

	return true
end

function var_0_1.ExistActiveEvent(arg_3_0)
	local var_3_0 = arg_3_0

	if not arg_3_0.ExistGuild(var_3_0) then
		return false
	end

	getProxy = var_1
	GuildProxy = var_3_0

	local var_3_1 = var_1(var_3_0)
	local var_3_2 = var_1.getRawData(var_3_1)

	if not var_1.GetActiveEvent(var_3_2) or var_2 and var_2:IsExpired() then
		pg = var_3_1

		local var_3_3 = var_3_1.TipsMgr.GetInstance()
		local var_3_4 = var_3.ShowTips

		i18n = var_1_10006

		var_3_4(var_3_3, var_1_10006("guild_battle_is_end"))

		return false
	end

	return true
end

function var_0_1.NotExistActiveEvent(arg_4_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getRawData(var_4_0)

	if var_1.GetActiveEvent(var_4_1) then
		pg = var_4_0

		local var_4_2 = var_4_0.TipsMgr.GetInstance()
		local var_4_3 = var_3.ShowTips

		i18n = var_1_10006

		var_4_3(var_4_2, var_1_10006("guild_battle_is_exist"))

		return false
	end

	return true
end

function var_0_1.ExistMission(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0

	if not arg_5_0.ExistActiveEvent(var_5_0) then
		return false
	end

	getProxy = var_2
	GuildProxy = var_5_0

	local var_5_1 = var_2(var_5_0)
	local var_5_2 = var_2.getRawData(var_5_1)
	local var_5_3 = var_2.GetActiveEvent(var_5_2)

	if arg_5_1 and var_5_3:GetMissionById(arg_5_1) == nil then
		pg = var_4

		local var_5_4 = var_4.TipsMgr.GetInstance()
		local var_5_5 = var_4.ShowTips

		i18n = var_7

		var_5_5(var_5_4, var_7("guild_event_not_exist"))

		return false
	end

	return true
end

function var_0_1.GetMissionById(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0

	if arg_6_0.ExistMission(var_6_0, arg_6_1) then
		getProxy = var_2
		GuildProxy = var_6_0

		local var_6_1 = var_2(var_6_0)
		local var_6_2 = var_2.getRawData(var_6_1)
		local var_6_3 = var_2.GetActiveEvent(var_6_2)

		return var_3.GetMissionById(var_6_3, arg_6_1)
	end

	return
end

function var_0_1.CanFormationMission(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0

	if not arg_7_0.ExistMission(var_7_0, arg_7_1) then
		return false
	end

	getProxy = var_2
	GuildProxy = var_7_0

	local var_7_1 = var_2(var_7_0)
	local var_7_2 = var_2.getRawData(var_7_1)
	local var_7_3 = var_2.GetActiveEvent(var_7_2)
	local var_7_4 = var_3.GetMissionById(var_7_3, arg_7_1)

	if var_4.GetCanFormationIndex(var_7_4) == -1 then
		pg = var_5

		local var_7_5 = var_5.TipsMgr.GetInstance()
		local var_7_6 = var_5.ShowTips

		i18n = var_1_10008

		var_7_6(var_7_5, var_1_10008("guild_fleet_can_not_edit"))

		return false
	end

	return true
end

function var_0_1.ExistBoss(arg_8_0)
	local var_8_0 = arg_8_0

	if not arg_8_0.ExistActiveEvent(var_8_0) then
		return false
	end

	getProxy = var_1
	GuildProxy = var_8_0

	local var_8_1 = var_1(var_8_0)
	local var_8_2 = var_1.getRawData(var_8_1)
	local var_8_3 = var_1.GetActiveEvent(var_8_2)

	if not var_2.GetBossMission(var_8_3) or not var_3:IsActive() then
		pg = var_8_2

		local var_8_4 = var_8_2.TipsMgr.GetInstance()
		local var_8_5 = var_4.ShowTips

		i18n = var_1_10007

		var_8_5(var_8_4, var_1_10007("guild_not_exist_boss"))

		return false
	end

	return true
end

function var_0_1.IsAnim(arg_9_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0)

	GuildMember = var_1_10002

	local var_9_2 = var_1_10002.IsAdministrator
	local var_9_3 = var_9_1

	if not var_9_2(var_9_1.getSelfDuty(var_9_3)) then
		pg = var_9_0

		local var_9_4 = var_9_0.TipsMgr.GetInstance()
		local var_9_5 = var_3.ShowTips

		i18n = var_9_3

		var_9_5(var_9_4, var_9_3("guild_commander_and_sub_op"))

		return false
	end

	return true
end

function var_0_1.CheckCapital(arg_10_0, arg_10_1, arg_10_2)
	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_10_0 = var_1_10003(var_1_10005)
	local var_10_1 = var_3.getRawData(var_10_0)

	if var_3.getCapital(var_10_1) < arg_10_1:GetConsume() then
		pg = var_5

		local var_10_2 = var_5.TipsMgr.GetInstance()
		local var_10_3 = var_5.ShowTips

		i18n = var_1_10008

		var_10_3(var_10_2, var_1_10008("guild_guildgold_no_enough_for_battle"))

		return false
	end

	return true
end

return var_0_1
