-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleBgMusicPlay.lua

module("logic.extensions.story.core.logic.handles.StoryHandleBgMusicPlay", package.seeall)

local M = class("StoryHandleBgMusicPlay")

function M:Handle(config)
	if not config or not config:HasAnyArg() then
		return false
	end

	local bgmRes = config:GetArgValue(StoryArgKeyConst.BgState1)

	if not string.nilorempty(bgmRes) then
		StoryModel.instance:cacheBgm()
		CriwareAudioFacade.instance:PlayBgmInnerBgName(bgmRes)
	end
end

return M
