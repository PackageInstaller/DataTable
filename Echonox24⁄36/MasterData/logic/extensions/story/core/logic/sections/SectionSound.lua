-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionSound.lua

module("logic.extensions.story.core.logic.sections.SectionSound", package.seeall)

local M = class("SectionSound", StorySectionBase)

function M:_OnInitCtor()
	self.m_playingID = false
	self.m_playHandle = StoryHandleSoundPlay.New()
	self.m_stopHandle = StoryHandleSoundStop.New()
end

function M:OnSectionEnableInternal()
	self.m_playingID = self.m_playHandle:Handle(self.config, self.parent.parent.shotId)
end

function M:OnSectionDisableInternal()
	self.m_stopHandle:Handle(self.config, self.m_playingID)
end

return M
