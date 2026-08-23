local OutpostEntityBarrier = class("OutpostEntityBarrier", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityBarrier:ctor()
	OutpostEntityBarrier.super.ctor(self)

	self.entityType = require("app.view.module.outpost.const.OutpostConst").EntityType.Barrier
	self.barrierInfo = nil
end

function OutpostEntityBarrier:getBarrierInfo()
	return self.barrierInfo
end

function OutpostEntityBarrier:OnIn()
	return
end

function OutpostEntityBarrier:OnOut()
	return
end

return OutpostEntityBarrier
