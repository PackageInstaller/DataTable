local var_0_0 = g.core.config.outpost_item_info
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostEntityDrop = class("OutpostEntityDrop", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityDrop:ctor()
	OutpostEntityDrop.super.ctor(self)

	self.entityType = var_0_1.EntityType.Drop
	self.svrData = nil
	self._mapType = 1
end

function OutpostEntityDrop:onCreate(arg_2_1)
	self.itemInfo = var_0_0.get(arg_2_1.item_id)
	self.svrData = arg_2_1
end

function OutpostEntityDrop:setMapType(arg_3_1)
	self._mapType = arg_3_1
end

function OutpostEntityDrop:getMapType()
	return self._mapType
end

return OutpostEntityDrop
