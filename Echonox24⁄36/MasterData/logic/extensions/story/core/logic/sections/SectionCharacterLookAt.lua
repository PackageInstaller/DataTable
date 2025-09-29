-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionCharacterLookAt.lua

module("logic.extensions.story.core.logic.sections.SectionCharacterLookAt", package.seeall)

local M = class("SectionCharacterLookAt", StorySectionBase)

function M:_OnInitCtor()
	self.lookAtAdapter = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local instProxy = targetGo:GetComponent(typeof(StoryEngine.StoryGameObjectInstProxy))

	if not instProxy or not instProxy.target then
		return
	end

	local enableLookAt = self.config:GetArgValueBoolean(StoryArgKeyConst.EnableLookAt)
	local beginSpeed = self.config:GetArgValueFloat(StoryArgKeyConst.LookAtBeginSpeed)
	local endSpeed = self.config:GetArgValueFloat(StoryArgKeyConst.LookAtEndSpeed)

	self.lookAtAdapter = AimIKAdpter.Get(instProxy.target)

	self.lookAtAdapter:Init(enableLookAt, beginSpeed, endSpeed)
	self:DoLookAt(enableLookAt)
end

function M:OnSectionDisableInternal()
	local exitLookAtOnDisable = self.config:GetArgValueBoolean(StoryArgKeyConst.ChaDisableLookOnExit)

	if self.lookAtAdapter and exitLookAtOnDisable then
		self.lookAtAdapter:SetLookAtEnable(false)
		self.lookAtAdapter:SetEnableEyeBlendShape(false)
	end

	self.lookAtAdapter = nil
end

function M:OnStoryEvaluateInternal(time)
	return
end

function M:DoLookAt(enableLookAt)
	if not self.lookAtAdapter then
		return
	end

	local isTarget = self.config:GetArgValueBoolean(StoryArgKeyConst.LookAtIsTarget)

	if isTarget then
		local targetUID = self.config:GetArgValue(StoryArgKeyConst.LookAtTargetUID)
		local offsetPos = self.config:GetArgValueVector3(StoryArgKeyConst.LookAtTargetOffsetPos)
		local ele = self.parent.binder:FindIDPtr(targetUID)
		local targetTf
		local inst = ele and ele.targetObj or nil

		if inst then
			local lookFace = self.config:GetArgValueBoolean(StoryArgKeyConst.ChaLookAtFace)

			if lookFace then
				local targetLookAt = AimIKAdpter.Get(inst.target)

				if targetLookAt then
					targetTf = targetLookAt.HeadBone
				end
			else
				targetTf = inst.proxyTarget.transform
			end
		end

		if not targetTf or goutil.isNil(targetTf) then
			printWarn("Story Log: could not found target transform!")

			return
		end

		self.lookAtAdapter:LookAtHead(targetTf, offsetPos)
	else
		local lookAtPos = self.config:GetArgValueVector3(StoryArgKeyConst.LookAtPos)
		local relativeLook = self.config:GetArgValueBoolean(StoryArgKeyConst.RelativeLookAtPos)

		if relativeLook then
			if not goutil.isNil(self.lookAtAdapter.HeadBone) then
				local pos = self.lookAtAdapter.HeadBone.position + Vector3.back + lookAtPos

				self.lookAtAdapter:LookAt(pos.x, pos.y, 1)
			end
		else
			self.lookAtAdapter:LookAt(lookAtPos.x, lookAtPos.y, 1)
		end
	end

	self.lookAtAdapter:SetEnableEyeBlendShape(enableLookAt)
end

function M:FindChildWithEndWith(target, name)
	if goutil.isNil(target) then
		return nil
	end

	return target.transform:Find(name)
end

return M
