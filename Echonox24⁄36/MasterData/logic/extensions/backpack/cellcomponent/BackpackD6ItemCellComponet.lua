-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackD6ItemCellComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackD6ItemCellComponet", package.seeall)

local M = class("BackpackD6ItemCellComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._lockGo = registry:findUIElement("backpack_item_962705275")
	self._discardGo = registry:findUIElement("backpack_item_2012755664")
end

function M:updateData(d6Item)
	local showLocked = d6Item:getIsLock()

	goutil.setActive(self._lockGo, showLocked)
end

return M
