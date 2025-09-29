-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipRecycleSignComponet.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipRecycleSignComponet", package.seeall)

local M = class("EquipRecycleSignComponet", BackpackEquipRecycleSignComponet)

function M:updateData(equipItemData)
	self._equipMo = equipItemData

	local hasOriginalD6 = self._equipMo:hasOriginalD6()

	goutil.setActive(self._signGo, hasOriginalD6)

	if hasOriginalD6 then
		local d6mo = self._equipMo:getOriginalD6():getEffectAttr()
		local iconName = string.format("equip_hole_0%d", d6mo:getEnhanceType())

		IconLoader.setSprite(self._imgHoleIcon, IconType.Skinlib, iconName)
	end
end

return M
