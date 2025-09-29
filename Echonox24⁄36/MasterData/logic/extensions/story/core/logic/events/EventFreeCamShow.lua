-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventFreeCamShow.lua

module("logic.extensions.story.core.logic.events.EventFreeCamShow", package.seeall)

local M = class("EventFreeCamShow", StoryEventBase)

function M:_OnInitCtor()
	self.m_position = StoryHandleFixPosition.New()
	self.m_rotation = StoryHandleFixRotation.New()
end

function M:OnEventExecuteInternal()
	local info = self.binder:FindIDPtr(StoryConstDef.FreeCameraTag)

	if not info then
		return
	end

	local inst = info.targetObj

	if goutil.isNil(inst) then
		return
	end

	if not goutil.isNil(inst) then
		local fov = self.config:GetArgValueNumber(StoryArgKeyConst.FreeCamFov)

		if fov > 0 then
			local vcam = inst.target:GetComponent(ComponentType.CinemachineVirtualCamera)

			CinemachineVirtualCamAdapter.SetVirtualCamFiledOfView(vcam, fov)
		end
	end

	self.m_position:Handle(self.config, inst, true)
	self.m_rotation:Handle(self.config, inst, true)
	self.binder:SetProxyPtrActive(StoryConstDef.FreeCameraTag, true)
	goutil.setActive(inst.proxyTarget, true)
end

return M
