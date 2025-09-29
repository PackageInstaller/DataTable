-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/SDKBase.lua

module("logic.common.sdk.SDKBase", package.seeall)

local json = require("cjson")
local clazz = "com.baitian.wrap.OneSDKWrap"
local KEY_INIT = "key_sdk_init"
local KEY_LOGIN = "key_sdk_login"
local KEY_PAY = "key_sdk_pay"
local KEY_LOGOUT = "key_sdk_logout"
local KEY_EXIT = "key_sdk_exit"
local KEY_ON_KEY_UP = "key_on_key_up"
local KEY_GUEST_UPGRADE = "key_sdk_guest_upgrade"
local KEY_REAL_NAME_AUTH = "key_sdk_real_name_auth"
local KEY_SHARE = "key_sdk_share"
local resultDevJson = false
local resultDevProperties = false
local M = class("SDKBase")

function M:ctor()
	return
end

function M:login()
	NativeBridge.instance:invoke(clazz, "login")
end

function M:logout()
	NativeBridge.instance:invoke(clazz, "logout")
end

function M:exit()
	if enableLog then
		printWarn("退出游戏")
	end

	NativeBridge.instance:invoke(clazz, "exit")
end

function M:destroy()
	NativeBridge.instance:invoke(clazz, "destroy")
end

function M:pay(paymentInfo, roleInfo)
	for key, value in pairs(roleInfo) do
		paymentInfo[key] = value
	end

	NativeBridge.instance:invoke(clazz, "pay", paymentInfo)
end

function M:createRole(roleInfo)
	NativeBridge.instance:invoke(clazz, "createRole", roleInfo)
end

function M:enterGame(roleInfo)
	NativeBridge.instance:invoke(clazz, "enterGame", roleInfo)
end

function M:upgradeRole(roleInfo)
	NativeBridge.instance:invoke(clazz, "upgradeRole", roleInfo)
end

function M:isShowUserCenterButton()
	local result = NativeBridge.instance:invokeBool(clazz, "isShowUserCenterButton")

	return result
end

function M:showUserCenter()
	NativeBridge.instance:invoke(clazz, "showUserCenter")
end

function M:showBBSpage()
	NativeBridge.instance:invoke(clazz, "showBBSpage")
end

function M:showWebBrowser(url, isUserBrowser)
	UnityEngine.Application.OpenURL(url)
end

function M:getDevJson()
	if not resultDevJson then
		resultDevJson = NativeBridge.instance:invokeString(clazz, "getDevJson")
	end

	return resultDevJson
end

function M:getDevInfo()
	local result = {}
	local devJson = self:getDevJson()

	if devJson == nil or devJson == "" then
		result.channelId = "1"
		result.cochannelId = "-1"
		result.sysVersion = "1"
		result.sdkVersion = "1.0.0.0"
		result.sdkType = "0"
		result.gameVersionCode = "100"
		result.gameVersionName = "1.0.0"
		result.gamepackageName = "com.baitian.unity.editor"
		result.imei = "00000000"
		result.imsi = "00000000"
		result.mac = ""
		result.networkInfo = "WIFI"
		result.phoneModel = "Editor"
		result.displayScreenWidth = 720
		result.displayScreenHeight = 1280
		result.densityDpi = 240
		result.platformSdkVersion = "1.0.0"
	else
		result = json.decode(devJson)
	end

	result.oneSdkVersion = result.sdkVersion

	return result
end

function M:getDeviceProperties()
	if not resultDevProperties then
		resultDevProperties = NativeBridge.instance:invokeString(clazz, "getDeviceProperties")
	end

	return resultDevProperties
end

function M:getDevicePropertiesInfo()
	local result = {}
	local devProperties = self:getDeviceProperties()

	if devProperties == nil or devProperties == "" then
		result.dataAppId = "1"
		result.terminal = 0
		result.platformId = 2
		result.platformIdSecond = 1
		result.phoneSysModel = "1.1"
		result.gameVersionCode = "100"
		result.gameVersionName = "1.0.0"
		result.gamepackageName = "com.baitian.unity.editor"
		result.imei = "00000000"
		result.imsi = "00000"
		result.networkInfo = "WIFI"
		result.phoneModel = "Editor"
		result.displayScreenWidth = 720
		result.displayScreenHeight = 1280
		result.densityDpi = 240
	else
		result = json.decode(devProperties)
	end

	result.packageName = result.gamepackageName

	return result
end

function M:getDeviceDetailJson()
	local devInfo = self:getDevInfo()
	local deviceProperties = self:getDevicePropertiesInfo()
	local temp = {}

	for k, v in pairs(devInfo) do
		if temp[k] == nil then
			temp[k] = v
		end
	end

	for k, v in pairs(deviceProperties) do
		if temp[k] == nil then
			temp[k] = v
		end
	end

	return json.encode(temp)
end

function M:getChannelId()
	local devInfo = self:getDevInfo()

	return devInfo and devInfo.channelId or 1
end

function M:getAndroidApiLevel()
	local devInfo = self:getDevInfo()

	return devInfo and devInfo.sysVersion or 1
end

function M:isAndroidOS()
	local devInfo = self:getDevInfo()

	return devInfo and devInfo.sdkType == "0"
end

function M:isIOS()
	local devInfo = self:getDevInfo()

	return devInfo and devInfo.sdkType == "1"
end

function M:sensorsTrack(eventId, properties, isFlush)
	properties = properties or {}

	if isFlush == nil then
		isFlush = true
	end

	local param = {}

	param.eventId = eventId
	param.properties = json.encode(properties)
	param.isFlush = isFlush

	NativeBridge.instance:invoke(clazz, "sensorsTrack", param)
end

function M:isAutomatorEnabled()
	local result = NativeBridge.instance:invokeBool(clazz, "isAutomatorEnabled")

	return result
end

function M:showTransition()
	NativeBridge.instance:invoke(clazz, "showTransition")
end

function M:hideTransition()
	NativeBridge.instance:invoke(clazz, "hideTransition")
end

function M:registerInitListener(callFunc)
	NativeBridge.instance:registerListener(KEY_INIT, function(result)
		local statusCode = result.statusCode

		callFunc(statusCode)
	end)
end

function M:unregisterInitListener()
	NativeBridge.instance:unregisterListener(KEY_INIT)
end

function M:registerLoginListener(callFunc)
	NativeBridge.instance:registerListener(KEY_LOGIN, function(result)
		local statusCode = result.statusCode
		local sessionId = result.sessionId
		local platformId = result.platformId
		local statusDesc = result.statusDesc

		if statusDesc then
			callFunc(statusCode, sessionId, platformId, statusDesc)
		else
			callFunc(statusCode, sessionId, platformId)
		end
	end)
end

function M:registerKeyUpListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_ON_KEY_UP, function(result)
		local keyCode = result.keyCode

		if callObj ~= nil then
			callFunc(callObj, keyCode)
		else
			callFunc(keyCode)
		end
	end)
end

function M:unregisterLoginListener()
	NativeBridge.instance:unregisterListener(KEY_LOGIN)
end

function M:registerLogoutListener(callFunc)
	NativeBridge.instance:registerListener(KEY_LOGOUT, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if statusDesc then
			callFunc(statusCode, statusDesc)
		else
			callFunc(statusCode)
		end
	end)
end

function M:unregisterLogoutListener()
	NativeBridge.instance:unregisterListener(KEY_LOGOUT)
end

function M:registerPayListener(callFunc)
	NativeBridge.instance:registerListener(KEY_PAY, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if statusDesc then
			callFunc(statusCode, statusDesc)
		else
			callFunc(statusCode)
		end
	end)
end

function M:unregisterPayListener()
	NativeBridge.instance:unregisterListener(KEY_PAY)
end

function M:registerExitListener(callFunc)
	NativeBridge.instance:registerListener(KEY_EXIT, function(result)
		local statusCode = result.statusCode

		callFunc(statusCode)
	end)
end

function M:unregisterExitListener()
	NativeBridge.instance:unregisterListener(KEY_EXIT)
end

function M:share(shareType, content, title, img, url)
	print("SDKBase.share() begin", shareType, content, title, img, url)

	local param = {}

	param.shareType = shareType
	param.content = content
	param.title = title
	param.img = img
	param.url = url

	NativeBridge.instance:invoke(clazz, "share", param)
	print("SDKBase.share() end", shareType, content, title, img, url)
end

function M:registerShareListener(callFunc)
	NativeBridge.instance:registerListener(KEY_SHARE, function(result)
		local statusCode = result.statusCode

		callFunc(statusCode)
	end)
end

function M:unregisterShareListener()
	NativeBridge.instance:unregisterListener(KEY_SHARE)
end

function M:getGameId()
	local isExis = NativeBridge.instance:isMethodExist(clazz, "getGameId")
	local gameId = isExis and NativeBridge.instance:invokeString(clazz, "getGameId")

	if not gameId or gameId == "" then
		gameId = 100046
	end

	return gameId
end

function M:registerGuestUpgradeListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GUEST_UPGRADE, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function M:unregisterGuestUpgradeListener()
	NativeBridge.instance:unregisterListener(KEY_GUEST_UPGRADE)
end

function M:gotoGuestUpgradeAccount()
	local isExis = NativeBridge.instance:isMethodExist(clazz, "gotoGuestUpgradeAccount")

	if isExis then
		NativeBridge.instance:invoke(clazz, "gotoGuestUpgradeAccount")
	end
end

function M:isShowGuestUpgradeAccount()
	local result = false
	local isExis = NativeBridge.instance:isMethodExist(clazz, "isShowGuestUpgradeAccount")

	if isExis then
		result = NativeBridge.instance:invokeBool(clazz, "isShowGuestUpgradeAccount")
	end

	return result
end

function M:registerRealNameAuthListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_REAL_NAME_AUTH, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function M:unregisterRealNameAuthListener()
	NativeBridge.instance:unregisterListener(KEY_REAL_NAME_AUTH)
end

function M:gotoRealNameAuth()
	local isExis = NativeBridge.instance:isMethodExist(clazz, "gotoRealNameAuth")

	if isExis then
		NativeBridge.instance:invoke(clazz, "gotoRealNameAuth")
	end
end

function M:getUserRealNameStatus()
	local result = false
	local isExis = NativeBridge.instance:isMethodExist(clazz, "getUserRealNameStatus")

	if isExis then
		result = NativeBridge.instance:invokeBool(clazz, "getUserRealNameStatus")
	end

	return result
end

function M:isShowRealNameAuth()
	local result = false
	local isExis = NativeBridge.instance:isMethodExist(clazz, "isShowRealNameAuth")

	if isExis then
		result = NativeBridge.instance:invokeBool(clazz, "isShowRealNameAuth")
	end

	return result
end

function M:isPolicyVersion()
	local isPolicy = false
	local isExis = NativeBridge.instance:isMethodExist(clazz, "gotoRealNameAuth")

	if isExis then
		isPolicy = true
	end

	return isPolicy
end

function M:getProtocolName()
	local protocolName = ""
	local isExis = NativeBridge.instance:isMethodExist(clazz, "getProtocolName")

	if isExis then
		protocolName = NativeBridge.instance:invokeString(clazz, "getProtocolName")
	end

	return isExis, protocolName
end

function M:showProtocolView()
	local isExis = NativeBridge.instance:isMethodExist(clazz, "showProtocolView")

	if isExis then
		NativeBridge.instance:invoke(clazz, "showProtocolView")
	end

	return isExis
end

function M:getPrivacyName()
	local privacyName = ""
	local isExis = NativeBridge.instance:isMethodExist(clazz, "getPrivacyName")

	if isExis then
		privacyName = NativeBridge.instance:invokeString(clazz, "getPrivacyName")
	end

	return isExis, privacyName
end

function M:showPrivacyView()
	local isExis = NativeBridge.instance:isMethodExist(clazz, "showPrivacyView")

	if isExis then
		NativeBridge.instance:invoke(clazz, "showPrivacyView")
	end

	return isExis
end

function M:ubeejoyTrack()
	return
end

function M:adjustTrack()
	return
end

function M:moneyToAdjustTrack()
	return
end

function M:reportShareResult()
	return
end

function M:rateUs()
	return
end

function M:trackFinishNewRoleTutorial()
	return
end

function M:trackObtainNewRolePack()
	return
end

function M:trackCreateRoleFail()
	return
end

function M:trackLoginServerFail()
	return
end

function M:forumStartWidget()
	return
end

function M:openForum()
	return
end

function M:monthToAdjustTrack()
	return
end

function M:getAdjustTrackToken()
	return
end

function M:isOfficialPlatform()
	return
end

function M:isWebPayOpen()
	return false
end

function M:payByWeb()
	return
end

function M:clipboardCopy(content)
	Clipboard.copy(content)
end

function M:clipboardPaste()
	return Clipboard.paste()
end

function M:setLanguage(language)
	return 0
end

function M:getSDKType()
	return SDKManager.SDKType.Default
end

return M
