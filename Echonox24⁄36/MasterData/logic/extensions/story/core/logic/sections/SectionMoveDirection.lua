-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionMoveDirection.lua

module("logic.extensions.story.core.logic.sections.SectionMoveDirection", package.seeall)

local M = class("SectionMoveDirection", StorySectionBase)

function M:_OnInitCtor()
	self.m_lastTime = 0
	self.m_shakeCameraHandle = StoryHandleMoveDirection.New()
end

function M:OnSectionEnableInternal()
	self.m_shakeCameraHandle:HandleSectionEnter(self.config, self:Duration())
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local percentTime = self:GetProgress(time)
	local realTime = percentTime * self:Duration()

	if realTime < self.m_lastTime or realTime <= self.m_lastTime then
		return
	end

	self.m_shakeCameraHandle:Handle(self.config, targetGo, percentTime)

	self.m_lastTime = realTime
end

return M
