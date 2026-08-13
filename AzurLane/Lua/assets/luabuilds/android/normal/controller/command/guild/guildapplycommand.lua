class = var_0_10000

local var_0_0 = "GuildApplyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1

	if not var_2.content then
		var_1_1 = ""
	end

	wordVer = var_1_10005

	local var_1_3

	if var_1_10005(var_1_1) > 0 then
		pg = var_1_3

		local var_1_2 = var_1_3.TipsMgr.GetInstance()

		var_1_3 = var_1_3.ShowTips
		i18n = var_1_10007

		var_1_3(var_1_2, var_1_10007("friend_msg_forbid"))

		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 60005, {
		id = var_1_0,
		content = var_1_1
	}, 60006, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10003

			var_2_1(var_2_0, var_2_10003.GUILD_APPLY_DONE)

			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10003

			var_2_3(var_2_2, var_2_10003("guild_apply_sucess"))
		elseif arg_2_0.result == 4 then
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("guild_join_cd"))
		elseif arg_2_0.result == 6 then
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10003

			var_2_7(var_2_6, var_2_10003("guild_apply_full"))
		elseif arg_2_0.result == 4305 then
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			i18n = var_2_10003

			var_2_9(var_2_8, var_2_10003("guild_tip_grand_fleet_is_frozen"))
		else
			local var_2_11

			if arg_2_0.result == 4306 then
				pg = var_2_11

				local var_2_10 = var_2_11.TipsMgr.GetInstance()

				var_2_11 = var_2_11.ShowTips
				i18n = var_2_10003

				var_2_11(var_2_10, var_2_10003("guild_member_full"))
			else
				pg = var_2_11

				local var_2_12 = var_2_11.TipsMgr.GetInstance()
				local var_2_13 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_13(var_2_12, var_2_10003("guild_apply_erro", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
