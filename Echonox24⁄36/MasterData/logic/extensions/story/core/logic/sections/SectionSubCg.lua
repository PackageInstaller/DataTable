-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionSubCg.lua

module("logic.extensions.story.core.logic.sections.SectionSubCg", package.seeall)

local M = class("SectionSubCg", StorySectionBase)

function M:_OnInitCtor()
	self.m_assetUID = nil
	self.m_instUID = nil
	self.m_proxyInst = nil
	self.m_handle = StoryHandleSubCgCreate.New()
	self._subCgData = nil
end

function M:OnStoryAwakeInternal()
	local argInfo = self.config:GetArg(StoryArgKeyConst.RefAssets)

	if not argInfo then
		return
	end

	self.m_assetUID = self.config:GetArgValue(StoryArgKeyConst.RefAssets)
	self.m_instUID = tostring(argInfo.GUID)
	self.m_proxyInst = self.m_handle:Handle(self.m_assetUID, self.m_instUID, self.config, self.binder)

	if self.m_proxyInst then
		self.binder:SetProxyPtrVisible(self.m_instUID, true, false)
	end
end

function M:OnSectionEnableInternal()
	self._subCgData = self:ParseSubCgData(self.config)

	if self.m_proxyInst and self.m_proxyInst.proxyTarget then
		StoryDispatcher:dispatchEvent(StoryNotifyName.OnSubCgEnter, self._subCgData, self.m_proxyInst)
	end
end

function M:OnSectionDisableInternal()
	StoryDispatcher:dispatchEvent(StoryNotifyName.OnSubCgExit, self._subCgData)
end

function M:ParseSubCgData(node)
	local subCgData = {}

	subCgData.targetPos = node:GetArgValueVector3(StoryArgKeyConst.Position)
	subCgData.isHoldCg = node:GetArgValueBoolean(StoryArgKeyConst.IsHoldCg)
	subCgData.isCloseCg = node:GetArgValueBoolean(StoryArgKeyConst.IsCloseCg)
	subCgData.cgPath = node:GetArgValue(StoryArgKeyConst.SubCGPath)

	return subCgData
end

return M
