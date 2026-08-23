local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.const.ConstMgr.ThemeBioConst
local var_0_3 = g.core.config.theme_biography_mission_info
local var_0_4 = g.core.config.theme_biography_mission_chain_info
local var_0_5 = g.core.config.theme_biography_chapter_info
local var_0_6 = g.core.config.biography_interaction_info
local var_0_7 = g.core.config.activity_theme_info
local var_0_8 = g.core.config.theme_vote_group_info
local var_0_9 = g.core.config.theme_vote_info
local var_0_10 = g.core.config.theme_biography_item_info
local var_0_11 = {
	2038,
	2039,
	2084,
	2303,
	2331
}
local ThemeBioData = class("ThemeBioData", require("app.core.model.BaseData"))

function ThemeBioData:ctor()
	self:initData()
end

function ThemeBioData:initData()
	ThemeBioData.super.ctor(self)

	self._chapters = {}
	self._chapterIds = {}
	self._firstChapter = 0
	self._chains = {}
	self._missions = {}
	self._initedInfo = false
	self._missionConditions = {}
	self._chapterNew = true
	self._newAdvanture = {}
	self._newBranches = {}
	self._newFastLevel = nil
	self._chapterAwarded = {}
	self._activeStartTime = 0
	self._activeFinishTime = 0
	self._inited = false
	self._unlockChapters = {}
	self._maxChapterId = nil
	self._mainMissionId = nil
	self._finishNewMission = false
	self._voteData = nil
	self._voteTimeMap = {}
	self._myVoteMap = {}
	self._serverVoteMap = {}
end

function ThemeBioData:refreshRedPointData(arg_3_1)
	self:updateMainInfo(arg_3_1)
end

function ThemeBioData:startByActivityData(arg_4_1)
	self._activeThemeType = arg_4_1:getActivityType()
	self._activeValue = arg_4_1:getActivityValue()
	self._activeThemeValue = arg_4_1:getConfigActivityValue() or 0
	self._sourceType = arg_4_1:getActivitySourceType()
	self._activeStartTime = arg_4_1:getStartTime()
	self._activeFinishTime = arg_4_1:getFinishTime()
	self._activityInfo = arg_4_1:getInfo()
	self._themeBioStartTime = self._activityInfo.biography_time1 or 0
	self._chapterIds = {}

	local var_4_0 = var_0_7.get(self._activeThemeValue)

	for iter_4_0 = 1, g.core.const.ConstMgr.ThemeConst.THEME_BIO_CHAPTER_NUM do
		if var_4_0["biography_id_" .. iter_4_0] > 0 then
			self._chapterIds[#self._chapterIds + 1] = var_4_0["biography_id_" .. iter_4_0]
		end
	end

	self:initInfo()

	for iter_4_1 = 1, #self._chapterIds do
		local var_4_1 = var_0_5.get(self._chapterIds[iter_4_1]).next_id

		if var_4_1 > 0 then
			self._chapters[self._chapterIds[iter_4_1]].next = var_4_1
			self._chapters[var_4_1].preset = self._chapterIds[iter_4_1]
		end
	end

	self._firstChapter = self:_findFirstChapter()

	if self._firstChapter then
		self:getChapter(self._firstChapter).fighting = true
	end

	self._voteTimeMap = {}

	if self._activityInfo.vote_infos then
		for iter_4_2, iter_4_3 in ipairs(self._activityInfo.vote_infos) do
			self._voteTimeMap[iter_4_3.id] = {
				startTime = iter_4_3.start_time,
				endTime = iter_4_3.end_time
			}
		end
	end
end

function ThemeBioData:getActivityValue()
	return self._activeValue
end

function ThemeBioData:getThemeBioStartTime()
	return self._themeBioStartTime
end

function ThemeBioData:getThemeBioChapterStartTime(arg_7_1)
	if not self._activityInfo then
		return 0
	end

	return self._activityInfo["biography_time" .. arg_7_1] or 0
end

function ThemeBioData:isActivityFinish()
	return g.core.common.ServerTime:getTime() > self._activeFinishTime and self._activeFinishTime > 0
end

function ThemeBioData:isThemeBioChapterOpen(arg_9_1)
	if not self._activeThemeValue or self._activeThemeValue == 0 then
		return
	end

	local var_9_0 = self._chapters[arg_9_1]

	if not self._chapters[arg_9_1] then
		return false
	end

	if not var_9_0.unlock then
		return false
	end

	local var_9_1 = self:getThemeBioChapterStartTime(var_9_0.number)

	return var_9_1 > 0 and var_9_1 < g.core.common.ServerTime:getTime()
end

function ThemeBioData:initInfo()
	if self._initedInfo then
		return
	end

	self._initedInfo = true

	local function var_10_0(arg_11_0, arg_11_1)
		if arg_11_1 == "unlock" then
			local var_11_0 = self:getMission(arg_11_0.preset)
			local var_11_1 = self:getChain(arg_11_0.chain)

			if (var_11_1.type == 1 or var_11_1.type == 2 and var_11_1.if_order == 1) and var_11_0 and not var_11_0.finish then
				return false
			end

			if not self:checkUnlock(arg_11_0.preset_type_1, arg_11_0.preset_value_1) then
				return false, 1
			end

			if not self:checkUnlock(arg_11_0.preset_type_2, arg_11_0.preset_value_2) then
				return false, 2
			end

			if not self:checkUnlock(arg_11_0.preset_type_3, arg_11_0.preset_value_3) then
				return false, 3
			end

			if not self:checkUnlock(arg_11_0.preset_type_4, arg_11_0.preset_value_4) then
				return false, 4
			end

			if not self:checkUnlock(arg_11_0.preset_type_5, arg_11_0.preset_value_5) then
				return false, 5
			end

			return true
		elseif arg_11_1 == "unlockType" then
			if not arg_11_0.unlock then
				local var_11_2 = self:getMission(arg_11_0.preset)
				local var_11_3 = self:getChain(arg_11_0.chain)

				if (var_11_3.type == 1 or var_11_3.type == 2 and var_11_3.if_order == 1) and var_11_2 and not var_11_2.finish then
					return 0
				end

				if not self:checkUnlock(arg_11_0.preset_type_1, arg_11_0.preset_value_1) then
					return 1
				end

				if not self:checkUnlock(arg_11_0.preset_type_2, arg_11_0.preset_value_2) then
					return 2
				end

				if not self:checkUnlock(arg_11_0.preset_type_3, arg_11_0.preset_value_3) then
					return 3
				end

				if not self:checkUnlock(arg_11_0.preset_type_4, arg_11_0.preset_value_4) then
					return 4
				end

				if not self:checkUnlock(arg_11_0.preset_type_5, arg_11_0.preset_value_5) then
					return 5
				end
			end

			return 0
		elseif arg_11_1 == "canShow" then
			return (not arg_11_0.finish or nil) and (self:checkUnlock(arg_11_0.unlock_seen_type, arg_11_0.unlock_seen_value) or arg_11_0.finish and arg_11_0.conceal == 0)
		elseif arg_11_1 == "canTrigger" then
			return arg_11_0.unlock and (not arg_11_0.finish or arg_11_0.repeatable == 1)
		end
	end

	for iter_10_0 = 1, var_0_3.getLength() do
		local var_10_1 = var_0_3.indexOf(iter_10_0).toObject()

		var_10_1.finish = false
		var_10_1.fighting = false
		var_10_1.next = 0
		var_10_1.preset = 0
		var_10_1.chain = 0
		var_10_1.index = 0
		var_10_1.isLast = false
		var_10_1.isFirst = false
		var_10_1.attack_count = 0
		var_10_1.reset_count = 0
		var_10_1.max = 1
		var_10_1.value = 0
		self._missions[var_10_1.id] = var_10_1

		setmetatable(var_10_1, {
			__index = var_10_0
		})
	end

	for iter_10_1 = 1, var_0_4.getLength() do
		local var_10_2 = var_0_4.indexOf(iter_10_1).toObject()

		var_10_2.finish = false
		var_10_2.fighting = false
		var_10_2.current = 1
		var_10_2.chapter = 0
		var_10_2.missions = {}

		local var_10_3 = 0

		for iter_10_2 = 1, 20 do
			if var_10_2["mission_" .. iter_10_2] and var_10_2["mission_" .. iter_10_2] > 0 then
				var_10_2.missions[iter_10_2] = var_10_2["mission_" .. iter_10_2]

				if var_10_3 == 0 then
					var_10_2.firstMissionId = var_10_2["mission_" .. iter_10_2]
					self._missions[var_10_2["mission_" .. iter_10_2]].isFirst = true
				end

				assert(self._missions[var_10_2["mission_" .. iter_10_2]], "cannot find mission id " .. var_10_2["mission_" .. iter_10_2])

				self._missions[var_10_2["mission_" .. iter_10_2]].chain = var_10_2.id
				self._missions[var_10_2["mission_" .. iter_10_2]].index = iter_10_2

				if var_10_3 > 0 then
					assert(self._missions[var_10_3], "cannot find mission id " .. var_10_3)

					self._missions[var_10_2["mission_" .. iter_10_2]].preset = var_10_3
					self._missions[var_10_3].next = var_10_2["mission_" .. iter_10_2]
				end

				var_10_3 = var_10_2["mission_" .. iter_10_2]
			end
		end

		var_10_2.lastMissionId = var_10_3
		self._missions[var_10_3].isLast = true
		self._chains[var_10_2.id] = var_10_2
	end

	local function var_10_4(arg_12_0, arg_12_1)
		if arg_12_1 == "unlock" then
			if arg_12_0.preset > 0 then
				local var_12_0 = self:getChapter(arg_12_0.preset)

				if var_12_0 and not var_12_0.finish then
					return false
				end
			end

			return true
		end
	end

	for iter_10_3 = 1, var_0_5.getLength() do
		local var_10_5 = var_0_5.indexOf(iter_10_3)
		local var_10_6 = var_10_5.toObject()

		var_10_6.finish = false
		var_10_6.perfect = false
		var_10_6.fighting = false
		var_10_6.index = 0
		var_10_6.preset = 0
		var_10_6.next = 0
		var_10_6.isLast = false
		var_10_6.progressAwarded = false
		var_10_6.res = {}
		var_10_6.chains = {}
		var_10_6.chains[1] = var_10_5.mission_chain_main

		assert(self._chains[var_10_5.mission_chain_main], "cannot find chain id " .. var_10_5.mission_chain_main)

		self._chains[var_10_5.mission_chain_main].chapter = var_10_6.id

		for iter_10_4 = 1, 10 do
			if var_10_6["mission_chain_branch_" .. iter_10_4] and var_10_6["mission_chain_branch_" .. iter_10_4] > 0 then
				var_10_6.chains[iter_10_4 + 1] = var_10_6["mission_chain_branch_" .. iter_10_4]

				assert(self._chains[var_10_6["mission_chain_branch_" .. iter_10_4]], "cannot find chain id " .. var_10_6["mission_chain_branch_" .. iter_10_4])

				self._chains[var_10_6["mission_chain_branch_" .. iter_10_4]].chapter = var_10_6.id
			end
		end

		self._chapters[var_10_6.id] = var_10_6

		for iter_10_5, iter_10_6 in ipairs(var_10_6.chains) do
			for iter_10_7, iter_10_8 in ipairs(self:getChain(iter_10_6).missions) do
				local var_10_7 = self:getMission(iter_10_8).mission_resource

				if var_10_6.res[var_10_7] then
					var_10_6.res[var_10_7][#var_10_6.res[var_10_7] + 1] = iter_10_8
				else
					var_10_6.res[var_10_7] = {
						iter_10_8
					}
				end
			end
		end

		setmetatable(var_10_6, {
			__index = var_10_4
		})
	end
end

function ThemeBioData:_findFirstChapter()
	local var_13_0

	for iter_13_0 = 1, #self._chapterIds do
		local var_13_1 = true

		for iter_13_1 = 1, #self._chapterIds do
			if iter_13_1 ~= iter_13_0 and var_0_5.get(self._chapterIds[iter_13_1]).next_id == self._chapterIds[iter_13_0] then
				var_13_1 = false

				break
			end
		end

		if var_13_1 then
			var_13_0 = self._chapterIds[iter_13_0]

			break
		end
	end

	return var_13_0
end

function ThemeBioData:checkUnlock(arg_14_1, arg_14_2)
	if arg_14_1 == 36 then
		local var_14_0 = self:getMission(arg_14_2)

		assert(var_14_0, "can not find mission " .. arg_14_2 .. " as preset")

		return var_14_0.finish
	elseif arg_14_1 == 37 then
		return g.core.model.User.bagData:isOwnItem(var_0_0.TYPE_BIO, arg_14_2)
	elseif arg_14_1 == 38 then
		return g.core.model.User.knightsData:hasKnightByAdvanceId(arg_14_2)
	elseif arg_14_1 == 39 then
		return g.core.model.User.UniteTokenData:hasLineupTokenById(arg_14_2)
	elseif arg_14_1 == 40 then
		return g.core.model.User:getDressId() == arg_14_2
	elseif arg_14_1 == 41 then
		return arg_14_2 <= g.core.model.User:getFightValue()
	elseif arg_14_1 == 1 then
		return arg_14_2 <= g.core.model.User:getLevel()
	elseif arg_14_1 == 42 then
		if not self._missionConditions[42] then
			return false
		end

		return arg_14_2 <= self._missionConditions[42]
	elseif arg_14_1 == 3 then
		if not self._missionConditions[3] or self._missionConditions[3] == 0 then
			return false
		end

		return arg_14_2 >= self._missionConditions[3]
	elseif arg_14_1 == 4 then
		if not self._missionConditions[4] then
			return false
		end

		return arg_14_2 <= self._missionConditions[4]
	elseif arg_14_1 == 5 then
		if not self._missionConditions[5] then
			return false
		end

		return arg_14_2 <= self._missionConditions[5]
	elseif arg_14_1 == 361 then
		local var_14_1 = self:getMission(arg_14_2)

		return var_14_1 and var_14_1.finish
	elseif arg_14_1 == 362 then
		return g.core.model.User.bagData:isOwnItem(var_0_0.TYPE_THEME_BIO_ITEM, arg_14_2)
	end

	return true
end

function ThemeBioData:getUnlockDesc(arg_15_1, arg_15_2)
	if arg_15_1 == 36 then
		return g.core.lang:get(409120, {
			name = self:getMission(arg_15_2).name
		})
	elseif arg_15_1 == 37 then
		return g.core.lang:get(409121, {
			name = var_0_0:convert({
				type = var_0_0.TYPE_BIO,
				value = arg_15_2
			}).name
		})
	elseif arg_15_1 == 38 then
		return g.core.lang:get(409122, {
			name = g.core.model.User.knightsData:getKnightInfoByAdvanceId(arg_15_2).name
		})
	elseif arg_15_1 == 39 then
		return g.core.lang:get(409123, {
			name = g.core.config.unite_token_info.get(arg_15_2).name
		})
	elseif arg_15_1 == 40 then
		return g.core.lang:get(409124, {
			name = g.core.config.dress_info.get(arg_15_2).name
		})
	elseif arg_15_1 == 41 then
		return g.core.lang:get(409125, {
			num = arg_15_2
		})
	elseif arg_15_1 == 1 then
		return g.core.lang:get(409126, {
			num = arg_15_2
		})
	elseif arg_15_1 == 42 then
		return g.core.lang:get(409127, {
			name = g.core.config.dungeon_chapter_info.get(arg_15_2).name
		})
	elseif arg_15_1 == 3 then
		return g.core.lang:get(409128, {
			num = arg_15_2
		})
	elseif arg_15_1 == 4 then
		return g.core.lang:get(409129, {
			num = arg_15_2
		})
	elseif arg_15_1 == 5 then
		return g.core.lang:get(409130, {
			num = arg_15_2
		})
	elseif arg_15_1 == 361 then
		return g.core.lang:get(409155, {
			name = self:getMission(arg_15_2).name
		})
	elseif arg_15_1 == 362 then
		return g.core.lang:get(409121, {
			name = var_0_0:convert({
				type = var_0_0.TYPE_THEME_BIO_ITEM,
				value = arg_15_2
			}).name
		})
	end
end

function ThemeBioData:getChapterCurPro(arg_16_1)
	local var_16_0 = self:getChapter(arg_16_1)
	local var_16_1 = 0

	for iter_16_0 = 2, #var_16_0.chains do
		for iter_16_1, iter_16_2 in ipairs(self:getChain(var_16_0.chains[iter_16_0]).missions) do
			local var_16_2 = self:getMission(iter_16_2)

			if var_16_2.finish then
				var_16_1 = var_16_1 + var_16_2.weight
			end
		end
	end

	return var_16_1
end

function ThemeBioData:getChapterMaxPro(arg_17_1)
	local var_17_0 = self:getChapter(arg_17_1)
	local var_17_1 = 0

	for iter_17_0 = 2, #var_17_0.chains do
		for iter_17_1, iter_17_2 in ipairs(self:getChain(var_17_0.chains[iter_17_0]).missions) do
			var_17_1 = var_17_1 + self:getMission(iter_17_2).weight
		end
	end

	return var_17_1
end

function ThemeBioData:getMaxChapterId()
	return self._maxChapterId
end

function ThemeBioData:updateMissionInfo(arg_19_1, arg_19_2)
	if not arg_19_1 then
		return
	end

	local var_19_0 = self._missions[arg_19_1.id]

	if not self._missions[arg_19_1.id] then
		return
	end

	self:initInfo()

	local var_19_1 = {}
	local var_19_2 = {}
	local var_19_3 = self:getChain(var_19_0.chain)
	local var_19_4 = self:getChapter(var_19_3.chapter)
	local var_19_5 = var_19_3.id - math.floor(var_19_3.id / 1000) * 1000 == 1

	if arg_19_1.finish then
		if self._mainMissionId and var_19_5 then
			if arg_19_1.id >= self._mainMissionId then
				self._mainMissionId = arg_19_1.id
			end
		elseif var_19_5 then
			self._mainMissionId = arg_19_1.id
		end
	end

	if self._mainMissionId then
		-- block empty
	end

	if not self._maxChapterId or self._maxChapterId < var_19_4.id then
		self._maxChapterId = var_19_4.id
	end

	if arg_19_2 then
		local var_19_6 = self:getChapter(self:getChain(var_19_0.chain).chapter)

		for iter_19_0 = 2, #var_19_6.chains do
			local var_19_7 = self:getChain(var_19_6.chains[iter_19_0])

			if var_19_7.type == 3 then
				for iter_19_1, iter_19_2 in ipairs(var_19_7.missions) do
					if self:getMission(iter_19_2).unlock then
						var_19_1[iter_19_2] = 1
					end
				end
			end

			if var_19_7.type == 2 and self:getMission(var_19_7.missions[1]).unlock then
				var_19_2[var_19_7.missions[1]] = 1
			end

			if var_19_7.type == 4 and self:getMission(var_19_7.missions[1]).unlock then
				var_19_2[var_19_7.missions[1]] = 1
			end
		end

		self._newFastLevel = nil

		if not var_19_0.finish and arg_19_1.finish and var_19_0.type == 1 and var_19_0.repeatable == 1 then
			self._newFastLevel = var_19_0
		end
	end

	if not var_19_0.finish and arg_19_1.finish then
		self._finishNewMission = true
		self._finishNewMissionInfo = var_19_0
	end

	var_19_0.finish = arg_19_1.finish
	var_19_0.attack_count = arg_19_1.attack_count or 0
	var_19_0.reset_count = arg_19_1.reset_count or 0

	if var_19_0.finish then
		self._chapterNew = false
		var_19_0.value = var_19_0.max

		if var_19_0.next > 0 then
			if not self._missions[var_19_0.next].finish then
				self._missions[var_19_0.next].fighting = true
			end

			self._chains[self._missions[var_19_0.next].chain].current = math.max(self._missions[var_19_0.next].index, self._chains[self._missions[var_19_0.next].chain].current)
		else
			local var_19_8 = self._chains[var_19_0.chain]

			var_19_8.finish = true
			var_19_8.fighting = false

			if var_19_8.type == 1 then
				self._chapters[var_19_8.chapter].finish = true
				self._chapters[var_19_8.chapter].fighting = false

				if self._chapters[var_19_8.chapter].next > 0 then
					if not self._chapters[self._chapters[var_19_8.chapter].next].finish then
						self._chapters[self._chapters[var_19_8.chapter].next].fighting = true
					end
				end
			end

			local var_19_9 = true

			for iter_19_3, iter_19_4 in ipairs(self._chapters[var_19_8.chapter].chains) do
				var_19_9 = var_19_9 and self._chains[iter_19_4].finish
			end

			if var_19_9 then
				self._chapters[var_19_8.chapter].perfect = true
			end
		end

		var_19_0.fighting = false
	end

	if arg_19_2 then
		self._newAdvanture = {}
		self._newBranches = {}

		local var_19_10 = self:getChapter(self:getChain(var_19_0.chain).chapter)

		for iter_19_5 = 1, #var_19_10.chains do
			local var_19_11 = self:getChain(var_19_10.chains[iter_19_5])

			if var_19_11.type == 3 then
				for iter_19_6, iter_19_7 in ipairs(var_19_11.missions) do
					if self:getMission(iter_19_7).unlock and var_19_1[iter_19_7] == nil then
						self._newAdvanture[#self._newAdvanture + 1] = iter_19_7
					end
				end
			end

			if var_19_11.type == 2 and self:getMission(var_19_11.missions[1]).unlock and var_19_2[var_19_11.missions[1]] == nil then
				self._newBranches[#self._newBranches + 1] = var_19_11
			end

			if var_19_11.type == 4 and self:getMission(var_19_11.missions[1]).unlock and var_19_2[var_19_11.missions[1]] == nil then
				self._newBranches[#self._newBranches + 1] = var_19_11
			end
		end
	end
end

function ThemeBioData:updateMainInfo(arg_20_1)
	self._inited = true

	self:initInfo()

	if arg_20_1.missions then
		for iter_20_0 = 1, #arg_20_1.missions do
			self:updateMissionInfo(arg_20_1.missions[iter_20_0])
		end
	end

	if arg_20_1.mission_progress_awarded then
		for iter_20_1, iter_20_2 in ipairs(arg_20_1.mission_progress_awarded) do
			self:gotProgressAward(iter_20_2)
		end
	end

	if arg_20_1.chapter_awarded then
		self._chapterAwarded = arg_20_1.chapter_awarded
	end

	self._finishNewMission = false
	self._finishNewMissionInfo = nil
end

function ThemeBioData:hasChapterAwarded(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self._chapterAwarded) do
		if iter_21_1 == arg_21_1 then
			return true
		end
	end
end

function ThemeBioData:hasAchieveAward()
	for iter_22_0, iter_22_1 in pairs(self._chapters) do
		if iter_22_1.finish and not self:hasChapterAwarded(iter_22_1.id) then
			return true
		end
	end

	return false
end

function ThemeBioData:gotChapterAward(arg_23_1)
	self._chapterAwarded[#self._chapterAwarded + 1] = arg_23_1
end

function ThemeBioData:getChapterIds()
	return self._chapterIds
end

function ThemeBioData:updatePresetCondition(arg_25_1)
	if arg_25_1 and next(arg_25_1) then
		for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
			self._missionConditions[iter_25_1.id] = iter_25_1.num
		end
	end
end

function ThemeBioData:gotProgressAward(arg_26_1)
	self:getChapter(arg_26_1).progressAwarded = true
end

function ThemeBioData:isInited()
	return self._inited
end

function ThemeBioData:getMaxMainMissionId()
	return self._mainMissionId
end

function ThemeBioData:getCurChaptersIndex()
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in pairs(self._chapters) do
		if iter_29_1.fighting then
			return iter_29_1.id
		end

		var_29_0 = iter_29_1.id
	end

	return var_29_0
end

function ThemeBioData:getMissionRewardBuyCharpter(arg_30_1, arg_30_2)
	local var_30_0 = self:getChapter(self:getCanFastCharBuyCharpter(arg_30_1, arg_30_2))
	local var_30_1 = {}

	if var_30_0 == nil then
		return var_30_1
	end

	local function var_30_2(arg_31_0)
		if arg_31_0.type == 3 then
			for iter_31_0, iter_31_1 in ipairs(var_0_11) do
				if iter_31_1 == arg_31_0.value then
					return true
				end
			end

			return false
		else
			return false
		end
	end

	for iter_30_0, iter_30_1 in ipairs(var_30_0.chains) do
		for iter_30_2, iter_30_3 in ipairs(self:getChain(iter_30_1).missions) do
			local var_30_3 = self:getMission(iter_30_3)

			if var_30_3.type == 1 and var_30_3.repeatable == 1 and var_30_3.reward_drop > 0 then
				for iter_30_4, iter_30_5 in ipairs(g.core.common.Drops:getGoodsArray(var_30_3.reward_drop)) do
					if iter_30_5.type == 2 or var_30_2(iter_30_5) then
						iter_30_5.finish = var_30_3.finish
						iter_30_5.mid = var_30_3.id

						table.insert(var_30_1, iter_30_5)
					end
				end
			end
		end
	end

	return var_30_1
end

function ThemeBioData:isHaveFinishMission(arg_32_1)
	local var_32_0 = false

	for iter_32_0, iter_32_1 in ipairs(self:getChapter(arg_32_1).chains) do
		for iter_32_2, iter_32_3 in ipairs(self:getChain(iter_32_1).missions) do
			local var_32_1 = self:getMission(iter_32_3)

			if var_32_1.type == 1 and var_32_1.repeatable == 1 and var_32_1.reward_drop > 0 then
				for iter_32_4, iter_32_5 in ipairs(g.core.common.Drops:getGoodsArray(var_32_1.reward_drop)) do
					if iter_32_5.type == 2 and var_32_1.finish then
						var_32_0 = true
					end
				end
			end
		end
	end

	return var_32_0
end

function ThemeBioData:getCanFastCharBuyCharpter(arg_33_1, arg_33_2)
	if arg_33_2 then
		return arg_33_1
	end

	for iter_33_0 = arg_33_1, 1, -1 do
		if self:isHaveFinishMission(iter_33_0) then
			arg_33_1 = iter_33_0

			break
		end
	end

	return arg_33_1
end

function ThemeBioData:checkHasNewChapterOpen()
	local var_34_0 = self:getCurChaptersIndex()

	if var_34_0 > 0 then
		local var_34_1 = self:getChapter(var_34_0)

		if var_34_1.finish then
			return false
		end

		local var_34_2 = g.core.common.Storage:load("theme_biography.json") or {}

		var_34_2.storys = var_34_2.storys or {}

		for iter_34_0, iter_34_1 in ipairs(var_34_2.storys) do
			if iter_34_1 == var_34_1.story then
				return false
			end
		end

		return true
	end

	return false
end

function ThemeBioData:getChapter(arg_35_1)
	if not arg_35_1 then
		assert(arg_35_1, "error chapter id: " .. arg_35_1)

		return
	end

	self:initInfo()
	assert(self._chapters[arg_35_1], "cannot find chapter info, id is " .. arg_35_1)

	return self._chapters[arg_35_1]
end

function ThemeBioData:getMission(arg_36_1)
	if not arg_36_1 then
		return
	end

	self:initInfo()

	return self._missions[arg_36_1]
end

function ThemeBioData:getChain(arg_37_1)
	if not arg_37_1 then
		return
	end

	self:initInfo()

	return self._chains[arg_37_1]
end

function ThemeBioData:updateRedInfo(arg_38_1)
	if not arg_38_1.biography_hint then
		return
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
		self:updateMainInfo(arg_38_1.biography_hint)
		self:updateInvited(arg_38_1.biography_hint.invitations)
	end
end

function ThemeBioData:isNew()
	return self._chapterNew
end

function ThemeBioData:getNewUnlcokFast()
	return self._newFastLevel
end

function ThemeBioData:getUnlockChapters(arg_41_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
		return
	end

	self:initInfo()

	return self._unlockChapters[arg_41_1]
end

function ThemeBioData:getFinishNewMission()
	return self._finishNewMission, self._finishNewMissionInfo
end

function ThemeBioData:setFinishNewMission()
	self._finishNewMission = false
	self._finishNewMissionInfo = nil
end

function ThemeBioData:isThemeBioChapterNew(arg_44_1)
	if arg_44_1 and arg_44_1.id then
		if not self:isThemeBioChapterOpen(arg_44_1.id) then
			return false
		end

		if self:judgeBioChapterNewSetting(arg_44_1.id) then
			return true
		end
	end

	return false
end

function ThemeBioData:_checkUnlock(arg_45_1)
	local var_45_0 = self:getThemeBioChapterStartTime(arg_45_1.number)

	if var_45_0 > 0 and g.core.common.ServerTime:getTime() < var_45_0 then
		return var_0_2.BIO_CHAPTER_LOCK
	end

	if not arg_45_1.unlock then
		return var_0_2.BIO_CHAPTER_BEFORE
	end

	return var_0_2.BIO_CHAPTER_UNLOCK
end

function ThemeBioData:getChapterUnlockStateAndTip(arg_46_1)
	if not arg_46_1 then
		return
	end

	local var_46_0 = self:getThemeBioChapterStartTime(arg_46_1.number)
	local var_46_1 = g.core.common.ServerTime:getTime()
	local var_46_2 = ""

	if var_46_0 > 0 and var_46_1 < var_46_0 then
		local var_46_4 = g.core.common.ServerTime:getDeltaDays(var_46_1, var_46_0)

		var_46_2 = var_46_4 > 1 and g.core.lang:get(409136, {
			num = var_46_4
		}) or g.core.lang:get(409137)

		return var_0_2.BIO_CHAPTER_LOCK, var_46_2, var_46_2
	end

	if not arg_46_1.unlock and arg_46_1.preset > 0 then
		local var_46_5 = self:getChapter(arg_46_1.preset)

		return var_0_2.BIO_CHAPTER_BEFORE, g.core.lang:get(409138, {
			name = var_46_5.name
		}), (g.core.lang:get(409139, {
			name = var_46_5.name
		}))
	end

	return var_0_2.BIO_CHAPTER_UNLOCK
end

function ThemeBioData:_getBioChapterNewSettingStr(arg_47_1)
	return (table.concat({
		g.core.platform.ServerListProxy:getSelectedServer().id,
		g.core.model.User:getId(),
		self._activeValue,
		arg_47_1
	}, "_"))
end

function ThemeBioData:setBioChapterNewSettingRecord(arg_48_1)
	local var_48_0 = self:_getBioChapterNewSettingStr(arg_48_1)
	local var_48_1 = g.core.common.Storage:load("ThemeBioChapterRecord.json") or {}

	if not var_48_1[var_48_0] then
		var_48_1[var_48_0] = "1"

		g.core.common.Storage:save("ThemeBioChapterRecord.json", var_48_1)
	end
end

function ThemeBioData:judgeBioChapterNewSetting(arg_49_1)
	if not arg_49_1 then
		return false
	end

	if not (g.core.common.Storage:load("ThemeBioChapterRecord.json") or {})[self:_getBioChapterNewSettingStr(arg_49_1)] then
		return true
	end

	return false
end

function ThemeBioData:judgeBioChapterRecordByType(arg_50_1, arg_50_2)
	arg_50_2 = arg_50_2 or ""

	if not arg_50_1 then
		return false
	end

	if not (g.core.common.Storage:load("ThemeBioChapterRecord.json") or {})[self:_getBioChapterNewSettingStr(arg_50_1) .. arg_50_2] then
		return true
	end

	return false
end

function ThemeBioData:setBioChapterRecordByType(arg_51_1, arg_51_2)
	arg_51_2 = arg_51_2 or ""

	local var_51_0 = self:_getBioChapterNewSettingStr(arg_51_1) .. arg_51_2
	local var_51_1 = g.core.common.Storage:load("ThemeBioChapterRecord.json") or {}

	if not var_51_1[var_51_0] then
		var_51_1[var_51_0] = "1"

		g.core.common.Storage:save("ThemeBioChapterRecord.json", var_51_1)
	end
end

function ThemeBioData:checkPlayedChapterPassEffect(arg_52_1, arg_52_2)
	if not arg_52_1 then
		return false
	end

	if (g.core.common.Storage:load("ThemeBioChapterRecord.json") or {})[self:_getBioChapterNewSettingStr(arg_52_1)] == arg_52_2 then
		return true
	end

	return false
end

function ThemeBioData:setPlayedChapterPassEffect(arg_53_1, arg_53_2)
	if not arg_53_1 then
		return false
	end

	local var_53_0 = g.core.common.Storage:load("ThemeBioChapterRecord.json") or {}

	var_53_0[self:_getBioChapterNewSettingStr(arg_53_1)] = arg_53_2

	g.core.common.Storage:save("ThemeBioChapterRecord.json", var_53_0)
end

function ThemeBioData:getCurChapterMainAndSubTaskState(arg_54_1)
	if not arg_54_1 then
		return
	end

	local var_54_0 = arg_54_1.chains

	if not self:getChain(arg_54_1.chains[1]).finish then
		return var_0_2.BIO_TASK_STATE.MAIN_TASK_UN_FINISH
	end

	for iter_54_0 = 2, #var_54_0 do
		for iter_54_1, iter_54_2 in ipairs(self:getChain(var_54_0[iter_54_0]).missions) do
			if not self:getMission(iter_54_2).finish then
				return var_0_2.BIO_TASK_STATE.SUB_TASK_UN_FINISH
			end
		end
	end

	return var_0_2.BIO_TASK_STATE.ALL_FINISH
end

function ThemeBioData:getInteractByBindAndChapterId(arg_55_1, arg_55_2)
	local var_55_0 = var_0_6.get(arg_55_1, arg_55_2)

	if var_55_0 then
		return var_55_0.toObject()
	end
end

function ThemeBioData:updateVoteInfo(arg_56_1)
	if arg_56_1.vote_ids then
		self._myVoteMap = {}

		for iter_56_0, iter_56_1 in ipairs(arg_56_1.vote_ids) do
			self._myVoteMap[iter_56_1.id] = {
				voteOption = iter_56_1.key,
				rightOption = iter_56_1.status
			}
		end
	end

	if arg_56_1.scene_vote then
		self._serverVoteMap = {}

		for iter_56_2, iter_56_3 in ipairs(arg_56_1.scene_vote) do
			self._serverVoteMap[iter_56_3.id] = self._serverVoteMap[iter_56_3.id] or {}
			self._serverVoteMap[iter_56_3.id][iter_56_3.key] = self._serverVoteMap[iter_56_3.id][iter_56_3.key] or 0
			self._serverVoteMap[iter_56_3.id][iter_56_3.key] = iter_56_3.status
		end
	end
end

function ThemeBioData:onVote(arg_57_1)
	if arg_57_1.vote_id then
		self._myVoteMap[arg_57_1.vote_id] = {
			voteOption = arg_57_1.vote_option,
			rightOption = arg_57_1.right_option
		}
		self._serverVoteMap[arg_57_1.vote_id] = self._serverVoteMap[arg_57_1.vote_id] or {}
		self._serverVoteMap[arg_57_1.vote_id][arg_57_1.vote_option] = self._serverVoteMap[arg_57_1.vote_id][arg_57_1.vote_option] or 0
		self._serverVoteMap[arg_57_1.vote_id][arg_57_1.vote_option] = self._serverVoteMap[arg_57_1.vote_id][arg_57_1.vote_option] + 1
	end
end

function ThemeBioData:hasVoteActivity()
	for iter_58_0 = 1, #self._chapterIds do
		if var_0_5.get(self._chapterIds[iter_58_0]).vote_group > 0 then
			return true
		end
	end

	return false
end

function ThemeBioData:getVoteGroupInfo(arg_59_1)
	if not arg_59_1 then
		return nil
	end

	return var_0_8.get(self._chapters[arg_59_1].vote_group)
end

function ThemeBioData:getVoteInfoByGroup(arg_60_1)
	return (var_0_9.match(function(arg_61_0)
		return arg_61_0.vote_group == arg_60_1
	end))
end

function ThemeBioData:getVoteInfoById(arg_62_1)
	return var_0_9.get(arg_62_1)
end

function ThemeBioData:getChapterIdByVoteId(arg_63_1)
	local var_63_0 = self:getVoteData()

	for iter_63_0 = 1, #var_63_0 do
		if var_63_0[iter_63_0].voteInfo.id == arg_63_1 then
			return var_63_0[iter_63_0].chapterId
		end
	end

	return 0
end

function ThemeBioData:showVoteBtn(arg_64_1)
	local var_64_0 = self:getVoteGroupInfo(arg_64_1)

	return self:checkUnlock(var_64_0.unlock_seen_type, var_64_0.unlock_seen_value)
end

function ThemeBioData:getVoteEntranceInfo()
	return
end

function ThemeBioData:getVoteData()
	local var_66_0 = {}

	for iter_66_0 = 1, #self._chapterIds do
		local var_66_1 = var_0_5.get(self._chapterIds[iter_66_0])

		if var_66_1.vote_group > 0 then
			local var_66_2 = self:getVoteInfoByGroup(var_66_1.vote_group)

			for iter_66_1 = 1, #var_66_2 do
				var_66_0[#var_66_0 + 1] = {
					voteInfo = var_66_2[iter_66_1],
					chapterId = self._chapterIds[iter_66_0]
				}
			end
		end
	end

	table.sort(var_66_0, function(arg_67_0, arg_67_1)
		if arg_67_0.chapterId ~= arg_67_1.chapterId then
			return arg_67_0.chapterId < arg_67_1.chapterId
		end

		return arg_67_0.voteInfo.id < arg_67_1.voteInfo.id
	end)

	return var_66_0
end

function ThemeBioData:hasFinishChapter(arg_68_1)
	return self._chapters[arg_68_1] and self._chapters[arg_68_1].finish
end

function ThemeBioData:getThemeBioVoteStartTime(arg_69_1)
	if not self._activityInfo then
		return 0
	end

	return (self._voteTimeMap[arg_69_1] or nil) and (self._voteTimeMap[arg_69_1].startTime or 0)
end

function ThemeBioData:isVoteOpen(arg_70_1)
	local var_70_0 = self:getThemeBioVoteStartTime(arg_70_1)

	return var_70_0 > 0 and var_70_0 < g.core.common.ServerTime:getTime()
end

function ThemeBioData:hasVoted(arg_71_1)
	return checkbool(self._myVoteMap[arg_71_1])
end

function ThemeBioData:isVotedByVoteIdAndOption(arg_72_1, arg_72_2)
	if not self._myVoteMap[arg_72_1] then
		return false
	end

	return self._myVoteMap[arg_72_1].voteOption == arg_72_2
end

function ThemeBioData:getMyVotedInfo(arg_73_1)
	if not self._myVoteMap[arg_73_1.id] then
		return
	end

	local var_73_0 = self._myVoteMap[arg_73_1.id].voteOption
	local var_73_1 = {}

	for iter_73_0, iter_73_1 in ipairs((self:getOptionInfo(arg_73_1))) do
		if iter_73_1.optionVote == var_73_0 then
			var_73_1 = iter_73_1

			break
		end
	end

	return var_73_1
end

function ThemeBioData:isRightByVoteIdAndOption(arg_74_1, arg_74_2)
	if not self._myVoteMap[arg_74_1] then
		return false
	end

	return self._myVoteMap[arg_74_1].rightOption == arg_74_2
end

function ThemeBioData:getRightOption(arg_75_1)
	local var_75_0 = self._myVoteMap[arg_75_1.id].rightOption
	local var_75_1 = {}
	local var_75_2 = self._myVoteMap[arg_75_1.id].voteOption == self._myVoteMap[arg_75_1.id].rightOption

	for iter_75_0, iter_75_1 in ipairs((self:getOptionInfo(arg_75_1))) do
		if iter_75_1.optionVote == var_75_0 then
			var_75_1 = iter_75_1

			break
		end
	end

	return var_75_1, var_75_2
end

function ThemeBioData:getAvgIdByVoteInfo(arg_76_1)
	local var_76_0 = self:getRightOption(arg_76_1)

	if not next(var_76_0) then
		var_76_0 = self:getMyVotedInfo(arg_76_1)
	end

	return (var_76_0 or nil) and (var_76_0.optionAvg or 0)
end

function ThemeBioData:isUnlockedEnding(arg_77_1, arg_77_2)
	local var_77_0 = self:getVoteInfoByGroup(var_0_9.get(arg_77_1).vote_group)

	for iter_77_0 = 1, #var_77_0 do
		if arg_77_1 ~= var_77_0[iter_77_0].id and self:isVotedByVoteIdAndOption(var_77_0[iter_77_0].id, arg_77_2) then
			return true
		end
	end

	return false
end

function ThemeBioData:isVoteOnging(arg_78_1)
	if not self._activityInfo then
		return false
	end

	local var_78_0 = self._voteTimeMap[arg_78_1] or {}
	local var_78_1 = var_78_0.startTime or 0
	local var_78_2 = var_78_0.endTime or 0
	local var_78_3 = g.core.common.ServerTime:getTime()

	return var_78_1 < var_78_3 and var_78_3 < var_78_2
end

function ThemeBioData:isVoteResultRevealed(arg_79_1)
	if not self._activityInfo then
		return false
	end

	return ((self._voteTimeMap[arg_79_1] or {}).endTime or 0) < g.core.common.ServerTime:getTime()
end

function ThemeBioData:hasOnlyOneOption(arg_80_1)
	local var_80_0 = 0
	local var_80_1 = arg_80_1.toObject()

	for iter_80_0 = 1, 4 do
		if var_80_1["option_" .. iter_80_0] > 0 then
			var_80_0 = var_80_0 + 1
		end

		if var_80_0 > 1 then
			break
		end
	end

	return var_80_0 == 1
end

function ThemeBioData:hasNoRightOption(arg_81_1)
	return self._myVoteMap[arg_81_1.id].rightOption == 0
end

function ThemeBioData:isVoteRight(arg_82_1)
	local var_82_0 = self._myVoteMap[arg_82_1] or {}

	return var_82_0.voteOption and var_82_0.voteOption == var_82_0.rightOption
end

function ThemeBioData:getOptionInfo(arg_83_1)
	local var_83_0 = {}

	for iter_83_0, iter_83_1, iter_83_2 in arg_83_1.gmatch({
		"option_%d+",
		"option_text_%d+",
		"ending_%d+",
		"avg_%d"
	}) do
		if iter_83_2[1] > 0 then
			var_83_0[#var_83_0 + 1] = {
				optionVote = iter_83_1,
				optionNo = iter_83_2[1],
				optionTxt = iter_83_2[2],
				optionEnding = iter_83_2[3],
				optionAvg = iter_83_2[4]
			}
		end
	end

	return var_83_0
end

function ThemeBioData:needShowVotePercent(arg_84_1)
	return #self:getVoteInfoByGroup(var_0_9.get(arg_84_1).vote_group) == 1
end

function ThemeBioData:getVotePercent(arg_85_1, arg_85_2)
	local var_85_1 = 0
	local var_85_2 = 0

	if not self._serverVoteMap[arg_85_1] then
		return 0
	end

	for iter_85_0, iter_85_1 in pairs(self._serverVoteMap[arg_85_1]) do
		if iter_85_0 == arg_85_2 then
			var_85_1 = var_85_1 + iter_85_1
		end

		var_85_2 = iter_85_1 + var_85_2
	end

	return (var_85_2 > 0 or nil) and string.format("%.2f", var_85_1 * 100 / var_85_2)
end

function ThemeBioData:getVoteResultLastTime(arg_86_1)
	return (self._voteTimeMap[arg_86_1.id] or {}).endTime or 0
end

function ThemeBioData:hasNewVoteResult()
	local var_87_0 = self:getVoteData()

	for iter_87_0 = 1, #var_87_0 do
		if self:isVoteOpen(var_87_0[iter_87_0].voteInfo.id) and self:hasVoted(var_87_0[iter_87_0].voteInfo.id) and self:isVoteResultRevealed(var_87_0[iter_87_0].voteInfo.id) and self:judgeBioChapterRecordByType(var_87_0[iter_87_0].voteInfo.id, "_NEW_RESULT") then
			return true
		end
	end

	return false
end

function ThemeBioData:needGotoLastVote()
	local var_88_0 = self:getVoteData()

	for iter_88_0 = 1, #var_88_0 do
		if self:hasOnlyOneOption(var_88_0[iter_88_0].voteInfo) then
			if not self:isVoteOpen(var_88_0[iter_88_0].voteInfo.id) then
				return false
			end

			if not self:hasFinishChapter(var_88_0[iter_88_0].chapterId) then
				return false
			end

			if var_88_0[iter_88_0].voteInfo.pre_vote > 0 and not self:hasVoted(var_88_0[iter_88_0].voteInfo.pre_vote) then
				return false
			end

			if self:hasVoted(var_88_0[iter_88_0].voteInfo.id) then
				return false
			end
		end
	end

	return true
end

function ThemeBioData:hasNewBioItemByItemId(arg_89_1)
	if not var_0_1:isOwnItem(var_0_0.TYPE_THEME_BIO_ITEM, arg_89_1) then
		return false
	end

	return (self:judgeBioChapterRecordByType(arg_89_1, "_NEW_ITEM"))
end

function ThemeBioData:hasNewBioItemByChapterId(arg_90_1)
	if not self._chapters[arg_90_1] then
		return false
	end

	for iter_90_0, iter_90_1 in var_0_10.ipairs() do
		if arg_90_1 == iter_90_1.chapter_id and self:hasNewBioItemByItemId(iter_90_1.id) then
			return true
		end
	end

	return false
end

function ThemeBioData:hasNewBioItem(arg_91_1)
	arg_91_1 = arg_91_1 or {}

	if arg_91_1.itemId then
		return self:hasNewBioItemByItemId(arg_91_1.itemId)
	elseif arg_91_1.chapterId then
		return self:hasNewBioItemByChapterId(arg_91_1.chapterId)
	else
		local var_91_0 = self:getChapterIds()

		for iter_91_0 = 1, #var_91_0 do
			if self:hasNewBioItemByChapterId(var_91_0[iter_91_0]) then
				return true
			end
		end
	end

	return false
end

return ThemeBioData
