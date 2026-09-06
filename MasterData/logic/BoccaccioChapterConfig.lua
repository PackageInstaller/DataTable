-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/config/BoccaccioChapterConfig.lua

module("logic.extensions.boccacciochapter.config.BoccaccioChapterConfig", package.seeall)

local BoccaccioChapterConfig = class("BoccaccioChapterConfig", BaseConfig)

function BoccaccioChapterConfig:getNames()
	return {
		"boccaccio_chapter",
		"boccaccio_chapter1_stage",
		"boccaccio_chapter2_error_word",
		"boccaccio_chapter2_passages",
		"boccaccio_chapter2_stage",
		"boccaccio_chapter2_story",
		"boccaccio_chapter2_word",
		"boccaccio_chapter3_sign_up_buff",
		"boccaccio_chapter3_stage",
		"boccaccio_chapter4_rank_prize",
		"boccaccio_chapter_activity",
		"boccaccio_chapter_creeps",
		"boccaccio_chapter_master",
		"boccaccio_chapter_progress_prize",
		"boccaccio_chapter_support_pet",
		"boccaccio_chapter_plot"
	}
end

function BoccaccioChapterConfig:handleConfig(name, content)
	if name == "boccaccio_chapter" then
		self._boccaccio_chapter = content
	elseif name == "boccaccio_chapter1_stage" then
		self._boccaccio_chapter1_stage = content

		self:_handleChapter1StageConfig(content.dataList)
	elseif name == "boccaccio_chapter2_error_word" then
		self._boccaccio_chapter2_error_word = content

		self:_handleChapter2ErrorWordConfig(content.dataList)
	elseif name == "boccaccio_chapter2_passages" then
		self._boccaccio_chapter2_passages = content
	elseif name == "boccaccio_chapter2_stage" then
		self._boccaccio_chapter2_stage = content

		self:_handleChapter2StageConfig(content.dataList)
	elseif name == "boccaccio_chapter2_story" then
		self._boccaccio_chapter2_story = content
	elseif name == "boccaccio_chapter2_word" then
		self._boccaccio_chapter2_word = content
	elseif name == "boccaccio_chapter3_sign_up_buff" then
		self._boccaccio_chapter3_sign_up_buff = content
	elseif name == "boccaccio_chapter3_stage" then
		self._boccaccio_chapter3_stage = content
	elseif name == "boccaccio_chapter4_rank_prize" then
		self._boccaccio_chapter4_rank_prize = content
	elseif name == "boccaccio_chapter_activity" then
		self._boccaccio_chapter_activity = content
	elseif name == "boccaccio_chapter_creeps" then
		self._boccaccio_chapter_creeps = content
	elseif name == "boccaccio_chapter_master" then
		self._boccaccio_chapter_master = content
	elseif name == "boccaccio_chapter_progress_prize" then
		self._boccaccio_chapter_progress_prize = content
	elseif name == "boccaccio_chapter_support_pet" then
		self._boccaccio_chapter_support_pet = content

		self:_handleSupportPetConfig(content.dataList)
	elseif name == "boccaccio_chapter_plot" then
		self._boccaccio_chapter_plot = content
	end
end

function BoccaccioChapterConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function BoccaccioChapterConfig:getChapterDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter, activityId)
end

function BoccaccioChapterConfig:getChapterData(activityId, chapterId)
	return self:_safeGet(self._boccaccio_chapter, activityId, chapterId)
end

function BoccaccioChapterConfig:getChapter1StageDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter1_stage, activityId)
end

function BoccaccioChapterConfig:getChapter1StageData(activityId, stageId)
	return self:_safeGet(self._boccaccio_chapter1_stage, activityId, stageId)
end

function BoccaccioChapterConfig:getChapter1StageDataListsInStar(activityId)
	return self:_safeGet(self._chapter1StageDataInStar, activityId)
end

function BoccaccioChapterConfig:getChapter1StageDataListInStar(activityId, starId)
	return self:_safeGet(self._chapter1StageDataInStar, activityId, starId)
end

function BoccaccioChapterConfig:_handleChapter1StageConfig(dataList)
	self._chapter1StageDataInStar = {}

	for _, data in ipairs(dataList) do
		local activityId = data.activityId
		local starId = data.starId

		self._chapter1StageDataInStar = MmUtil.checkTable(self._chapter1StageDataInStar, activityId, starId)

		table.insert(self._chapter1StageDataInStar[activityId][starId], data)
	end
end

function BoccaccioChapterConfig:getChapter2ErrorWordDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter2_error_word, activityId)
end

function BoccaccioChapterConfig:getChapter2ErrorWordData(activityId, errorWordId)
	return self:_safeGet(self._boccaccio_chapter2_error_word, activityId, errorWordId)
end

function BoccaccioChapterConfig:getChapter2ErrorWordReplaceWordId(activityId, errorWordId)
	local data = self:getChapter2ErrorWordData(activityId, errorWordId)

	return (data or nil) and (data.replaceWordId or 0)
end

function BoccaccioChapterConfig:getChapter2ErrorWordDataListBySotryId(activityId, storyId)
	return self:_safeGet(self._chapter2ErrorWordDataInStory, activityId, storyId)
end

function BoccaccioChapterConfig:_handleChapter2ErrorWordConfig(dataList)
	self._chapter2ErrorWordDataInStory = {}

	for _, data in ipairs(dataList) do
		local activityId = data.activityId
		local storyId = data.storyId

		self._chapter2ErrorWordDataInStory = MmUtil.checkTable(self._chapter2ErrorWordDataInStory, activityId, storyId)

		table.insert(self._chapter2ErrorWordDataInStory[activityId][storyId], data)
	end
end

function BoccaccioChapterConfig:getChapter2PassagesDatass(activityId)
	return self:_safeGet(self._boccaccio_chapter2_passages, activityId)
end

function BoccaccioChapterConfig:getChapter2PassagesDatas(activityId, storyId)
	return self:_safeGet(self._boccaccio_chapter2_passages, activityId, storyId)
end

function BoccaccioChapterConfig:getChapter2PassagesData(activityId, storyId, passagesId)
	return self:_safeGet(self._boccaccio_chapter2_passages, activityId, storyId, passagesId)
end

function BoccaccioChapterConfig:getChapter2StageDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter2_stage, activityId)
end

function BoccaccioChapterConfig:getChapter2StageData(activityId, stageId)
	return self:_safeGet(self._boccaccio_chapter2_stage, activityId, stageId)
end

function BoccaccioChapterConfig:getChapter2StageDatasInStory(activityId, storyId)
	return self:_safeGet(self._chapter2StageDataInActivity, activityId, storyId)
end

function BoccaccioChapterConfig:_handleChapter2StageConfig(dataList)
	self._chapter2StageDataInActivity = {}

	for _, data in ipairs(dataList) do
		local activityId = data.activityId
		local storyId = data.storyId

		self._chapter2StageDataInActivity = MmUtil.checkTable(self._chapter2StageDataInActivity, activityId, storyId)

		table.insert(self._chapter2StageDataInActivity[activityId][storyId], data)
	end
end

function BoccaccioChapterConfig:getChapter2StoryDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter2_story, activityId)
end

function BoccaccioChapterConfig:getChapter2StoryData(activityId, stroyId)
	return self:_safeGet(self._boccaccio_chapter2_story, activityId, stroyId)
end

function BoccaccioChapterConfig:getChapter2WordDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter2_word, activityId)
end

function BoccaccioChapterConfig:getChapter2WordData(activityId, wordId)
	return self:_safeGet(self._boccaccio_chapter2_word, activityId, wordId)
end

function BoccaccioChapterConfig:getChapter2WordDataByError(activityId, errorWordId)
	local wordId = self:getChapter2ErrorWordReplaceWordId(activityId, errorWordId)

	return self:getChapter2WordData(activityId, wordId)
end

function BoccaccioChapterConfig:getChapter3SignUpBuffDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter3_sign_up_buff, activityId)
end

function BoccaccioChapterConfig:getChapter3SignUpBuffData(activityId, buffId)
	return self:_safeGet(self._boccaccio_chapter3_sign_up_buff, activityId, buffId)
end

function BoccaccioChapterConfig:getChapter3StageDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter3_stage, activityId)
end

function BoccaccioChapterConfig:getChapter3StageData(activityId, stageId)
	return self:_safeGet(self._boccaccio_chapter3_stage, activityId, stageId)
end

function BoccaccioChapterConfig:getChapter4RankPrizeDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter4_rank_prize, activityId)
end

function BoccaccioChapterConfig:getChapter4RankPrizeDataByRank(activityId, rank)
	local datas = self:getChapter4RankPrizeDatas(activityId)

	return MmUtil.unorderedSearchInArrayKey(datas, "rankRange", rank)
end

function BoccaccioChapterConfig:getActivityData(activityId)
	return self:_safeGet(self._boccaccio_chapter_activity, activityId)
end

function BoccaccioChapterConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._boccaccio_chapter_creeps, creepsMasterId)
end

function BoccaccioChapterConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._boccaccio_chapter_creeps, creepsMasterId, creepsId)
end

function BoccaccioChapterConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._boccaccio_chapter_master, creepsMasterId)
end

function BoccaccioChapterConfig:getProgressPrizeDatas(activityId, chapterId)
	local chapterData = self:getChapterData(activityId, chapterId)

	if chapterData then
		if not chapterData.progressPlan then
			local progressPlan = 0

			return self:_safeGet(self._boccaccio_chapter_progress_prize, progressPlan)
		end
	end
end

function BoccaccioChapterConfig:getProgressPrizeData(activityId, chapterId, progressId)
	local datas = self:getProgressPrizeDatas(activityId, chapterId)

	return datas[progressId]
end

function BoccaccioChapterConfig:getSupportPetDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter_support_pet, activityId)
end

function BoccaccioChapterConfig:getSupportPetData(activityId, creepsId)
	return self:_safeGet(self._boccaccio_chapter_support_pet, activityId, creepsId)
end

function BoccaccioChapterConfig:getSupportPetDatasByPlan(activityId, supportPetPlan)
	return self:_safeGet(self._supportPetDataListInPlan, activityId, supportPetPlan)
end

function BoccaccioChapterConfig:_handleSupportPetConfig(dataList)
	self._supportPetDataListInPlan = {}

	for _, data in ipairs(dataList) do
		local activityId = data.activityId
		local supportPetPlan = data.supportPetPlan

		self._supportPetDataListInPlan = MmUtil.checkTable(self._supportPetDataListInPlan, activityId, supportPetPlan)

		table.insert(self._supportPetDataListInPlan[activityId][supportPetPlan], data)
	end
end

function BoccaccioChapterConfig:getPlotDatas(activityId)
	return self:_safeGet(self._boccaccio_chapter_plot, activityId)
end

BoccaccioChapterConfig.instance = BoccaccioChapterConfig.New()

return BoccaccioChapterConfig
