-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionTransform.lua

module("logic.extensions.story.core.logic.sections.SectionTransform", package.seeall)

local M = class("SectionTransform", StorySectionBase)

function M:_OnInitCtor()
	self.m_transformHandle = StoryHandleTransformTo.New()
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local progress = self:GetProgress(time)

	self.m_transformHandle:Handle(self.config, targetGo, progress, true, false)
end

return M
