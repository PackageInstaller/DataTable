-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/SkillPerformanceCOWrapper.lua

module("logic.battle.config.SkillPerformanceCOWrapper", package.seeall)

local SkillPerformanceCOWrapper = class("SkillPerformanceCOWrapper")

function SkillPerformanceCOWrapper:ctor(skillPerformanceCO)
	self._skillPerformanceCO = skillPerformanceCO
	self._bubbleRatios = false
end

function SkillPerformanceCOWrapper:getPerformanceCO()
	return self._skillPerformanceCO
end

function SkillPerformanceCOWrapper:_buildConfig()
	self._bubbleRatios = self:_buildBubbleRatios()
end

function SkillPerformanceCOWrapper:_buildBubbleRatios()
	local bubbleRatios = {}
	local skillPerformanceCO = self._skillPerformanceCO
	local bubbleWeightItems = string.split(skillPerformanceCO.bubbleWeights, ",")

	for _, bubbleWeightItem in pairs(bubbleWeightItems) do
		local bubbleDetails = string.split(bubbleWeightItem, "#")
		local weight = checknumber(bubbleDetails[1])
		local count = checkint(bubbleDetails[2])

		if count > 1 then
			for i = 1, count do
				table.insert(bubbleRatios, weight)
			end
		else
			table.insert(bubbleRatios, weight)
		end
	end

	local totalWeight = 0

	for _, weight in pairs(bubbleRatios) do
		totalWeight = totalWeight + weight
	end

	for i, weight in pairs(bubbleRatios) do
		bubbleRatios[i] = weight / totalWeight
	end

	return bubbleRatios
end

return SkillPerformanceCOWrapper
