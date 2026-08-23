local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildHospital = class("OutpostEntityBuildHospital", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildHospital:ctor()
	OutpostEntityBuildHospital.super.ctor(self)

	self.buildType = var_0_0.BuildType.Hospital
end

return OutpostEntityBuildHospital
