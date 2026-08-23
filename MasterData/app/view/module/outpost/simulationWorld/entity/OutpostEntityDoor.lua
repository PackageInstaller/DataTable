local OutpostEntityDoor = class("OutpostEntityDoor", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityDoor:ctor()
	OutpostEntityDoor.super.ctor(self)

	self.entityType = require("app.view.module.outpost.const.OutpostConst").EntityType.Door
	self.doorMapCfg = nil
end

function OutpostEntityDoor:setDoorMapCfg(arg_2_1)
	self.doorMapCfg = arg_2_1
end

function OutpostEntityDoor:getDoorMapCfg()
	return self.doorMapCfg
end

return OutpostEntityDoor
