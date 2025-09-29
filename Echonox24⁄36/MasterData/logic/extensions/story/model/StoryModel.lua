-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/model/StoryModel.lua

module("logic.extensions.story.model.StoryModel", package.seeall)

local M = class("StoryModel")

function M:ctor()
	self._isVideoBg = false
	self._battleEventList = {}
	self.history = {}
	self._renderMap = false
	self._currentBgmId = false
	self._curAmbId = false
	self._isAfterBattle = false
	self._storyLoaderMap = false
end

function M:init()
	return
end

function M:clear()
	self._isVideoBg = false
	self._hasVideo = false

	self:clearHistory()
	self:clearUserJump()
	self:clearFeature()
	self:releaseLoader()

	self._isDoJump = false
end

function M:cacheLoader(loader)
	if not self._storyLoaderMap then
		self._storyLoaderMap = {}
	end

	table.insert(self._storyLoaderMap, loader)
end

function M:releaseLoader()
	if self._storyLoaderMap then
		for _, v in pairs(self._storyLoaderMap) do
			if v then
				v:dispose()
			end
		end

		table.clear(self._storyLoaderMap)

		self._storyLoaderMap = false
	end
end

function M:setScene2dBgType(isVideoBg)
	self._isVideoBg = isVideoBg
end

function M:getScene2dBgType()
	return self._isVideoBg or false
end

function M:setBattleEvent(question, choice)
	self._battleEventList[question] = choice
end

function M:checkBattleQuestionExist(question)
	return self._battleEventList[question]
end

function M:removeBattleQuestion(question)
	self._battleEventList[question] = nil
end

function M:sendBattleEvent()
	if TableUtil.getLen(self._battleEventList) > 0 then
		GuideAgent.instance:sendSetPlotAnswersRequest(self._battleEventList)
	end

	self._battleEventList = {}
end

function M:clearHistory()
	self.history = {}
end

function M:getHistory()
	return self.history or {}
end

function M:getHistoryByIndex(index)
	self.history = self.history or {}

	for k, v in ipairs(self.history) do
		if v.index == index then
			return v
		end
	end

	return false
end

function M:addHistory(historyData)
	self.history = self.history or {}

	local isRepeat = false

	for k, v in ipairs(self.history) do
		if v.index == historyData.index and historyData.isOption == v.isOption and historyData.isError == v.isError then
			isRepeat = true

			break
		end
	end

	if not isRepeat then
		table.insert(self.history, historyData)
	end
end

function M:cacheWrongOption(nextGroupId, question)
	if self._isWrongAnswerStepInfo then
		self._isWrongAnswerStepInfo.nextGroupId = nextGroupId
		self._isWrongAnswerStepInfo.question = question
	else
		self._isWrongAnswerStepInfo = {
			nextGroupId = nextGroupId,
			question = question
		}
	end
end

function M:getWrongStepInfo()
	return self._isWrongAnswerStepInfo
end

function M:clearWrongOption()
	self._isWrongAnswerStepInfo = false
end

function M:cachePlotType(plotType)
	self._curPlotType = plotType
end

function M:getPlotType()
	return self._curPlotType and self._curPlotType or NewbieExtension_pb.PlotEnum.NONE
end

function M:clearPlotType()
	self._curPlotType = false
end

function M:cacheUserJump()
	self._isClickJump = true
end

function M:clearUserJump()
	self._isClickJump = false
end

function M:getUserJump()
	return self._isClickJump or false
end

function M:setVideo(hasVideo)
	self._hasVideo = hasVideo
end

function M:hasVideo()
	return self._hasVideo
end

function M:cacheFeature()
	local currentDepthState = SpaceX.OutlineFeatureUtils.GetOutlineDepth()

	self:_saveFeatureState(RendererFeatureName.Outline, currentDepthState)
end

function M:_saveFeatureState(name, ison)
	if not self._renderMap then
		self._renderMap = {}
	end

	self._renderMap[name] = currentDepthState
end

function M:getFeature(name)
	if not self._renderMap then
		return
	end

	return self._renderMap[name] or false
end

function M:clearFeature()
	if self._renderMap then
		table.clear(self._renderMap)
	end

	self._renderMap = false
end

function M:cacheBgm()
	self._currentBgmId = CriwareAudioPlayer.instance:getCurrentBgmId()

	CriwareAudioFacade.instance:stopBgm()

	self._curHasBgm = true

	if enableLog then
		printInfo("暂停当前BGM，并缓存 ", self._currentBgmId)
	end
end

function M:cacheAmb()
	self._curAmbId = CriwareAudioPlayer.instance:getCurrentEnvironmentId()

	CriwareAudioFacade.instance:stopCurrentEnvironment()

	self._curHasAmb = true

	if enableLog then
		printInfo("暂停当前AMB，并缓存 ", self._curAmbId)
	end
end

function M:revertBgmAndAmb()
	if self._curHasBgm then
		CriwareAudioFacade.instance:stopBgm()

		self._curHasBgm = false
	end

	if self._curHasAmb then
		CriwareAudioFacade.instance:stopCurrentEnvironment()

		self._curHasAmb = false
	end

	if not self._isAfterBattle then
		if self._currentBgmId and self._currentBgmId > 0 then
			CriwareAudioFacade.instance:playBgmInnerById(self._currentBgmId)
		end

		if self._curAmbId and self._curAmbId > 0 then
			CriwareAudioFacade.instance:playEnvironmentById(self._curAmbId)
		end

		if enableLog then
			printInfo("剧情结束还原", self._curAmbId, self._currentBgmId)
		end
	end

	self._curAmbId = false
	self._currentBgmId = false
	self._isAfterBattle = false
end

function M:isAfterBattle(isAfterBattle)
	self._isAfterBattle = isAfterBattle
end

function M:setJumpAnimState(doJump)
	self._isDoJump = doJump
end

function M:getJumpState()
	return self._isDoJump or false
end

M.instance = M.New()

return M
