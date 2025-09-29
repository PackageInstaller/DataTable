-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginWebHandler.lua

module("logic.extensions.login.controller.LoginWebHandler", package.seeall)

local sdkLoginTimeOut = 20
local M = class("LoginWebHandler")

function M:ctor(controller)
	self._controller = controller
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.LOGIN_GET_SERVER_LIST_EVENT, self._dealGetServerList, self)
	GlobalDispatcher:addEventListener(EventType.LOGIN_SELECT_SERVER_EVENT, self._updateSelectServer, self)
end

function M:sendHttpGetServerListRequest(param, callback)
	param.platformId = LoginModel.instance.platformId

	LoginAgent.instance:sendHttpGetServerListRequest(param)

	self._getServerListCallback = callback
end

function M:_dealGetServerList(e, isSuccess, resultCode)
	LoginModel.instance:setIsWebLogined(isSuccess)

	if isSuccess then
		ViewMgr.instance:destroy(ViewName.LoginSimulationSDK, false)
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_UPDATE_SELECT_EVENT, LoginModel.instance:getServerName(), LoginModel.instance:getServerIP())
	else
		self:_onGameWebLoginFail(resultCode)
	end

	if self._getServerListCallback then
		self._getServerListCallback(isSuccess)

		self._getServerListCallback = nil
	end

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
end

function M:_updateSelectServer(e, info)
	LoginModel.instance:updateServerInfo(info)
	GlobalDispatcher:dispatchEvent(EventType.LOGIN_GET_SERVER_LIST_EVENT, LoginModel.instance:getServerName(), LoginModel.instance:getServerIP())
end

function M:_handleSDKLongTimeNoReturn()
	if not LoginModel.instance:getIsWebLogined() then
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
		forcePrint("===========M: _handleSDKLongTimeNoReturn==============")
	end
end

function M:beginGetSessionId()
	if LoginModel.instance:isLogoutAndLoginAgain() then
		forcePrint("======beginGetSessionId=====_isPassFloatPoint==")
		LoginModel.instance:setLogoutAndLoginAgain(false)

		if not LoginModel.instance:getIsWebLogined() then
			self:_handleAccountLoginFinish()
		end

		return
	end

	if LoginModel.instance.sessionId then
		forcePrint("===========M: beginGetSessionId sessionId = " .. LoginModel.instance.sessionId)

		return
	end

	if not Astral.OSDef.isEditor and LoginModel.instance:isSDKNeedLogout() then
		if Astral.GameConstParser.Instance.enableSDKLogin then
			SDKManager.getSDKInstacne():logout()
		end

		LoginModel.instance:setSDKNeedLogout(false)
	end

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)
	settimer(sdkLoginTimeOut, self._handleSDKLongTimeNoReturn, self, false)
	printWarn("lzr..Astral.GameConstParser.Instance.enableSDKLogin", Astral.GameConstParser.Instance.enableSDKLogin)

	if (Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS or Astral.OSDef.RunOS == Astral.OSDef.Win32 and not Astral.OSDef.isEditor) and Astral.GameConstParser.Instance.enableSDKLogin and not SDKManager.getSDKInstacne():isAutomatorEnabled() then
		self._controller.sdkHandler:_SDKLogin()
	else
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
		self:_simulationSDKLogin()
	end
end

function M:_simulationSDKLogin()
	ViewMgr.instance:open(ViewName.LoginSimulationSDK)
end

function M:_onGameWebLoginFail(resultCode)
	forcePrint("GameWebLoginFail========resultCode = ", resultCode)

	local content = resultCode
	local dialog = Dialog.showWarnMessage(lang("tip_title"), string.format(lang("tip_login_fail_retry"), content))

	dialog:setViewRootType(ViewRootType.TopMost)
	dialog:setConfirmListener(self._onGameWebLoginFailHandle, self)
end

function M:_onGameWebLoginFailHandle()
	forcePrint("===========M:_onGameWebLoginFailHandle=============beginGetSessionId")

	if Astral.GameConstParser.Instance.enableSDKLogin then
		SDKManager.getSDKInstacne():logout()
	end

	forcePrint("===========M:_onGameWebLoginFailHandle after SDKManager.getSDKInstacne():logout() ?============")

	LoginModel.instance.sessionId = nil

	self:beginGetSessionId()
end

return M
