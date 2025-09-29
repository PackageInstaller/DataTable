-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionEvent.lua

module("logic.extensions.story.core.logic.sections.SectionEvent", package.seeall)

local M = class("SectionEvent", StorySectionBase)

function M:_OnInitCtor()
	self.m_event = nil
end

function M:OnStoryAwakeInternal()
	local evtId = self.config:GetArgValueNumber(StoryArgKeyConst.StoryEventID)

	self.m_event = StoryFactor.CreateEvent(evtId)

	if self.m_event then
		self.m_event:InitData(self.binder, self.config)
		self.m_event:OnStoryAwake()
	else
		printError("不存在事件id:", evtId)
	end
end

function M:OnSectionEnableInternal()
	if self.m_event then
		if self.m_event.hasTrigger then
			self.m_event:OnStoryClean()
		end

		self.m_event:OnEventExecute()
	end
end

function M:OnStoryDestroyInternal()
	if self.m_event then
		self.m_event:OnStoryDestroy()
	end

	self.m_event = nil
end

return M
