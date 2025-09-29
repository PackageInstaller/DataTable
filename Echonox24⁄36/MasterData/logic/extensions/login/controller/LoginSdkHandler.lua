-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginSdkHandler.lua

module("logic.extensions.login.controller.LoginSdkHandler", package.seeall)

local M = class("LoginSdkHandler")

function M:ctor(controller)
	self._controller = controller
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.APPLICATION_PAUSE, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_RESUME, self._onHandleOnApplicationResume, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_QUIT, self._onHandleOnApplicationQuit, self)
	GlobalDispatcher:addEventListener(EventType.SIMULATION_SDK_LOGIN_SUCCESS, self._handleAccountLoginFinish, self)
	GlobalDispatcher:addEventListener(EventType.SDK_LOGIN_SUCCESS, self._handleAccountLoginFinish, self)
end

function M:_SDKLogin()
	SDKManager.getSDKInstacne():registerLoginListener(function(statusCode, sessionId, platformId, statusDesc)
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_SDK_WINDOW_SHOW, false)

		if statusCode == SDKManager.STATUS_OK then
			self:_SDKLoginSuccess(statusCode, sessionId, platformId, statusDesc)
		else
			self:_SDKLoginFail(statusCode, sessionId, platformId, statusDesc)
		end
	end)
	SDKManager.getSDKInstacne():login()
	GlobalDispatcher:dispatchEvent(EventType.LOGIN_SDK_WINDOW_SHOW, true)
end

function M:_SDKLoginSuccess(statusCode, sessionId, platformId, statusDesc)
	SDKManager.getSDKInstacne():registerLogoutListener(function(statusCodeLogOut, statusDescLogOut)
		forcePrint("===========M:_onSDKLogout in registerLogoutListener=============")
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_SDK_WINDOW_SHOW, false)

		if statusCodeLogOut ~= SDKManager.STATUS_OK then
			if statusDescLogOut then
				printError(lang("tip_logout_fail") .. statusDescLogOut)
			else
				printError(lang("tip_logout_fail"))
			end
		end

		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
		LoginModel.instance:setIsWebLogined(false)

		if LoginModel.instance.sessionId then
			ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)
			SDKManager.getSDKInstacne():login()
			GlobalDispatcher:dispatchEvent(EventType.LOGIN_SDK_WINDOW_SHOW, true)

			LoginModel.instance.sessionId = nil
		end
	end)
	SDKManager.getSDKInstacne():registerExitListener(function()
		forcePrint("===========M:_onSDKExit in registerExitListener=============")
		UserAgent.instance:sendLogoutRequest()
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
	end)
	NativeBridge.instance:log("OneSDK login success")
	NativeBridge.instance:log("sessionId: " .. sessionId)
	NativeBridge.instance:log("platformId: " .. platformId)

	LoginModel.instance.sessionId = sessionId
	LoginModel.instance.platformId = platformId

	GlobalDispatcher:dispatchEvent(EventType.SDK_LOGIN_SUCCESS)
end

function M:_SDKLoginFail(statusCode, sessionId, platformId, statusDesc)
	NativeBridge.instance:log("OneSDK login fail")
	forcePrint("===========statusCode====" .. statusCode)
	printError("OneSDK login fail, statusCode is ", statusCode)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	if ViewMgr.instance:isOpen(ViewName.Login) then
		if statusCode == SDKError.LOGIN_FAIL_NO_NETWORK then
			local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_login_connectwebfail"))

			dialog:setConfirmListener(function()
				SDKManager.getSDKInstacne():login()
				GlobalDispatcher:dispatchEvent(EventType.LOGIN_SDK_WINDOW_SHOW, true)
			end, self)
			dialog:setCancelListener(self.confirmExit, self)
		else
			local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_login_sdkfail"))

			if statusDesc then
				printError(lang("tip_login_sdkfail") .. statusDesc)
			end

			if statusCode == -28 then
				local dialog = Dialog.showWarnMessage(lang("tip_title"), statusDesc, nil, btnVisiableInfo)

				dialog:setConfirmListener(self.confirmExit, self)
				dialog:setCancelListener(self.confirmExit, self)
			else
				local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_login_sdkfail"), nil, btnVisiableInfo)

				dialog:setConfirmListener(self._retryLogin, self)
				dialog:setCancelListener(self._retryLogin, self)
			end
		end
	end
end

function M:_onRealNameAuthCallback(statusCode, statusDesc)
	UserAgent.instance:sendNotifyRealNameInfoUpdateRequest()
	self:_handleAccountLoginFinish(statusCode == SDKManager.STATUS_OK)
end

function M:_onHandleOnApplicationPause(pause)
	forcePrint("============== come in _onHandleOnApplicationPause ===============")

	if LoginModel.instance.sessionId == nil then
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
	end
end

function M:_onHandleOnApplicationResume()
	forcePrint("============== come in _onHandleOnApplicationResume ===============")

	if not LoginModel.instance:getIsWebLogined() and LoginModel.instance.sessionId then
		forcePrint("============== come in _isWebLogined = false ")
		self:_handleAccountLoginFinish()
	end
end

function M:_onHandleOnApplicationQuit()
	UserAgent.instance:sendLogoutRequest()
end

function M:_handleAccountLoginFinish(isRealNameSuccess)
	forcePrint("============== come in _handleAccountLoginFinish ===============")

	if not isRealNameSuccess and (Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS) and Astral.GameConstParser.Instance.enableSDKLogin and not SDKManager.getSDKInstacne():isAutomatorEnabled() then
		local isRealName = SDKManager.getSDKInstacne():getUserRealNameStatus()

		if not isRealName then
			-- block empty
		end
	end

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)
	self._controller.webHandler:sendHttpGetServerListRequest({
		debug = false,
		sessionId = LoginModel.instance.sessionId
	})
	LoginFacade.instance:checkShowConfidentialityTip()
	NewNoticeController.instance:openNoticeView()
end

function M:confirmExit()
	self._controller:confirmExit()
end

return M
