local OutpostEntityMask = class("OutpostEntityMask", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityMask:ctor()
	OutpostEntityMask.super.ctor(self)

	self.entityType = require("app.view.module.outpost.const.OutpostConst").EntityType.Mask
end

return OutpostEntityMask
