-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionAnimation.lua

module("logic.extensions.story.core.logic.sections.SectionAnimation", package.seeall)

local M = class("SectionAnimation", StorySectionBase)

function M:_OnInitCtor()
	self.m_mixHandle = StoryHandleMixAnimationPlay.New()
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local sectionDuration = self:Duration()

	self.m_mixHandle:Handle(self.config, targetGo, sectionDuration)
end

function M:OnStoryEvaluateInternal(time)
	return
end

return M
