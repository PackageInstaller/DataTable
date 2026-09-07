local GetActivityShopCommand = class("GetActivityShopCommand", pm.SimpleCommand)

function GetActivityShopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback
	local var_1_2 = getProxy(ShopsProxy)
	local var_1_3 = {}

	_.each(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_2_0)
		if arg_2_0 and not arg_2_0:isEnd() and arg_2_0:getConfig("config_id") == 0 then
			var_1_3[arg_2_0.id] = ActivityShop.New(arg_2_0)

			var_1_2:addActivityShops(var_1_3)
		end

		return
	end)
	self:sendNotification(GAME.GET_ACTIVITY_SHOP_DONE)

	if var_1_1 then
		var_1_1(var_1_3)
	end

	return
end

return GetActivityShopCommand
