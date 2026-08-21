module("bootstrap.util.DeviceUtil", package.seeall)

local var_0_0 = {}
local var_0_1 = "com.baitian.wrap.DeviceUtilWrap"

function var_0_0.isEmulator()
	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		return NativeBridge.instance:invokeBool(var_0_1, "isEmulator")
	else
		return false
	end
end

return var_0_0
