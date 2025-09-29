-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/AssetsUtil.lua

module("logic.common.sdk.nativeutil.AssetsUtil", package.seeall)

local AssetsUtilWrap = {}
local clazz = "com.baitian.wrap.AssetsUtilWrap"

function AssetsUtilWrap.getFilesFromAssets(path)
	local param = {}

	param.path = path

	return NativeBridge.instance:invoke("com.baitian.wrap.AssetsUtilWrap", "getFilesFromAssets", param)
end

function AssetsUtilWrap.registerAssetsUtilListener(callFunc)
	NativeBridge.instance:registerListener("key_get_files_from_assets", function(result)
		callFunc(result)
	end)
end

function AssetsUtilWrap.unregisterAssetsUtilListener()
	NativeBridge.instance:unregisterListener("key_get_files_from_assets")
end

return AssetsUtilWrap
