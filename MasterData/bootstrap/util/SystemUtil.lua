module("bootstrap.util.SystemUtil", package.seeall)

local var_0_0 = {}
local var_0_1 = require("cjson")
local var_0_2 = "com.baitian.wrap.SystemUtilWrap"
local var_0_3 = Astral.OSDef

function var_0_0.restart(arg_1_0)
	if var_0_3.RunOS == var_0_3.Android then
		local var_1_0 = {}

		var_0_0.invoke(var_0_2, "restartApp", var_1_0)

		return
	end

	UnityEngine.Application.Quit()
end

function var_0_0.invoke(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or {}

	local var_2_0 = var_0_1.encode(arg_2_2)

	if not var_0_0._nativeMgr then
		var_0_0._nativeMgr = Astral.NativeMgr.Instance
	end

	var_0_0._nativeMgr:CallStatic(arg_2_0, arg_2_1, var_2_0)
end

function var_0_0.Quit()
	if Astral.OSDef.RunOS == Astral.OSDef.Win32 then
		UnityEngine.Application.Quit()
	end

	BootstrapUtil.sdkDestroy()

	if Astral.OSDef.RunOS ~= Astral.OSDef.Win32 then
		UnityEngine.Application.Quit()
	end
end

return var_0_0
