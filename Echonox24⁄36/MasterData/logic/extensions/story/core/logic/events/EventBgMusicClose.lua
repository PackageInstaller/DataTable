-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventBgMusicClose.lua

module("logic.extensions.story.core.logic.events.EventBgMusicClose", package.seeall)

local M = class("EventBgMusicClose", StoryEventBase)

function M:_OnInitCtor()
	self.m_handle = StoryHandleBgMusicStop.New()
end

function M:OnEventExecuteInternal()
	self.m_handle:Handle()
end

function M:OnStoryCleanInternal()
	return
end

return M
