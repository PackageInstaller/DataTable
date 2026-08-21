module("bootstrap.flow.nodes.BootstrapInitViews", package.seeall)

local var_0_0 = class("BootstrapInitViews", BoostrapFlowLauncherNode)

function var_0_0.onStart(arg_1_0)
	print("BootstrapFlow", "关闭闪屏")
	BootstrapMsgBoxView.buildUI(arg_1_0:getContext():getData("MsgBoxPrefabInstance"))
	BootstrapMsgBoxView.onEnter()
	BootstrapLoadingView.instance:buildUI(arg_1_0:getContext():getData("LoadingPrefabInstance"))
	BootstrapLoadingView.instance:onEnter()

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		BootstrapUtil.hideTransition()
	end

	BootstrapLoadingView.instance:setLoadingEndCallback(function()
		arg_1_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
	end)
	BootstrapView.instance:buildUI(arg_1_0:getContext():getData("LoadingPrefabInstance"))
	BootstrapView.instance:onEnter()
end

function var_0_0.onDestroy(arg_3_0)
	var_0_0.super.onDestroy(arg_3_0)
	BootstrapMsgBoxView.destroyUI()
	BootstrapLoadingView.instance:destroyUI()
	BootstrapView.instance:destroyUI()
end

return var_0_0
