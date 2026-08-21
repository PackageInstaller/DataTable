module("bootstrap.BootstrapLauncherBase", package.seeall)

local var_0_0 = class("BootstrapLauncherBase")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.startHotUpdate(arg_2_0)
	arg_2_0:onHotupdateDone()
end

local var_0_1 = Astral.FileUtils.LuaBundleRootDir_64

function var_0_0.loadLuaBundles(arg_3_0)
	forcePrint("BootstrapLauncherBase loadLuaBundles")

	arg_3_0._luaBundles = {
		var_0_1 .. "/framework",
		var_0_1 .. "/frameworkext",
		var_0_1 .. "/logic"
	}
	arg_3_0._luaBundlesCount = #arg_3_0._luaBundles
	arg_3_0._luaBundlesLoaded = 0
	arg_3_0._luaBundlesSucc = 0

	for iter_3_0 = 1, arg_3_0._luaBundlesCount do
		getres(arg_3_0._luaBundles[iter_3_0], arg_3_0._onLuaBundleLoaded, arg_3_0)
	end
end

function var_0_0._onLuaBundleLoaded(arg_4_0, arg_4_1)
	forcePrint("BootstrapLauncherBase _onLuaBundleLoaded", arg_4_1.ResPath, arg_4_1.IsSuccess)

	if arg_4_1.IsSuccess then
		arg_4_0._luaBundlesSucc = arg_4_0._luaBundlesSucc + 1

		local var_4_0 = string.sub(arg_4_1.ResPath, string.len(var_0_1 .. "/") + 1)

		arg_4_1:Retain()
		rescache:AddLuaBundle(var_4_0, arg_4_1.assetBundle)
	end

	arg_4_0._luaBundlesLoaded = arg_4_0._luaBundlesLoaded + 1

	if arg_4_0._luaBundlesLoaded >= arg_4_0._luaBundlesCount and arg_4_0._luaBundlesSucc == arg_4_0._luaBundlesLoaded then
		arg_4_0:onLuaBundlesDone()
	end
end

function var_0_0.importFrameworkLua(arg_5_0)
	usingnow("framework.import_framework")
end

function var_0_0.importLogicLua(arg_6_0)
	usingnow("logic.setting.import_frameworkext")
	usingnow("logic.setting.modulepath_logic")
	usingnow("logic.setting.import_logic")
	usingnow("logic.setting.import_proto")
	usingnow("logic.LogicLauncher", "LogicLauncher")
end

function var_0_0.getHotUpdateAppCode(arg_7_0)
	return "appCode"
end

function var_0_0.onHotupdateDone(arg_8_0)
	forcePrint("BootstrapLauncherBase onHotupdateDone")
	arg_8_0:startLoadLuaBundles()
end

function var_0_0.startLoadLuaBundles(arg_9_0)
	forcePrint("BootstrapLauncherBase startLoadLuaBundles")

	if Astral.VersionMgr.Instance.IsUpdateCatelog then
		Astral.VersionMgr.Instance.IsUpdateCatelog = false

		rescache:UpdateCatelog(arg_9_0.updateCatalogFinish, arg_9_0)
	else
		arg_9_0:updateCatalogFinish()
	end
end

function var_0_0.updateCatalogFinish(arg_10_0)
	if Astral.VersionMgr.Instance.IsUpdateBootstrapScripts and not Astral.VersionMgr.Instance.IsNeedRestartApp then
		Astral.VersionMgr.Instance.IsUpdateBootstrapScripts = false
		Astral.VersionMgr.Instance.IsReloadLuaClient = true

		arg_10_0:reloadLuaClient()
	else
		arg_10_0:loadLuaBundles()
	end
end

function var_0_0.reloadLuaClient(arg_11_0)
	Astral.HotUpdateSchemeManager.RestartVM()
end

function var_0_0.onLuaBundlesDone(arg_12_0)
	forcePrint("BootstrapLauncherBase onLuaBundlesDone")
	arg_12_0:importFrameworkLua(true)
	arg_12_0:importLogicLua()
end

function var_0_0.start(arg_13_0)
	forcePrint("BootstrapLauncherBase startHotUpdate")
	arg_13_0:startHotUpdate()
end

return var_0_0
