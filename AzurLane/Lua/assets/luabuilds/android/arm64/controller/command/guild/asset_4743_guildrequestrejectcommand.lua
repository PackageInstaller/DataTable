class = var_0_10000

local var_0_0 = "GuildRequestRejectCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = arg_1_1:getType()

	pg = var_1_0

	local var_1_3 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 60022, {
		player_id = var_1_1
	}, 60023, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.deleteRequest(var_2_10004, var_1_1)

			var_2_10004 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_5

			var_2_0(var_2_10004, var_5.GUIDL_REQUEST_REJECT_DONE)

			if not var_1_2 then
				pg = var_2
				var_2_10004 = var_2.TipsMgr.GetInstance()

				local var_2_1 = var_2.ShowTips

				i18n = var_5

				var_2_1(var_2_10004, var_5("guild_rejecet_apply_sucess"))
			end
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_3(var_2_2, var_2_10004("guild_reject_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
