-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleAmbPlay.lua

module("logic.extensions.story.core.logic.handles.StoryHandleAmbPlay", package.seeall)

local M = class("StoryHandleAmbPlay")

function M:Handle(config)
	if not config or not config:HasAnyArg() then
		return false
	end

	local cueName = config:GetArgValue(StoryArgKeyConst.AmbEffect)

	if not string.nilorempty(cueName) then
		StoryModel.instance:cacheAmb()
		CriwareAudioFacade.instance:playEnvironmentByName(cueName)
	end
end

return M
