-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/widget/GameplayRegulatoryItem.lua

module("logic.extensions.dungeon.view.entrance.widget.GameplayRegulatoryItem", package.seeall)

local M = class("GameplayRegulatoryItem", SimpleCellComponent)

function M:buildUI()
	self._btnClick = self._registry:getBtn("fight_entry_regulatory_item_-2122379825")
	self._txtLock = self._registry:getText("fight_entry_regulatory_item_-641175179")
	self._goLockBg = self._registry:getGo("fight_entry_regulatory_item_1339628800")
	self._goLock = self._registry:getGo("fight_entry_regulatory_item_1800565397")
	self._goNormal = self._registry:getGo("fight_entry_regulatory_item_87964590")
	self._doubleHint = self._registry:getGo("0&com_multiple_rewards_hint_2109480314")
	self._canvasGroup = self._go:GetComponent(ComponentType.CanvasGroup)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClick()
	if self._callback ~= nil then
		self._callback()
	end
end

function M:updateData(data)
	local isUnlock = data.unlock

	self._canvasGroup.alpha = isUnlock and 1 or 0.85
	self._txtLock.text = data.unlockText
	self._callback = data.callback

	goutil.setActive(self._goLock, not isUnlock)
	goutil.setActive(self._goLockBg, not isUnlock)
	goutil.setActive(self._doubleHint, false)
end

function M:setDoubleHint(isShow)
	goutil.setActive(self._doubleHint, isShow)
end

return M
