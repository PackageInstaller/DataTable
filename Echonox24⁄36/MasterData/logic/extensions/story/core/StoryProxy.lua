-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryProxy.lua

module("logic.extensions.story.core.StoryProxy", package.seeall)

local M = class("StoryProxy")

M.floatMax = 9999999999

function M:ctor()
	self.sequenceShots = nil
	self.storyGraph = nil
	self.pending = false
	self.speed = 1
	self.asset = nil
	self.binder = nil
	self.PlayingShot = nil
	self.storyBlackBoard = nil
end

function M:Dispose()
	self:OnStoryDestroy()
end

function M:OnStoryDestroy()
	if self.sequenceShots then
		for index, item in ipairs(self.sequenceShots) do
			item:OnStoryDestroy()
		end
	end

	if self.storyGraph then
		self.storyGraph:Dispose()
	end

	if self.storyBlackBoard then
		self.storyBlackBoard:Reset()
	end

	self.storyBlackBoard = nil
	self.sequenceShots = nil
	self.PlayingShot = nil
	self.pending = false
	self.asset = nil
	self.binder = nil
	self.storyGraph = nil
end

function M:CreateGraph(graphAsset, binder)
	self.asset = graphAsset
	self.binder = binder
	self.storyBlackBoard = StoryBlackBoard.New(graphAsset)
	self.sequenceShots = {}
	self.storyGraph = StoryGraph.New()

	StoryShotBuilder.BuildSequenceShots(self.asset, self.binder, self.sequenceShots, self.storyBlackBoard)
	self.storyGraph:Build(self.sequenceShots)
end

function M:SwitchSeqShot(shotId, isJump)
	local targetShot = self:GetShot(shotId)

	if not targetShot then
		printError("SwitchSeqShot", "未配置末尾节点或者不存在节点：" .. shotId)

		return
	end

	local fromShot = self.PlayingShot
	local path = self.storyGraph:GetShotPath(fromShot, targetShot)
	local _oldPlaying = self.PlayingShot

	self.PlayingShot = nil

	if _oldPlaying then
		_oldPlaying:Evaluate(M.floatMax)
		_oldPlaying:OnStoryExit()
	end

	for _, item in ipairs(path) do
		if item ~= targetShot and item ~= _oldPlaying then
			item:SetJumpState(isJump)
			item:OnStoryEnter()
			item:Evaluate(M.floatMax)
			item:OnStoryExit()
		end
	end

	self.PlayingShot = targetShot

	self.PlayingShot:OnStoryEnter()
	StoryDispatcher:dispatchEvent(StoryNotifyName.StorySwitchShotFinish, isJump)
end

function M:OnStoryUpdate(deltaTime)
	if self.storyGraph == nil then
		return
	end

	if self.pending then
		return
	end

	local _time = deltaTime * self.speed

	if self.PlayingShot then
		self.PlayingShot:OnStoryUpdate(_time)
	end
end

function M:GetFirstShotId()
	if self.sequenceShots and #self.sequenceShots > 0 then
		return self.sequenceShots[1].shotId
	end

	return 0
end

function M:GetNextShotId()
	if self.PlayingShot == nil then
		return self:GetFirstShotId()
	end

	local ver = self.storyGraph:GetOutVer(self.PlayingShot, -1)

	if ver then
		return ver.data.shotId
	end

	return 0
end

function M:CheckCurrentFinish()
	if self.PlayingShot == nil then
		return false
	end

	if self.PlayingShot.State == StoryDefine.StoryRunningState.Finish then
		return true
	end

	return false
end

function M:GetShot(shotId)
	if not self.sequenceShots then
		return nil
	end

	for key, value in pairs(self.sequenceShots) do
		if value.shotId == shotId then
			return value
		end
	end

	return nil
end

function M:GetShotIndex(shotId)
	if not self.sequenceShots then
		return -1
	end

	for key, value in ipairs(self.sequenceShots) do
		if value.shotId == shotId then
			return key
		end
	end

	return -1
end

return M
