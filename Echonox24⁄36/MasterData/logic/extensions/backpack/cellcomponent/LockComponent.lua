-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LockComponent.lua

module("logic.extensions.backpack.cellcomponent.LockComponent", package.seeall)

local M = class("LockComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._rootGo = registry:findUIElement("backpack_item_962705275")
	self._lockGo = goutil.findChild(self._rootGo, "Lock")
	self._unlockGo = goutil.findChild(self._rootGo, "UnLock")
end

function M:setVisible(visible)
	goutil.setActive(self._rootGo, visible)
end

function M:updateData(itemData)
	local islock = itemData:getIsLock()

	goutil.setActive(self._rootGo, islock)

	if islock then
		goutil.setActive(self._lockGo, true)
		goutil.setActive(self._unlockGo, false)
	end
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M
