-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueDiceMo.lua

module("logic.extensions.roguelike.model.RogueDiceMo", package.seeall)

local M = class("RogueDiceMo")
local PATTERN = RoguelikeConst.DICE_PATTERN

function M:ctor(diceType, prop, specialType)
	self._id = RogueMgr.instance:getNewUnitIdIndex()
	self._patterns = {}
	self._mainDiceType = diceType

	if diceType == RoguelikeConst.ROGUE_DICE_TYPE.COMBAT then
		self._patterns = {
			PATTERN.POWER,
			PATTERN.AGILE,
			PATTERN.KNOWLEDGE,
			PATTERN.COMMUNICATE,
			PATTERN.INSIGHT,
			PATTERN.LUCKY
		}
	elseif diceType == RoguelikeConst.ROGUE_DICE_TYPE.PLAYER then
		if specialType then
			for i = 1, 6 do
				self._patterns[i] = PATTERN.WHITE
			end

			self._specialType = specialType
		else
			local propIndexs, whiteIndexs = self:getRandomIndex()

			for i = 1, #propIndexs do
				self._patterns[propIndexs[i]] = prop
			end

			for i = 1, #whiteIndexs do
				self._patterns[whiteIndexs[i]] = PATTERN.WHITE
			end
		end
	elseif diceType == RoguelikeConst.ROGUE_DICE_TYPE.ROSE then
		self._patterns = {
			PATTERN.FATHER,
			PATTERN.DAUGHTER,
			PATTERN.DAUGHTER,
			PATTERN.DAUGHTER,
			PATTERN.DAUGHTER,
			PATTERN.DAUGHTER
		}
	elseif diceType == RoguelikeConst.ROGUE_DICE_TYPE.TRUTH then
		self._patterns = {
			PATTERN.NORMAL,
			PATTERN.CRITICAL_STRIKE,
			PATTERN.TRANCE,
			PATTERN.REDUCE_WISDOM,
			PATTERN.WHITE,
			PATTERN.WHITE
		}
	end

	self._upIndex = 1
end

function M:getId()
	return self._id
end

function M:getPatterns()
	return self._patterns or {}
end

function M:getRandomUpIndex()
	return math.random(1, 6)
end

function M:getRandomUpPattern()
	return self._patterns[math.random(1, 6)]
end

function M:getSpecialType()
	return self._specialType
end

function M:attachExtraPattern(patterns)
	if not patterns or #patterns == 0 then
		return
	end

	local index = 1

	for i = 1, 6 do
		local tempPattern = self._patterns[i]

		if tempPattern == PATTERN.WHITE then
			self._patterns[i] = patterns[index]
			index = index + 1

			if index > #patterns then
				return
			end
		end
	end
end

function M:setUpIndex(index)
	self._upIndex = index
end

function M:getUpIndex()
	return self._upIndex
end

function M:getUpPattern()
	local pattern = self._patterns[self._upIndex]

	return pattern
end

function M:getUpPatternType()
	local pattern = self._patterns[self._upIndex]

	return RoguelikeConst.GetPatternType(pattern)
end

function M:getUpPatternCo()
	local pattern = self._patterns[self._upIndex]

	return RoguelikeConfig.instance:getExtraPatternById(RoguelikeUtil.instance:convertCAttrType2SType(pattern))
end

function M:getUpPatternEffect()
	local co = self:getUpPatternCo()

	if co then
		return co.effect
	end

	return 0
end

function M:getUpPatternMatchDiceCount()
	local co = self:getUpPatternCo()

	if co then
		return co.matchDice
	end

	return 0
end

function M:getPatternLevel()
	local pattern = self._patterns[self._upIndex]

	return RoguelikeConst.GetPatternLevel(pattern)
end

function M:getIsNormal()
	return self:getUpPattern() >= PATTERN.POWER and self:getUpPattern() <= PATTERN.LUCKY
end

function M:getIsUpSpecial()
	return self:getUpPattern() > PATTERN.WHITE
end

function M:getHadSpecial()
	for k, v in pairs(self._patterns) do
		if v > PATTERN.WHITE then
			return true
		end
	end

	return false
end

function M:getSpecialPatternCount()
	local count = 0

	for k, v in pairs(self._patterns) do
		if v > PATTERN.WHITE then
			count = count + 1
		end
	end

	return count
end

function M:setUpPattern(pattern)
	self._patterns[self._upIndex] = pattern
end

function M:getSpecialPatterns()
	local specialPatterns = {}

	for i = 1, 6 do
		local tempPattern = self._patterns[i]

		if tempPattern ~= PATTERN.WHITE then
			table.insert(specialPatterns, tempPattern)
		end
	end

	table.sort(specialPatterns, function(a, b)
		local aPriority = self:getPatternPriority(a)
		local bPriority = self:getPatternPriority(b)

		return aPriority < bPriority
	end)

	return specialPatterns
end

function M:getPatternPriority(pattern)
	local priorityMap = {
		[PATTERN.BLESSING] = 1,
		[PATTERN.CURSE] = 2,
		[PATTERN.BLEEDING] = 3,
		[PATTERN.TRANCE] = 4,
		[PATTERN.CRITICAL_STRIKE] = 5,
		[PATTERN.SACRIFICE] = 6,
		[PATTERN.REDUCE_WISDOM] = 7
	}

	return priorityMap[pattern] or 10
end

function M:getPatternByIndex(index)
	return self._patterns[index] or RoguelikeConst.DICE_PATTERN.WHITE
end

function M:getPatternIsSpecial(index)
	return self._patterns[index] and self._patterns[index] > RoguelikeConst.DICE_PATTERN.WHITE
end

function M:setPatternByIndex(index, pattern)
	self._patterns[index] = pattern
end

function M:getRandomIndex(total)
	local sequence = {}
	local randSequence = {}

	total = total or 3

	for i = 1, 6 do
		table.insert(sequence, i)
	end

	local endIndex = #sequence

	total = endIndex < total and endIndex or total

	function swap(idx1, idx2)
		local temp = sequence[idx1]

		sequence[idx1] = sequence[idx2]
		sequence[idx2] = temp
	end

	for i = 1, total do
		local temp = math.random(1, endIndex)

		table.insert(randSequence, sequence[temp])
		swap(temp, endIndex)

		endIndex = endIndex - 1
	end

	function isContain(index)
		for j = 1, #randSequence do
			if randSequence[j] == index then
				return true
			end
		end

		return false
	end

	local otherSequence = {}

	for i = 1, 6 do
		if not isContain(i) then
			table.insert(otherSequence, i)
		end
	end

	return randSequence, otherSequence
end

function M:setGo(go)
	self._go = go
end

function M:getGo()
	return self._go
end

function M:setDiceType(diceType)
	self._diceType = diceType
end

function M:getDiceType()
	return self._diceType
end

function M:getMainDiceType()
	return self._mainDiceType
end

return M
