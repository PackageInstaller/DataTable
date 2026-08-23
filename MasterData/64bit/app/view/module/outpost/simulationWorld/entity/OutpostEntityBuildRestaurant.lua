local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildRestaurant = class("OutpostEntityBuildRestaurant", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildRestaurant:ctor()
	OutpostEntityBuildRestaurant.super.ctor(self)

	self.buildType = var_0_0.BuildType.Restaurant
end

return OutpostEntityBuildRestaurant
