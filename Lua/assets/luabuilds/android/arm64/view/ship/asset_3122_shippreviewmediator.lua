local ShipPreviewMediator = class("ShipPreviewMediator", import("..base.ContextMediator"))

function ShipPreviewMediator:register()
	assert(self.contextData.shipVO, "shipVO is nil")
	assert(self.contextData.weaponIds, "weaponIds is nil")
	assert(self.contextData.equipSkinId, "equipment skin id is nil")
	self.viewComponent:setShip(self.contextData.shipVO, self.contextData.weaponIds, self.contextData.equipSkinId)

	return
end

function ShipPreviewMediator:listNotificationInterests()
	return {}
end

function ShipPreviewMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ShipPreviewMediator
