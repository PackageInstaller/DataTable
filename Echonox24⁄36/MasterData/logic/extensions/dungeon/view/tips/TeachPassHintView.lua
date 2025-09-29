-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/tips/TeachPassHintView.lua

module("logic.extensions.dungeon.view.tips.TeachPassHintView", package.seeall)

local M = class("TeachPassHintView", ViewComponent)

function M:buildUI()
	self._txtContent = self:getTextByPath("txtContent")
	self._btnConfirm = self:getBtnByPath("btnConfirm")
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickEnsure, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	local param = self:getFirstParam()

	if param then
		self._txtContent.text = param
	end
end

function M:_onClickEnsure()
	self:close()
end

return M
