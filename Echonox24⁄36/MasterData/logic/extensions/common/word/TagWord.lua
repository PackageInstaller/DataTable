-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/TagWord.lua

module("logic.extensions.common.word.TagWord", package.seeall)

local M = class("TagWord", WordBase)

function M:ctor(tagId)
	self.super.ctor(self, tagId)

	self._wordType = WordEnum.WordType.Tag
end

function M:getIcon()
	return ActiveSkillConfig.instance:getTagIconName(self._config.typeName)
end

return M
