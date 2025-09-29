-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackCanvasGroupComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackCanvasGroupComponet", package.seeall)

local M = class("BackpackCanvasGroupComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	self._canvasGroup = self._cell._go:GetComponent(ComponentType.CanvasGroup)
end

function M:updateData(itemData)
	local type = itemData and itemData:getType()

	if not type or not MainBackpackModel.instance:isInRecycling() then
		return
	end

	if type == GameEnum.ItemTypeEnum.EquipItemType or type == GameEnum.ItemTypeEnum.EchoItemType then
		local isGray = itemData:getIsLock() or itemData:getIsEquip()

		self._canvasGroup.alpha = isGray and 0.5 or 1
	elseif type == GameEnum.ItemTypeEnum.DiceItem then
		local isGray = itemData:getIsLock()

		self._canvasGroup.alpha = isGray and 0.5 or 1
	end
end

return M
