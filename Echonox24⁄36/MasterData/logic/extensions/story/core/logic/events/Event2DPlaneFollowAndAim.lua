-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/Event2DPlaneFollowAndAim.lua

module("logic.extensions.story.core.logic.events.Event2DPlaneFollowAndAim", package.seeall)

local M = class("Event2DPlaneFollowAndAim", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnStoryAwakeInternal()
	return
end

function M:OnEventExecuteInternal()
	if not self:CheckPlaneStory() then
		return
	end

	self:ResetPlaneRoot()

	local node = self.config
	local _activeLookAt = node:GetArgValueBoolean(StoryArgKeyConst.planeFAactiveLookAt)
	local _activeSyncPos = node:GetArgValueBoolean(StoryArgKeyConst.planeFAactiveSyncPost)
	local _distanceZ = node:GetArgValueFloat(StoryArgKeyConst.planeFAdistanceZ)
	local _moveSpeed = node:GetArgValueFloat(StoryArgKeyConst.planeFAmoveSpeed)
	local _immadiateSetPosDistance = node:GetArgValueFloat(StoryArgKeyConst.planeFAimSetPosDistance)
	local offsetPos = node:GetArgValueVector2(StoryArgKeyConst.planeBgOffset)
	local entry = StoryController.instance:getCurStoryEntry()
	local planeGo = entry.bgRootContain
	local rootGo = planeGo.transform:Find("bg_root").gameObject
	local bgTf = rootGo.transform:Find("bg")
	local sfa = StoryPlaneFollowAndAim.Get(rootGo)

	sfa.bgRootTransform = rootGo.transform
	sfa.activeLookAt = _activeLookAt
	sfa.activeSyncPos = _activeSyncPos
	sfa.distanceZ = _distanceZ
	sfa.moveSpeed = _moveSpeed
	sfa.immadiateSetPosDistance = _immadiateSetPosDistance

	sfa:ForceUpdate()

	bgTf.localPosition = offsetPos
end

function M:OnStoryCleanInternal()
	return
end

function M:CheckPlaneStory()
	local entry = StoryController.instance:getCurStoryEntry()

	if not entry then
		return false
	end

	return not goutil.isNil(entry.bgRootContain)
end

function M:ResetPlaneRoot()
	if not self:CheckPlaneStory() then
		return
	end

	local entry = StoryController.instance:getCurStoryEntry()
	local planeGo = entry.bgRootContain

	if not planeGo then
		return
	end

	local rootGo = planeGo.transform:Find("bg_root").gameObject

	if goutil.isNil(rootGo) then
		return
	end

	local bgTf = rootGo.transform:Find("bg")

	if not goutil.isNil(bgTf) then
		Astral.TransformUtil.SetLocalPos(bgTf.transform, 0, 0, 0)
	end

	StoryUtils.ResetTransform(rootGo)
end

return M
