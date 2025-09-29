-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/WordBase.lua

module("logic.extensions.common.word.WordBase", package.seeall)

local M = class("WordBase")

function M:ctor(key)
	self._key = key
	self._config = nil
	self._wordType = WordEnum.WordType.Proper
end

function M:getType()
	return self._wordType
end

function M:setCO(wordCO)
	self._config = wordCO
end

function M:getCO()
	return self._config
end

function M:getKey()
	return self._key
end

function M:getDesc()
	return self._config.desc
end

function M:getIcon()
	return self._config.icon
end

function M:getName()
	return self._config.name
end

function M:getNameFormat()
	if string.nilorempty(self:getIcon()) then
		return string.format("%s", self:getName())
	else
		return string.format("<sprite name=\"%s\">%s", self:getIcon(), self:getName())
	end
end

function M:getNameUnderline()
	if string.nilorempty(self:getIcon()) then
		return string.format("<color=%s><u>%s</u></color>", WordUtil.NameDefaultColor, self:getName())
	else
		return string.format("<sprite name=\"%s\"><color=%s><u>%s</u></color>", self:getIcon(), WordUtil.NameDefaultColor, self:getName())
	end
end

function M:getNameBracket()
	if string.nilorempty(self:getIcon()) then
		return string.format("[%s]", self:getName())
	else
		return string.format("<sprite name=\"%s\">[%s]", self:getIcon(), self:getName())
	end
end

function M:getNameBracketUnderline()
	if string.nilorempty(self:getIcon()) then
		return string.format("[<u>%s</u>]", self:getName())
	else
		return string.format("<sprite name=\"%s\">[<u>%s</u>]", self:getIcon(), self:getName())
	end
end

function M:toString()
	return self._config.desc
end

return M
