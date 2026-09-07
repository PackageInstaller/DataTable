local Dorm3dShopDetailMediator = class("Dorm3dShopDetailMediator", import("view.base.ContextMediator"))

Dorm3dShopDetailMediator.SHOPPING = "Dorm3dShopDetailMediator.SHOPPING"

function Dorm3dShopDetailMediator:register()
	self:bind(Dorm3dShopDetailMediator.SHOPPING, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_2_1.shopId,
			count = arg_2_1.count,
			silentTip = arg_2_1.silentTip
		})

		return
	end)

	return
end

function Dorm3dShopDetailMediator:listNotificationInterests()
	return {
		GAME.SHOPPING_DONE
	}
end

function Dorm3dShopDetailMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.SHOPPING_DONE then
		self.viewComponent:closeView()
	end

	return
end

function Dorm3dShopDetailMediator:remove()
	return
end

return Dorm3dShopDetailMediator
