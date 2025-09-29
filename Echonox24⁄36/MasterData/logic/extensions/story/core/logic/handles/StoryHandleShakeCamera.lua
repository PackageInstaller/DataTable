-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleShakeCamera.lua

module("logic.extensions.story.core.logic.handles.StoryHandleShakeCamera", package.seeall)

local M = class("StoryHandleShakeCamera")

function M:HandleEnter(targetGo, shakeCode, shakeTimeType, needStopShake)
	if goutil.isNil(targetGo) or not targetGo then
		return
	end

	if needStop then
		StoryUtils.stopShakeGo(targetGo)

		local entry = StoryController.instance:getCurStoryEntry()

		if not entry then
			local planeGo = entry.bgRootContain

			StoryUtils.stopShakeGo(planeGo)
		end

		return
	end

	local time = false

	if shakeTimeType == StoryConstDef.EShakeCameraTime.Hold then
		time = 99999999
	end

	StoryUtils.shakeGo(targetGo, tonumber(shakeCode), time)

	local entry = StoryController.instance:getCurStoryEntry()

	if not entry then
		local planeGo = entry.bgRootContain

		StoryUtils.shakeGo(planeGo, tonumber(shakeCode), time)
	end
end

function M:HandleExit(targetGo, needStop)
	if goutil.isNil(targetGo) or not targetGo then
		return
	end

	if needStop then
		StoryUtils.stopShakeGo(targetGo)

		local entry = StoryController.instance:getCurStoryEntry()

		if not entry then
			local planeGo = entry.bgRootContain

			StoryUtils.stopShakeGo(planeGo)
		end
	end
end

return M
