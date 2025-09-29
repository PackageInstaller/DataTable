-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/SkillValueDivider.lua

module("logic.battle.skill.attackpoint.SkillValueDivider", package.seeall)

local SkillValueDivider = class("SkillValueDivider")

function SkillValueDivider:ctor()
	self._originalValue = 0
	self._totalWeight = 0
	self._curTotalValue = 0
end

function SkillValueDivider:clear()
	self._originalValue = 0
	self._curTotalValue = 0
end

function SkillValueDivider:setOriginalValueAndWeight(originalValue, totalWeight)
	self._originalValue = originalValue
	self._totalWeight = totalWeight
end

function SkillValueDivider:genNextValue(weight)
	if self._curTotalValue >= self._originalValue then
		return 0
	end

	local ratio = weight / self._totalWeight
	local nextValue = math.ceil(self._originalValue * ratio)
	local curTotalValue = self._curTotalValue + nextValue

	if curTotalValue > self._originalValue then
		nextValue = self._originalValue - self._curTotalValue
		self._curTotalValue = self._originalValue

		return nextValue
	end

	self._curTotalValue = curTotalValue

	return nextValue
end

function SkillValueDivider:getCurTotalValue()
	return self._curTotalValue
end

return SkillValueDivider
