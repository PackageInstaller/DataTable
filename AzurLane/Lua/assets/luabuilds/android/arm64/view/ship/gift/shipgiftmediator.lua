local var_0_0 = class("ShipGiftMediator", import("view.base.ContextMediator"))

var_0_0.SHIP_GIFT = "ShipGiftMediator:shipGift"
var_0_0.ADD_SHIP_INTIMACY = "ShipGiftMediator:addShipIntimacy"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SHIP_GIFT, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ADD_SHIP_INTIMACY, function(arg_3_0, arg_3_1, arg_3_2)
		getProxy(BayProxy):RawGetShipById(arg_3_1.id):addLikability(arg_3_2)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.USE_ITEM_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.USE_ITEM_DONE then
		if var_5_0.drops[1] then
			local var_5_1 = var_5_0.drops[1].count or 0

			arg_5_0.viewComponent:OnGiftSuccess(var_5_1)

			return
		end
	end
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
