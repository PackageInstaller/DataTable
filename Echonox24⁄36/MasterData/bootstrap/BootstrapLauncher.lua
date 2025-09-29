module("bootstrap.BootstrapLauncher", package.seeall)

local var_0_0 = class("BootstrapLauncher", BootstrapLauncherBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._flow = false
end

function var_0_0.start(arg_2_0)
	Astral.FileUtils.Instance:Init()
	print("BootstrapLauncher:start===============")

	arg_2_0._flow = BootstrapFlow.New()

	arg_2_0._flow:addDoneListener(arg_2_0.onHotupdateDone, arg_2_0)
	arg_2_0._flow:start()
end

function var_0_0.importLogicLua(arg_3_0)
	var_0_0.super.importLogicLua(arg_3_0)

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		BootstrapUtil.hideTransition()
	end
end

function var_0_0.updateCatalogFinish(arg_4_0)
	if Astral.VersionMgr.Instance.IsUpdateBootstrapScripts then
		arg_4_0:destroyFlow()
	end

	var_0_0.super.updateCatalogFinish(arg_4_0)
end

function var_0_0.destroyFlow(arg_5_0)
	if not arg_5_0._flow then
		return
	end

	if arg_5_0._flow then
		arg_5_0._flow:destroy()
	end

	arg_5_0._flow = false
end

var_0_0.instance = var_0_0.New()

var_0_0.instance:start()

return var_0_0
