module("bootstrap.util.PermissionUtil", package.seeall)

local var_0_0 = {}
local var_0_1 = "com.baitian.wrap.PermissionUtilWrap"

function var_0_0.checkPermission(arg_1_0)
	local var_1_0 = {
		permission = arg_1_0
	}

	return NativeBridge.instance:invokeBool(var_0_1, "checkPermission", var_1_0)
end

function var_0_0.requestPermission(arg_2_0, arg_2_1)
	local var_2_0 = {
		permission = arg_2_0,
		rational = arg_2_1
	}

	var_2_0.alwaysShowRationale = true

	NativeBridge.instance:invoke(var_0_1, "requestPermission", var_2_0)
end

function var_0_0.openPermissionSettings()
	NativeBridge.instance:invoke(var_0_1, "openPermissionSettings")
end

function var_0_0.registerPermissionListener(arg_4_0)
	NativeBridge.instance:registerListener("key_permission_result", function(arg_5_0)
		arg_4_0(arg_5_0)
	end)
end

return var_0_0
