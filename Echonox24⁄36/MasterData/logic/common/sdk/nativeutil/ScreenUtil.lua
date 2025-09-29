-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/ScreenUtil.lua

module("logic.common.sdk.nativeutil.ScreenUtil", package.seeall)

local ScreenUtil = {}
local clazz = "com.baitian.wrap.ScreenUtilWrap"

function ScreenUtil.getScreenBrightness()
	return NativeBridge.instance:invokeInt(clazz, "getScreenBrightness")
end

function ScreenUtil.setScreenBrightness(brightness)
	local param = {}

	param.brightness = brightness

	NativeBridge.instance:invoke(clazz, "setScreenBrightness", param)
end

return ScreenUtil
