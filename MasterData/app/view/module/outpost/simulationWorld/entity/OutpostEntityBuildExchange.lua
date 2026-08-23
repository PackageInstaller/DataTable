local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildExchange = class("OutpostEntityBuildExchange", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase"))

function OutpostEntityBuildExchange:ctor()
	OutpostEntityBuildExchange.super.ctor(self)

	self.buildType = var_0_0.BuildType.Exchange
end

return OutpostEntityBuildExchange
