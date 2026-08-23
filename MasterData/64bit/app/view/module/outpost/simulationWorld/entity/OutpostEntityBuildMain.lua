local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildMain = class("OutpostEntityBuildMain", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildMain:ctor()
	OutpostEntityBuildMain.super.ctor(self)

	self.buildType = var_0_0.BuildType.Main
end

return OutpostEntityBuildMain
