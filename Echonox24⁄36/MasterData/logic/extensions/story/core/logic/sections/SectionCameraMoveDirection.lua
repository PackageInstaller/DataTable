-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionCameraMoveDirection.lua

module("logic.extensions.story.core.logic.sections.SectionCameraMoveDirection", package.seeall)

local M = class("SectionCameraMoveDirection", StorySectionBase)
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

function M:_OnInitCtor()
	self.m_lastTime = 0
	self.m_posFrom = nil
	self.m_shakeCameraHandle = StoryHandleMoveDirection.New()
	self.m_camProxyInst = nil
	self._isFollowPanel = false
	self._bgContainObj = false
	self._storyFollowComp = false
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if targetGo then
		self.m_camProxyInst = targetGo:GetComponent(typeof(StoryEngine.StoryGameObjectInstProxy))
	end

	local entry = StoryController.instance:getCurStoryEntry()

	self._bgContainObj = entry.bgRootContain

	if not self._bgContainObj or goutil.isNil(self._bgContainObj) then
		return
	end

	self._bgContainObj.transform:SetParent(entry.scene2D.transform)
	StoryUtils.ResetTransform(self._bgContainObj)
	self.m_shakeCameraHandle:HandleSectionEnter(self.config, self:Duration())
end

function M:OnSectionDisableInternal()
	if self.m_camProxyInst then
		local resetPos = self.config:GetArgValueBoolean(StoryArgKeyConst.FreeCamDirResetPos)

		if resetPos then
			StoryUtils.ResetTransform(self.m_camProxyInst.target)
		end
	end

	self.m_camProxyInst = nil

	local entry = StoryController.instance:getCurStoryEntry()

	self._bgContainObj = entry.bgRootContain

	if not self._bgContainObj or goutil.isNil(self._bgContainObj) then
		return
	end

	self._bgContainObj.transform:SetParent(kMainCamera.transform)
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

	if self.m_camProxyInst then
		self.m_shakeCameraHandle:Handle(self.config, self.m_camProxyInst.target, percentTime)

		self.m_lastTime = realTime
	end
end

return M
