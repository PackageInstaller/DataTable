-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/ProperWord.lua

module("logic.extensions.common.word.ProperWord", package.seeall)

local M = class("ProperWord", WordBase)

function M:ctor(key)
	self._key = key
	self._config = nil
	self._wordType = WordEnum.WordType.Proper
end

return M
