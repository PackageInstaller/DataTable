-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackNameComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackNameComponent", package.seeall)

local M = class("BackpackNameComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._nameText = nil
	self._visible = false
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._nameNode = registry:findUIElement("backpack_item_1238128537")
	self._nameText = registry:findUIElement("backpack_item_241486979", UIComponentType.Text)

	self:setVisible(true)
end

function M:updateData(itemData)
	self:setNameText(itemData:getName())
end

function M:setNameText(text)
	if self._visible then
		self._nameText.text = text
	end
end

function M:setVisible(visible)
	self._visible = visible

	goutil.setActive(self._nameNode, visible)
	goutil.setActive(self._nameText.gameObject, visible)
end

return M
