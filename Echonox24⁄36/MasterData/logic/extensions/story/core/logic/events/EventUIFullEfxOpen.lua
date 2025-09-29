-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventUIFullEfxOpen.lua

module("logic.extensions.story.core.logic.events.EventUIFullEfxOpen", package.seeall)

local M = class("EventUIFullEfxOpen", StoryEventBase)

function M.CreateUIFullEfxRTData()
	local st = {}

	st.efxGameObj = nil

	return st
end

function M:_OnInitCtor()
	self.m_assetUID = nil
	self.m_instUID = nil
	self.targetPs = nil
	self.m_proxyInst = nil
	self.m_handle = StoryHandleParticleCreate.New()
end

function M:OnStoryAwakeInternal()
	local argInfo = self.config:GetArg(StoryArgKeyConst.RefAssets)

	if not argInfo then
		return
	end

	self.m_assetUID = self.config:GetArgValue(StoryArgKeyConst.RefAssets)
	self.m_instUID = tostring(argInfo.GUID)
	self.m_proxyInst = self.m_handle:Handle(self.m_assetUID, self.m_instUID, self.config, self.binder)
	self.targetPs = nil

	if self.m_proxyInst then
		if self.m_proxyInst.proxyTarget then
			local targetPs = self.m_proxyInst.proxyTarget:GetComponentInChildren(typeof(UnityEngine.ParticleSystem), true)

			if targetPs then
				targetPs:Simulate(0)

				targetPs.time = 0

				targetPs:Play()
			end

			self.targetPs = targetPs
		end

		self.binder:SetProxyPtrVisible(self.m_instUID, false, false)
	end
end

function M:OnEventExecuteInternal()
	self.binder:SetProxyPtrVisible(self.m_instUID, true, true)

	local data = M.CreateUIFullEfxRTData()

	data.efxGameObj = self.m_proxyInst and self.m_proxyInst.proxyTarget

	StoryDispatcher:dispatchEvent(StoryNotifyName.UIFullEfxRTEvent, true, data)
end

function M:OnStoryCleanInternal()
	if not string.nilorempty(self.m_instUID) then
		self.binder:SetProxyPtrVisible(self.m_instUID, false, false)

		local handle = StoryHandleGOInstProxyDelete.New()

		handle:Handle(self.m_assetUID, self.m_instUID, self.binder)
		StoryDispatcher:dispatchEvent(StoryNotifyName.UIFullEfxRTEvent, false, nil)
	end

	self.m_instUID = nil
	self.m_assetUID = nil
	self.targetPs = nil
	self.m_proxyInst = nil
end

return M
