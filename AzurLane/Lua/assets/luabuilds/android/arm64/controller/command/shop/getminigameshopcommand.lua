class = var_0_10000

local var_0_0 = "GetMiniGameShopCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 26150, {
		type = 1
	}, 26151, function(arg_2_0)
		MiniGameShop = var_2_10001

		local var_2_0 = var_2_10001.New(arg_2_0)

		getProxy = var_2_10002
		ShopsProxy = var_2_10004

		local var_2_1 = var_2_10002(var_2_10004)
		local var_2_2 = var_2.setMiniShop(var_2_1, var_2_0)
		local var_2_3 = arg_1_0
		local var_2_4 = var_3.sendNotification

		GAME = var_2_10006

		var_2_4(var_2_3, var_2_10006.GET_MINI_GAME_SHOP_DONE)

		if var_1_1 then
			var_1_1(var_2_0)
		end

		return
	end)

	return
end

return var_0_1
