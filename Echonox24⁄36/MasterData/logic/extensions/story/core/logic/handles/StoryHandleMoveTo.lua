-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleMoveTo.lua

module("logic.extensions.story.core.logic.handles.StoryHandleMoveTo", package.seeall)

local M = class("StoryHandleMoveTo")

function M:ctor()
	self.m_getter = StoryPositionArgGetter.New()
end

function M:HandleCurve(config, targetGo, fromVect, progress, curve, isLocal, lookAtPoint)
	pritnError("暂时没法获取AnimationCurve")
end

function M:Handle(config, targetGo, fromVect, progress, isLocal, lookAtPoint)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self.m_getter

	getter:UpdateAsset(config)

	if getter.posValid then
		local toVect

		if getter.isPosCfg then
			toVect = StoryLogicUtil.GetCurStoryStagePosition(getter.posIndex)
		else
			toVect = getter.pos
		end

		if Vector3.Distance(fromVect, toVect) > 0.001 then
			if lookAtPoint then
				if isLocal then
					targetTf.localRotation = Quaternion.LookRotation(toVect - fromVect, Vector3.up)
				else
					targetTf.rotation = Quaternion.LookRotation(toVect - fromVect, Vector3.up)
				end
			end

			toVect = fromVect + (toVect - fromVect) * progress
		end

		if isLocal then
			targetTf.localPosition = toVect
		else
			targetTf.position = toVect
		end
	end
end

return M
