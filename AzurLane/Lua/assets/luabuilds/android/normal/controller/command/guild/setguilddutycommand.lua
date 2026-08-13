class = var_0_10000

local var_0_0 = "SetGuildDutyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().playerId

	if not var_2.dutyId then
		pg = var_1_10005
		var_1_10006 = var_1_10005.TipsMgr.GetInstance()
		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10007

		var_1_10005(var_1_10006, var_1_10007("guild_duty_id_is_null"))

		return
	end

	if not var_1_0 then
		pg = var_1_10005
		var_1_10006 = var_1_10005.TipsMgr.GetInstance()
		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10007

		var_1_10005(var_1_10006, var_1_10007("guild_player_is_null"))

		return
	end

	getProxy = var_1_10005
	GuildProxy = var_1_10006

	local var_1_1 = var_1_10005(var_1_10006)
	local var_1_2 = var_5.getData(var_1_1)

	GuildConst = var_1_1

	local var_1_3

	if var_4 == var_1_1.DUTY_DEPUTY_COMMANDER then
		var_1_3 = var_1_2:getAssistantCount()

		local var_1_4 = var_1_2

		if var_1_3 == var_1_2.getAssistantMaxCount(var_1_4) then
			pg = var_1_3

			local var_1_5 = var_1_3.TipsMgr.GetInstance()

			var_1_3 = var_1_3.ShowTips
			i18n = var_1_4

			var_1_3(var_1_5, var_1_4("guild_duty_commder_max_count"))

			return
		end
	end

	pg = var_1_3

	local var_1_6 = var_1_3.ConnectionMgr.GetInstance()

	var_7.Send(var_1_6, 60012, {
		player_id = var_1_0,
		duty_id = var_4
	}, 60013, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getData(var_2_10003)
			local var_2_1 = var_2.getMemberById(var_2_0, var_1_0)

			var_2_10003.setDuty(var_2_1, var_0)

			local var_2_2 = var_0

			GuildConst = var_2_1

			if var_2_2 == var_2_1.DUTY_COMMANDER then
				getProxy = var_2_2
				PlayerProxy = var_5

				local var_2_3 = var_2_2(var_5)
				local var_2_4 = var_4.getRawData(var_2_3).id
				local var_2_5 = var_2:getMemberById(var_2_4)
				local var_2_6 = var_5.setDuty

				GuildConst = var_2_10008

				var_2_6(var_2_5, var_2_10008.DUTY_ORDINARY)
			end

			var_1:updateGuild(var_2)

			local var_2_7 = arg_1_0
			local var_2_8 = var_4.sendNotification

			GAME = var_6

			var_2_8(var_2_7, var_6.SET_GUILD_DUTY_DONE, var_2_10003)

			pg = var_2_8

			local var_2_9 = var_2_8.TipsMgr.GetInstance()
			local var_2_10 = var_4.ShowTips

			i18n = var_6

			var_2_10(var_2_9, var_6("guild_set_duty_sucess"))
		else
			pg = var_1

			local var_2_11 = var_1.TipsMgr.GetInstance()
			local var_2_12 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_12(var_2_11, var_2_10003("guild_setduty_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
