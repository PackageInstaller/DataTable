-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/SignalStrengthUtil.lua

module("logic.common.sdk.nativeutil.SignalStrengthUtil", package.seeall)

local SignalStrengthUtil = {}
local clazz = "com.baitian.wrap.SignalStrengthUtil"

function SignalStrengthUtil.getSignalStrengthLevel(simSlotIndex)
	local param = {}

	param.simSlotIndex = 0

	return NativeBridge.instance:invokeInt("com.baitian.wrap.SignalStrengthWrap", "getSignalStrengthLevel", param)
end

function SignalStrengthUtil.getWifiStrengthLevel()
	return NativeBridge.instance:invokeInt("com.baitian.wrap.SignalStrengthWrap", "getWifiStrengthLevel")
end

function SignalStrengthUtil.getSimCardCount()
	return NativeBridge.instance:invokeInt("com.baitian.wrap.SignalStrengthWrap", "getSimCardCount")
end

function SignalStrengthUtil.registerSignalStrengthListener(callFunc)
	NativeBridge.instance:registerListener("key_signal_strength", function(result)
		callFunc(result)
	end)
end

function SignalStrengthUtil.unregisterSignalStrengthListener()
	NativeBridge.instance:unregisterListener("key_signal_strength")
end

return SignalStrengthUtil
