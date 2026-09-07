local ShipEvaluationMediator = class("ShipEvaluationMediator", import("..base.ContextMediator"))

function ShipEvaluationMediator:register()
	self.showTrans = self.contextData.showTrans
	self.groupId = self.contextData.groupId

	self.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(self.groupId)))
	self.viewComponent:setShowTrans(self.showTrans)
	self.viewComponent:flushAll()
	self:bind(ShipEvaluationLayer.EVENT_LIKE, function(arg_2_0)
		self:sendNotification(GAME.LIKE_SHIP, self.groupId)

		return
	end)
	self:bind(ShipEvaluationLayer.EVENT_EVA, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.EVALUATE_SHIP, {
			groupId = self.groupId,
			content = arg_3_1
		})

		return
	end)
	self:bind(ShipEvaluationLayer.EVENT_ZAN, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.ZAN_SHIP_EVALUATION, {
			groupId = self.groupId,
			evaId = arg_4_1,
			operation = arg_4_2
		})

		return
	end)
	self:bind(ShipEvaluationLayer.EVENT_IMPEACH, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.IMPEACH_SHIP_EVALUATION, {
			groupId = self.groupId,
			evaId = arg_5_1,
			reason = arg_5_2
		})

		return
	end)

	return
end

function ShipEvaluationMediator:listNotificationInterests()
	return {
		CollectionProxy.GROUP_INFO_UPDATE,
		CollectionProxy.GROUP_EVALUATION_UPDATE
	}
end

function ShipEvaluationMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == CollectionProxy.GROUP_INFO_UPDATE then
		if self.groupId == var_7_1 then
			self.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(var_7_1)))
			self.viewComponent:flushHeart()
		end
	elseif var_7_0 == CollectionProxy.GROUP_EVALUATION_UPDATE then
		if self.groupId == var_7_1 then
			self.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(var_7_1)))
			self.viewComponent:flushEva()
		end
	end

	return
end

return ShipEvaluationMediator
