local var_0_0 = g.core.config.dungeon_chapter_info
local var_0_1 = g.core.config.biography_chapter_info
local var_0_2 = g.core.config.theme_biography_chapter_info
local var_0_3 = g.core.config.scroll_main_growth_info
local var_0_4 = g.core.config.activity_theme_dungeon_chapter_info
local var_0_5 = g.core.const.ConstMgr.ThemeConst
local var_0_6 = table.insert
local PlotReplayReviewData = class("PlotReplayReviewData")
local var_0_8 = g.core.const.ConstMgr.PlotReplayConst

function PlotReplayReviewData:ctor()
	self:initData()
end

function PlotReplayReviewData:initData()
	self._fullDungeonChapterNum = 0
	self._dungeonLastUnlockChapter = 0
	self._dungeonLastPassedChapter = 0
	self._fullBiographyChapterNum = 0
	self._biographyCurIndex = 0
	self._biographyCurInfo = nil
	self._fullDungeonChapterInfo = {}
	self._fullBiographyInfo = {}
	self._fillResInfo = {}
	self._themeDungeonPvSeenList = {}
	self._fullthemeChapterStory = {}
	self._profileInfo = {}
	self._profileGotAwards = {}
	self._joinedThemeActId = {}
	self._themeBioList = {}

	self:_init()
end

function PlotReplayReviewData:_init()
	self:_initDungeonChapter()
	self:_initBiography()
	self:_initResInfo()
	self:_initProfileInfo()
end

function PlotReplayReviewData:_initDungeonChapter()
	local var_4_0 = var_0_0.getLength()

	self._fullDungeonChapterNum = var_4_0

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = {}
		local var_4_2 = var_0_0.indexOf(iter_4_0)

		var_4_1.storys = g.core.model.User.storyData:getDungeonChapterStory(var_4_2.id)
		var_4_1.info = var_4_2

		var_0_6(self._fullDungeonChapterInfo, var_4_1)
	end
end

function PlotReplayReviewData:_initBiography()
	local var_5_0 = var_0_1.getLength()

	self._fullBiographyChapterNum = var_5_0

	for iter_5_0 = 1, var_5_0 do
		local var_5_1 = {}
		local var_5_2 = var_0_1.indexOf(iter_5_0)

		var_5_1.storys = g.core.model.User.storyData:getBioChapterStory(var_5_2.id)
		var_5_1.info = var_5_2

		var_0_6(self._fullBiographyInfo, var_5_1)
	end
end

function PlotReplayReviewData:_initThemeDungeonChapter()
	self._fullthemeChapterStory = {}

	local var_6_0 = self:getJoinedThemeDungeonChapters()

	if #var_6_0 > 0 then
		for iter_6_0 = 1, #var_6_0 do
			local var_6_1 = {}
			local var_6_2 = var_0_4.get(var_6_0[iter_6_0].id)

			var_6_1.themeId = var_6_0[iter_6_0].themeId
			var_6_1.storys = g.core.model.User.storyData:getThemeDungeonChapterStory(var_6_2.id)

			if var_6_1.storys and #var_6_1.storys > 0 then
				local var_6_3 = 0

				for iter_6_1, iter_6_2 in ipairs(var_6_1.storys) do
					if self:isSeenDungeonPv(iter_6_2.storyId) then
						iter_6_2.finish = true
						var_6_3 = var_6_3 + 1
					end
				end

				var_6_1.openStageNum = var_6_3
			else
				var_6_1.openStageNum = 0
			end

			var_6_1.isUnlock = var_6_1.openStageNum > 1 and 1 or 0
			var_6_1.info = var_6_2
			var_6_1.themeType = var_0_8.THEME

			var_0_6(self._fullthemeChapterStory, var_6_1)
		end
	end

	local var_6_4 = self:getJoinedThemeBioChapters()

	if #var_6_4 > 0 then
		for iter_6_3 = 1, #var_6_4 do
			local var_6_5 = {}
			local var_6_6 = var_0_2.get(var_6_4[iter_6_3].id)

			var_6_5.themeId = var_6_4[iter_6_3].themeId
			var_6_5.storys = g.core.model.User.storyData:getThemeBioChapterStory(var_6_6.id)

			if var_6_5.storys and #var_6_5.storys > 0 then
				local var_6_7 = 0

				for iter_6_4, iter_6_5 in ipairs(var_6_5.storys) do
					if self:hasCompletedThemeBioStory(iter_6_5.storyId) then
						var_6_7 = var_6_7 + 1
					end
				end

				var_6_5.openStageNum = var_6_7
			else
				var_6_5.openStageNum = 0
			end

			var_6_5.isUnlock = var_6_5.openStageNum > 1 and 1 or 0
			var_6_5.info = var_6_6
			var_6_5.themeType = var_0_8.THEME_BIO

			var_0_6(self._fullthemeChapterStory, var_6_5)
		end
	end

	self:sortThemeChapterStorys()
end

function PlotReplayReviewData:_initThemeBioChapterStory()
	for iter_7_0, iter_7_1 in self._fillResInfo[var_0_8.THEME_BIO] or {} do
		local var_7_1 = iter_7_1.chapter_id
		local var_7_2 = {
			storys = g.core.model.User.storyData:getThemeBioChapterStory(iter_7_1.chapter_id)
		}
		local var_7_3 = 0

		if var_7_2.storys and #var_7_2.storys > 0 then
			for iter_7_2, iter_7_3 in ipairs(var_7_2.storys) do
				if self:hasCompletedThemeBioStory(iter_7_3.storyId) then
					var_7_3 = var_7_3 + 1
				end
			end
		end

		var_7_2.openStageNum = var_7_3
		var_7_2.isUnlock = var_7_2.openStageNum > 1 and 1 or 0
		var_7_2.info = var_0_2.get(var_7_1)

		var_0_6(self._fullthemeChapterStory, var_7_2)
	end
end

function PlotReplayReviewData:_initResInfo()
	for iter_8_0 = 1, var_0_3.getLength() do
		local var_8_0 = var_0_3.indexOf(iter_8_0)

		self._fillResInfo[var_8_0.tab_type] = self._fillResInfo[var_8_0.tab_type] or {}
		self._fillResInfo[var_8_0.tab_type][var_8_0.chapter_id] = var_8_0
	end
end

function PlotReplayReviewData:_initProfileInfo()
	self._profileInfo = {}

	for iter_9_0 = 1, g.core.config.daily_profile_info.getLength() do
		local var_9_0 = clone(g.core.config.daily_profile_info.indexOf(iter_9_0).toObject())

		if not self._profileInfo[var_9_0.type] then
			self._profileInfo[var_9_0.type] = {}
			self._profileInfo[var_9_0.type].typeName = var_9_0.type_name
			self._profileInfo[var_9_0.type].type = var_9_0.type
			self._profileInfo[var_9_0.type].infos = {}
		end

		local var_9_1 = var_9_0.subtype

		if not self._profileInfo[var_9_0.type].infos[var_9_0.subtype] then
			self._profileInfo[var_9_0.type].infos[var_9_1] = {}
		end

		table.insert(self._profileInfo[var_9_0.type].infos[var_9_1], var_9_0)
	end
end

function PlotReplayReviewData:getProfileInfo()
	return self._profileInfo
end

function PlotReplayReviewData:setProfileSelectedId(arg_11_1)
	self._profileSelectdId = arg_11_1
end

function PlotReplayReviewData:setProfileAwards(arg_12_1)
	self._profileGotAwards = arg_12_1.story_id or {}
end

function PlotReplayReviewData:updateProfileAward(arg_13_1)
	if arg_13_1.story_id then
		table.insert(self._profileGotAwards, arg_13_1.story_id)
	end
end

function PlotReplayReviewData:getProfileAwardState(arg_14_1)
	if g.core.model.User.dungeonData:getPassedChapterNum() < g.core.config.daily_profile_info.get(arg_14_1).num then
		return 0
	end

	for iter_14_0, iter_14_1 in ipairs(self._profileGotAwards) do
		if iter_14_1 == arg_14_1 then
			return 2
		end
	end

	return 1
end

function PlotReplayReviewData:getProfileUnlockCntBySubType(arg_15_1)
	local var_15_0 = 0
	local var_15_1 = g.core.model.User.dungeonData:getPassedChapterNum()

	for iter_15_0 = 1, g.core.config.daily_profile_info.getLength() do
		local var_15_2 = g.core.config.daily_profile_info.indexOf(iter_15_0)

		if var_15_2.subtype == arg_15_1 and var_15_1 >= var_15_2.num then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function PlotReplayReviewData:getProfileAward(arg_16_1)
	local var_16_0 = g.core.config.drop_info.match(function(arg_17_0)
		return arg_17_0.id == arg_16_1
	end)
	local var_16_1 = {}

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			for iter_16_2 = 1, 5 do
				if iter_16_1["reward_type_" .. iter_16_2] == 0 then
					break
				end

				table.insert(var_16_1, {
					type = iter_16_1["reward_type_" .. iter_16_2],
					value = iter_16_1["reward_value_" .. iter_16_2],
					size = iter_16_1["reward_min_" .. iter_16_2]
				})
			end
		end
	end

	return var_16_1
end

function PlotReplayReviewData:getFirstAwardProfile()
	for iter_18_0 = 1, g.core.config.daily_profile_info.getLength() do
		local var_18_0 = g.core.config.daily_profile_info.indexOf(iter_18_0)

		if self:getProfileAwardState(var_18_0.id) == 1 then
			return var_18_0
		end
	end
end

function PlotReplayReviewData:getProfileSelectedId()
	return self._profileSelectdId
end

function PlotReplayReviewData:updateUnlockData()
	self._dungeonLastUnlockChapter = g.core.model.User.dungeonData:getLastUnlockChapter()
	self._dungeonLastPassedChapter = g.core.model.User.dungeonData:getLastPassedChapter()
end

function PlotReplayReviewData:getDataConfigByType(arg_21_1, arg_21_2)
	if arg_21_1 == var_0_8.MAIN then
		return self:getDungeonChapterInfo(arg_21_2)
	elseif arg_21_1 == var_0_8.GENERAL then
		return self:getBioChapterOpenStoryInfo(arg_21_2)
	else
		return self:getThemeChapterOpenStoryInfo(arg_21_2)
	end
end

function PlotReplayReviewData:updateDungeonChapterStoryInfo(arg_22_1)
	if self._fullDungeonChapterInfo[arg_22_1] then
		if self._fullDungeonChapterInfo[arg_22_1].storys and #self._fullDungeonChapterInfo[arg_22_1].storys > 0 then
			local var_22_0 = 0
			local var_22_1 = false
			local var_22_2 = false
			local var_22_3 = false
			local var_22_4
			local var_22_5

			for iter_22_0, iter_22_1 in ipairs(self._fullDungeonChapterInfo[arg_22_1].storys) do
				if iter_22_1.chapterState then
					if iter_22_1.chapterState == 1 then
						var_22_1 = true

						if g.core.model.User.storyData:isStoryPlayed(tostring(iter_22_1.storyId)) then
							var_22_0 = var_22_0 + 1
							var_22_2 = true
							iter_22_1.finish = true
						else
							var_22_4 = iter_22_1
						end
					elseif iter_22_1.chapterState == 2 then
						var_22_3 = true
						var_22_5 = iter_22_1
					end
				elseif iter_22_1.checkPointId and g.core.model.User.dungeonData:isStagePassed(iter_22_1.checkPointId) then
					var_22_0 = var_22_0 + 1
					iter_22_1.finish = true
				elseif g.core.model.User.storyData:isStoryPlayed(tostring(iter_22_1.storyId)) then
					var_22_0 = var_22_0 + 1
					iter_22_1.finish = true
				end
			end

			if var_22_1 and not var_22_2 and var_22_0 > 0 then
				var_22_0 = var_22_0 + 1

				if var_22_4 then
					var_22_4.finish = true
				end
			end

			if var_22_3 and var_22_0 - 1 == #self._fullDungeonChapterInfo[arg_22_1].storys then
				var_22_0 = var_22_0 + 1

				if var_22_5 then
					var_22_5.finish = true
				end
			end

			self._fullDungeonChapterInfo[arg_22_1].openStageNum = var_22_0
		else
			self._fullDungeonChapterInfo[arg_22_1].openStageNum = 0
		end
	end
end

function PlotReplayReviewData:getDungeonChapterOpenNum(arg_23_1)
	self:updateDungeonChapterStoryInfo(arg_23_1)

	return self._fullDungeonChapterInfo[arg_23_1].openStageNum
end

function PlotReplayReviewData:getDungeonChapterInfo(arg_24_1)
	self:updateDungeonChapterStoryInfo(arg_24_1)

	return self._fullDungeonChapterInfo[arg_24_1]
end

function PlotReplayReviewData:updateBioChapterStoryInfo(arg_25_1)
	if not self._fullBiographyInfo[arg_25_1] then
		return
	end

	if self._fullBiographyInfo[arg_25_1].storys and #self._fullBiographyInfo[arg_25_1].storys > 0 then
		local var_25_0 = 0
		local var_25_1 = false
		local var_25_2 = false
		local var_25_3

		for iter_25_0, iter_25_1 in ipairs(self._fullBiographyInfo[arg_25_1].storys) do
			if iter_25_1.chapterState then
				if iter_25_1.chapterState == 1 then
					var_25_2 = true

					if g.core.model.User.storyData:isStoryPlayed(tostring(iter_25_1.storyId)) then
						var_25_1 = true
						var_25_0 = var_25_0 + 1
						iter_25_1.finish = true
					else
						var_25_3 = iter_25_1
					end
				end
			elseif iter_25_1.missionId then
				local var_25_4 = g.core.model.User.bioData:getMission(iter_25_1.missionId)

				if var_25_4 and var_25_4.finish then
					var_25_0 = var_25_0 + 1
					iter_25_1.finish = true
				elseif g.core.model.User.storyData:isStoryPlayed(tostring(iter_25_1.storyId)) then
					var_25_0 = var_25_0 + 1
					iter_25_1.finish = true
				end
			end
		end

		if var_25_2 and var_25_0 > 0 and not var_25_1 then
			var_25_0 = var_25_0 + 1
			var_25_3.finish = true
		end

		self._fullBiographyInfo[arg_25_1].openStageNum = var_25_0
	else
		self._fullBiographyInfo[arg_25_1].openStageNum = 0
	end
end

function PlotReplayReviewData:updatethemeChapterStoryInfo(arg_26_1)
	local var_26_0 = self._fullthemeChapterStory[arg_26_1]

	if not self._fullthemeChapterStory[arg_26_1] then
		return
	end

	if var_26_0.storys and #var_26_0.storys > 0 then
		local var_26_1 = 0

		if var_26_0.themeType == var_0_8.THEME then
			for iter_26_0, iter_26_1 in ipairs(var_26_0.storys) do
				if self:isSeenDungeonPv(iter_26_1.storyId) then
					var_26_1 = var_26_1 + 1
				end
			end
		elseif var_26_0.themeType == var_0_8.THEME_BIO then
			for iter_26_2, iter_26_3 in ipairs(var_26_0.storys) do
				if self:hasCompletedThemeBioStory(iter_26_3.storyId) then
					var_26_1 = var_26_1 + 1
				end
			end
		end

		var_26_0.openStageNum = var_26_1
	else
		var_26_0.openStageNum = 0
	end

	var_26_0.isUnlock = var_26_0.openStageNum > 1 and 1 or 0
end

function PlotReplayReviewData:sortThemeChapterStorys()
	table.sort(self._fullthemeChapterStory, function(arg_28_0, arg_28_1)
		if arg_28_0.openStageNum > 0 ~= (arg_28_1.openStageNum > 0) then
			return arg_28_0.openStageNum > 0
		end

		if arg_28_0.themeId ~= arg_28_1.themeId then
			return arg_28_0.themeId < arg_28_1.themeId
		end

		if arg_28_0.info.id ~= arg_28_1.info.id then
			return arg_28_0.info.id < arg_28_1.info.id
		end

		return false
	end)
end

function PlotReplayReviewData:getBioChapterOpenStoryNum(arg_29_1)
	self:updateBioChapterStoryInfo(arg_29_1)

	return self._fullBiographyInfo[arg_29_1].openStageNum
end

function PlotReplayReviewData:getBioChapterOpenStoryInfo(arg_30_1)
	self:updateBioChapterStoryInfo(arg_30_1)

	return self._fullBiographyInfo[arg_30_1]
end

function PlotReplayReviewData:getThemeChapterOpenStoryInfo(arg_31_1)
	self:updatethemeChapterStoryInfo(arg_31_1)

	return self._fullthemeChapterStory[arg_31_1]
end

function PlotReplayReviewData:getGrowthInfoByTypeAndChapter(arg_32_1, arg_32_2)
	if not self._fillResInfo[arg_32_1] then
		return nil
	end

	return self._fillResInfo[arg_32_1][arg_32_2]
end

function PlotReplayReviewData:getCurPassedIdByType(arg_33_1)
	if arg_33_1 == var_0_8.MAIN then
		return self._dungeonLastPassedChapter
	else
		return self._biographyCurIndex - 1
	end
end

function PlotReplayReviewData:getChapterStageNumInfo(arg_34_1, arg_34_2)
	local var_34_0 = self:getDataConfigByType(arg_34_1, arg_34_2)
	local var_34_1 = 0

	if arg_34_1 == 1 then
		var_34_1 = #g.core.model.User.storyData:getDungeonChapterStory(arg_34_2)
	elseif arg_34_1 == 2 then
		var_34_1 = #g.core.model.User.storyData:getBioChapterStory(arg_34_2)
	elseif arg_34_1 == 3 then
		if self._fullthemeChapterStory[arg_34_2] and self._fullthemeChapterStory[arg_34_2].info then
			if self._fullthemeChapterStory[arg_34_2].themeType == var_0_8.THEME then
				var_34_1 = #g.core.model.User.storyData:getThemeDungeonChapterStory(self._fullthemeChapterStory[arg_34_2].info.id)
			elseif self._fullthemeChapterStory[arg_34_2].themeType == var_0_8.THEME_BIO then
				var_34_1 = #g.core.model.User.storyData:getThemeBioChapterStory(self._fullthemeChapterStory[arg_34_2].info.id)
			end
		end
	end

	return var_34_0.openStageNum, var_34_1
end

function PlotReplayReviewData:checkChapterUnlocked(arg_35_1, arg_35_2)
	local var_35_0, var_35_1 = self:getChapterStageNumInfo(arg_35_1, arg_35_2)

	return var_35_0 > 0
end

function PlotReplayReviewData:getReplayCellNum(arg_36_1)
	if arg_36_1 == var_0_8.MAIN then
		return #self._fullDungeonChapterInfo
	elseif arg_36_1 == var_0_8.GENERAL then
		return #self._fullBiographyInfo
	elseif arg_36_1 == var_0_8.THEME then
		return #self._fullthemeChapterStory
	end
end

function PlotReplayReviewData:getReplayCellInfo(arg_37_1, arg_37_2)
	if arg_37_1 == var_0_8.MAIN then
		self:updateDungeonChapterStoryInfo(arg_37_2)

		return self._fullDungeonChapterInfo[arg_37_2]
	elseif arg_37_1 == var_0_8.GENERAL then
		self:updateBioChapterStoryInfo(arg_37_2)

		return self._fullBiographyInfo[arg_37_2]
	elseif arg_37_1 == var_0_8.THEME then
		self:updatethemeChapterStoryInfo(arg_37_2)

		return self._fullthemeChapterStory[arg_37_2]
	end
end

function PlotReplayReviewData:initThemeDungeonSeenPv(arg_38_1)
	if arg_38_1.pvList then
		self._themeDungeonPvSeenList = arg_38_1.pvList
	end

	if arg_38_1.actList then
		self._joinedThemeActId = arg_38_1.actList
	end

	if arg_38_1.bioList then
		self._themeBioList = arg_38_1.bioList
	end

	self:_initThemeDungeonChapter()
end

function PlotReplayReviewData:isSeenDungeonPv(arg_39_1)
	for iter_39_0 = 1, #self._themeDungeonPvSeenList do
		if self._themeDungeonPvSeenList[iter_39_0] == arg_39_1 then
			return true
		end
	end

	return false
end

function PlotReplayReviewData:hasCompletedThemeBioStory(arg_40_1)
	for iter_40_0 = 1, #self._themeBioList do
		if self._themeBioList[iter_40_0] == arg_40_1 then
			return true
		end
	end

	return false
end

function PlotReplayReviewData:getJoinedThemeDungeonChapters()
	local var_41_0 = {}

	if #self._joinedThemeActId > 0 then
		for iter_41_0 = 1, #self._joinedThemeActId do
			local var_41_1 = g.core.config.activity_theme_info.get(self._joinedThemeActId[iter_41_0])

			for iter_41_1 = 1, var_0_5.THEME_DUNGEON_CHAPTER_NUM do
				if var_41_1["chapter_id_" .. iter_41_1] > 0 then
					table.insert(var_41_0, {
						id = var_41_1["chapter_id_" .. iter_41_1],
						themeId = self._joinedThemeActId[iter_41_0]
					})
				end
			end
		end
	end

	table.sort(var_41_0, function(arg_42_0, arg_42_1)
		return arg_42_0.id < arg_42_1.id
	end)

	return var_41_0
end

function PlotReplayReviewData:getJoinedThemeBioChapters()
	local var_43_0 = {}

	if #self._joinedThemeActId > 0 then
		for iter_43_0 = 1, #self._joinedThemeActId do
			local var_43_1 = g.core.config.activity_theme_info.get(self._joinedThemeActId[iter_43_0])

			for iter_43_1 = 1, var_0_5.THEME_BIO_CHAPTER_NUM do
				if var_43_1["biography_id_" .. iter_43_1] > 0 then
					table.insert(var_43_0, {
						id = var_43_1["biography_id_" .. iter_43_1],
						themeId = self._joinedThemeActId[iter_43_0]
					})
				end
			end
		end
	end

	table.sort(var_43_0, function(arg_44_0, arg_44_1)
		return arg_44_0.id < arg_44_1.id
	end)

	return var_43_0
end

function PlotReplayReviewData:isProfileHasAward(arg_45_1)
	arg_45_1 = arg_45_1 or {}

	local var_45_0 = g.core.config.daily_profile_info

	for iter_45_0 = 1, g.core.config.daily_profile_info.getLength() do
		local var_45_1 = var_45_0.indexOf(iter_45_0)

		if not arg_45_1.type and not arg_45_1.subtype and not arg_45_1.id then
			if self:getProfileAwardState(var_45_1.id) == 1 then
				return true
			end
		elseif (var_45_1.type == arg_45_1.type or var_45_1.subtype == arg_45_1.subtype or var_45_1.id == arg_45_1.id) and self:getProfileAwardState(var_45_1.id) == 1 then
			return true
		end
	end

	return false
end

function PlotReplayReviewData:isProfileSubHasAward(arg_46_1)
	arg_46_1 = arg_46_1 or {}

	local var_46_0 = g.core.config.daily_profile_info

	for iter_46_0 = 1, g.core.config.daily_profile_info.getLength() do
		local var_46_1 = var_46_0.indexOf(iter_46_0)

		if not arg_46_1.type and not arg_46_1.subtype and not arg_46_1.id then
			if self:getProfileAwardState(var_46_1.id) == 1 then
				return true
			end
		elseif var_46_1.type == arg_46_1.type and var_46_1.subtype == arg_46_1.subtype and var_46_1.id == arg_46_1.id and self:getProfileAwardState(var_46_1.id) == 1 then
			return true
		end
	end

	return false
end

function PlotReplayReviewData:getPlotReplayDataIndex(arg_47_1, arg_47_2)
	local var_47_0

	if arg_47_1 == var_0_8.MAIN then
		var_47_0 = self._fullDungeonChapterInfo
	elseif arg_47_1 == var_0_8.GENERAL then
		var_47_0 = self._fullBiographyInfo
	elseif arg_47_1 == var_0_8.THEME then
		var_47_0 = self._fullthemeChapterStory
	elseif arg_47_1 == var_0_8.THEME_BIO then
		var_47_0 = self._fullthemeChapterStory
	end

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if iter_47_1.info.id == arg_47_2 and (not iter_47_1.themeType or arg_47_1 == iter_47_1.themeType) then
			return iter_47_0
		end
	end

	return 1
end

return PlotReplayReviewData
