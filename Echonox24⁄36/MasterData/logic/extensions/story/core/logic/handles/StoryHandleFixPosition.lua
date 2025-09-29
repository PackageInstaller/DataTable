-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleFixPosition.lua

module("logic.extensions.story.core.logic.handles.StoryHandleFixPosition", package.seeall)

local M = class("StoryHandleFixPosition")

function M:ctor()
	self._getter = StoryPositionArgGetter.New()
end

function M:Handle(config, targetGo, isLocal)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self._getter

	getter:UpdateAsset(config)

	if getter.posValid then
		local toVect

		if getter.isPosCfg then
			toVect = StoryLogicUtil.GetCurStoryStagePosition(getter.posIndex)
		else
			toVect = getter.pos
		end

		if isLocal then
			targetTf.localPosition = toVect
		else
			targetTf.position = toVect
		end
	end
end

return M
