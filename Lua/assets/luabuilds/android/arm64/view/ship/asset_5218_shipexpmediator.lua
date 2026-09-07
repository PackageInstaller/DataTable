local ShipExpMediator = class("ShipExpMediator", import("..base.ContextMediator"))

function ShipExpMediator:register()
	self.contextData.type = self.contextData.type or ShipExpLayer.TypeDefault

	return
end

return ShipExpMediator
