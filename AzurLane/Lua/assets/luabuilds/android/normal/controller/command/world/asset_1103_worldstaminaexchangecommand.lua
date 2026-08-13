class = var_0_10000

local var_0_0 = "WorldStaminaExchangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	PlayerProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	nowWorld = var_1_10004

	local var_1_3 = var_1_10004().staminaMgr
	local var_1_4, var_1_5, var_1_6, var_1_7 = var_4.GetExchangeData(var_1_3)

	pg = var_1_10009

	local var_1_8 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_8, 33108, {
		type = 1
	}, 33109, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_10003 = var_1.getData(var_2_0)

			var_1.consume(var_2_10003, {
				oil = var_1_5
			})

			var_2_10003 = var_1_2

			var_2.updatePlayer(var_2_10003, var_1)

			var_2_10003 = var_0

			var_2.ExchangeStamina(var_2_10003, var_1_4, true)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.WORLD_STAMINA_EXCHANGE_DONE)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("world_stamina_exchange_err_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
