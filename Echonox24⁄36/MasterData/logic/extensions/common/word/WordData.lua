-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/WordData.lua

module("logic.extensions.common.word.WordData", package.seeall)

local M = class("WordData")

function M:ctor(desc)
	self._rawDesc = desc
	self._parsedDesc = nil
	self._words = {}
end

function M:getWords()
	return self._words
end

function M:refreshOrder()
	table.sort(self._words, WordUtil.sortWord)
end

function M:addWord(word)
	for index, w in ipairs(self._words) do
		if w:getKey() == word:getKey() then
			self._words[index] = word

			return
		end
	end

	table.insert(self._words, word)
end

function M:removeWord(wordKey)
	for i = 1, #self._words do
		if self._words[i]:getKey() == wordKey then
			table.remove(self._words, i)
		end
	end
end

function M:getRawDesc()
	return self._rawDesc
end

function M:getDesc()
	return self._parsedDesc
end

function M:setDesc(desc)
	self._parsedDesc = desc
end

function M:length()
	return #self._words
end

function M:hasWords()
	return self:length() > 0
end

function M:getBuffWords()
	return self:getTypeWords(WordEnum.WordType.Buff)
end

function M:getTagWords()
	return self:getTypeWords(WordEnum.WordType.Tag)
end

function M:getProperWords()
	return self:getTypeWords(WordEnum.WordType.Proper)
end

function M:getTypeWords(wordType)
	local result = {}

	for _, word in ipairs(self._words) do
		if word:getType() == wordType then
			table.insert(result, word)
		end
	end

	return result
end

function M:toString()
	return self._parsedDesc or ""
end

return M
