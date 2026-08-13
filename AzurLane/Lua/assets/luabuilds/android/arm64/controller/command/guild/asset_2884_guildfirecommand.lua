class = var_0_10000

local var_0_0 = "GuildFireCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)
	local var_1_4 = var_4.getData(var_1_3)
	local var_1_5 = var_1_2:getData()

	if var_6.getDutyByMemberId(var_1_5, var_1_4.id) >= var_6:getDutyByMemberId(var_1_1) then
		pg = var_1_5

		local var_1_6 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10012

		var_1_5(var_1_6, var_1_10012("guild_fire_duty_limit"))

		return
	end

	pg = var_1_5

	local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 60014, {
		player_id = var_1_1
	}, 60015, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_1 = var_2_1.getData(var_2_0)
			var_2_10004 = var_1_2
			var_2_10004 = var_2.getData(var_2_10004)

			var_2_1.deleteMember(var_2_10004, var_1_1)

			var_2_10004 = var_1_2

			var_2.updateGuild(var_2_10004, var_2_1)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.GUILD_FIRE_DONE)

			pg = var_2_2
			var_2_10004 = var_2_2.TipsMgr.GetInstance()

			local var_2_3 = var_2.ShowTips

			i18n = var_5

			var_2_3(var_2_10004, var_5("guild_fire_succeed"))
		else
			pg = var_2_1

			local var_2_4 = var_2_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_5(var_2_4, var_2_10004("guild_fire_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
