-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/data/BoccaccioChapterSubMo.lua

module("logic.extensions.boccacciochapter.data.BoccaccioChapterSubMo", package.seeall)

local BoccaccioChapterSubMo = class("BoccaccioChapterSubMo")

function BoccaccioChapterSubMo:ctor(activityId)
	self._activityId = activityId

	local storyDatas = BoccaccioChapterConfig.instance:getChapter2StoryDatas(activityId) or {}

	self._maxStoryId = #storyDatas

	self:onReset()
end

function BoccaccioChapterSubMo:onReset()
	self._chapterInfoMap = {}
	self._chapter4RankInfo = nil
	self._hasUnlockPlotIds = {}
	self._hasUnlockPlotIdMap = {}
	self._maxGainProgressIds = {}
	self._maxPassStageIdC1 = 0
	self._isRecoverySequenceInStorys = {}
	self._searchedErrorWords = {}
	self._replacedErrorWords = {}
	self._gainWordCountsInStory = {}
	self._hasGainWordPositionInStage = {}
	self._lastClgResultC2 = nil
	self._lastClgResultC3 = nil
	self._lastClgResultC4 = nil
end

function BoccaccioChapterSubMo:dispose()
	self:onReset()
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapterInfoRes(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapterInfoMap = {}
	self._chapterInfoMap[1] = info.chapter1Info
	self._chapterInfoMap[2] = info.chapter2Info
	self._chapterInfoMap[3] = info.chapter3Info
	self._chapterInfoMap[4] = info.chapter4Info
	self._hasUnlockPlotIds = info.hasUnlockPlot or {}

	for _, plotId in ipairs(self._hasUnlockPlotIds) do
		self._hasUnlockPlotIdMap[plotId] = true
	end

	for chapterId, cInfo in pairs(self._chapterInfoMap) do
		self._maxGainProgressIds[chapterId] = cInfo.maxGainProgressId
	end

	local infoC1 = msg.chapter1Info

	self._maxPassStageIdC1 = infoC1.maxPassStageId

	local infoC2 = msg.chapter2Info

	self._isRecoverySequenceInStorys = {}
	self._searchedErrorWords = {}
	self._replacedErrorWords = {}
	self._hasGainWordPositionInStage = {}

	for _, v in ipairs(infoC2.storyInfo) do
		local storyId = v.storyId

		self._isRecoverySequenceInStorys[storyId] = checkbool(v.isRecoverySequence)

		for _, wordId in ipairs(v.hasFindErrorWord) do
			self._searchedErrorWords[wordId] = true
		end

		for _, wordId in ipairs(v.hasReplaceErrorWord) do
			self._replacedErrorWords[wordId] = true
		end

		self._gainWordCountsInStory[storyId] = {}

		for _, wordId in ipairs(v.gainWord) do
			self._gainWordCountsInStory[storyId][wordId] = (self._gainWordCountsInStory[storyId][wordId] or 0) + 1
		end

		for i, stageInfo in ipairs(v.stageInfo) do
			local stageId = stageInfo.stageId

			self._hasGainWordPositionInStage[stageId] = {}

			for _, posId in ipairs(stageInfo.hasGainWordPosition) do
				posId = posId + 1
				self._hasGainWordPositionInStage[stageId][posId] = true
			end
		end
	end
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapterOneClickGainProgressPrizeRes(msg)
	local chapterId = msg.chapter

	if not self._chapterInfoMap[chapterId] then
		self._chapterInfoMap[chapterId].maxGainProgressId = msg.maxGainProgressId
		self._chapterInfoMap[chapterId] = self._chapterInfoMap[chapterId]
		self._maxGainProgressIds[msg.chapter] = msg.maxGainProgressId
	end
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter2RecoverySequenceRes(msg)
	local storyId = msg.storyId

	self._isRecoverySequenceInStorys[storyId] = true
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter2FindErrorWordRes(msg)
	self._searchedErrorWords[msg.errorWordId] = true
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter2ReplaceWordRes(msg)
	local activityId = msg.activityId
	local storyId = msg.storyId

	self._replacedErrorWords[msg.errorWordId] = true

	local data = BoccaccioChapterConfig.instance:getChapter2WordDataByError(activityId, msg.errorWordId)
	local wordId = data.wordId

	if self._gainWordCountsInStory[storyId] and self._gainWordCountsInStory[storyId][wordId] then
		self._gainWordCountsInStory[storyId][wordId] = self._gainWordCountsInStory[storyId][wordId] - 1
	end
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter3SignUpRes(msg)
	if not self._chapterInfoMap[3] then
		self._chapterInfoMap[3].hasSignUpDays = checknumber(msg.hasSignUpDays)
		self._chapterInfoMap[3].isSignUpToday = true
		self._chapterInfoMap[3] = self._chapterInfoMap[3]
	end
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter3SaveClgRes(msg)
	return
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter4RankViewRes(msg)
	self._chapter4RankInfo = GameUtil.pbToTable(msg)
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapterFirstClickRes(msg)
	return
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter1NotifyClgRes(msg)
	if msg.isWin then
		self._maxPassStageIdC1 = Mathf.Max(self._maxPassStageIdC1, msg.stageId)
	end
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter2NotifyClgRes(msg)
	self._lastClgResultC2 = msg

	local storyId = msg.storyId
	local stageId = msg.stageId

	for _, v in ipairs(msg.gainWord) do
		self._gainWordCountsInStory[storyId][v] = (self._gainWordCountsInStory[storyId][v] or 0) + 1
	end

	for _, posId in ipairs(msg.gainWordPosition) do
		posId = posId + 1
		self._hasGainWordPositionInStage[stageId][posId] = true
	end
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter3NotifyClgRes(msg)
	self._lastClgResultC3 = msg
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapter4NotifyClgRes(msg)
	self._lastClgResultC4 = msg
end

function BoccaccioChapterSubMo:handlePM_BoccaccioChapterUnlockPlotRes(msg)
	local plotId = checknumber(msg.plotId)

	if plotId > 0 then
		table.insert(self._hasUnlockPlotIds, plotId)

		self._hasUnlockPlotIdMap[plotId] = true
	end
end

function BoccaccioChapterSubMo:getChapterInfo(chapterId)
	return self._chapterInfoMap[chapterId]
end

function BoccaccioChapterSubMo:getChapter4RankInfo()
	return self._chapter4RankInfo
end

function BoccaccioChapterSubMo:isUnlockChapter(chapterId)
	local data = BoccaccioChapterConfig.instance:getChapterData(self._activityId, chapterId)
	local timePeriod = GameUtil.getTimePeriod(data.openTime, nil)

	return timePeriod == GameUtil.inTimePeriod
end

function BoccaccioChapterSubMo:getCurProgress(chapterId)
	if chapterId == BoccaccioChapterEnum.ChapterId_1 then
		return self:getPassStageCountC1()
	elseif chapterId == BoccaccioChapterEnum.ChapterId_2 then
		return self:getReplacedErrorWordCount()
	elseif chapterId == BoccaccioChapterEnum.ChapterId_3 then
		return self:getMaxPassStageIdC3()
	elseif chapterId == BoccaccioChapterEnum.ChapterId_4 then
		return self:getTotalHurtC4()
	end

	return 0
end

function BoccaccioChapterSubMo:getMaxGainProgressId(chapterId)
	return checknumber(self._maxGainProgressIds[chapterId])
end

function BoccaccioChapterSubMo:isHasCanGetPrize(chapterId)
	local datas = BoccaccioChapterConfig.instance:getProgressPrizeDatas(self._activityId, chapterId) or {}

	for _, data in ipairs(datas) do
		if self:isCanGetPrize(chapterId, data.progressId) then
			return true
		end
	end

	return false
end

function BoccaccioChapterSubMo:isEnoughGetPrize(chapterId, progressId)
	local prizeData = BoccaccioChapterConfig.instance:getProgressPrizeData(self._activityId, chapterId, progressId)
	local need = checknumber(prizeData and prizeData.progress)
	local cur = self:getCurProgress(chapterId)

	return need <= cur
end

function BoccaccioChapterSubMo:isHasGainPrize(chapterId, progressId)
	local gainProgressId = self:getMaxGainProgressId(chapterId)

	return progressId <= gainProgressId and gainProgressId > 0
end

function BoccaccioChapterSubMo:isCanGetPrize(chapterId, progressId)
	return not self:isHasGainPrize(chapterId, progressId) and self:isEnoughGetPrize(chapterId, progressId)
end

function BoccaccioChapterSubMo:getPassStageCountC1()
	return self._maxPassStageIdC1
end

function BoccaccioChapterSubMo:isPassStarC1(starId)
	local dataList = BoccaccioChapterConfig.instance:getChapter1StageDataListInStar(self._activityId, starId)
	local maxData = dataList and dataList[#dataList]

	if maxData then
		if not maxData.stageId then
			local stageId = 0

			return stageId <= self._maxPassStageIdC1
		end
	end
end

function BoccaccioChapterSubMo:isUnlockStarC1(starId)
	local lastStarId = starId - 1

	return self:isPassStarC1(lastStarId)
end

function BoccaccioChapterSubMo:isPassStageC1(stageId)
	return stageId <= self._maxPassStageIdC1
end

function BoccaccioChapterSubMo:isUnlockStageC1(stageId)
	local lastStageId = stageId - 1

	return self:isPassStageC1(lastStageId)
end

function BoccaccioChapterSubMo:getCurLatestStageIdC1()
	return self._maxPassStageIdC1 + 1
end

function BoccaccioChapterSubMo:getClgResultC2()
	return self._lastClgResultC2
end

function BoccaccioChapterSubMo:getMaxStoryId()
	return self._maxStoryId
end

function BoccaccioChapterSubMo:isUnlockStory(storyId)
	local lastStoryId = storyId - 1

	return self:isAllErrorWordsReplaced(lastStoryId)
end

function BoccaccioChapterSubMo:isAllErrorWordsSearched(storyId)
	local dataList = BoccaccioChapterConfig.instance:getChapter2ErrorWordDataListBySotryId(self._activityId, storyId) or {}

	for _, data in ipairs(dataList) do
		local errorWordId = data.errorWordId

		if not self:isSearchedErrorWord(errorWordId) then
			return false
		end
	end

	return true
end

function BoccaccioChapterSubMo:isAllErrorWordsReplaced(storyId)
	local dataList = BoccaccioChapterConfig.instance:getChapter2ErrorWordDataListBySotryId(self._activityId, storyId) or {}

	for _, data in ipairs(dataList) do
		local errorWordId = data.errorWordId

		if not self:isReplaceErrorWord(errorWordId) then
			return false
		end
	end

	return true
end

function BoccaccioChapterSubMo:isRecoverySequenceInStory(storyId)
	return self._isRecoverySequenceInStorys[storyId] or false
end

function BoccaccioChapterSubMo:isSearchedErrorWord(errorWordId)
	return self._searchedErrorWords[errorWordId] or false
end

function BoccaccioChapterSubMo:isReplaceErrorWord(errorWordId)
	return self._replacedErrorWords[errorWordId] or false
end

function BoccaccioChapterSubMo:getReplacedErrorWordCount()
	local count = 0

	for _, isReplace in pairs(self._replacedErrorWords) do
		if isReplace then
			count = count + 1
		end
	end

	return count
end

function BoccaccioChapterSubMo:getGainWordCountInStory(storyId, wordId)
	if self._gainWordCountsInStory[storyId] then
		if not self._gainWordCountsInStory[storyId][wordId] then
			return 0
		end
	end
end

function BoccaccioChapterSubMo:getGainWordTotalCountInStory(storyId)
	local result = 0

	if not self._gainWordCountsInStory[storyId] then
		for _, count in pairs(self._gainWordCountsInStory[storyId]) do
			result = result + count
		end

		return result
	end
end

function BoccaccioChapterSubMo:isHasGainWordPositionInStage(stageId, posId)
	return (self._hasGainWordPositionInStage[stageId] or nil) and (self._hasGainWordPositionInStage[stageId][posId] or false)
end

function BoccaccioChapterSubMo:getLastClgResultC3()
	return self._lastClgResultC3
end

function BoccaccioChapterSubMo:getMaxPassStageIdC3()
	if not self._chapterInfoMap[3] then
		return checknumber(self._chapterInfoMap[3].maxPassStageId)
	end
end

function BoccaccioChapterSubMo:getLastClgResultC4()
	return self._lastClgResultC4
end

function BoccaccioChapterSubMo:getTotalHurtC4()
	if not self._chapterInfoMap[4] then
		return checknumber(self._chapterInfoMap[4].totalBossDamage)
	end
end

function BoccaccioChapterSubMo:getHasUnlockPlotIds()
	return self._hasUnlockPlotIds or {}
end

function BoccaccioChapterSubMo:isUnlockPlot(plotId)
	return self._hasUnlockPlotIdMap[plotId] or false
end

return BoccaccioChapterSubMo
