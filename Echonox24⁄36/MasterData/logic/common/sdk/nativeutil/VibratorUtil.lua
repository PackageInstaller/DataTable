-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/VibratorUtil.lua

module("logic.common.sdk.nativeutil.VibratorUtil", package.seeall)

local VibratorUtil = {}
local clazz = "com.baitian.wrap.VibratorUtilWrap"

function VibratorUtil.vibrate(seconds, amplitude, level)
	local param = {}

	param.seconds = seconds
	param.amplitude = amplitude
	param.level = level

	return NativeBridge.instance:invokeBool(clazz, "vibrate", param)
end

return VibratorUtil
