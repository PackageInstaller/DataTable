-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/facade/ShareFacade.lua

module("logic.extensions.share.facade.ShareFacade", package.seeall)

local M = class("ShareFacade")

function M:isSystemOpen(showToast)
	local systemEnum

	if systemEnum then
		return SystemOpenFacade.instance:isOpen(systemEnum, showToast)
	end

	return true
end

function M:isPlatformOpen(showToast)
	return true
end

function M:isOpen(showToast)
	if not self:isPlatformOpen(showToast) then
		return false
	end

	if not self:isSystemOpen(showToast) then
		return false
	end

	return true
end

function M:openShare(shareEnum, fileName, showToast, exitCallBackFunc, exitCallBackHandler)
	if not self:isOpen(showToast) then
		return false
	end

	local info = {}

	info.shareType = shareEnum
	info.fileName = fileName
	info.handler = exitCallBackHandler
	info.exitCallBackFunc = exitCallBackFunc

	ViewMgr.instance:open(ViewName.Share, info)

	return true
end

M.instance = M.New()

return M
