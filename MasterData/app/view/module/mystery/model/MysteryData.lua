local var_0_0 = g.core.config.mystery_chapter_info
local var_0_1 = g.core.config.mystery_stage_info
local var_0_2 = g.core.config.mystery_task_info
local var_0_3 = g.core.const.ConstMgr.MysteryConst
local MysteryChapterData = require("app.view.module.mystery.model.MysteryChapterData")
local MysteryStageData = require("app.view.module.mystery.model.MysteryStageData")
local MysteryData = class("MysteryData")

function MysteryData:ctor()
	self:initData()
end

function MysteryData:initData()
	self._chapterDict = {}
	self._curChapterId = 1
	self._curRoomId = nil
	self._maxChapterId = 0
	self._stageDict = {}
	self._killedEliteIds = {}
	self._killMonsterGroups = {}
	self._storyFinishIds = {}
	self._taskDict = {}
	self._dailyTaskId = 0
	self._newChapterId = 0
	self._finishStoryIds = {}
	self._roomDict = {}
	self._roomUserDict = {}
	self._oldRoomUser = {}
	self._monsterVersion = 1

	self:_initChapterData()
	self:_initStageData()
end

function MysteryData:_initChapterData()
	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		self._chapterDict[iter_3_1.id] = MysteryChapterData.new(iter_3_1.id)

		if iter_3_1.next_id == 0 then
			self._maxChapterId = iter_3_1.id
		end
	end
end

function MysteryData:_initStageData()
	for iter_4_0, iter_4_1 in var_0_1.ipairs() do
		self._stageDict[iter_4_1.id] = MysteryStageData.new(iter_4_1.id)
	end
end

function MysteryData:isChapterPass(arg_5_1)
	return self._chapterDict[arg_5_1]:isPassed()
end

function MysteryData:getLastUnlockChapterId()
	local var_6_0 = 1

	for iter_6_0, iter_6_1 in pairs(self._chapterDict) do
		if iter_6_1:isPassed() then
			var_6_0 = iter_6_1:getChapterConfig().next_id
		end
	end

	if var_6_0 == 0 then
		var_6_0 = var_0_0.getLength()
	end

	return var_6_0
end

function MysteryData:getLastPassChapterId()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(self._chapterDict) do
		if iter_7_1:isPassed() then
			var_7_0 = iter_7_1:getChapterConfig().id
		end
	end

	return var_7_0
end

function MysteryData:getChapterDataById(arg_8_1)
	return self._chapterDict[arg_8_1]
end

function MysteryData:getAllChapterList()
	return table.values(self._chapterDict)
end

function MysteryData:getCurChapterId()
	return self._curChapterId
end

function MysteryData:setCurChapterId(arg_11_1)
	self._curChapterId = arg_11_1
end

function MysteryData:getCurRoomId()
	return self._curRoomId
end

function MysteryData:getChapterPage()
	local var_13_0 = table.values(self._chapterDict)
	local var_13_1 = 0
	local var_13_2 = {}

	for iter_13_0 = 1, #var_13_0 do
		var_13_2[1] = var_13_2[1] or {}

		table.insert(var_13_2[1], var_13_0[iter_13_0])

		var_13_1 = var_13_1 + 1

		local var_13_3

		if var_13_1 >= var_0_3.CHAPTER_MAX_COUNT then
			var_13_1 = 0
			var_13_3 = 1 + 1
		end
	end

	return var_13_2
end

function MysteryData:getStageDataById(arg_14_1)
	return self._stageDict[arg_14_1]
end

function MysteryData:onS2CMysteryInfo(arg_15_1)
	if arg_15_1.info then
		for iter_15_0, iter_15_1 in pairs(self._chapterDict) do
			iter_15_1:updateServerInfo(arg_15_1.info)
		end

		if arg_15_1.info.kill_elite_ids then
			self._killedEliteIds = arg_15_1.info.kill_elite_ids
		end

		if arg_15_1.info.finish_story_ids then
			for iter_15_2 = 1, #arg_15_1.info.finish_story_ids do
				self._finishStoryIds[arg_15_1.info.finish_story_ids[iter_15_2]] = arg_15_1.info.finish_story_ids[iter_15_2]
			end
		end

		self._dailyTaskId = arg_15_1.info.daily_monster_task_id or 0
	end

	if arg_15_1.tasks then
		self._taskDict = {}

		for iter_15_3, iter_15_4 in ipairs(arg_15_1.tasks) do
			self._taskDict[iter_15_4.id] = {
				progress = iter_15_4.value,
				isGet = iter_15_4.awarded
			}
		end
	end
end

function MysteryData:onS2CMysteryEnter(arg_16_1)
	if arg_16_1.room then
		self._curRoomId = arg_16_1.room.room_id

		if arg_16_1.room.monsters then
			for iter_16_0, iter_16_1 in ipairs(arg_16_1.room.monsters) do
				local var_16_0 = self:getStageDataById(iter_16_1.base_id)

				if var_16_0 then
					var_16_0:updateServerInfo(iter_16_1)
				end
			end
		end

		if arg_16_1.room.users then
			if table.nums(self._roomUserDict) > 0 then
				self._oldRoomUser = self._roomUserDict
			end

			self._roomUserDict = {}

			for iter_16_2, iter_16_3 in ipairs(arg_16_1.room.users) do
				self._roomUserDict[iter_16_3.user_id] = iter_16_3
			end
		end
	end
end

function MysteryData:getRoomUserData()
	return self._roomUserDict
end

function MysteryData:getOldRoomUser()
	return self._oldRoomUser
end

function MysteryData:sendUserSnapIdList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self._roomUserDict) do
		var_19_0[#var_19_0 + 1] = iter_19_0
	end

	if #var_19_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
			user_ids = var_19_0
		})
	end
end

function MysteryData:addRoomUserSnapList(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_1 or {}) do
		if self._roomUserDict[iter_20_1.id] then
			self._roomUserDict[iter_20_1.id].snapShot = iter_20_1
		end
	end
end

function MysteryData:removeRoomUser(arg_21_1)
	if arg_21_1.uid then
		self._oldRoomUser[arg_21_1.uid] = self._roomUserDict[arg_21_1.uid]
		self._roomUserDict[arg_21_1.uid] = nil

		self:_resetRoomValue()
	end
end

function MysteryData:isCanFastChallangeFinishChapter(arg_22_1)
	return self:getStageDataById(arg_22_1):getPassed()
end

function MysteryData:onS2CMysteryExit()
	self:resetRoomData()
end

function MysteryData:onS2CMysteryMonsterChallengeFinish(arg_24_1)
	if arg_24_1.is_win and arg_24_1.monster_id then
		local var_24_0 = self:getStageDataById(arg_24_1.monster_id)

		if var_24_0 then
			var_24_0:setLastKillTime(g.core.common.ServerTime:getTime())
		end
	end
end

function MysteryData:onS2CMysteryMonsterFastChallenge(arg_25_1)
	if arg_25_1.monster_id then
		local var_25_0 = self:getStageDataById(arg_25_1.monster_id)

		if var_25_0:getStageCfg().type == var_0_3.MAP_ITEM_TYPE.MONSTER then
			var_25_0:setLastKillTime(g.core.common.ServerTime:getTime())
		end
	end
end

function MysteryData:onS2CMysteryEliteChallengeFinish(arg_26_1)
	if arg_26_1.is_win and arg_26_1.monster_id then
		self:passEliteOpenNewChapter(arg_26_1.monster_id)
	end
end

function MysteryData:passEliteOpenNewChapter(arg_27_1)
	local var_27_0 = false

	for iter_27_0, iter_27_1 in ipairs(self._killedEliteIds) do
		if iter_27_1 == arg_27_1 then
			var_27_0 = true

			break
		end
	end

	if not var_27_0 then
		for iter_27_2, iter_27_3 in pairs(self._chapterDict) do
			local var_27_1 = iter_27_3:getChapterConfig()

			if var_27_1.elite_monster == arg_27_1 then
				self._newChapterId = var_27_1.next_id
			end
		end
	end
end

function MysteryData:getNewChapterId()
	return self._newChapterId
end

function MysteryData:resetNewChapterId()
	self._newChapterId = 0
end

function MysteryData:resetRoomData()
	self._curRoomId = nil
	self._roomDict = {}
	self._roomUserDict = {}
end

function MysteryData:onS2CMysteryGetRoomList(arg_31_1)
	self._roomDict = {}

	local var_31_0, var_31_1

	if arg_31_1 then
		var_31_0 = arg_31_1.room_id_list or {}

		if arg_31_1 then
			var_31_1 = arg_31_1.room_num_list or {}
		end
	end

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		self._roomDict[iter_31_1] = {}
		self._roomDict[iter_31_1].id = iter_31_1
		self._roomDict[iter_31_1].num = var_31_1[iter_31_0] or 0
	end
end

function MysteryData:getRoomsData()
	return self._roomDict
end

function MysteryData:getRoomMaxUserCount()
	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MYSTERY_ROOM_MAX_USER_NUM).parameter
end

function MysteryData:onS2CMysteryStoryFinish(arg_34_1)
	if arg_34_1.story_id then
		self._finishStoryIds[arg_34_1.story_id] = arg_34_1.story_id
	end
end

function MysteryData:isAwardMysteryStoryById(arg_35_1)
	return self._finishStoryIds[arg_35_1]
end

function MysteryData:onS2CMysteryAcceptTask(arg_36_1)
	if arg_36_1.task_id then
		self._dailyTaskId = arg_36_1.task_id
	end
end

function MysteryData:onS2CMysteryGiveUpTask()
	self._dailyTaskId = 0

	self:resetDailyTaskProg()
end

function MysteryData:resetDailyTaskProg()
	for iter_38_0, iter_38_1 in pairs(self._taskDict) do
		local var_38_0 = var_0_2.get(iter_38_0)

		if var_38_0 and var_38_0.task_type == var_0_3.TASK_TYPE.DAILY then
			iter_38_1.progress = 0
			iter_38_1.isGet = false
		end
	end
end

function MysteryData:crossDayResetTaskProg()
	for iter_39_0, iter_39_1 in pairs(self._taskDict) do
		local var_39_0 = var_0_2.get(iter_39_0)

		if var_39_0 and var_39_0.task_type ~= var_0_3.TASK_TYPE.MAIN then
			iter_39_1.progress = 0
			iter_39_1.isGet = false
		end
	end
end

function MysteryData:getDailyTaskId()
	return self._dailyTaskId
end

function MysteryData:getTaskProgById(arg_41_1)
	return self._taskDict[arg_41_1]
end

function MysteryData:isDaliyTaskDone()
	for iter_42_0, iter_42_1 in pairs(self._taskDict) do
		if var_0_2.get(iter_42_0).task_type == var_0_3.TASK_TYPE.DAILY and self:getTaskStateById(iter_42_0) == var_0_3.TASK_STATE.DONE then
			return true
		end
	end

	return false
end

function MysteryData:onS2CMysteryNotifyTask(arg_43_1)
	if arg_43_1.task_list then
		for iter_43_0, iter_43_1 in ipairs(arg_43_1.task_list) do
			self._taskDict[iter_43_1.id] = {
				progress = iter_43_1.value,
				isGet = iter_43_1.awarded
			}
		end
	end
end

function MysteryData:onS2CMySteryNotifyMove(arg_44_1)
	self._roomUserDict[arg_44_1.user_id] = arg_44_1
	self._roomUserDict[arg_44_1.user_id].isAttack = false

	local var_44_0 = false

	for iter_44_0, iter_44_1 in pairs(self._roomUserDict) do
		if not iter_44_1.snapShot then
			var_44_0 = true
		end
	end

	if var_44_0 then
		self:_resetRoomValue()
		self:sendUserSnapIdList()
	end
end

function MysteryData:onS2CMysteryNotifyAttack(arg_45_1)
	self._roomUserDict[arg_45_1.user.user_id] = arg_45_1.user
	self._roomUserDict[arg_45_1.user.user_id].isAttack = true

	if arg_45_1.monster then
		local var_45_0 = self:getStageDataById(arg_45_1.monster.base_id)

		if var_45_0 then
			var_45_0:updateServerInfo(arg_45_1.monster)
		end
	end
end

function MysteryData:_resetRoomValue()
	if self._curRoomId ~= nil and self._roomDict[self._curRoomId] then
		self._roomDict[self._curRoomId].num = table.nums(self._roomUserDict)
	end
end

function MysteryData:getTaskStateById(arg_47_1)
	if arg_47_1 == 0 then
		return var_0_3.TASK_STATE.UNDONE
	end

	if self._taskDict[arg_47_1] then
		if self._taskDict[arg_47_1].isGet then
			return var_0_3.TASK_STATE.DONE
		elseif not self._taskDict[arg_47_1].isGet and self._taskDict[arg_47_1].progress >= var_0_2.get(arg_47_1).task_size then
			return var_0_3.TASK_STATE.CAN_AWARD
		end
	end

	return var_0_3.TASK_STATE.UNDONE
end

function MysteryData:getChallengeTime()
	local var_48_0 = g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.MYSTERY_MONSTER_COUNT)

	return var_48_0 and var_48_0 or 0
end

function MysteryData:setTaskProgress(arg_49_1)
	if self._taskDict[arg_49_1] then
		self._taskDict[arg_49_1].progress = 0
		self._taskDict[arg_49_1].awarded = false
	end
end

function MysteryData:getDailyChallengeEliteTime()
	return (g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.MYSTERY_ELITE_COUNT))
end

function MysteryData:saveStoryStorage(arg_51_1)
	local var_51_0 = g.core.common.Storage:load("mystery.json") or {}

	if var_51_0.storys == nil then
		var_51_0.storys = {}
	end

	table.insert(var_51_0.storys, arg_51_1)
	g.core.common.Storage:save("mystery.json", var_51_0)
end

function MysteryData:isNeedStory(arg_52_1)
	local var_52_0 = g.core.common.Storage:load("mystery.json") or {}

	for iter_52_0, iter_52_1 in ipairs((var_52_0.storys or nil) and (var_52_0.storys or {})) do
		if iter_52_1 == arg_52_1 then
			return false
		end
	end

	return true
end

function MysteryData:getLastMysteryChatTime()
	return self._lastChatTime or 0
end

function MysteryData:setLastMysteryChatTime()
	self._lastChatTime = g.core.common.ServerTime:getTime()
end

function MysteryData:s2CMysteryEliteChallengeBegin()
	return
end

function MysteryData:setMonsterVersion(arg_56_1)
	self._monsterVersion = arg_56_1
end

function MysteryData:getSwitchMonsterTeamId(arg_57_1)
	local var_57_0 = g.core.config.monster_team_switch_info.get(arg_57_1)

	if not var_57_0 then
		return arg_57_1
	end

	return (self._monsterVersion == 1 or nil) and (var_57_0.id or var_57_0["id_" .. self._monsterVersion])
end

function MysteryData:isHaveTaskCanGetAwards(arg_58_1)
	if arg_58_1.taskType then
		for iter_58_0, iter_58_1 in pairs(self._taskDict) do
			if var_0_2.get(iter_58_0).task_type == arg_58_1.taskType and self:getTaskStateById(iter_58_0) == var_0_3.TASK_STATE.CAN_AWARD then
				return true
			end
		end

		return false
	elseif arg_58_1.chapterId then
		for iter_58_2, iter_58_3 in pairs(self._taskDict) do
			local var_58_0 = var_0_2.get(iter_58_2)

			if var_58_0.chapter_id == arg_58_1.chapterId and self:getTaskStateById(iter_58_2) == var_0_3.TASK_STATE.CAN_AWARD and var_58_0.task_type == var_0_3.TASK_TYPE.MAIN then
				return true
			end
		end

		return false
	else
		for iter_58_4, iter_58_5 in var_0_2.ipairs() do
			if self:getTaskStateById(iter_58_5.id) == var_0_3.TASK_STATE.CAN_AWARD then
				return true
			end
		end

		return false
	end
end

function MysteryData:isHaveChallengeTime()
	return self:getChallengeTime() > 0
end

function MysteryData:isMysteryCanGetDailyTask(arg_60_1)
	if arg_60_1.chapterId then
		return (self:isHaveCanGetDailyTaskByChapter(arg_60_1.chapterId))
	else
		local var_60_0 = self:getLastUnlockChapterId()

		for iter_60_0, iter_60_1 in pairs(self._chapterDict) do
			if var_60_0 < iter_60_0 then
				return false
			end

			if self:isHaveCanGetDailyTaskByChapter(iter_60_0) then
				return true
			end
		end
	end

	return false
end

function MysteryData:isHaveCanGetDailyTaskByChapter(arg_61_1)
	for iter_61_0, iter_61_1 in pairs((self:getChapterDataById(arg_61_1):getMonsterGroupCfg())) do
		if iter_61_1.isGroupPass and not self:isDaliyTaskDone() and self._dailyTaskId == 0 then
			return true
		end
	end

	return false
end

function MysteryData:isHaveDailyMonsterTime()
	return self:getDailyChallengeEliteTime() > 0
end

function MysteryData:showBossAttackBtn()
	local var_63_0 = g.core.common.Storage:load("mysteryChallenge.json", true) or {}
	local var_63_1 = g.core.common.ServerTime:getDateObject()

	var_63_0.attackDay = var_63_1.year .. "." .. var_63_1.month .. "." .. var_63_1.day

	g.core.common.Storage:save("mysteryChallenge.json", var_63_0, true)
end

function MysteryData:isWaitAttackBoss()
	local var_64_0 = self:isHaveDailyMonsterTime()
	local var_64_1 = g.core.common.ServerTime:getDateObject()
	local var_64_2 = g.core.common.Storage:load("mysteryChallenge.json", true)

	if var_64_2 then
		var_64_0 = var_64_0 and var_64_2.attackDay ~= var_64_1.year .. "." .. var_64_1.month .. "." .. var_64_1.day
	end

	return var_64_0
end

return MysteryData
