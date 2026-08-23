local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildHotel = class("OutpostEntityBuildHotel", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildHotel:ctor()
	OutpostEntityBuildHotel.super.ctor(self)

	self.buildType = var_0_0.BuildType.Hotel
end

return OutpostEntityBuildHotel
