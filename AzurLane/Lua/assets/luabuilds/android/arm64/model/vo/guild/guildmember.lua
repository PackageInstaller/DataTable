class = var_0_10000

local var_0_0 = "GuildMember"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..Friend"))
local var_0_2 = {}

i18n = var_0_0
var_0_2[1] = var_0_0("guild_word_commder")
i18n = var_2
var_0_2[2] = var_2("guild_word_deputy_commder")
i18n = var_2
var_0_2[3] = var_2("guild_word_picked")
i18n = var_2
var_0_2[4] = var_2("guild_word_ordinary")

function var_0_1.IsAdministrator(arg_1_0)
	GuildConst = var_1_10001

	local var_1_0

	if arg_1_0 ~= var_1_10001.DUTY_COMMANDER then
		GuildConst = var_1

		if arg_1_0 ~= var_1.DUTY_DEPUTY_COMMANDER then
			var_1_0 = false

			goto label_1_0
		end
	end

	var_1_0 = true

	::label_1_0::

	return var_1_0
end

function var_0_1.isCommander(arg_2_0)
	GuildConst = var_1_10001

	return arg_2_0 == var_1_10001.DUTY_COMMANDER
end

function var_0_1.dutyId2Name(arg_3_0)
	return var_0_2[arg_3_0]
end

function var_0_1.Ctor(arg_4_0, arg_4_1)
	var_0_1.super.Ctor(arg_4_0, arg_4_1)

	local var_4_0

	if not arg_4_1.liveness then
		var_4_0 = 0
	end

	arg_4_0.liveness = var_4_0

	local var_4_1

	if not arg_4_1.duty then
		GuildConst = var_4_1
		var_4_1 = var_4_1.DUTY_RECRUIT
	end

	arg_4_0.duty = var_4_1

	local var_4_2

	if not arg_4_1.join_time then
		var_4_2 = 0
	end

	arg_4_0.joinTime = var_4_2
	GuildAssaultFleet = var_4_2
	arg_4_0.assaultFleet = var_4_2.New({
		user_id = arg_4_0.id
	})
	GuildAssaultFleet = var_2
	arg_4_0.externalAssaultFleet = var_2.New({
		user_id = arg_4_0.id
	})

	if arg_4_0.icon == 1 then
		arg_4_0.icon = 101171
	end

	return
end

function var_0_1.GetLiveness(arg_5_0)
	return arg_5_0.liveness
end

function var_0_1.IsRecruit(arg_6_0)
	local var_6_0 = arg_6_0.duty

	GuildConst = var_1_10002

	return var_6_0 == var_1_10002.DUTY_RECRUIT
end

function var_0_1.AddLiveness(arg_7_0, arg_7_1)
	print = var_1_10002

	var_1_10002("add member liveness", arg_7_1)

	arg_7_0.liveness = arg_7_0.liveness + arg_7_1

	if arg_7_0:CanUpgradeDuty() then
		arg_7_0.duty = arg_7_0.duty - 1
	end

	return
end

function var_0_1.CanUpgradeDuty(arg_8_0)
	local var_8_0 = arg_8_0.duty

	GuildConst = var_1_10002

	if var_8_0 == var_1_10002.DUTY_RECRUIT then
		local var_8_1 = arg_8_0.liveness

		pg = var_2

		local var_8_2

		if not (var_8_1 >= var_2.guildset.guild_active_become_regular.key_value) then
			var_8_2 = false
		else
			var_8_2 = true
		end

		return var_8_2
	end
end

function var_0_1.UpdateExternalAssaultFleet(arg_9_0, arg_9_1)
	arg_9_0.externalAssaultFleet = arg_9_1

	return
end

function var_0_1.GetExternalAssaultFleet(arg_10_0)
	return arg_10_0.externalAssaultFleet
end

function var_0_1.UpdateAssaultFleet(arg_11_0, arg_11_1)
	arg_11_0.assaultFleet = arg_11_1

	return
end

function var_0_1.GetAssaultFleet(arg_12_0)
	return arg_12_0.assaultFleet
end

function var_0_1.UpdateAssaultFleetShips(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.assaultFleet

	var_3.InitShips(var_13_0, arg_13_1, arg_13_2)

	return
end

function var_0_1.UpdateExternalAssaultFleetShips(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.externalAssaultFleet

	var_3.InitShips(var_14_0, arg_14_1, arg_14_2)

	return
end

function var_0_1.isNewMember(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.TimeMgr.GetInstance()
	local var_15_1 = var_1.GetServerTime(var_15_0)

	if arg_15_0.joinTime ~= 0 and var_1:IsSameDay(var_15_1, arg_15_0.joinTime) then
		return true
	end

	return false
end

function var_0_1.setDuty(arg_16_0, arg_16_1)
	arg_16_0.duty = arg_16_1

	return
end

function var_0_1.GetDuty(arg_17_0)
	return arg_17_0.duty
end

function var_0_1.IsCommander(arg_18_0)
	local var_18_0 = arg_18_0.duty

	GuildConst = var_1_10002

	return var_18_0 == var_1_10002.DUTY_COMMANDER
end

function var_0_1.isLongOffLine(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_19_0) - arg_19_0.preOnLineTime > 0
end

function var_0_1.setDamage(arg_20_0, arg_20_1)
	arg_20_0.damage = arg_20_1

	return
end

function var_0_1.getDamage(arg_21_0)
	if arg_21_0.damage then
		return arg_21_0.damage
	end

	return 0
end

function var_0_1.GetShip(arg_22_0)
	Ship = var_1_10001

	return var_1_10001.New({
		configId = arg_22_0.icon,
		skin_id = arg_22_0.skinId,
		name = arg_22_0.name
	})
end

function var_0_1.GetJoinZeroTime(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetNextTimeByTimeStamp(var_23_0, arg_23_0.joinTime)
end

return var_0_1
