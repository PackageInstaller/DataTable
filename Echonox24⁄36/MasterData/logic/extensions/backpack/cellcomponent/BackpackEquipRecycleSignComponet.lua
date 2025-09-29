-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackEquipRecycleSignComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackEquipRecycleSignComponet", package.seeall)

local M = class("BackpackEquipRecycleSignComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	self._signGo = goutil.findChild(self._cell._go, "equip_hole_item_copy")
	self._imgHoleIcon = goutil.findChildImageComponent(self._signGo, "unlock/imgHoleIcon")
end

function M:updateData(equipItemData)
	self._equipMo = equipItemData

	if MainBackpackModel.instance:isInRecycling() then
		local hasOriginalD6 = self._equipMo:hasOriginalD6()

		goutil.setActive(self._signGo, hasOriginalD6)

		if hasOriginalD6 then
			local d6mo = self._equipMo:getOriginalD6():getEffectAttr()
			local iconName = string.format("equip_hole_0%d", d6mo:getEnhanceType())

			IconLoader.setSprite(self._imgHoleIcon, IconType.Skinlib, iconName)
		end
	else
		goutil.setActive(self._signGo, false)
	end
end

return M
