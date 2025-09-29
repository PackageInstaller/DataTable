-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginController.lua

module("logic.extensions.login.controller.LoginController", package.seeall)

local M = class("LoginController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._compList = {}
	self._isReturnToLogin = false

	self:_addComponent("webHandler", LoginWebHandler)
	self:_addComponent("hotUpdateHandler", LoginHotUpdateHandler)
	self:_addComponent("reconnectHandler", LoginReconnectHandler)
	self:_addComponent("sdkHandler", LoginSdkHandler)
	self:_addComponent("netSecProtectHandler", LoginNetSecProtectSdkHandler)
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function M:_notifyComponents(functionName, ...)
	for _, component in pairs(self._compList or {}) do
		local func = component[functionName]

		if func then
			func(component, ...)
		end
	end
end

function M:onInit()
	self:_notifyComponents("onInit")
end

function M:onReset()
	self:_notifyComponents("onReset")
end

function M:showReturnToLoginDialog(contentText, title)
	self:_showReturnToLoginDialog(contentText, title)
end

function M:returnToLogin()
	self:_returnToLogin()
end

function M:clearReturnToLogin()
	self._isReturnToLogin = false
end

function M:hideLoginFailDialog()
	if self._loginFailDialog then
		self._loginFailDialog:close()

		self._loginFailDialog = nil
	end
end

function M:_showReturnToLoginDialog(contentText, title)
	if self._isReturnToLogin or self._loginFailDialog then
		return
	end

	local dialog = Dialog.showNotifyMessage(title or lang("tip_connect_game"), contentText or lang("tip_ask_relogin"))

	dialog:setConfirmListener(self._onClickReturnToLogin, self)
	dialog:setConfirmButtonText(lang("tip_common_sure"))

	self._loginFailDialog = dialog
end

function M:_onClickReturnToLogin()
	self.reconnectHandler:clear()
	self:_returnToLogin()

	self._loginFailDialog = nil
end

function M:_returnToLogin()
	self._isReturnToLogin = true

	if Astral.GameConstParser.Instance.enableSDKLogin then
		SDKManager.getSDKInstacne():logout()
	end

	LoginModel.instance.sessionId = nil

	SceneFace.instance:exitScene()
	SceneFace.instance:clearEnterSceneInfo()
	SceneMgr.instance:exitCurScene()
	LoadingFacade.instance:hideLoading()
	LoadingFacade.instance:clear()
	BattleMgr.instance:forceExit()
	AirWorkShopDefMgr.instance:forceExit()
	RogueMgr.instance:exit()
	ExtensionMgr.instance:resetAllExtensions()
	NetConnMgr.instance:disconnect()
	Dialog.closeAllMessage()
	ViewMgr.instance:closeAllViews(WindowType.WindowCloseReasonType.QuickCloseType)
	MemoryMgr.instance:gc()
	LoginModel.instance:setSDKNeedLogout(true)
	LoginFacade.instance:showLogin()
	NetSecProtectMgr.instance:logout()
end

function M:confirmExit()
	SystemUtil.Quit()
end

function M:requestServerListAgain(callback)
	if LoginModel.instance.sessionId then
		self.webHandler:sendHttpGetServerListRequest({
			debug = false,
			sessionId = LoginModel.instance.sessionId
		}, callback)
	else
		if Astral.GameConstParser.Instance.enableSDKLogin and not Astral.OSDef.isEditor then
			return
		end

		local accountName = "accountName"
		local defualtName = "t1"
		local account = Astral.LocalStorage.Instance:GetString(accountName, defualtName)

		self.webHandler:sendHttpGetServerListRequest({
			debug = true,
			account = account
		}, callback)
	end
end

M.instance = M.New()

return M
