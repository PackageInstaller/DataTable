-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionTimeLine.lua

module("logic.extensions.story.core.logic.sections.SectionTimeLine", package.seeall)

local M = class("SectionTimeLine", StorySectionBase)

function M:_OnInitCtor()
	self.m_playableDirector = nil
end

function M:ReleaseData()
	self.m_playableDirector = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	self.parent.binder:SetPtrActive(targetGo.uid, true)
	goutil.setActive(targetGo.proxyTarget, true)

	self.m_playableDirector = targetGo:GetComponentInChildren(typeof(UnityEngine.Playables.PlayableDirector), true)

	self:RebindTimeline(self.m_playableDirector)

	self.m_playableDirector.initialTime = 0

	self.m_playableDirector:Play()
end

function M:OnSectionDisableInternal()
	self.m_playableDirector:Stop()
	self:ReleaseData()

	local targetGo = self.parent.bindingTarget

	if targetGo then
		self.parent.binder:SetPtrActive(targetGo.uid, false)
		goutil.setActive(targetGo.proxyTarget, false)
	end
end

function M:OnStoryEvaluateInternal(time)
	if goutil.isNil(self.m_playableDirector) then
		return
	end

	local duration = self.m_playableDirector.duration
	local progress = self:GetProgress(time)
	local playTime = progress * duration
	local tempTime = time - self.config.startTime

	if tempTime < 0 then
		tempTime = 0
	elseif tempTime > self.m_playableDirector.duration then
		tempTime = self.m_playableDirector.duration
	end

	self.m_playableDirector.time = tempTime

	self.m_playableDirector:Evaluate()
end

function M:RebindTimeline(playableDirector)
	if goutil.isNil(playableDirector) then
		return
	end

	local _list = TimelineUtil.GetDirectorAllTrackGroupNames(playableDirector)

	for i = 1, _list.Count do
		local _groupName = _list[i - 1]
		local _arr = string.split(_groupName, "_")
		local _pre = _arr[1]

		if M[_pre] then
			table.remove(_arr, 1)
			M[_pre](self, playableDirector, _groupName, unpack(_arr))
		end
	end
end

function M:_getModelGameObject(key)
	local roleObj = self.parent.binder:GetBindingInst(key)

	if roleObj then
		local childCount = roleObj.transform.childCount

		if childCount > 0 then
			return roleObj.transform:GetChild(0).gameObject
		end
	end

	return nil
end

function M:roleRoot(playableDirector, groupName, resId)
	resId = tonumber(resId)

	local _container = self:_getModelContainer(resId)

	if goutil.isNil(_container) then
		return
	end

	print("resId", resId, groupName)

	local _animator = _container:GetComponent(ComponentType.Animator)

	if goutil.isNil(_animator) then
		_container:AddComponent(ComponentType.Animator)
	end

	TimelineUtil.BindTrackGroup(playableDirector, groupName, _container)
end

function M:role(playableDirector, groupName, resId)
	resId = tonumber(resId)

	local _modelGo = self:_getModelGameObject(resId)

	if goutil.isNil(_modelGo) then
		return
	end

	TimelineUtil.BindTrackGroup(playableDirector, groupName, _modelGo)
end

function M:roleAnim(playableDirector, groupName, resId)
	resId = tonumber(resId)

	local _modelGo = self:_getModelGameObject(resId)

	if goutil.isNil(_modelGo) then
		return
	end

	TimelineUtil.BindTrackGroup(playableDirector, groupName, _modelGo)
end

return M
