class = var_0_10000

local var_0_0 = "GetMedalShopCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 16106, {
		type = 0
	}, 16107, function(arg_2_0)
		local var_2_0
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10005

			var_2_2(var_2_1, var_2_10005.GET_MEDALSHOP_DONE)

			MedalShop = var_2_2
			var_2_0 = var_2_2.New(arg_2_0)
			getProxy = var_2_2
			ShopsProxy = var_4

			if var_2_2(var_4).medalShop then
				var_2_10005 = var_2_2

				var_2_2.UpdateMedalShop(var_2_10005, var_2_0)
			else
				var_2_10005 = var_2_2

				var_2_2.SetMedalShop(var_2_10005, var_2_0)
			end
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_2.ShowTips

			ERROR_MESSAGE = var_2_10005

			var_2_4(var_2_3, var_2_10005[arg_2_0.result] .. arg_2_0.result)
		end

		if var_1_1 then
			var_1_1(var_2_0)
		end

		return
	end)

	return
end

return var_0_1
