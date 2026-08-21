local var_0_0 = class("GuildMember", import("..Friend"))
local var_0_1 = {
	i18n("guild_word_commder"),
	i18n("guild_word_deputy_commder"),
	i18n("guild_word_picked"),
	i18n("guild_word_ordinary")
}

function var_0_0.IsAdministrator(arg_1_0)
	return arg_1_0 == GuildConst.DUTY_COMMANDER or arg_1_0 == GuildConst.DUTY_DEPUTY_COMMANDER
end

function var_0_0.isCommander(arg_2_0)
	return arg_2_0 == GuildConst.DUTY_COMMANDER
end

function var_0_0.dutyId2Name(arg_3_0)
	return var_0_1[arg_3_0]
end

function var_0_0.Ctor(arg_4_0, arg_4_1)
	var_0_0.super.Ctor(arg_4_0, arg_4_1)

	arg_4_0.liveness = arg_4_1.liveness or 0
	arg_4_0.duty = arg_4_1.duty or GuildConst.DUTY_RECRUIT
	arg_4_0.joinTime = arg_4_1.join_time or 0
	arg_4_0.assaultFleet = GuildAssaultFleet.New({
		user_id = arg_4_0.id
	})
	arg_4_0.externalAssaultFleet = GuildAssaultFleet.New({
		user_id = arg_4_0.id
	})

	if arg_4_0.icon == 1 then
		arg_4_0.icon = 101171
	end

	return
end

function var_0_0.GetLiveness(arg_5_0)
	return arg_5_0.liveness
end

function var_0_0.IsRecruit(arg_6_0)
	return arg_6_0.duty == GuildConst.DUTY_RECRUIT
end

function var_0_0.AddLiveness(arg_7_0, arg_7_1)
	print("add member liveness", arg_7_1)

	arg_7_0.liveness = arg_7_0.liveness + arg_7_1

	if arg_7_0:CanUpgradeDuty() then
		arg_7_0.duty = arg_7_0.duty - 1
	end

	return
end

function var_0_0.CanUpgradeDuty(arg_8_0)
	return arg_8_0.duty == GuildConst.DUTY_RECRUIT and arg_8_0.liveness >= pg.guildset.guild_active_become_regular.key_value
end

function var_0_0.UpdateExternalAssaultFleet(arg_9_0, arg_9_1)
	arg_9_0.externalAssaultFleet = arg_9_1

	return
end

function var_0_0.GetExternalAssaultFleet(arg_10_0)
	return arg_10_0.externalAssaultFleet
end

function var_0_0.UpdateAssaultFleet(arg_11_0, arg_11_1)
	arg_11_0.assaultFleet = arg_11_1

	return
end

function var_0_0.GetAssaultFleet(arg_12_0)
	return arg_12_0.assaultFleet
end

function var_0_0.UpdateAssaultFleetShips(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.assaultFleet:InitShips(arg_13_1, arg_13_2)

	return
end

function var_0_0.UpdateExternalAssaultFleetShips(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.externalAssaultFleet:InitShips(arg_14_1, arg_14_2)

	return
end

function var_0_0.isNewMember(arg_15_0)
	local var_15_0 = pg.TimeMgr.GetInstance()

	if arg_15_0.joinTime ~= 0 and var_15_0:IsSameDay(var_15_0:GetServerTime(), arg_15_0.joinTime) then
		return true
	end

	return false
end

function var_0_0.setDuty(arg_16_0, arg_16_1)
	arg_16_0.duty = arg_16_1

	return
end

function var_0_0.GetDuty(arg_17_0)
	return arg_17_0.duty
end

function var_0_0.IsCommander(arg_18_0)
	return arg_18_0.duty == GuildConst.DUTY_COMMANDER
end

function var_0_0.isLongOffLine(arg_19_0)
	local var_19_0 = pg.TimeMgr.GetInstance():GetServerTime() - arg_19_0.preOnLineTime

	return var_19_0 > 0
end

function var_0_0.setDamage(arg_20_0, arg_20_1)
	arg_20_0.damage = arg_20_1

	return
end

function var_0_0.getDamage(arg_21_0)
	if arg_21_0.damage then
		return arg_21_0.damage
	end

	return 0
end

function var_0_0.GetShip(arg_22_0)
	return Ship.New({
		configId = arg_22_0.icon,
		skin_id = arg_22_0.skinId,
		name = arg_22_0.name
	})
end

function var_0_0.GetJoinZeroTime(arg_23_0)
	return pg.TimeMgr.GetInstance():GetNextTimeByTimeStamp(arg_23_0.joinTime)
end

return var_0_0
