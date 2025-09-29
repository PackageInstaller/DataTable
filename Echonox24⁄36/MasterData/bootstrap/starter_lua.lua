if Astral.OSDef.is64Cpu and jit then
	jit.off()
end

enableLog = Astral.LogManager.enableLog
enableWarnLog = Astral.LogManager.enableWarnLog
enableErrorLog = Astral.LogManager.enableErrorLog
enableDebug = Astral.LogManager.isDebugBuild

function __G__TRACKBACK__(arg_1_0)
	if enableErrorLog then
		nprintError("LuaException: " .. arg_1_0 .. "\n" .. debug.traceback())
	end

	return arg_1_0
end

function trycall(arg_2_0, ...)
	if ... ~= nil then
		local var_2_0 = {
			...
		}

		return xpcall(function()
			arg_2_0(unpack(var_2_0, 1), unpack(var_2_0, 2, #var_2_0))
		end, __G__TRACKBACK__)
	else
		return xpcall(arg_2_0, __G__TRACKBACK__)
	end
end

module_paths = {}
module_tables = {}

function setglobal(arg_4_0, arg_4_1)
	rawset(_G, arg_4_0, arg_4_1)
end

function getglobal(arg_5_0)
	return rawget(_G, arg_5_0)
end

function getmodule(arg_6_0)
	return module_tables[arg_6_0]
end

function usingnow(arg_7_0, arg_7_1)
	local var_7_0 = require(arg_7_0)

	if arg_7_1 and not module_tables[arg_7_1] then
		if type(var_7_0) ~= "table" then
			module_tables[arg_7_1] = true

			error("can not find module for path=" .. arg_7_0)
		else
			module_tables[arg_7_1] = var_7_0

			setglobal(arg_7_1, var_7_0)
		end
	end

	return var_7_0
end

function using(arg_8_0, arg_8_1)
	if arg_8_1 and not module_paths[arg_8_1] then
		module_paths[arg_8_1] = arg_8_0
	end

	return true
end

local var_0_0 = require("bootstrap.protobufext.protobufextthem")

gmetatable = {}

function gmetatable.__index(arg_9_0, arg_9_1)
	local var_9_0 = module_tables[arg_9_1]

	if not var_9_0 then
		local var_9_1 = module_paths[arg_9_1]

		if var_9_1 then
			var_9_0 = require(var_9_1)

			if type(var_9_0) ~= "table" then
				module_tables[arg_9_1] = true

				error("can not find module for path=" .. var_9_1)
			else
				module_tables[arg_9_1] = var_9_0

				setglobal(arg_9_1, var_9_0)
			end
		end
	end

	return var_9_0
end

function gmetatable.__newindex(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= "framework" and arg_10_1 ~= "frameworkext" and arg_10_1 ~= "bootstrap" and arg_10_1 ~= "logic" then
		error("set global vairable directly is not allowed,please use setglobal instead!,key=" .. arg_10_1)
	end
end

setmetatable(_G, gmetatable)

local function var_0_1()
	usingnow("bootstrap.core.log")
	usingnow("bootstrap.core.table")
	usingnow("bootstrap.core.oop")
	usingnow("bootstrap.core.math")
	usingnow("bootstrap.core.io")
	usingnow("bootstrap.core.string")
	usingnow("bootstrap.core.bit")
	usingnow("bootstrap.shortcut_csharp")
	usingnow("bootstrap.BootstrapUtil", "BootstrapUtil")
	usingnow("bootstrap.BootstrapConstdef", "BootstrapConstdef")
	usingnow("bootstrap.BootstrapLauncherBase", "BootstrapLauncherBase")
	usingnow("bootstrap.util.PermissionUtil", "PermissionUtil")
	usingnow("bootstrap.BootstrapHelper", "BootstrapHelper")
	usingnow("bootstrap.view.BootstrapMsgBoxView", "BootstrapMsgBoxView")
	usingnow("bootstrap.view.BootstrapLoadingView", "BootstrapLoadingView")
	usingnow("bootstrap.view.BootstrapView", "BootstrapView")
	usingnow("bootstrap.view.BootstrapViewLogic", "BootstrapViewLogic")
	usingnow("bootstrap.flow.base.BoostrapFlowContext", "BoostrapFlowContext")
	usingnow("bootstrap.flow.base.BoostrapFlowNode", "BoostrapFlowNode")
	usingnow("bootstrap.flow.base.BoostrapFlowParentNode", "BoostrapFlowParentNode")
	usingnow("bootstrap.flow.base.BoostrapFlowRoot", "BoostrapFlowRoot")
	usingnow("bootstrap.flow.compose.BoostrapFlowParallel", "BoostrapFlowParallel")
	usingnow("bootstrap.flow.compose.BoostrapFlowSequence", "BoostrapFlowSequence")
	usingnow("bootstrap.flow.compose.BoostrapFlowSubTree", "BoostrapFlowSubTree")
	usingnow("bootstrap.flow.BootstrapFlow", "BootstrapFlow")
	usingnow("bootstrap.flow.BootstrapFlowConst", "BootstrapFlowConst")
	usingnow("bootstrap.flow.nodes.BoostrapFlowLauncherNode", "BoostrapFlowLauncherNode")
	usingnow("bootstrap.flow.nodes.BootstrapHotUpdate", "BootstrapHotUpdate")
	usingnow("bootstrap.flow.nodes.BootstrapHotUpdateDownload", "BootstrapHotUpdateDownload")
	usingnow("bootstrap.flow.nodes.BootstrapInitViews", "BootstrapInitViews")
	usingnow("bootstrap.flow.nodes.BootstrapResPreLoad", "BootstrapResPreLoad")
	usingnow("bootstrap.flow.nodes.BootstrapSdkInit", "BootstrapSdkInit")
	usingnow("bootstrap.flow.nodes.BootstrapUIAdaptive", "BootstrapUIAdaptive")
	usingnow("bootstrap.const.BootstrapConst", "BootstrapConst")
	usingnow("bootstrap.const.GameRequestUrl", "GameRequestUrl")
	usingnow("bootstrap.config.BootstrapGameConfig", "BootstrapGameConfig")
	usingnow("bootstrap.config.BootstrapGameConfigMgr", "BootstrapGameConfigMgr")
	usingnow("bootstrap.config.BootstrapConstdefExtend", "BootstrapConstdefExtend")
	usingnow("bootstrap.config.LangLauncherTips", "LangLauncherTips")
	usingnow("bootstrap.config.BootstrapLanguage", "BootstrapLanguage")
	usingnow("bootstrap.util.Netkit", "Netkit")
	usingnow("bootstrap.util.SystemUtil", "SystemUtil")
	usingnow("bootstrap.util.DeviceUtil", "DeviceUtil")
	usingnow("bootstrap.util.HotUpdateUtil", "HotUpdateUtil")
	print("AstralUnity-lua is started...")
	usingnow("bootstrap.BootstrapLauncher", "BootstrapLauncher")
end

local var_0_2, var_0_3 = trycall(var_0_1)
