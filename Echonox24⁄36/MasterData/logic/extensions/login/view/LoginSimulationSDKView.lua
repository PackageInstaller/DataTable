-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginSimulationSDKView.lua

module("logic.extensions.login.view.LoginSimulationSDKView", package.seeall)

local M = class("LoginSimulationSDKView", ViewComponent)
local accountName = "accountName"
local defualtName = ""

function M:ctor()
	M.super.ctor(self)

	self._accoutPerf = nil
	self._btnLogin = nil
	self._inputAccountName = nil
end

function M:buildUI()
	self._btnLogin = self:getBtn("login_simulation_sdk_view_-768957226")
	self._inputAccountName = self:getInput("login_simulation_sdk_view_-645147739")
end

function M:destroyUI()
	self._btnLogin = nil
	self._inputAccountName = nil
end

function M:bindEvents()
	self._btnLogin:AddClickListener(self._onClickLoginBtn, self)
end

function M:unbindEvents()
	self._btnLogin:RemoveClickListener()
end

function M:onEnter()
	self._inputAccountName:SetText(Astral.LocalStorage.Instance:GetString(accountName, defualtName))
	self:_setEvent(true)
end

function M:onEnterFinished()
	return
end

function M:_setEvent(add)
	if add then
		KeycodeListener.instance:addEventListener(UnityEngine.KeyCode.Return, self._onKeyEnter, self)
	else
		KeycodeListener.instance:removeEventListener(UnityEngine.KeyCode.Return, self._onKeyEnter, self)
	end
end

function M:_onClickLoginBtn()
	self:_login()
end

function M:_login()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)

	local account = self._inputAccountName:GetText()

	if account and account ~= "" then
		LoginController.instance.webHandler:sendHttpGetServerListRequest({
			debug = true,
			account = account
		})
		Astral.LocalStorage.Instance:SetString(accountName, account)
	else
		FloatWordMgr.instance:show("账号为空或者无效账号")
	end
end

function M:_onKeyEnter(keyCode, isOn)
	if isOn then
		self:_login()
	end
end

function M:onExit()
	self:_setEvent(false)
end

function M:_onHttpGetSimulationSessoinIdSuccess(platformId, sessionId)
	printInfo("请求模拟sdk登录的sessionId 成功=", platformId, sessionId)

	LoginModel.instance.platformId = platformId
	LoginModel.instance.sessionId = sessionId

	GlobalDispatcher:dispatch(EventType.SIMULATION_SDK_LOGIN_SUCCESS)
	self:close()
end

function M:_onHttpGetSimulationSessoinIdError(resultCode)
	printInfo("请求模拟sdk登录的sessionId 失败，错误码=", resultCode)
	FloatWordMgr.instance:show(lang("请求模拟sdk登录的sessionId失败，错误码=" .. resultCode .. ",找后端查看一下验证站点"))
end

return M
