-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/VolumeUtil.lua

module("logic.common.sdk.nativeutil.VolumeUtil", package.seeall)

local VolumeUtil = {}

function VolumeUtil.registerVolumeChangedListener()
	NativeBridge.instance:registerListener("key_sdk_volume_changed", function(result)
		return
	end)
end

function VolumeUtil.getCurrentVolume()
	return NativeBridge.instance:invokeInt("com.baitian.wrap.VolumeUtilWrap", "getCurrentVolume")
end

return VolumeUtil
