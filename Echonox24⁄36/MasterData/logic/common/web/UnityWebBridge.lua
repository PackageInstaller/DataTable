-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/web/UnityWebBridge.lua

module("logic.common.web.UnityWebBridge", package.seeall)

local UnityWebBridge = {}
local json = require("cjson")
local nativeClazz = "com.baitian.android.webview.bridge.unity.UnityWebBridge"

function UnityWebBridge.isExistFunc()
	local isExis = NativeBridge.instance:isMethodExist(nativeClazz, "openWebView")

	return isExis
end

function UnityWebBridge.openWebView(url, showToolbar, x, y, width, height, ignoreBackPress)
	local params = {}

	params.url = url
	params.showToolbar = showToolbar

	if x ~= nil and y ~= nil and width ~= nil and height ~= nil then
		params.x = tonumber(x)
		params.y = tonumber(y)
		params.width = tonumber(width)
		params.height = tonumber(height)
	end

	params.ignoreBackPress = ignoreBackPress

	NativeBridge.instance:invoke(nativeClazz, "openWebView", params)
end

function UnityWebBridge.closeWebView()
	NativeBridge.instance:invoke(nativeClazz, "closeWebView", params)
end

function UnityWebBridge.callbackWebView(callback, msgTable)
	local param = {}

	param.callback = callback
	param.paramJson = json.encode(msgTable)

	NativeBridge.instance:invoke(nativeClazz, "callbackWebView", param)
end

function UnityWebBridge.registerGetActionListener(callFunc)
	NativeBridge.instance:registerListener("key_webview_get_action", function(result)
		callFunc(result)
	end)
end

function UnityWebBridge.unregisterGetActionListener()
	NativeBridge.instance:unregisterListener("key_webview_get_action")
end

function UnityWebBridge.registerPostActionListener(callFunc)
	NativeBridge.instance:registerListener("key_webview_post_action", function(result)
		callFunc(result)
	end)
end

function UnityWebBridge.unregisterPostActionListener()
	NativeBridge.instance:unregisterListener("key_webview_post_action")
end

return UnityWebBridge
