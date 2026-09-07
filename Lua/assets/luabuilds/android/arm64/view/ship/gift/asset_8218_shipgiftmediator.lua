local ShipGiftMediator = class("ShipGiftMediator", import("view.base.ContextMediator"))

ShipGiftMediator.SHIP_GIFT = "ShipGiftMediator:shipGift"
ShipGiftMediator.ADD_SHIP_INTIMACY = "ShipGiftMediator:addShipIntimacy"

function ShipGiftMediator:register()
	self:bind(ShipGiftMediator.SHIP_GIFT, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)
	self:bind(ShipGiftMediator.ADD_SHIP_INTIMACY, function(arg_3_0, arg_3_1, arg_3_2)
		getProxy(BayProxy):RawGetShipById(arg_3_1.id):addLikability(arg_3_2)

		return
	end)

	return
end

function ShipGiftMediator:listNotificationInterests()
	return {
		GAME.USE_ITEM_DONE
	}
end

function ShipGiftMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.USE_ITEM_DONE then
		self.viewComponent:OnGiftSuccess((var_5_0.drops[1] or nil) and (var_5_0.drops[1].count or 0))
	end

	return
end

function ShipGiftMediator:remove()
	return
end

return ShipGiftMediator
