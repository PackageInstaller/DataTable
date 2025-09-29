-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/cell/CommButton.lua

module("logic.extensions.common.cell.CommButton", package.seeall)

local M = class("CommButton", SimpleCellComponent)

function M:buildUI()
	local go = self._go

	self._clickHandler = Handler.New()
	self._btn = UIComponentType.ButtonAdapter(go)
	self._goNormal = goutil.findChild(go, "normal")
	self._goNotClick = goutil.findChild(go, "notClick")
	self._txtContent = goutil.findChildComponent(go, "normal/Text1", UIComponentType.Text)
	self._txtContentNotClick = goutil.findChildComponent(go, "notClick/Text1", UIComponentType.Text)
	self._txtContentNotClick.text = self._txtContent.text

	self:setActiveState(true)
end

function M:destroyUI()
	self._btn = nil

	if self._clickHandler then
		self._clickHandler:clear()
	end

	self._clickHandler = nil
end

function M:bindEvents()
	self._btn:AddClickListener(self._onClickBtn, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()
end

function M:_onClickBtn()
	if self._clickHandler and self._clickHandler:hadCallback() then
		self._clickHandler:call()
	end
end

function M:AddClickListener(callBack, callBackHandler)
	self._clickHandler:setListener(callBack, callBackHandler)
end

function M:RemoveClickListener()
	if self._clickHandler then
		self._clickHandler:clear()
	end
end

function M:getGo()
	return self._go
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setActiveState(active)
	self._active = active

	goutil.setActive(self._goNormal, self._active)
	goutil.setActive(self._goNotClick, not self._active)
end

function M:getActiveState()
	return self._active
end

function M:setInteractable(interactable)
	self._btn.btn.interactable = interactable
end

function M:setText(str)
	if not self._txtContent or goutil.isNil(self._txtContent) then
		return
	end

	self._txtContent.text = str
	self._txtContentNotClick.text = str
end

function M:getTextStr()
	if not self._txtContent or goutil.isNil(self._txtContent) then
		return
	end

	return self._txtContent.text
end

return M
