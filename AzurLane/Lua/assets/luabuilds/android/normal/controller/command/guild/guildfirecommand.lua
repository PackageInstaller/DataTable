class = var_0_10000

local var_0_0 = "GuildFireCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	GuildProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_1_3 = var_1_10004(var_1_10005)
	local var_1_4 = var_4.getData(var_1_3)
	local var_1_5 = var_1_2:getData()
	local var_1_6 = var_6.getDutyByMemberId(var_1_5, var_1_4.id)
	local var_1_7 = var_6

	if var_1_6 >= var_6.getDutyByMemberId(var_1_7, var_1_1) then
		pg = var_1_7

		local var_1_8 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10011

		var_1_7(var_1_8, var_1_10011("guild_fire_duty_limit"))

		return
	end

	pg = var_1_7

	local var_1_9 = var_1_7.ConnectionMgr.GetInstance()

	var_9.Send(var_1_9, 60014, {
		player_id = var_1_1
	}, 60015, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_1 = var_2_1.getData(var_2_0)
			var_2_10003 = var_1_2
			var_2_10003 = var_2.getData(var_2_10003)

			var_2_1.deleteMember(var_2_10003, var_1_1)

			var_2_10003 = var_1_2

			var_2.updateGuild(var_2_10003, var_2_1)

			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_10003, var_4.GUILD_FIRE_DONE)

			pg = var_2_2
			var_2_10003 = var_2_2.TipsMgr.GetInstance()

			local var_2_3 = var_2.ShowTips

			i18n = var_4

			var_2_3(var_2_10003, var_4("guild_fire_succeed"))
		else
			pg = var_2_1

			local var_2_4 = var_2_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("guild_fire_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
