-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleBgMusicStop.lua

module("logic.extensions.story.core.logic.handles.StoryHandleBgMusicStop", package.seeall)

local M = class("StoryHandleBgMusicStop")

function M:Handle()
	CriwareAudioFacade.instance:stopBgm()
end

return M
