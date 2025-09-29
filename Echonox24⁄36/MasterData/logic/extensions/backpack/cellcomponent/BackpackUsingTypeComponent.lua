-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackUsingTypeComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackUsingTypeComponent", package.seeall)

local M = class("BackpackUsingTypeComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._usingTypeGo = registry:findUIElement("backpack_item_142192069")

	self:setUsingGoVisible(false)
end

function M:updateData(data)
	if data and data.isUsing then
		local isInUse = data:isUsing()

		self:setUsingGoVisible(isInUse)
	else
		self:setUsingGoVisible(false)
	end
end

function M:setUsingGoVisible(visible)
	self._usingTypeGo:SetActive(visible)
end

return M
