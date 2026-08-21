local var_0_0 = class("GetMiniGameShopCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(26150, {
		type = 1
	}, 26151, function(arg_2_0)
		local var_2_0 = MiniGameShop.New(arg_2_0)
		local var_2_1 = getProxy(ShopsProxy):setMiniShop(var_2_0)

		arg_1_0:sendNotification(GAME.GET_MINI_GAME_SHOP_DONE)

		if var_1_1 then
			var_1_1(var_2_0)
		end

		return
	end)

	return
end

return var_0_0
