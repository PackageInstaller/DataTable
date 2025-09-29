-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleScene2DClose.lua

module("logic.extensions.story.core.logic.handles.StoryHandleScene2DClose", package.seeall)

local M = class("StoryHandleScene2DClose")
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kVideoColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

function M:Handle(config, binder)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local bgRootContain = _storyEntry.bgRootContain
	local scene2d = _storyEntry.scene2D
	local effectBindObj = goutil.findChild(scene2d, "bgEffect")

	if effectBindObj then
		goutil.clearChildren(effectBindObj)
	end

	local bgObj = goutil.findChild(bgRootContain, "bg_root/bg")

	if not bgObj then
		return
	end

	local materialSetter = MaterialSetter.Get(bgObj)
	local isVideoBg = StoryModel.instance:getScene2dBgType()

	if isVideoBg then
		local videoMgr = CriWareVideoMgr.Get(bgObj)

		if videoMgr then
			videoMgr:DestroyMovie()
		end
	else
		materialSetter:DOAlpha(kMainColorID, 0, 1)
	end
end

return M
