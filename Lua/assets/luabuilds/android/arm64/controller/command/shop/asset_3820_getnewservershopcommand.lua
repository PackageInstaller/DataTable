local GetNewServerShopCommand = class("GetNewServerShopCommand", pm.SimpleCommand)

function GetNewServerShopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.actType or ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP
	local var_1_3 = getProxy(ActivityProxy):getActivityByType(var_1_2)

	if not var_1_3 or var_1_3:isEnd() then
		var_1_0.callback()

		return
	end

	pg.ConnectionMgr.GetInstance():Send(26041, {
		act_id = var_1_3.id
	}, 26042, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0

			if var_1_2 == ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP then
				var_2_0 = NewServerShop.New({
					start_time = arg_2_0.start_time,
					stop_time = arg_2_0.stop_time,
					goods = arg_2_0.goods,
					id = var_1_3.id
				})
			elseif var_1_2 == ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP then
				var_2_0 = BlackFridayShop.New({
					start_time = arg_2_0.start_time,
					stop_time = arg_2_0.stop_time,
					goods = arg_2_0.goods,
					id = var_1_3.id
				})
			end

			getProxy(ShopsProxy):SetNewServerShop(var_1_2, var_2_0)
			var_1_1(var_2_0)
			self:sendNotification(GAME.GET_NEW_SERVER_SHOP_DONE)
		else
			var_1_1()
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GetNewServerShopCommand
