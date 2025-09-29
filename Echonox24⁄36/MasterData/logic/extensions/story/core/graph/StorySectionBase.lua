-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/StorySectionBase.lua

module("logic.extensions.story.core.graph.StorySectionBase", package.seeall)

local M = class("StorySectionBase")

function M:ctor()
	self.id = 0
	self.LogicState = StoryDefine.StoryLogicState.None
	self.binder = nil
	self.parent = nil
	self.config = nil
	self.storyBlackBoard = nil
	self.m_enable = false
	self.m_enableCount = 0
	self._isJumpShot = false

	self:_OnInitCtor()
end

function M:TimeRange()
	return Vector2.New(self.config.startTime, self.config.endTime)
end

function M:Duration()
	return math.max(self.config.endTime - self.config.startTime, 0)
end

function M:IsUsable()
	return self.LogicState ~= StoryDefine.StoryLogicState.Destroy and self.LogicState ~= StoryDefine.StoryLogicState.None
end

function M:IsJump()
	return self._isJumpShot
end

function M:Init(binder, config, track, storyBlackBoard)
	self.binder = binder
	self.config = config
	self.parent = track
	self.storyBlackBoard = storyBlackBoard
end

function M:OnStoryAwake()
	self:OnStoryAwakeInternal()
end

function M:SetJumpState(isJump)
	self._isJumpShot = isJump
end

function M:OnStoryEnter()
	if self.LogicState == StoryDefine.StoryLogicState.Enter then
		self:OnStoryExit()
	end

	self.m_enableCount = 0
	self.LogicState = StoryDefine.StoryLogicState.Enter

	self:OnStoryEnterInternal()
end

function M:OnStoryExit()
	if self.LogicState == StoryDefine.StoryLogicState.Enter then
		self:OnSectionDisable()

		self.m_enableCount = 0
		self.LogicState = StoryDefine.StoryLogicState.Exited

		self:OnStoryExitInternal()
	end
end

function M:OnStoryDestroy()
	self:OnStoryExit()

	self.LogicState = StoryDefine.StoryLogicState.Destroy

	self:OnStoryDestroyInternal()

	self.storyBlackBoard = nil
end

function M:OnSectionEnable()
	if self:IsUsable() and not self.m_enable then
		self.m_enable = true

		self:OnSectionEnableInternal()
	end
end

function M:OnSectionDisable()
	if self:IsUsable() and self.m_enable then
		self.m_enable = false

		self:OnSectionDisableInternal()
	end
end

function M:Evaluate(time)
	local isBetween = time >= self.config.startTime and time <= self.config.endTime
	local isGreaterEnd = time > self.config.endTime

	if isBetween and not self.m_enable then
		self.m_enableCount = self.m_enableCount + 1

		self:OnSectionEnable()
	elseif isGreaterEnd and not self.m_enable and self.m_enableCount == 0 then
		self.m_enableCount = self.m_enableCount + 1

		self:OnSectionEnable()
	end

	if self.m_enable then
		self:OnStoryEvaluateInternal(time)
	end

	if not isBetween and self.m_enable then
		self:OnSectionDisable()
	end
end

function M:OnStoryUpdate(deltaTime)
	return
end

function M:GetProgress(time, isLoop)
	isLoop = isLoop == true

	local duration = self:Duration()

	return self:GetProgressWithDuration(time, duration, isLoop)
end

function M:GetProgressWithDuration(time, duration, isLoop)
	local timeRange = self:TimeRange()

	if time < timeRange.x then
		return 0
	end

	if duration <= 0 then
		return 1
	end

	local validTime = time - timeRange.x

	if isLoop then
		return validTime % duration
	else
		validTime = validTime / duration

		if validTime < 0 then
			validTime = 0
		elseif validTime > 1 then
			validTime = 1
		end

		return validTime
	end
end

function M:_OnInitCtor()
	return
end

function M:OnStoryAwakeInternal()
	return
end

function M:OnStoryEnterInternal()
	return
end

function M:OnSectionEnableInternal()
	return
end

function M:OnSectionDisableInternal()
	return
end

function M:OnStoryExitInternal()
	return
end

function M:OnStoryDestroyInternal()
	return
end

function M:OnStoryEvaluateInternal(time)
	return
end

return M
