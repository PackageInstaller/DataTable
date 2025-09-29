module("bootstrap.flow.nodes.BootstrapSdkInit", package.seeall)

local var_0_0 = class("BootstrapSdkInit", BoostrapFlowLauncherNode)

function var_0_0.onStart(arg_1_0)
	print("BootstrapFlow", "SDK初始化")
	BootstrapUtil.registerInitListener(arg_1_0.onSdkInited, arg_1_0)

	if Astral.OSDef.RunOS == Astral.OSDef.Win32 and not Astral.OSDef.isEditor then
		if Astral.GameConstParser.Instance.enableSDKLogin then
			BootstrapUtil.sdkInit(true, not enableDebug)
		else
			arg_1_0:onSdkInited(BootstrapUtil.STATUS_OK, "")

			return
		end
	end

	local var_1_0 = BootstrapUtil.checkSdkInit()

	if var_1_0 == BootstrapUtil.INIT_SUCCESS then
		arg_1_0:onSdkInited(BootstrapUtil.STATUS_OK)
	elseif var_1_0 == BootstrapUtil.INIT_FAIL then
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitFail)
		arg_1_0:showUITipByState(BootstrapConstdef.EBootstrapState.SDKInitFail)
		print("SDK初始化失败")
	elseif Astral.OSDef.RunOS == Astral.OSDef.IOS then
		BootstrapGameConfigMgr.reqGameConfig()
		arg_1_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
	end
end

function var_0_0.onDestroy(arg_2_0)
	var_0_0.super.onDestroy(arg_2_0)
end

function var_0_0.onSdkInited(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == BootstrapUtil.STATUS_OK then
		print("SDKInitSuccess===============")
		BootstrapUtil.clearNativeCallback()
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitSuccess)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartReqGameConfig)
		BootstrapGameConfigMgr.reqGameConfig()
		arg_3_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
	else
		print("SDKInitFail===============")
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitFail)
		arg_3_0:showUITipByState(BootstrapConstdef.EBootstrapState.SDKInitFail)
		printError(string.format("SDK初始化失败:%s", arg_3_2))
	end
end

return var_0_0
