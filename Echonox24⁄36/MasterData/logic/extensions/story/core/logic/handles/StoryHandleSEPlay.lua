-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleSEPlay.lua

module("logic.extensions.story.core.logic.handles.StoryHandleSEPlay", package.seeall)

local M = class("StoryHandleSEPlay")

function M:Handle(config)
	if not config or not config:HasAnyArg() then
		return false
	end

	local soundEffectRes = config:GetArgValue(StoryArgKeyConst.SECueName)

	CriwareAudioFacade.instance:playSEByName(soundEffectRes)
end

return M
