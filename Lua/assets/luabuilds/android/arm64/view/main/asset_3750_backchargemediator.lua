local BackChargeMediator = class("BackChargeMediator", import("..base.ContextMediator"))

BackChargeMediator.CHARGE = "BackChargeMediator:CHARGE"

function BackChargeMediator:register()
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	local var_1_0 = getProxy(ShopsProxy):getChargedList()

	if var_1_0 then
		self.viewComponent:setChargedList(var_1_0)
	end

	self:bind(BackChargeMediator.CHARGE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.REFUND_CHHARGE, {
			shopId = arg_2_1
		})

		return
	end)

	return
end

function BackChargeMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS,
		GAME.REFUND_INFO_UPDATE
	}
end

function BackChargeMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == PlayerProxy.UPDATED then
		-- block empty
	elseif var_4_0 == ShopsProxy.CHARGED_LIST_UPDATED then
		-- block empty
	elseif var_4_0 == GAME.CHARGE_CONFIRM_FAILED then
		-- block empty
	elseif var_4_0 == GAME.CHARGE_SUCCESS then
		self:sendNotification(GAME.GET_REFUND_INFO)
	elseif var_4_0 == GAME.REFUND_INFO_UPDATE then
		self.viewComponent:refundUpdate()
	end

	return
end

return BackChargeMediator
