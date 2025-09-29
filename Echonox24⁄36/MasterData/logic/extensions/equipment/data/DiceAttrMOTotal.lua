-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/DiceAttrMOTotal.lua

module("logic.extensions.equipment.data.DiceAttrMOTotal", package.seeall)

local M = class("DiceAttrMOTotal", DiceAttrMO)

function M:ctor(DiceAttrMO)
	self._diceAttrId = DiceAttrMO:getAttrId()
	self._level = DiceAttrMO:getLevel()
	self._value = DiceAttrMO:getValue()
	self._enhanced = DiceAttrMO:isEnhanced()
	self._co = EquipmentConfig.instance:getConfigByKey(ConfigName.DiceAttr, self._diceAttrId)
	self._buffCodes = {}
	self._tagCodes = {}

	self:_getCo3DDesc()
end

function M:AddDiceAttrMO(DiceAttrMO)
	if self._diceAttrId ~= DiceAttrMO:getAttrId() then
		return
	end

	local newLv = DiceAttrMO:getLevel()

	if newLv > self._level then
		self._level = newLv
	end

	self._value = self._value + DiceAttrMO:getValue()

	if not self._enhanced then
		self._enhanced = DiceAttrMO:isEnhanced()
	end
end

function M:getAttrId()
	return self._diceAttrId
end

function M:getLevel()
	return self._level
end

function M:getValue()
	return self._value
end

function M:getPart()
	return self._co.part
end

function M:isEnhanced()
	return self._enhanced
end

function M:getEnhanceType()
	return self._co.group
end

function M:getDesc()
	if self._fackAttrType == EquipEnum.FackAttrType.RecycleType then
		return lang("tips_d6_recycle_attr")
	end

	if string.find(self._co.desc, "[+-]%%") then
		local str = string.gsub(self:getCoDesc(), "([+-])(%%)", "%1" .. 100 * self:getValue() .. "%%")

		return StringUtil.replaceMiddleBracketsToColor(str)
	else
		local str = string.gsub(self:getCoDesc(), "([+-])", "%1" .. self:getValue())

		return StringUtil.replaceMiddleBracketsToColor(str)
	end

	return ""
end

function M:getAttrColor()
	return EquipEnum.AttrLevel2Color[self:getLevel()] or EquipEnum.ColorMap.White
end

function M:getColorCode(value)
	local color = EquipEnum.AttrLevel2Color[self:getLevel()]

	return string.format("<color=%s>%s</color>", color, value)
end

return M
