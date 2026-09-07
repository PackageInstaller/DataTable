local ChargeActGiftMediator = class("ChargeActGiftMediator", import("view.base.ContextMediator"))

ChargeActGiftMediator.DO_PAY = "ChargeActGiftMediator.DO_PAY"
ChargeActGiftMediator.GO_SHOP = "ChargeActGiftMediator.GO_SHOP"

function ChargeActGiftMediator:register()
	self:bind(ChargeActGiftMediator.DO_PAY, function(arg_2_0)
		local var_2_0 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)

		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = var_2_0.id,
			costDrop = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResDiamond,
				count = GiftActCommodity.CalcPrice(var_2_0)
			})
		})

		return
	end)
	self:bind(ChargeActGiftMediator.GO_SHOP, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

function ChargeActGiftMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function ChargeActGiftMediator:handleNotification(arg_5_1)
	if arg_5_1:getName() == ActivityProxy.ACTIVITY_OPERATION_DONE and arg_5_1:getBody() == self.contextData.actId then
		self.viewComponent:closeView()
	end

	return
end

return ChargeActGiftMediator
