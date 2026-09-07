local BuildShipRegularExchangeMediator = class("BuildShipRegularExchangeMediator", import("...base.ContextMediator"))

BuildShipRegularExchangeMediator.EXCHAGNE_SHIP = "BuildShipRegularExchangeMediator.EXCHAGNE_SHIP"

function BuildShipRegularExchangeMediator:register()
	self:bind(BuildShipRegularExchangeMediator.EXCHAGNE_SHIP, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.REGULAR_BUILD_POOL_EXCHANGE, {
			id = arg_2_1
		})

		return
	end)
	self.viewComponent:setCount(getProxy(BuildShipProxy):getRegularExchangeCount())

	return
end

function BuildShipRegularExchangeMediator:listNotificationInterests()
	return {
		GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE
	}
end

function BuildShipRegularExchangeMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE then
		self.viewComponent:flush()
	end

	return
end

return BuildShipRegularExchangeMediator
