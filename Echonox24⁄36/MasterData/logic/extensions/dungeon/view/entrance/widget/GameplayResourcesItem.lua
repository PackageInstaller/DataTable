-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/widget/GameplayResourcesItem.lua

module("logic.extensions.dungeon.view.entrance.widget.GameplayResourcesItem", package.seeall)

local M = class("GameplayResourcesItem", SimpleCellComponent)

function M:buildUI()
	self._btnClick = self._registry:getBtn("fight_entry_resources_item_-677225200")
	self._txtName = self._registry:getText("fight_entry_resources_item_1653897463")
	self._txtResources = self._registry:getText("fight_entry_resources_item_920098853")
	self._txtUnlock = self._registry:getText("fight_entry_resources_item_1329819602")
	self._goLock = self._registry:getGo("fight_entry_resources_item_-625511693")
	self._goDouble = goutil.findChild(self._go, "click/doubleHint")
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
	if self._callback then
		self._callback()
	end
end

function M:updateData(data)
	self._callback = data.callback

	goutil.setActive(self._goDouble, data.isDouble)

	local isUnlock = data.unlock

	self._canvasGroup.alpha = isUnlock and 1 or 0.85
	self._txtUnlock.text = data.unlockText

	goutil.setActive(self._goLock, not isUnlock)
end

function M:setActivity()
	goutil.setActive(self._goDouble, true)
end

return M
