class = var_0_10000

local var_0_0 = "GetRivalInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 18104, {
		id = var_1_1
	}, 18105, function(arg_2_0)
		local var_2_1

		if arg_2_0.info.id == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.TipsMgr.GetInstance()

			var_2_1 = var_2_1.ShowTips
			i18n = var_2_10003

			var_2_1(var_2_0, var_2_10003("common_get_player_info_erro"))
		else
			Rival = var_2_1

			local var_2_2 = var_2_1.New(arg_2_0.info)
			local var_2_3 = arg_1_0
			local var_2_4 = var_2.sendNotification

			GAME = var_2_10004

			var_2_4(var_2_3, var_2_10004.GET_RIVAL_INFO_DONE, {
				rival = var_2_2
			})
		end

		return
	end)

	return
end

return var_0_1
