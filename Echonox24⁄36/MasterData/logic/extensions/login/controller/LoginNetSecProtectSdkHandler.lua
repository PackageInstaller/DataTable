-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginNetSecProtectSdkHandler.lua

module("logic.extensions.login.controller.LoginNetSecProtectSdkHandler", package.seeall)

local M = class("LoginNetSecProtectSdkHandler")

function M:ctor(controller)
	self._controller = controller
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.LOGIN_CONNECT_SERVER_DONE_EVENT, self._onHandleLogin, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_QUIT, self._onHandleOnAppQuit, self)
end

function M:_onHandleLogin(isSuccess)
	if isSuccess then
		local userId = LoginModel.instance:getUserId()
		local userName = LoginModel.instance:getAccount()
		local serverName = LoginModel.instance:getServerName()

		NetSecProtectMgr.instance:setUserInfo(userId, userName, serverName)
	end
end

function M:_onHandleOnAppQuit()
	NetSecProtectMgr.instance:logOut()
end

return M
