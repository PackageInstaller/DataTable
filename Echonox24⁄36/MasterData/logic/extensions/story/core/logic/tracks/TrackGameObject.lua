-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/tracks/TrackGameObject.lua

module("logic.extensions.story.core.logic.tracks.TrackGameObject", package.seeall)

local M = class("TrackGameObject", StoryTrackBase)

function M:OnStoryEnterInternal()
	self.bindingTarget = nil

	self:UpdateTarget()
end

function M:OnStoryExitInternal()
	self.bindingTarget = nil
end

function M:OnStoryEvaluateInternal(time)
	self:UpdateTarget()
end

function M:UpdateTarget()
	if self.bindingTarget then
		return
	end

	local refTargetID = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)
	local ptrInfo = self.binder:FindIDPtr(refTargetID)

	if ptrInfo and ptrInfo.type == StoryResIDPtrType.GameObject and ptrInfo.isUsable then
		local proxy = ptrInfo.targetObj

		if proxy then
			self.bindingTarget = proxy.proxyTarget
		end
	end
end

return M
