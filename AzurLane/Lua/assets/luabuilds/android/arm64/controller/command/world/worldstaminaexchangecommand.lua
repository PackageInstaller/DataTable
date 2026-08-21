local var_0_0 = class("WorldStaminaExchangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = nowWorld().staminaMgr
	local var_1_3, var_1_4, var_1_5, var_1_6 = nowWorld().staminaMgr:GetExchangeData()

	pg.ConnectionMgr.GetInstance():Send(33108, {
		type = 1
	}, 33109, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1:getData()

			var_2_0:consume({
				oil = var_1_4
			})
			var_1_1:updatePlayer(var_2_0)
			var_1_2:ExchangeStamina(var_1_3, true)
			arg_1_0:sendNotification(GAME.WORLD_STAMINA_EXCHANGE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_stamina_exchange_err_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
