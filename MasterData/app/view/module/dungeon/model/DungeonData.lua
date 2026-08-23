local DungeonData = class("DungeonData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.dungeon_land_info
local var_0_2 = g.core.config.dungeon_chapter_info
local var_0_3 = g.core.config.dungeon_chest_info
local var_0_4 = g.core.config.dungeon_stage_info
local var_0_5 = g.core.const.ConstMgr.DungeonConst
local var_0_6 = g.core.config.presetmail_info
local ChapterData = import(".ChapterData")
local StageData = import(".StageData")

function DungeonData:ctor()
	self._debugEditor = var_0_5.DEBUG_EDITOR and device.isWindowsDebug()

	self:initData()
end

function DungeonData:initData()
	self._chapterStageIds = {}
	self._chapters = {}
	self._stages = {}
	self._registAwards = {}
	self._lastPassedChapterId = 0
	self._lastUnlockChapterId = 1
	self._landId = 1
	self._newStageId = 0
	self._newChapterId = 0
	self._newLandId = 0
	self._battleInfo = {}
	self._isAllPass = false
	self._dataInited = false
	self._finishAchieve = {}
	self._lastResetTime = 0
	self._maxEnterLand = 0
	self._isHidePerfectLand = false
	self._interactionIdByFirstChapterList = {}
	self._displayVersion = 1

	self:_initChapterStageIds()
end

function DungeonData:_initChapterStageIds()
	self._chapterStageIds = {}

	for iter_3_0 = 1, var_0_2.getLength() do
		local var_3_0 = var_0_2.indexOf(iter_3_0)

		self._chapterStageIds[var_3_0.id] = self._chapterStageIds[var_3_0.id] or {}

		for iter_3_1 = 1, g.core.const.ConstMgr.DungeonConst.MAX_STAGE_COUNT do
			if var_3_0["stage_" .. iter_3_1] > 0 then
				table.insert(self._chapterStageIds[var_3_0.id], var_3_0["stage_" .. iter_3_1])
			end
		end
	end

	self:_initPreRegistrationConfig()
end

function DungeonData:_initPreRegistrationConfig()
	self._registAwards = {}

	local var_4_0 = var_0_6.getLength()

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = var_0_6.indexOf(iter_4_0)

		if var_4_1.type == 1 and g.core.utils.Tools.isOpIdMatchWithInfo(var_4_1, var_0_6) then
			local var_4_2 = self._registAwards
			local var_4_3 = {
				id = var_4_1.id
			}

			if var_0_6.hasKey("name") then
				var_4_3.name = var_4_1.name or ""
			end

			var_4_3.dropId = var_4_1.drop
			var_4_3.mailId = var_4_1.mail_id
			var_4_3.isBig = var_4_1.id == var_4_0

			table.insert(var_4_2, var_4_3)
		end

		if next(self._registAwards) then
			table.sort(self._registAwards, function(arg_5_0, arg_5_1)
				return arg_5_0.id > arg_5_1.id
			end)
		end
	end
end

function DungeonData:initChapterList(arg_6_1)
	self._lastResetTime = g.core.common.ServerTime:getTime()
	self._chapters = {}
	self._stages = {}

	self:updateDungeonAchievement(arg_6_1.flags)

	if arg_6_1.stages then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.stages) do
			self._stages[iter_6_1.id] = StageData.new(iter_6_1)
		end
	end

	for iter_6_2 = 1, var_0_2.getLength() do
		local var_6_0 = var_0_2.indexOf(iter_6_2)

		self._chapters[var_6_0.id] = ChapterData.new(var_6_0.id)

		if self._interactionIdByFirstChapterList[var_6_0.interaction_id] == nil then
			self._interactionIdByFirstChapterList[var_6_0.interaction_id] = var_6_0
		end
	end

	if arg_6_1.chapters then
		for iter_6_3, iter_6_4 in ipairs(arg_6_1.chapters) do
			self:_updateChapterData(iter_6_4.id, iter_6_4)
		end
	end

	for iter_6_5, iter_6_6 in pairs(self._chapters) do
		self:_updateChapterStates(iter_6_5)
	end

	self:updateLastChapterAndLand()

	self._dataInited = true
end

function DungeonData:_updateChapterStates(arg_7_1)
	local var_7_0 = self._chapters[arg_7_1]

	if not self._chapters[arg_7_1] then
		var_7_0 = ChapterData.new(arg_7_1)
		self._chapters[arg_7_1] = var_7_0
	end

	var_7_0:setStarNum((self:_calcChapterStar(arg_7_1)))
	var_7_0:setIsPassed((self:_checkChapterPassed(arg_7_1)))
end

function DungeonData:updateLastChapterAndLand()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self._chapters or {}) do
		local var_8_1 = var_0_2.get(iter_8_0)

		if iter_8_1:isPassed() then
			if not var_8_1.next_id or var_8_1.next_id == 0 then
				self._lastPassedChapterId = iter_8_0
				self._lastUnlockChapterId = iter_8_0
				var_8_0 = var_8_1
				self._maxEnterLand = var_8_1.land_id

				break
			elseif self._chapters[var_8_1.next_id] and not self._chapters[var_8_1.next_id]:isPassed() then
				self._lastPassedChapterId = iter_8_0

				local var_8_2 = var_0_2.get(var_8_1.next_id)

				if self:isLevelReach(var_8_1.next_id) then
					self._lastUnlockChapterId = var_8_1.next_id
					var_8_0 = var_8_2
				else
					self._lastUnlockChapterId = iter_8_0
					var_8_0 = var_0_2.get(iter_8_0)
				end

				self._maxEnterLand = var_8_2.land_id

				break
			end
		end
	end

	if self._lastPassedChapterId == 0 then
		var_8_0 = var_0_2.indexOf(1)
		self._lastUnlockChapterId = var_8_0.id
		self._maxEnterLand = var_8_0.land_id
	end

	self._landId = var_8_0.land_id
end

function DungeonData:updateDungeonAchievement(arg_9_1)
	self._finishAchieve = {}

	local var_9_0 = arg_9_1 or {}

	for iter_9_0 = 1, #var_9_0 do
		local var_9_1 = {
			id = math.floor(var_9_0[iter_9_0] / 10)
		}

		self._finishAchieve[var_9_1.id] = self._finishAchieve[var_9_1.id] or {}
		var_9_1.index = var_9_0[iter_9_0] % 10

		table.insert(self._finishAchieve[var_9_1.id], var_9_1.index)
	end
end

function DungeonData:_calcChapterStar(arg_10_1)
	local var_10_0 = 0

	if self._chapterStageIds[arg_10_1] then
		for iter_10_0 = 1, #self._chapterStageIds[arg_10_1] do
			if self._stages[self._chapterStageIds[arg_10_1][iter_10_0]] then
				var_10_0 = var_10_0 + self._stages[self._chapterStageIds[arg_10_1][iter_10_0]]:getStar()
			end
		end
	end

	return var_10_0
end

function DungeonData:_checkChapterPassed(arg_11_1)
	if not self._chapterStageIds[arg_11_1] then
		return false
	end

	if self._stages[self._chapterStageIds[arg_11_1][#self._chapterStageIds[arg_11_1]]] and self._stages[self._chapterStageIds[arg_11_1][#self._chapterStageIds[arg_11_1]]]:isPassed() then
		return true
	else
		return false
	end
end

function DungeonData:_updateStageData(arg_12_1, arg_12_2)
	if not arg_12_1 or arg_12_1 <= 0 or not arg_12_2 then
		return
	end

	local var_12_0 = self._stages[arg_12_1]

	if self._stages[arg_12_1] then
		if arg_12_2.star < var_12_0:getStar() then
			arg_12_2.star = var_12_0:getStar()
		end

		var_12_0:set(arg_12_2)
	else
		self._stages[arg_12_1] = StageData.new(arg_12_2)
	end
end

function DungeonData:_updateChapterData(arg_13_1, arg_13_2)
	if not arg_13_1 or arg_13_1 <= 0 or not arg_13_2 then
		return
	end

	if self._chapters[arg_13_1] then
		self._chapters[arg_13_1]:set(arg_13_2)
	else
		self._chapters[arg_13_1] = ChapterData.new(arg_13_1, arg_13_2)
	end
end

function DungeonData:updateStageExecuteResult(arg_14_1)
	local var_14_0 = clone(arg_14_1.stage)
	local var_14_1 = arg_14_1.is_win

	self._battleInfo.stageId = arg_14_1.id
	self._battleInfo.isWin = var_14_1
	self._battleInfo.isFirst = arg_14_1.is_first or false

	if (not self._stages[arg_14_1.id] or self._stages[arg_14_1.id]:getStar() == 0) and var_14_1 then
		self:updateNewId(arg_14_1.id)
	end

	self:_updateStageData(arg_14_1.id, var_14_0)
	self:_updateChapterStates(var_0_4.get(arg_14_1.id).chapter_id)

	if self._newChapterId > 0 or self._isAllPass then
		self:updateLastChapterAndLand()
	end
end

function DungeonData:resetBattleInfo()
	self._battleInfo = {}
end

function DungeonData:updateNewId(arg_16_1)
	local var_16_0 = var_0_4.get(arg_16_1)
	local var_16_1 = var_0_2.get(var_16_0.chapter_id)

	for iter_16_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_STAGE_COUNT do
		if var_16_1["stage_" .. iter_16_0] == arg_16_1 then
			if iter_16_0 < g.core.const.ConstMgr.DungeonConst.MAX_STAGE_COUNT then
				self._newStageId = var_16_1["stage_" .. iter_16_0 + 1]

				break
			else
				self._newStageId = 0
			end
		end
	end

	if self._newStageId > 0 then
		self._newChapterId = 0
		self._newLandId = 0
	else
		self._newChapterId = var_16_1.next_id

		if self._newChapterId > 0 then
			self._newStageId = var_0_2.get(self._newChapterId).stage_1

			local var_16_2 = var_0_2.get(self._newChapterId)

			if var_0_2.get(var_16_0.chapter_id).land_id ~= var_16_2.land_id then
				self._newLandId = var_16_2.land_id
			end
		else
			self._newLandId = 0
		end
	end

	self._isAllPass = self._newStageId == 0 and self._newChapterId == 0 and self._newLandId == 0
end

function DungeonData:getNewStageId()
	return self._newStageId
end

function DungeonData:getNewChapterId()
	return self._newChapterId
end

function DungeonData:getNewLandId()
	return self._newLandId
end

function DungeonData:resetNewStageId()
	self._newStageId = 0
end

function DungeonData:resetNewChapterId()
	self._newChapterId = 0
end

function DungeonData:resetNewLandId()
	self._newLandId = 0
end

function DungeonData:isAllPassed()
	return self._isAllPass
end

function DungeonData:updateStageCountByBlitz(arg_24_1)
	if self._stages[arg_24_1.id] then
		self._stages[arg_24_1.id]:setChallengeCount((self._stages[arg_24_1.id]:getChallengeCount() or 0) + arg_24_1.num)
	end
end

function DungeonData:updateStarChestResult(arg_25_1)
	self:_updateChapterData(arg_25_1.id, arg_25_1.chapter)
end

function DungeonData:updateStageResetResult(arg_26_1)
	self:_updateStageData(arg_26_1.id, arg_26_1.stage)
end

function DungeonData:getTotalStars()
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(self._chapters) do
		var_27_0 = var_27_0 + iter_27_1:getStarNum()
	end

	return var_27_0
end

function DungeonData:getChapterStar(arg_28_1)
	return self._chapters[arg_28_1] and self._chapters[arg_28_1]:getStarNum() or 0
end

function DungeonData:getLandStar(arg_29_1)
	local var_29_0 = var_0_1.get(arg_29_1)
	local var_29_1 = 0

	for iter_29_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND do
		if var_29_0["chapter_" .. iter_29_0] > 0 and self:isChapterUnlocked(var_29_0["chapter_" .. iter_29_0]) then
			var_29_1 = var_29_1 + (self._chapters[var_29_0["chapter_" .. iter_29_0]] and self._chapters[var_29_0["chapter_" .. iter_29_0]]:getStarNum() or 0)
		end
	end

	return var_29_1
end

function DungeonData:isDataInited()
	return self._dataInited
end

function DungeonData:isChapterUnlocked(arg_31_1)
	return self:isLevelReach(arg_31_1) and (self:isChapterPassed(arg_31_1) or arg_31_1 == self:getLastUnlockChapter())
end

function DungeonData:getChapterPassedState(arg_32_1)
	return (self:isChapterUnlocked(arg_32_1) or nil) and (not self:isChapterPassed(arg_32_1) and g.core.const.ConstMgr.DungeonConst.CHAPTER_STATE.NOT_PASS or self:getChapterStar(arg_32_1) < var_0_2.get(arg_32_1).total_star and g.core.const.ConstMgr.DungeonConst.CHAPTER_STATE.NOT_MAXSTAR or g.core.const.ConstMgr.DungeonConst.CHAPTER_STATE.MAXSTAR)
end

function DungeonData:isChapterPassed(arg_33_1)
	assert(arg_33_1 ~= 0, "chapterId can't be zero")

	return self._chapters[arg_33_1] and self._chapters[arg_33_1]:isPassed() or false
end

function DungeonData:isChapterMaxStar(arg_34_1)
	return self._chapters[arg_34_1] and self._chapters[arg_34_1]:isMaxStar() or false
end

function DungeonData:getStageStar(arg_35_1)
	return self._stages[arg_35_1] and self._stages[arg_35_1]:getStar() or 0
end

function DungeonData:getStageResetNum(arg_36_1)
	return self._stages[arg_36_1] and self._stages[arg_36_1]:getResetCount() or 0
end

function DungeonData:getStageRemainChallengeNum(arg_37_1)
	return var_0_4.get(arg_37_1).attempts - (self._stages[arg_37_1] and self._stages[arg_37_1]:getChallengeCount() or 0)
end

function DungeonData:getLastUnlockedStage(arg_38_1)
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs((self:getStageIds(arg_38_1))) do
		if not self:isStageUnlocked(iter_38_1) then
			break
		end

		var_38_0 = iter_38_1
	end

	return var_38_0
end

function DungeonData:getLastPassedStage(arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs((self:getStageIds(arg_39_1))) do
		if not self:isStagePassed(iter_39_1) then
			break
		end

		var_39_0 = iter_39_1
	end

	return var_39_0
end

function DungeonData:getStageIndex(arg_40_1)
	if arg_40_1 <= 0 then
		return 1
	end

	local var_40_0 = self:getStageIds(var_0_4.get(arg_40_1).chapter_id)

	for iter_40_0 = 1, #var_40_0 do
		if var_40_0[iter_40_0] == arg_40_1 then
			return iter_40_0
		end
	end
end

function DungeonData:isLevelReach(arg_41_1)
	local var_41_0 = var_0_2.fetch(arg_41_1)

	return (var_41_0 or nil) and g.core.model.User:getLevel() >= var_41_0.condition_level
end

function DungeonData:isStageUnlocked(arg_42_1)
	if arg_42_1 < 1 then
		return true
	end

	local var_42_0 = var_0_4.get(arg_42_1)

	return self:isLevelReach(var_42_0.chapter_id) and (var_42_0.preset_stage == 0 or self:isStagePassed(var_42_0.preset_stage))
end

function DungeonData:isStagePassed(arg_43_1)
	return self._stages[arg_43_1] and self._stages[arg_43_1]:isPassed() or false
end

function DungeonData:isChapterNextStagePassed(arg_44_1)
	local var_44_0 = var_0_2.get(var_0_4.get(arg_44_1).chapter_id)

	for iter_44_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_STAGE_COUNT do
		if var_44_0["stage_" .. iter_44_0] > 0 then
			local var_44_1 = var_0_4.get(var_44_0["stage_" .. iter_44_0])

			if var_44_1.preset_stage == arg_44_1 then
				return self:isStagePassed(var_44_1.id)
			end
		end
	end

	return true
end

function DungeonData:isStageChestUnlocked(arg_45_1)
	if arg_45_1 <= 0 then
		return false
	end

	local var_45_0 = var_0_3.get(arg_45_1).unlock

	return var_45_0 == 0 or self:isStagePassed(var_45_0)
end

function DungeonData:isStageChestSeen(arg_46_1)
	if arg_46_1 == 0 then
		return true
	end

	local var_46_0 = var_0_3.get(arg_46_1).unlock_seen

	return var_46_0 == 0 or self:isStagePassed(var_46_0)
end

function DungeonData:isBossStage(arg_47_1, arg_47_2)
	if not arg_47_1 or arg_47_1 <= 0 then
		return false
	end

	local var_47_0 = {}

	var_47_0 = arg_47_2 and self:getStageIds(arg_47_2) or self:getStageIds(var_0_4.get(arg_47_1).chapter_id)

	if next(var_47_0) and arg_47_1 == var_47_0[#var_47_0] then
		return true
	end

	return false
end

function DungeonData:canGetStarChest(arg_48_1)
	if not self._chapters[arg_48_1] then
		return false
	end

	for iter_48_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_STAR_CHEST_COUNT do
		if self._chapters[arg_48_1]:canGetStarChest(iter_48_0) then
			return true
		end
	end

	return false
end

function DungeonData:isShowGetStarChestRedPoint(arg_49_1)
	if not arg_49_1.id then
		return false
	end

	return (self:canGetStarChest(arg_49_1.id))
end

function DungeonData:canReceiveStarChest(arg_50_1, arg_50_2)
	if not self._chapters[arg_50_1] or not arg_50_2 or arg_50_2 <= 0 then
		return false
	end

	return (self._chapters[arg_50_1]:canGetStarChest(arg_50_2))
end

function DungeonData:canGetStageChest(arg_51_1)
	if not self._chapters[arg_51_1] then
		return false
	end

	for iter_51_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_STAGE_CHEST_COUNT do
		if self:canOpenStageChest(arg_51_1, iter_51_0) and not self._chapters[arg_51_1]:isStageChestOpen(iter_51_0) then
			return true
		end
	end

	return false
end

function DungeonData:canOpenStageChest(arg_52_1, arg_52_2)
	local var_52_0 = self._chapters[arg_52_1]:getStageChestIdByIndex(arg_52_2)

	if var_52_0 <= 0 then
		return false
	end

	return (self:isStageChestUnlocked(var_52_0))
end

function DungeonData:canReceiveStageChest(arg_53_1, arg_53_2)
	if not self._chapters[arg_53_1] or not arg_53_2 or arg_53_2 <= 0 then
		return false
	end

	if self:canOpenStageChest(arg_53_1, arg_53_2) and not self._chapters[arg_53_1]:isStageChestOpen(arg_53_2) then
		return not self:isChapterNextStagePassed(var_0_3.get((self._chapters[arg_53_1]:getStageChestIdByIndex(arg_53_2))).unlock)
	end

	return false
end

function DungeonData:getChapterNumByLandId(arg_54_1)
	local var_54_0 = var_0_1.get(arg_54_1)
	local var_54_1 = 0

	for iter_54_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND do
		if var_54_0["chapter_" .. iter_54_0] > 0 then
			var_54_1 = var_54_1 + 1
		end
	end

	return var_54_1
end

function DungeonData:getChapterIndex(arg_55_1)
	if arg_55_1 <= 0 then
		return 0
	end

	local var_55_0 = var_0_1.get(var_0_2.get(arg_55_1).land_id)

	for iter_55_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND do
		if arg_55_1 == var_55_0["chapter_" .. iter_55_0] then
			return iter_55_0
		end
	end

	return 0
end

function DungeonData:isPassedByChapIdxAndLandId(arg_56_1, arg_56_2)
	return (self:isChapterPassed(var_0_1.get(arg_56_2)["chapter_" .. arg_56_1]))
end

function DungeonData:isUnolckByPreChapIdxAndLandId(arg_57_1, arg_57_2)
	local var_57_0 = var_0_2.get(var_0_1.get(arg_57_2)["chapter_" .. arg_57_1])

	if var_57_0.next_id == 0 then
		return false
	end

	return (self:isChapterUnlocked(var_57_0.next_id))
end

function DungeonData:getFinalLandId()
	for iter_58_0, iter_58_1 in var_0_1.ipairs() do
		if iter_58_1.next_id == 0 then
			return iter_58_1.id
		end
	end

	return 1
end

function DungeonData:isFinishLand(arg_59_1)
	local var_59_0 = var_0_1.get(arg_59_1)

	for iter_59_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND do
		if var_59_0["chapter_" .. iter_59_0] > 0 then
			if not self:isChapterPassed(var_59_0["chapter_" .. iter_59_0]) then
				return false
			end
		else
			break
		end
	end

	return true
end

function DungeonData:getPreLandId(arg_60_1)
	local var_60_0 = self:getFirstLandId()

	if arg_60_1 == var_60_0 then
		return var_60_0
	end

	for iter_60_0 = 1, var_0_1.getLength() do
		local var_60_1 = var_0_1.indexOf(iter_60_0)

		if var_60_1.next_id == arg_60_1 then
			return var_60_1.id
		end
	end

	return var_60_0
end

function DungeonData:getPostLandId(arg_61_1)
	local var_61_0 = var_0_1.get(arg_61_1)

	return (var_61_0.next_id == 0 or nil) and var_61_0.id
end

function DungeonData:getFirstLandId()
	return var_0_1.indexOf(1).id
end

function DungeonData:getLastUnlockStageId()
	return (self:getLastUnlockedStage((self:getLastUnlockChapter())))
end

function DungeonData:getCurUnlockStageCount()
	local var_64_0 = 0

	for iter_64_0, iter_64_1 in ipairs((self:getStageIds((self:getLastUnlockChapter())))) do
		if not self:isStagePassed(iter_64_1) then
			var_64_0 = var_64_0 + 1
		end
	end

	return var_64_0
end

function DungeonData:getOpenUnlockStageId()
	local var_65_0 = 0

	if self:getCurUnlockStageCount() > var_0_5.OPEN_ASTRICT_STAGE then
		local var_65_1 = self:getStageIds((self:getLastUnlockChapter()))
		local var_65_2 = self:getStageIndex((self:getLastUnlockStageId())) + var_0_5.OPEN_ASTRICT_STAGE

		if var_65_1[var_65_2] then
			var_65_0 = var_65_1[var_65_2]
		end
	end

	return var_65_0
end

function DungeonData:getLastPassedStageId()
	return (self:getLastPassedStage((self:getLastRecordChapter())))
end

function DungeonData:getPreChapterId(arg_67_1)
	for iter_67_0 = 1, var_0_2.getLength() do
		local var_67_0 = var_0_2.get(iter_67_0)

		if var_67_0.next_id == arg_67_1 then
			return var_67_0.id
		end
	end

	return 1
end

function DungeonData:getUnlockLandNum()
	local var_68_0 = self:getCurLandId()
	local var_68_1 = 0

	for iter_68_0 = 1, var_0_1.getLength() do
		if var_68_0 >= var_0_1.indexOf(iter_68_0).id then
			var_68_1 = var_68_1 + 1
		end
	end

	return var_68_1
end

function DungeonData:getPassedChapterNum()
	for iter_69_0, iter_69_1 in var_0_2.ipairs() do
		if iter_69_1.id == self._lastPassedChapterId then
			return iter_69_0
		end
	end

	return 0
end

function DungeonData:getFinalChapterByLandId(arg_70_1)
	local var_70_0 = var_0_1.get(arg_70_1)

	for iter_70_0 = g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND, 1, -1 do
		if var_70_0["chapter_" .. iter_70_0] > 0 and self:isChapterUnlocked(var_70_0["chapter_" .. iter_70_0]) then
			return var_70_0["chapter_" .. iter_70_0]
		end
	end

	return var_70_0.chapter_1
end

function DungeonData:getOpenLandCount()
	local var_71_0 = 0

	for iter_71_0, iter_71_1 in var_0_1.ipairs() do
		if iter_71_1.next_id > 0 then
			var_71_0 = var_71_0 + 1
		else
			return var_71_0 + 1
		end
	end
end

function DungeonData:getLandTotalStar(arg_72_1)
	local var_72_0 = var_0_1.get(arg_72_1)
	local var_72_1 = 0

	for iter_72_0 = g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND, 1, -1 do
		if var_72_0["chapter_" .. iter_72_0] > 0 then
			var_72_1 = var_72_1 + var_0_2.get(var_72_0["chapter_" .. iter_72_0]).total_star
		end
	end

	return var_72_1
end

function DungeonData:getUnMaxStarChapterByLandId(arg_73_1)
	local var_73_0 = var_0_1.get(arg_73_1)
	local var_73_1 = 0

	for iter_73_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND do
		local var_73_2 = var_73_0["chapter_" .. iter_73_0]

		if var_73_0["chapter_" .. iter_73_0] > 0 and self:isChapterUnlocked(var_73_2) then
			if self._chapters[var_73_2] and not self._chapters[var_73_2]:isMaxStar() or var_73_2 == self._newChapterId then
				return var_73_2
			end

			var_73_1 = var_73_2
		end
	end

	return var_73_1
end

function DungeonData:getLastRecordChapter()
	local var_74_0 = self:getLastUnlockChapter()

	if self:getChapterStar(var_74_0) > 0 then
		return var_74_0
	else
		return self:getPreChapterId(var_74_0)
	end
end

function DungeonData:getCurStarAchieveId()
	local var_75_0 = 0

	if not self._finishAchieve or not next(self._finishAchieve) then
		return 1
	end

	for iter_75_0, iter_75_1 in pairs(self._finishAchieve) do
		var_75_0 = math.max(var_75_0, iter_75_0)
	end

	return #self._finishAchieve[var_75_0] < 6 and var_75_0 or g.core.config.dungeon_achievement_info.get(var_75_0).next_id
end

function DungeonData:getLastAchieveId(arg_76_1)
	for iter_76_0, iter_76_1 in g.core.config.dungeon_achievement_info.ipairs() do
		if iter_76_1.next_id == arg_76_1 then
			return iter_76_1.id
		end
	end

	return 0
end

function DungeonData:getNextAchieveId(arg_77_1)
	if arg_77_1 >= self:getCurStarAchieveId() then
		return 0
	end

	return g.core.config.dungeon_achievement_info.get(arg_77_1).next_id
end

function DungeonData:getAchieveState(arg_78_1, arg_78_2)
	if not g.core.config.dungeon_achievement_info.fetch(arg_78_1) then
		return 0
	end

	if self:getTotalStars() < g.core.config.dungeon_achievement_info.get(arg_78_1)["star_" .. arg_78_2] then
		return 0
	end

	local var_78_0 = self._finishAchieve[arg_78_1]

	if self._finishAchieve[arg_78_1] and next(var_78_0) then
		for iter_78_0 = 1, #var_78_0 do
			if var_78_0[iter_78_0] == arg_78_2 then
				return 2
			end
		end
	end

	return 1
end

function DungeonData:getAllCanGetAward(arg_79_1)
	local var_79_0 = {}

	for iter_79_0 = 1, 6 do
		if self:getAchieveState(arg_79_1, iter_79_0) == 1 then
			table.insert(var_79_0, iter_79_0)
		end
	end

	return var_79_0
end

function DungeonData:canReceiveStarAward()
	if not self:isShowAchievePop() then
		return false
	end

	local var_80_0 = self:getCurStarAchieveId()

	if var_80_0 == 0 then
		return false
	end

	for iter_80_0 = 1, 6 do
		if self:getAchieveState(var_80_0, iter_80_0) == 1 then
			return true
		end
	end

	return false
end

function DungeonData:getNearestStarNum()
	if not self:isShowAchievePop() then
		return 0
	end

	local var_81_0 = self:getCurStarAchieveId()

	if var_81_0 == 0 then
		return 0
	end

	local var_81_1 = g.core.config.dungeon_achievement_info.get(var_81_0)
	local var_81_2 = var_81_1.star_6

	for iter_81_0 = 1, 6 do
		local var_81_3 = self:getAchieveState(var_81_0, iter_81_0)

		if var_81_3 == 0 or var_81_3 == 1 then
			var_81_2 = math.min(var_81_2, var_81_1["star_" .. iter_81_0])
		end
	end

	return var_81_2
end

function DungeonData:getChapterAndStageById(arg_82_1)
	return var_0_4.get(arg_82_1).chapter_id, (self:getStageIndex(arg_82_1))
end

function DungeonData:isShowCityHint()
	local var_83_0

	for iter_83_0, iter_83_1 in ipairs((g.core.model.User.cityData:getCityList())) do
		if not iter_83_1:isCityUnlock() then
			var_83_0 = iter_83_1

			break
		end
	end

	if not var_83_0 then
		return false
	end

	local var_83_1 = var_0_4.get(var_83_0:getCfg().stage_id).chapter_id

	if self._lastUnlockChapterId == self:getPreChapterId(var_83_1) then
		return true, 2
	elseif self._lastUnlockChapterId == var_83_1 then
		return true, 1
	else
		return false
	end
end

function DungeonData:checkResetData()
	if self:checkExpired(self._lastResetTime) then
		for iter_84_0, iter_84_1 in pairs(self._stages) do
			iter_84_1:setChallengeCount(0)
			iter_84_1:setResetCount(0)
		end

		self._lastResetTime = g.core.common.ServerTime:getTime()
	end
end

function DungeonData:isAwardReach()
	local var_85_0 = 0

	for iter_85_0, iter_85_1 in g.core.config.dungeon_achievement_info.ipairs() do
		for iter_85_2 = 1, 6 do
			local var_85_1 = self:getAchieveState(iter_85_1.id, iter_85_2)

			if var_85_1 == 1 then
				var_85_0 = var_85_0 + 1
			end

			if var_85_0 >= 3 then
				return true
			end

			if var_85_1 == 0 then
				return false
			end

			if iter_85_2 == 6 and var_85_1 == 1 then
				return true
			end
		end
	end

	return false
end

function DungeonData:isShowAchievePop()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_ACHIEVE) and self:getCurStarAchieveId() > 0
end

function DungeonData:canReceiveNearLand(arg_87_1, arg_87_2)
	local var_87_0 = var_0_1.getLength()
	local var_87_1 = {}

	if arg_87_2 == 0 then
		if arg_87_1 == var_0_1.indexOf(1).id then
			return false, 0
		end

		for iter_87_0 = var_87_0, 1, -1 do
			local var_87_2 = var_0_1.indexOf(iter_87_0)

			if arg_87_1 > var_87_2.id then
				table.insert(var_87_1, var_87_2.id)
			end
		end
	else
		if arg_87_1 == var_0_1.indexOf(var_87_0).id then
			return false, 0
		end

		for iter_87_1 = 1, var_87_0 do
			local var_87_3 = var_0_1.indexOf(iter_87_1)

			if arg_87_1 < var_87_3.id then
				table.insert(var_87_1, var_87_3.id)
			end
		end
	end

	for iter_87_2, iter_87_3 in ipairs(var_87_1) do
		local var_87_4 = var_0_1.get(iter_87_3)

		for iter_87_4 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHAPTER_IN_LAND do
			if g.core.model.User.dungeonData:canGetStarChest(var_87_4["chapter_" .. iter_87_4]) or g.core.model.User.dungeonData:canGetStageChest(var_87_4["chapter_" .. iter_87_4]) then
				return true, var_87_4["chapter_" .. iter_87_4]
			end
		end
	end

	return false, 0
end

function DungeonData:setBioOpenTip(arg_88_1)
	self._isOpenBioTip = arg_88_1
end

function DungeonData:getBioOpenTip()
	return self._isOpenBioTip
end

function DungeonData:setHidePerfectLand(arg_90_1)
	self._isHidePerfectLand = arg_90_1
end

function DungeonData:getHidePerfectLand()
	return self._isHidePerfectLand
end

function DungeonData:setFailBattleJumpFlag()
	self._inBattleFailFlag = true
end

function DungeonData:inFailBattleJumpState()
	if self._inBattleFailFlag then
		self._inBattleFailFlag = false

		return true
	end

	return false
end

function DungeonData:getDungeonLandListData()
	local var_94_0 = {}

	for iter_94_0 = 1, var_0_1.getLength() do
		local var_94_1 = var_0_1.indexOf(iter_94_0)

		if var_94_1.id <= self._landId then
			if self._isHidePerfectLand then
				if self:getLandStar(var_94_1.id) ~= self:getLandTotalStar(var_94_1.id) then
					table.insert(var_94_0, var_94_1.id)
				end
			else
				table.insert(var_94_0, var_94_1.id)
			end
		end
	end

	table.sort(var_94_0, function(arg_95_0, arg_95_1)
		return arg_95_0 < arg_95_1
	end)

	return var_94_0
end

function DungeonData:getStarAwardsData(arg_96_1)
	local var_96_1 = {}

	for iter_96_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_CHEST_ICON_COUNT do
		local var_96_2 = var_0_3.get(arg_96_1)

		if var_96_2["reward_type_" .. iter_96_0] > 0 then
			table.insert(var_96_1, {
				type = var_96_2["reward_type_" .. iter_96_0],
				value = var_96_2["reward_value_" .. iter_96_0],
				size = var_96_2["reward_size_" .. iter_96_0]
			})
		end
	end

	return var_96_1
end

function DungeonData:setSpecialGuideOpe()
	self._guideSpecialOpe = true
end

function DungeonData:isSpecialGuideOpe()
	if self._guideSpecialOpe then
		self._guideSpecialOpe = false

		return true
	end

	return false
end

function DungeonData.checkBoxAward()
	for iter_99_0 = 1, g.core.model.User.dungeonData:getLastUnlockChapter() do
		if g.core.model.User.dungeonData:canGetStarChest(iter_99_0) or g.core.model.User.dungeonData:canGetStageChest(iter_99_0) then
			return true
		end
	end

	return false
end

function DungeonData.getAvailableAwardChapterIds()
	local var_100_0 = {}

	for iter_100_0 = 1, g.core.model.User.dungeonData:getLastUnlockChapter() do
		if g.core.model.User.dungeonData:canGetStarChest(iter_100_0) or g.core.model.User.dungeonData:canGetStageChest(iter_100_0) then
			table.insert(var_100_0, iter_100_0)
		end
	end

	return var_100_0
end

function DungeonData:updateChaptersData(arg_101_1)
	if not arg_101_1.chapters then
		return
	end

	for iter_101_0, iter_101_1 in pairs(arg_101_1.chapters) do
		self:_updateChapterData(iter_101_1.id, iter_101_1)
	end
end

function DungeonData:getChapter(arg_102_1)
	return self._chapters[arg_102_1]
end

function DungeonData:getStage(arg_103_1)
	return self._stages[arg_103_1]
end

function DungeonData:getLastPassedChapter()
	return self._lastPassedChapterId
end

function DungeonData:getLastUnlockChapter()
	return self._lastUnlockChapterId
end

function DungeonData:getStageIds(arg_106_1)
	return self._chapterStageIds[arg_106_1] or {}
end

function DungeonData:getStageNum(arg_107_1)
	return #self._chapterStageIds[arg_107_1]
end

function DungeonData:getCurLandId()
	return self._landId
end

function DungeonData:getBattleInfo()
	return self._battleInfo
end

function DungeonData:getFinishAchieve()
	return self._finishAchieve
end

function DungeonData:getMaxEnterLand()
	return self._maxEnterLand
end

function DungeonData:setNormalSkipFight(arg_112_1)
	g.core.common.Storage:save("dungeon_normal_skipFight.json", {
		isSkip = arg_112_1
	}, true)
end

function DungeonData:getNormalSkipFight()
	return (g.core.common.Storage:load("dungeon_normal_skipFight.json", true) or {}).isSkip or false
end

function DungeonData:isCanAutoFightByStageId()
	return (self:getNormalSkipFight())
end

function DungeonData:getChapterIdByInteractionId(arg_115_1)
	return self._interactionIdByFirstChapterList[arg_115_1]
end

function DungeonData:setDebugEditor(arg_116_1)
	self._debugEditor = arg_116_1
end

function DungeonData:getDebugEditor()
	return self._debugEditor == true
end

function DungeonData:isGetRegistrationMailAward()
	for iter_118_0, iter_118_1 in ipairs(self._registAwards) do
		if g.core.model.User.mailData:isUnReadMail({
			baseId = iter_118_1.mailId
		}) then
			return false
		end
	end

	return true
end

function DungeonData:isShowPreRegistration()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_PRE_REGISTRATION) and not g.core.platform.ServerListProxy:isTesting() then
		if self:getLastPassedChapter() >= var_0_5.OPEN_REGISTRATION_CHAPTER then
			if not self:isGetRegistrationMailAward() then
				return true
			else
				return false
			end
		else
			return true
		end
	else
		return false
	end
end

function DungeonData:isShowYoungGift()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_PRE_REGISTRATION) and not g.core.platform.ServerListProxy:isTesting() and not self:isShowPreRegistration() and g.core.model.User.dungeonData:getLastPassedChapter() < g.core.config.achievement_info.get(10029).num then
		return true
	end

	return false
end

function DungeonData:isShowEdenGarden()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_PRE_REGISTRATION) and not g.core.platform.ServerListProxy:isTesting() then
		if not self:isShowPreRegistration() and not self:isShowYoungGift() and g.core.model.User.dungeonData:getLastPassedChapter() < g.core.config.achievement_info.get(10030).num then
			return true
		end
	end

	return false
end

function DungeonData:getRegistrationAwardData()
	return self._registAwards
end

function DungeonData:isPassALLChapterAndTurnNextLand()
	local var_123_0 = false
	local var_123_1
	local var_123_2 = self:getLastUnlockChapter()
	local var_123_3 = var_0_2.get(var_123_2)

	if var_123_3.next_id ~= 0 and self._chapters[var_123_2] and self._chapters[var_123_2]:isPassed() then
		var_123_1 = var_0_2.get(var_123_3.next_id).land_id
		var_123_0 = var_123_1 ~= var_123_3.land_id
	end

	return var_123_0, var_123_1
end

function DungeonData:setAutoChallenge(arg_124_1)
	self._autoChallenge = arg_124_1
end

function DungeonData:isAutoChallenge()
	return self._autoChallenge
end

function DungeonData:setDisplayVersion(arg_126_1)
	self._displayVersion = arg_126_1
end

function DungeonData:getDisplayVersion()
	return self._displayVersion
end

return DungeonData
