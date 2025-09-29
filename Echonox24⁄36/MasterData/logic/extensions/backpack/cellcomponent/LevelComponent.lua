-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LevelComponent.lua

module("logic.extensions.backpack.cellcomponent.LevelComponent", package.seeall)

local M = class("LevelComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._rootGo = registry:findUIElement("backpack_item_108093803")
	self._txtNum = goutil.findChildTextComponent(self._rootGo, "txtNum")
end

function M:setVisible(visible)
	self._rootGo:SetActive(visible)
end

function M:updateData(itemData)
	if itemData:getType() == GameEnum.ItemTypeEnum.EquipItemType then
		goutil.setActive(self._rootGo, true)

		local level = itemData:getLevel()

		self._txtNum.text = string.format("Lv.%d", level)
	else
		goutil.setActive(self._rootGo, false)
	end
end

return M
