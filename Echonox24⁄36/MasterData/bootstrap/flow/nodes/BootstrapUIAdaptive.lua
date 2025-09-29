module("bootstrap.flow.nodes.BootstrapUIAdaptive", package.seeall)

local var_0_0 = class("BootstrapUIAdaptive", BoostrapFlowLauncherNode)

function var_0_0.onStart(arg_1_0)
	arg_1_0:_adaptive()
end

function var_0_0._adaptive(arg_2_0)
	print("BootstrapFlow", "UI适配")
	arg_2_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
end

return var_0_0
