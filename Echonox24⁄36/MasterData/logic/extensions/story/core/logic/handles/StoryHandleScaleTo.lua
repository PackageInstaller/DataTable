-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleScaleTo.lua

module("logic.extensions.story.core.logic.handles.StoryHandleScaleTo", package.seeall)

local M = class("StoryHandleScaleTo")

function M:ctor()
	self.m_getter = StoryScaleArgGetter.New()
end

function M:HandleCurve(config, targetGo, fromVect, progress, curve)
	pritnError("暂时没法获取AnimationCurve")
end

function M:Handle(config, targetGo, fromVect, progress)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self.m_getter

	getter:UpdateAsset(config)

	local toVect = getter.scale
	local targetVect = fromVect + (toVect - fromVect) * progress

	targetTf.localScale = targetVect
end

return M
