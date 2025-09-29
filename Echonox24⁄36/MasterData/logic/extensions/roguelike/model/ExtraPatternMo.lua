-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/ExtraPatternMo.lua

module("logic.extensions.roguelike.model.ExtraPatternMo", package.seeall)

local M = class("ExtraPatternMo")

function M:ctor(pattern)
	self._pattern = pattern
end

function M:getIsDebuff()
	local pattern = RoguelikeConst.DICE_PATTERN

	return self._pattern == pattern.BLEEDING or self._pattern == pattern.TRANCE or self._pattern == pattern.CURSE
end

function M:getNeedSelect()
	local pattern = RoguelikeConst.DICE_PATTERN

	return self._pattern ~= pattern.BLEEDING and self._pattern ~= pattern.TRANCE and self._pattern ~= pattern.CURSE
end

function M:getEffectRoleId()
	return
end

return M
