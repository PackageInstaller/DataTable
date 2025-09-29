-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/StoryShot.lua

module("logic.extensions.story.core.graph.StoryShot", package.seeall)

local M = class("StoryShot")

function M:ctor(shotId)
	self.shotId = shotId
	self.config = nil
	self.storyBlackBoard = nil
	self.tracks = {}
	self.shotEdges = {}
	self._isJumpShot = false
	self.State = StoryDefine.StoryRunningState.None
	self.LogicState = StoryDefine.StoryLogicState.None
	self.m_playTime = 0
	self.m_maxTime = 0
end

function M:IsUsable()
	return self.LogicState ~= StoryDefine.StoryLogicState.Destroy and self.LogicState ~= StoryDefine.StoryLogicState.None
end

function M:Init(config, storyBlackBoard)
	self.config = config
	self.storyBlackBoard = storyBlackBoard
end

function M:OnStoryAwake()
	for index, item in ipairs(self.tracks) do
		item:OnStoryAwake()
	end
end

function M:SetJumpState(isJump)
	self._isJumpShot = isJump
end

function M:OnStoryEnter()
	if self.LogicState == StoryDefine.StoryLogicState.Enter then
		self:OnStoryExit()
	end

	self.m_playTime = 0
	self.m_maxTime = self:MaxEndTime()
	self.State = StoryDefine.StoryRunningState.Running
	self.LogicState = StoryDefine.StoryLogicState.Enter

	for index, value in ipairs(self.tracks) do
		value:SetJumpState(self._isJumpShot)
		value:OnStoryEnter()
	end

	StoryDispatcher:dispatchEvent(StoryNotifyName.StoryShotEnter)
end

function M:OnStoryExit()
	if self.LogicState == StoryDefine.StoryLogicState.Enter then
		self.State = StoryDefine.StoryRunningState.Exited
		self.LogicState = StoryDefine.StoryLogicState.Exited

		for index, value in ipairs(self.tracks) do
			value:OnStoryExit()
		end

		StoryDispatcher:dispatchEvent(StoryNotifyName.StoryShotExit)
	end
end

function M:OnStoryDestroy()
	self:OnStoryExit()

	self.State = StoryDefine.StoryRunningState.None
	self.LogicState = StoryDefine.StoryLogicState.Destroy
	self.storyBlackBoard = nil

	for index, value in ipairs(self.tracks) do
		value:OnStoryDestroy()
	end
end

function M:OnStoryUpdate(deltaTime)
	if self.LogicState ~= StoryDefine.StoryLogicState.Enter then
		return
	end

	if self.State ~= StoryDefine.StoryRunningState.Running then
		return
	end

	local targetTime = self.m_playTime + deltaTime

	if targetTime >= self.m_maxTime then
		targetTime = self.m_maxTime
		self.State = StoryDefine.StoryRunningState.Finish
	end

	self.m_playTime = targetTime

	for index, value in ipairs(self.tracks) do
		value:OnStoryUpdate(deltaTime)
	end

	self:Evaluate(self.m_playTime)
end

function M:Evaluate(time)
	if self.LogicState ~= StoryDefine.StoryLogicState.Enter then
		return
	end

	for index, value in ipairs(self.tracks) do
		value:Evaluate(time)
	end
end

function M:IsEnd()
	if self.config ~= nil then
		return self.config.isEnd
	end

	return false
end

function M:ContainBranchEdge()
	for key, value in pairs(self.shotEdges) do
		if value.containerLinkType == StoryContainerLinkType.Branch then
			return true
		end
	end

	return false
end

function M:IsManual()
	return self.config.isAutoNext ~= true
end

function M:MaxEndTime()
	local _time = 0

	for _, item in ipairs(self.tracks) do
		local maxTime = item:MaxEndTime()

		if _time < maxTime then
			_time = maxTime
		end
	end

	return _time
end

return M
