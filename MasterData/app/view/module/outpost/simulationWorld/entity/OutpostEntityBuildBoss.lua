local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildBoss = class("OutpostEntityBuildBoss", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildBoss:ctor()
	OutpostEntityBuildBoss.super.ctor(self)

	self.buildType = var_0_0.BuildType.Boss
end

return OutpostEntityBuildBoss
