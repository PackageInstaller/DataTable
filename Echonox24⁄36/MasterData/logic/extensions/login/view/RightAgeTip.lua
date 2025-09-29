-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/RightAgeTip.lua

module("logic.extensions.login.view.RightAgeTip", package.seeall)

local M = class("RightAgeTip", ViewComponent)

function M:buildUI()
	self._closeBtn = self:getBtn("summon_card_preview_tips_1562694936")
end

function M:destroyUI()
	self._closeBtn = nil
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
end

return M
