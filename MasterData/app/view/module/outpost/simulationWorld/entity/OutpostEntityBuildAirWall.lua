local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildAirWall = class("OutpostEntityBuildAirWall", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildAirWall:ctor()
	OutpostEntityBuildAirWall.super.ctor(self)

	self.buildType = var_0_0.BuildType.AirWall
end

return OutpostEntityBuildAirWall
