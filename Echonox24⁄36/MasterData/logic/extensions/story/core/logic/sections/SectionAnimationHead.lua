-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionAnimationHead.lua

module("logic.extensions.story.core.logic.sections.SectionAnimationHead", package.seeall)

local M = class("SectionAnimationHead", StorySectionBase)

function M:_OnInitCtor()
	self.m_mixHandle = StoryHandleMixAnimationPlay.New()
	self._animatorAdapter = false
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local _baseAnimName = self.config:GetArgValue(StoryArgKeyConst.RefAssetsHead)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if _storyEntry and _storyEntry:IsRogue() then
		return
	end

	local animatorAdapter = StoryLogicUtil.GetFirstAnimatorAdapter(targetGo)

	if goutil.isNil(animatorAdapter) then
		return
	end

	if string.nilorempty(_baseAnimName) then
		return
	end

	self._animatorAdapter = StoryLogicUtil.GetFirstAnimatorAdapter(targetGo)

	self._animatorAdapter:PlayHead(_baseAnimName)
end

function M:OnStoryEvaluateInternal(time)
	return
end

function M:OnSectionDisableInternal()
	if self._animatorAdapter then
		self._animatorAdapter:PlayHead("Empty", 0.5)
	end
end

return M
