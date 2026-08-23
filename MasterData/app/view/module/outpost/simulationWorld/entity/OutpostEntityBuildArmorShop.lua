local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildArmorShop = class("OutpostEntityBuildArmorShop", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildArmorShop:ctor()
	OutpostEntityBuildArmorShop.super.ctor(self)

	self.buildType = var_0_0.BuildType.ArmorShop
end

return OutpostEntityBuildArmorShop
