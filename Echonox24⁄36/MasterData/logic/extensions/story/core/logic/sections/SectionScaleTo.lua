-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionScaleTo.lua

module("logic.extensions.story.core.logic.sections.SectionScaleTo", package.seeall)

local M = class("SectionScaleTo", StorySectionBase)

function M:_OnInitCtor()
	self.m_scaleHandle = StoryHandleScaleTo.New()
	self.m_orgScale = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if targetGo then
		self.m_orgScale = targetGo.transform.localScale
	else
		self.m_orgScale = Vector3.one
	end
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if targetGo then
		local progress = self:GetProgress(time)

		self.m_scaleHandle:Handle(self.config, targetGo, self.m_orgScale, progress)
	end
end

return M
