-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleFixScale.lua

module("logic.extensions.story.core.logic.handles.StoryHandleFixScale", package.seeall)

local M = class("StoryHandleFixScale")

function M:ctor()
	self._getter = StoryScaleArgGetter.New()
end

function M:Handle(config, targetGo)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self._getter

	getter:UpdateAsset(config)

	if getter.scalValid then
		targetTf.localScale = getter.scale
	end
end

return M
