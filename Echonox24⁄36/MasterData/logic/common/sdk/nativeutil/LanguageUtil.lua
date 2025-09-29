-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/LanguageUtil.lua

module("logic.common.sdk.nativeutil.LanguageUtil", package.seeall)

local LanguageUtil = {}
local clazz = "com.baitian.wrap.LanguageUtilWrap"

function LanguageUtil.getSystemLanguage()
	return NativeBridge.instance:invokeString(clazz, "getSystemLanguage")
end

function LanguageUtil.getSystemLanguageV2()
	return NativeBridge.instance:invokeString(clazz, "getSystemLanguageV2")
end
