local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildTavern = class("OutpostEntityBuildTavern", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildTavern:ctor()
	OutpostEntityBuildTavern.super.ctor(self)

	self.buildType = var_0_0.BuildType.Tavern
end

return OutpostEntityBuildTavern
