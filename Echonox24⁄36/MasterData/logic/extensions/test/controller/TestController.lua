-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/test/controller/TestController.lua

module("logic.extensions.test.controller.TestController", package.seeall)

local M = class("TestController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	KeycodeListener.instance:addEventListener(UnityEngine.KeyCode.F3, self.doFile, self)
	KeycodeListener.instance:addEventListener(UnityEngine.KeyCode.F5, self.clearEvent, self)
	self:replaceLog()
end

function M:_reloadLua(e, flag)
	if flag then
		Debug.reloadLua()
	end
end

function M:doFile(e, flag)
	if flag then
		ReloadLuaUtil.requireLuaDebug()
	end
end

function M:clearEvent(e, flag)
	if flag then
		ReloadLuaUtil.clearEvents()
	end
end

function M:replaceLog()
	ReloadLuaUtil.replaceLog()
end

M.instance = M.New()

return M
