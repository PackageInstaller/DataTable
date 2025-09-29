-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BreakPointComponent.lua

module("logic.extensions.backpack.cellcomponent.BreakPointComponent", package.seeall)

local M = class("BreakPointComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._breakPointRoot = registry:findUIElement("0&break_point_-2114175626")
	self._breakPointView = Astral.LuaComponentContainer.Add(self._breakPointRoot, EchoItemBreakPointView)

	self:setVisible(false)
end

function M:setVisible(visible)
	self._breakPointRoot:SetActive(visible)
end

function M:updateData(itemData)
	self:setVisible(false)

	if itemData:getType() == GameEnum.ItemTypeEnum.EchoItemType then
		local level = itemData.getLevel and itemData:getLevel() or 0

		self:setVisible(level > 1)

		if level > 1 then
			self._breakPointView:setEchoItemLevel(level, itemData:getMaxLevel())
		end
	end
end

return M
