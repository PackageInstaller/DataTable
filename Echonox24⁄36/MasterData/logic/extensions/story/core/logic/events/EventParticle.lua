-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventParticle.lua

module("logic.extensions.story.core.logic.events.EventParticle", package.seeall)

local M = class("EventParticle", StoryEventBase)

function M:_OnInitCtor()
	self.m_assetUID = nil
	self.m_instUID = nil
	self.targetPs = nil
	self.m_proxyInst = nil
	self.m_handle = StoryHandleParticleCreate.New()
	self.m_position = StoryHandleFixPosition.New()
	self.m_rotation = StoryHandleFixRotation.New()
end

function M:OnEventExecuteInternal()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local rootGo = _storyEntry.root

	if goutil.isNil(rootGo) then
		printWarn("rootGo is nil")

		return
	end

	local particleRoot = goutil.findChild(rootGo, "particleRoot")

	if goutil.isNil(particleRoot) then
		return
	end

	local isCloseParticle = self.config:GetArgValueBoolean(StoryArgKeyConst.CloseParticle)

	if particleRoot then
		goutil.clearChildren(particleRoot)
	end

	if isCloseParticle then
		return
	end

	local argInfo = self.config:GetArg(StoryArgKeyConst.RefAssets)

	if not argInfo then
		return
	end

	self.m_assetUID = self.config:GetArgValue(StoryArgKeyConst.RefAssets)
	self.m_instUID = tostring(argInfo.GUID)
	self.m_proxyInst = self.m_handle:Handle(self.m_assetUID, self.m_instUID, self.config, self.binder)
	self.targetPs = nil

	if self.m_proxyInst then
		goutil.addChildToParent(self.m_proxyInst, particleRoot)
		self.m_position:Handle(self.config, self.m_proxyInst.proxyTarget, true)
		self.m_rotation:Handle(self.config, self.m_proxyInst.proxyTarget, true)

		if self.m_proxyInst.proxyTarget then
			local targetPs = self.m_proxyInst.proxyTarget:GetComponentInChildren(typeof(UnityEngine.ParticleSystem), true)

			if targetPs then
				targetPs:Simulate(0)

				targetPs.time = 0

				targetPs:Play()
			end

			self.targetPs = targetPs
		end

		self.binder:SetProxyPtrVisible(self.m_instUID, true, true)
	end
end

function M:OnStoryCleanInternal()
	if not string.nilorempty(self.m_instUID) then
		self.binder:SetProxyPtrVisible(self.m_instUID, false, false)

		local handle = StoryHandleGOInstProxyDelete.New()

		handle:Handle(self.m_assetUID, self.m_instUID, self.binder)
	end

	self.m_instUID = nil
	self.m_assetUID = nil
	self.targetPs = nil
	self.m_proxyInst = nil
end

return M
