-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/DiceAttrMO.lua

module("logic.extensions.equipment.data.DiceAttrMO", package.seeall)

local M = class("DiceAttrMO")

function M:ctor(DiceAttrNO)
	self:updateByNo(DiceAttrNO)
end

function M:updateByNo(DiceAttrNO)
	self._diceAttrId = DiceAttrNO.diceAttrId
	self._level = DiceAttrNO.level
	self._value = DiceAttrNO.value or 0
	self._enhancedLevel = DiceAttrNO.enhancedLevel or 0
	self._enhancedValue = DiceAttrNO.enhancedValue or 0
	self._co = EquipmentConfig.instance:getConfigByKey(ConfigName.DiceAttr, self._diceAttrId)
	self._fackAttrType = DiceAttrNO.fackAttrType
	self._fackRecommedD6 = DiceAttrNO.fackRecommendD6
	self._buffCodes = {}
	self._tagCodes = {}

	self:_getCo3DDesc()
end

function M:_getCo3DDesc()
	local buffs = {}
	local tags = {}

	if not self._co then
		return
	end

	self._co3DDesc = ActiveSkillCOUtil.buildBuffAndTagDesc(self._co.desc, buffs, tags)

	for code, _ in pairs(buffs) do
		table.insert(self._buffCodes, code)
	end

	for code, _ in pairs(tags) do
		table.insert(self._tagCodes, code)
	end
end

function M:getAttrId()
	return self._diceAttrId
end

function M:getLevel()
	return self._enhancedLevel > 0 and self._enhancedLevel or self._level
end

function M:getReallyLevel()
	return self._level
end

function M:setLevel(level)
	self._level = level
end

function M:getValue()
	return self._enhancedValue > 0 and self._enhancedValue or self._value
end

function M:getSourceValue()
	return self._value
end

function M:getEnhancedAddValue()
	return self._enhancedValue - self._value
end

function M:getPart()
	return self._co.part
end

function M:getEnhanceType()
	return self._co.group
end

function M:getIcon()
	return self._co.icon
end

function M:getSourceDesc()
	if self._fackAttrType == EquipEnum.FackAttrType.RecycleType then
		return lang("tips_d6_recycle_attr")
	elseif self._fackAttrType == EquipEnum.FackAttrType.ShowType then
		return lang("tips_d6_show_attr")
	elseif self._fackAttrType == EquipEnum.FackAttrType.Recommended then
		return self._fackRecommedD6
	end

	local coDesc = self:getCoDesc()

	if string.find(coDesc, "[+-]%%") then
		local str = string.gsub(coDesc, "([+-])(%%)", "%1" .. 100 * self:getSourceValue() .. "%%")

		return StringUtil.replaceMiddleBracketsToColor(str)
	else
		local str = string.gsub(coDesc, "([+-])", "%1" .. self:getSourceValue())

		return StringUtil.replaceMiddleBracketsToColor(str)
	end

	return ""
end

function M:getFilterDesc()
	local coDesc = self:getCoDesc()

	if string.find(coDesc, "[+-]%%") then
		local str = string.gsub(coDesc, "([+-])(%%)", "%1" .. self:getSourceValue() .. "%%")

		return StringUtil.replaceMiddleBracketsToColor(str)
	else
		local str = string.gsub(coDesc, "([+-])", "%1" .. self:getSourceValue())

		return StringUtil.replaceMiddleBracketsToColor(str)
	end

	return ""
end

function M:getDesc(highLightTagIds, isGetBase)
	if self._fackAttrType == EquipEnum.FackAttrType.RecycleType then
		return lang("tips_d6_recycle_attr")
	elseif self._fackAttrType == EquipEnum.FackAttrType.ShowType then
		return lang("tips_d6_show_attr")
	elseif self._fackAttrType == EquipEnum.FackAttrType.Recommended then
		local str = self:getFackAttr()

		return str
	end

	local value = self:getValue()

	if isGetBase == true then
		value = self:getSourceValue()
	end

	local coDesc = self:getCoDesc()

	if highLightTagIds and #highLightTagIds > 0 then
		local buffs = {}
		local tags = {}

		coDesc = ActiveSkillCOUtil.buildBuffAndTagDesc(self._co.desc, buffs, tags, highLightTagIds)
	end

	if string.find(coDesc, "[+-]%%") then
		local str = string.gsub(coDesc, "([+-])(%%)", "%1" .. 100 * value .. "%%")

		return StringUtil.replaceMiddleBracketsToColor(str)
	else
		local str = string.gsub(coDesc, "([+-])", "%1" .. value)

		return StringUtil.replaceMiddleBracketsToColor(str)
	end

	return ""
end

function M:getFackAttr()
	local buffs = {}
	local tags = {}

	self._co3DDesc = ActiveSkillCOUtil.buildBuffAndTagDesc(self._fackRecommedD6, buffs, tags)

	for code, _ in pairs(buffs) do
		table.insert(self._buffCodes, code)
	end

	for code, _ in pairs(tags) do
		table.insert(self._tagCodes, code)
	end

	local str = self:getCoDesc()

	return StringUtil.replaceMiddleBracketsToColor(str)
end

function M:getCoDesc()
	return self._co3DDesc
end

function M:getBuffsAndTags()
	if #self._buffCodes > 0 or #self._tagCodes > 0 then
		return self._buffCodes, self._tagCodes
	end

	return false, false
end

function M:getTags()
	return self._tagCodes
end

function M:getAttrColor()
	return EquipEnum.AttrLevel2Color[self:getLevel()] or EquipEnum.ColorMap.White
end

function M:getColorCode(value)
	local color = EquipEnum.AttrLevel2Color[self:getLevel()]

	return string.format("<color=%s>%s</color>", color, value)
end

function M:getSourceColorCode(value)
	local color = EquipEnum.AttrLevel2Color[self:getReallyLevel()]

	return string.format("<color=%s>%s</color>", color, value)
end

function M:getCopyForExtract()
	local ret = clone(self)

	ret._enhancedLevel = 0
	ret._enhancedValue = 0

	return ret
end

function M:isEnhanced()
	return self._enhancedLevel > self._level
end

function M:getIsFackAttr()
	return self._fackAttrType or false
end

function M:getFackRecommedD6()
	return self._fackRecommedD6
end

return M
