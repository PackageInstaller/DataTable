-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleSceneClose.lua

module("logic.extensions.story.core.logic.handles.StoryHandleSceneClose", package.seeall)

local M = class("StoryHandleSceneClose")

function M:Handle(config, binder)
	if not config then
		return
	end

	if not binder then
		return
	end

	local _key = config:GetArgValue(StoryArgKeyConst.RefTargetID)
	local sceneObj = binder:GetBindObject(_key)
	local sceneName = sceneObj and sceneObj.name or nil

	if not sceneName then
		return
	end

	local _url = StoryLogicResPathUtils.GetScenePath(sceneName)

	SceneMapResMgr.instance:unload(_url)
end

return M
