class = var_0_10000

local var_0_0 = "GetShopStreetCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 22101, {
		type = 0
	}, 22102, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.GET_SHOPSTREET_DONE)

		getProxy = var_2_1
		ShopsProxy = var_2_0

		local var_2_2 = var_2_1(var_2_0)
		local var_2_3 = var_1.getShopStreet(var_2_2)

		if var_1_0 then
			var_1_0(var_2_3)
		end

		return
	end)

	return
end

return var_0_1
