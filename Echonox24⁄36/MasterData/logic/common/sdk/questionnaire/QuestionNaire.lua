-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/questionnaire/QuestionNaire.lua

module("logic.common.sdk.questionnaire.QuestionNaire", package.seeall)

local QuestionNaire = {}
local json = require("cjson")
local clazz = "com.baitian.questionnaire.BTQuestionnaireWrap"

function QuestionNaire.requestQuestionInfo(appCode, gameId, coChannelId, platformId, serverId, roleId, ext, ext1, ext2, timestamp, notifyUrl, lang, sign)
	local param = {}

	param.appCode = appCode
	param.gameId = gameId
	param.coChannelId = coChannelId
	param.platformId = platformId
	param.serverId = serverId
	param.roleId = roleId
	param.ext = ext
	param.ext1 = ext1
	param.ext2 = ext2
	param.timestamp = timestamp
	param.notifyUrl = notifyUrl
	param.lang = lang
	param.sign = sign

	NativeBridge.instance:invoke(clazz, "requestQuestionInfo", param)
end

function QuestionNaire.setServerUrl(serverUrl)
	local param = {}

	param.serverUrl = serverUrl

	NativeBridge.instance:invoke(clazz, "setServerUrl", param)
end

function QuestionNaire.setDelaySeconds(delaySeconds)
	local param = {}

	param.delaySeconds = delaySeconds

	NativeBridge.instance:invoke(clazz, "setDelaySeconds", param)
end

function QuestionNaire.registerQuestionnaireInfoListener(callFunc, callFuncSelf)
	NativeBridge.instance:registerListener("questionnaireInfo", function(result)
		local content = json.decode(result.value)

		if callFuncSelf then
			callFunc(callFuncSelf, content, result.statusCode)
		else
			callFunc(content, result.statusCode)
		end
	end)
end

function QuestionNaire.openQuestionView(url, showToolbar, x, y, width, height, ignoreBackPress)
	local params = {}

	params.url = url
	params.showToolbar = showToolbar

	if x ~= nil and y ~= nil and width ~= nil and height ~= nil then
		params.x = x
		params.y = y
		params.width = width
		params.height = height
	end

	params.ignoreBackPress = ignoreBackPress

	NativeBridge.instance:invoke(clazz, "openQuestionView", params)
end

function QuestionNaire.closeQuestionView()
	NativeBridge.instance:invoke(clazz, "closeQuestionView", params)
end

function QuestionNaire.callbackWebView(callback, msgTable)
	local param = {}

	param.callback = callback
	param.paramJson = json.encode(msgTable)

	NativeBridge.instance:invoke(clazz, "callbackWebView", param)
end

function QuestionNaire.registerGetActionListener(callFunc)
	NativeBridge.instance:registerListener("key_webview_get_action", function(result)
		callFunc(result)
	end)
end

function QuestionNaire.unregisterGetActionListener()
	NativeBridge.instance:unregisterListener("key_webview_get_action")
end

function QuestionNaire.registerPostActionListener(callFunc)
	NativeBridge.instance:registerListener("key_webview_post_action", function(result)
		callFunc(result)
	end)
end

function QuestionNaire.unregisterPostActionListener()
	NativeBridge.instance:unregisterListener("key_webview_post_action")
end

return QuestionNaire
