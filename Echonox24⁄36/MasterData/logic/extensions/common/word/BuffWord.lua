-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/BuffWord.lua

module("logic.extensions.common.word.BuffWord", package.seeall)

local M = class("BuffWord", WordBase)

function M:ctor(tagId)
	self.super.ctor(self, tagId)

	self._wordType = WordEnum.WordType.Buff
end

function M:getIcon()
	return self._config.descIcon
end

return M
