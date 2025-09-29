-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgboard/controller/MsgBoardController.lua

module("logic.extensions.msgboard.controller.MsgBoardController", package.seeall)

local M = class("MsgBoardController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	NetConnMgr.instance:addReceiveFilter(self._handleResultCodeMsg, self)
end

function M:onReset()
	return
end

function M:_handleResultCodeMsg(extId, cmd, status, structName, msg, downTag, connType)
	if status ~= 0 then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType ~= 0 then
			FloatWordMgr.instance:show(LanguageMgr.instance:getText(itemInfo))
		end
	end
end

M.instance = M.New()

return M
