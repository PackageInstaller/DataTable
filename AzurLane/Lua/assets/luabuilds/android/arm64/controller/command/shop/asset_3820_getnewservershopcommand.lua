class = var_0_10000

local var_0_0 = "GetNewServerShopCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1

	if not var_2.actType then
		ActivityConst = var_1_1
		var_1_1 = var_1_1.ACTIVITY_TYPE_NEWSERVER_SHOP
	end

	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getActivityByType(var_1_2, var_1_1) or var_5:isEnd() then
		var_1_0()

		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 26041, {
		act_id = var_5.id
	}, 26042, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0
			local var_2_1 = var_1_1

			ActivityConst = var_2_10003

			if var_2_1 == var_2_10003.ACTIVITY_TYPE_NEWSERVER_SHOP then
				NewServerShop = var_2_1
				var_2_0 = var_2_1.New({
					start_time = arg_2_0.start_time,
					stop_time = arg_2_0.stop_time,
					goods = arg_2_0.goods,
					id = var_0.id
				})
			else
				var_2_1 = var_1_1
				ActivityConst = var_3

				if var_2_1 == var_3.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP then
					BlackFridayShop = var_2_1
					var_2_0 = var_2_1.New({
						start_time = arg_2_0.start_time,
						stop_time = arg_2_0.stop_time,
						goods = arg_2_0.goods,
						id = var_0.id
					})
				end
			end

			getProxy = var_2_1
			ShopsProxy = var_2_10004
			var_2_10004 = var_2_1(var_2_10004)

			var_2.SetNewServerShop(var_2_10004, var_1_1, var_2_0)
			var_1_0(var_2_0)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.GET_NEW_SERVER_SHOP_DONE)
		else
			var_1_0()

			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
