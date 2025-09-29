-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/facade/SecretFacade.lua

module("logic.extensions.systemtip.facade.SecretFacade", package.seeall)

local M = class("SecretFacade", BaseFacade)

function M:init()
	ViewMgr.instance:openSpecialView(ViewName.SecretView)
	ViewMgr.instance:openSpecialView(ViewName.ClickView)
end

function M:registered(view)
	self._selectView = view
end

function M:setID(id)
	if self._selectView then
		self._selectView:setID(id)
	end
end

M.instance = M.New()

return M
