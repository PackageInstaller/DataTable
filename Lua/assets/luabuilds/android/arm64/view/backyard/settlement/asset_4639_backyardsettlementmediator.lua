local BackYardSettlementMediator = class("BackYardSettlementMediator", import("...base.ContextMediator"))

function BackYardSettlementMediator:register()
	self.viewComponent:setShipVOs(self.contextData.oldShips, self.contextData.newShips)
	self.viewComponent:setDormVO(getProxy(DormProxy):getRawData())

	return
end

function BackYardSettlementMediator:listNotificationInterests()
	return {}
end

function BackYardSettlementMediator:handleNotification()
	return
end

return BackYardSettlementMediator
