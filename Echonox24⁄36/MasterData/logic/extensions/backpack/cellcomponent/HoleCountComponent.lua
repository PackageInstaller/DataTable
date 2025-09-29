-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/HoleCountComponent.lua

module("logic.extensions.backpack.cellcomponent.HoleCountComponent", package.seeall)

local M = class("HoleCountComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._holeCountGo = registry:findUIElement("backpack_item_633745008")
	self._txtHoleCount = registry:findUIElement("backpack_item_1011461502", UIComponentType.Text)
	self._holeNums = {}
	self._holeNumsTyp = {}

	for i = 1, EquipEnum.MaxDiceCount do
		local tempHole = goutil.findChild(self._holeCountGo, "hole" .. i)

		table.insert(self._holeNums, tempHole)

		local holeTyp = {
			type1 = goutil.findChild(tempHole, "type1"),
			type2 = goutil.findChild(tempHole, "type2")
		}

		table.insert(self._holeNumsTyp, holeTyp)
	end
end

function M:setVisible(visible)
	goutil.setActive(self._holeCountGo, false)
end

function M:setCount(equipMo)
	goutil.setActive(self._holeCountGo, false)

	do return end

	if equipMo:hasOriginalD6() then
		self:setHoleType2(1, true)
	else
		goutil.setActive(self._holeNums[1], false)
	end

	for i = 2, EquipEnum.MaxDiceCount - 1 do
		self:setHoleType2(i, i - 1 <= #equipMo:getExtraDiceAttrs())
	end

	if equipMo:getQuality() > GameEnum.QualityEnum.B then
		self:setHoleType2(EquipEnum.MaxHoleCount, EquipEnum.MaxDiceCount - 1 <= #equipMo:getExtraDiceAttrs())
	else
		goutil.setActive(self._holeNums[EquipEnum.MaxHoleCount], false)
	end
end

function M:setHoleType2(index, opened)
	local holeType1 = self._holeNumsTyp[index].type1
	local holeType2 = self._holeNumsTyp[index].type2

	goutil.setActive(self._holeNums[index], true)
	goutil.setActive(holeType1, not opened)
	goutil.setActive(holeType2, opened)
end

return M
