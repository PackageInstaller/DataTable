-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleMixAnimationPlay.lua

module("logic.extensions.story.core.logic.handles.StoryHandleMixAnimationPlay", package.seeall)

local M = class("StoryHandleMixAnimationPlay")

M.BaseLayerName = "Base Layer"

function M:ctor()
	self.m_animatorHandle = StoryHandleAnimatorPlay.New()
end

function M:Handle(config, targetGo, sectionDuration)
	if goutil.isNil(targetGo) then
		return
	end

	local _baseAnimName = config:GetArgValue(StoryArgKeyConst.ModelAniBase)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if _storyEntry and _storyEntry:IsRogue() then
		local animationPlayer = StoryLogicUtil.GetFirstAnimationPlayer(targetGo)

		if goutil.isNil(animationPlayer) then
			return
		end

		local isLoop = _baseAnimName == "idle"

		animationPlayer:PlayAnimation(_baseAnimName, isLoop, true)

		return
	end

	local animatorAdapter = StoryLogicUtil.GetFirstAnimatorAdapter(targetGo)

	if goutil.isNil(animatorAdapter) then
		return
	end

	local firstAnimator = StoryLogicUtil.GetFirstAnimator(targetGo)

	firstAnimator.applyRootMotion = false

	local speed = 1

	if sectionDuration then
		speed = animatorAdapter:GetStartSpeed(_baseAnimName, sectionDuration)
	end

	if speed == 0 then
		speed = 1
	end

	self.m_animatorHandle:Handle(animatorAdapter, M.BaseLayerName, _baseAnimName, speed)
end

return M
