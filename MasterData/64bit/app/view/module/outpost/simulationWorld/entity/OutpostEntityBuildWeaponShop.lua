local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildWeaponShop = class("OutpostEntityBuildWeaponShop", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildWeaponShop:ctor()
	OutpostEntityBuildWeaponShop.super.ctor(self)

	self.buildType = var_0_0.BuildType.WeaponShop
end

return OutpostEntityBuildWeaponShop
