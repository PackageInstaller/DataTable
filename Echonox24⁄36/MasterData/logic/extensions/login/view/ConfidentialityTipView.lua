-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/ConfidentialityTipView.lua

module("logic.extensions.login.view.ConfidentialityTipView", package.seeall)

local M = class("ConfidentialityTipView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._isFinishRead = false
end

function M:buildUI()
	self._btnClose = self:getBtn("confidentiality_agreement_tips_-1941039244")
	self._btnConfirm = self:getBtn("confidentiality_agreement_tips_-1568176983")
	self._toggleRead = self:getUIComponent("confidentiality_agreement_tips_-1965302340", UIComponentType.SpaceXToggle)
	self._scrollRectAdapter = Astral.ScrollRectAdapter.Get(self:getGo("confidentiality_agreement_tips_-1155246815"))
	self._scrollRect = self._scrollRectAdapter.scrollRect
end

function M:destroyUI()
	self._btnClose = nil
	self._btnConfirm = nil
	self._toggleRead = nil
	self._scrollRectAdapter = nil
	self._scrollRect = nil
	self._isFinishRead = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._scrollRectAdapter:AddOnValueChanged(self._onScrollChange, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._scrollRectAdapter:RemoveOnValueChanged()
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

function M:_onClickConfirm()
	if not self._toggleRead.IsOn or not self._isFinishRead then
		FloatWordMgr.instance:show("必须完整阅读并同意保密协议才可进行下一步操作")

		return
	end

	LoginFacade.instance:setReadConfidentiality()
	self:close()
end

function M:_onScrollChange()
	if self._scrollRect.verticalNormalizedPosition <= 0 and not self._isFinishRead then
		self._isFinishRead = true
	end
end

return M
