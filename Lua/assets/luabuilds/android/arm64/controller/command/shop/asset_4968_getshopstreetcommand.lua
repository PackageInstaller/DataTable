local GetShopStreetCommand = class("GetShopStreetCommand", pm.SimpleCommand)

function GetShopStreetCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(22101, {
		type = 0
	}, 22102, function(arg_2_0)
		self:sendNotification(GAME.GET_SHOPSTREET_DONE)

		if var_1_1 then
			var_1_1((getProxy(ShopsProxy):getShopStreet()))
		end

		return
	end)

	return
end

return GetShopStreetCommand
