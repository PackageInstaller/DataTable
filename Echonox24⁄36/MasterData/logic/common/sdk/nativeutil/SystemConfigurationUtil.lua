-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/SystemConfigurationUtil.lua

module("logic.common.sdk.nativeutil.SystemConfigurationUtil", package.seeall)

local SystemConfigurationUtil = {}
local clazz = "com.baitian.wrap.SystemConfigurationUtilWrap"

function SystemConfigurationUtil.getLocale()
	return NativeBridge.instance:invokeString(clazz, "getLocale")
end

return SystemConfigurationUtil
