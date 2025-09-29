module("bootstrap.flow.nodes.BoostrapFlowLauncherNode", package.seeall)

local var_0_0 = class("BoostrapFlowLauncherNode", BoostrapFlowNode)

function var_0_0.showUITipByState(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	BootstrapViewLogic.instance:showUITipByState(arg_1_1, arg_1_2, arg_1_3)
end

return var_0_0
