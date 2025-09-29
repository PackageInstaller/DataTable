-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionScale.lua

module("logic.extensions.story.core.logic.sections.SectionScale", package.seeall)

local M = class("SectionScale", StorySectionBase)

function M:_OnInitCtor()
	self.m_scaleHandle = StoryHandleFixScale.New()
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	self.m_scaleHandle:Handle(self.config, targetGo)
end

return M
