local var_0_0 = g.core.config.mystery_chapter_info
local var_0_1 = g.core.config.mystery_stage_info
local var_0_2 = g.core.config.mystery_task_info
local var_0_3 = g.core.config.mystery_story_info
local var_0_4 = g.core.config.mystery_boss_info
local var_0_5 = g.core.model.User.mysteryData
local var_0_6 = g.core.const.ConstMgr.MysteryConst
local MysteryChapterData = class("MysteryChapterData")

function MysteryChapterData:ctor(arg_1_1)
	self._chapterId = arg_1_1
	self._chapterCfg = var_0_0.get(arg_1_1)
	self._isEliteDead = false
	self._monsterGroupInfo = {}
	self._monsterGroupLen = 0
	self._refBindDict = {}
	self._chapterTaskDict = {}
	self._storyTriggerDict = {}

	self:initMonsterStageInfo()
	self:initMapAllBindInfo()
	self:initChapterTasks()
	self:initStoryInfo()
end

function MysteryChapterData:initMonsterStageInfo()
	for iter_2_0 = 1, 5 do
		if self._chapterCfg["monster" .. iter_2_0] > 0 then
			local var_2_0 = {}

			for iter_2_1 = 1, var_0_1.getLength() do
				local var_2_1 = var_0_1.indexOf(iter_2_1)

				if var_2_1.group == self._chapterCfg["monster" .. iter_2_0] then
					table.insert(var_2_0, var_2_1)
				end
			end

			self._monsterGroupInfo[self._chapterCfg["monster" .. iter_2_0]] = {
				isGroupPass = false,
				stageInfo = var_2_0
			}
			self._monsterGroupLen = self._monsterGroupLen + 1
		end
	end
end

function MysteryChapterData:initMapAllBindInfo()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self._monsterGroupInfo) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1.stageInfo) do
			table.insert(var_3_0, iter_3_3)
		end
	end

	local var_3_1 = self:getEliteMonsterCfg()

	if var_3_1 then
		table.insert(var_3_0, var_3_1)
	end

	local var_3_2 = self:getTaskNpcCfg()

	if var_3_2 then
		table.insert(var_3_0, var_3_2)
	end

	for iter_3_4 = 1, #var_3_0 do
		self._refBindDict[var_3_0[iter_3_4].number] = var_3_0[iter_3_4]
	end
end

function MysteryChapterData:initChapterTasks()
	local var_4_0 = {}

	for iter_4_0 = 1, var_0_2.getLength() do
		local var_4_1 = var_0_2.indexOf(iter_4_0)

		if var_4_1.chapter_id == self._chapterId then
			table.insert(var_4_0, var_4_1)
		end
	end

	for iter_4_1, iter_4_2 in ipairs(var_4_0) do
		if iter_4_2.task_type ~= var_0_6.TASK_TYPE.BOSS then
			self._chapterTaskDict[iter_4_2.task_type] = self._chapterTaskDict[iter_4_2.task_type] or {}

			table.insert(self._chapterTaskDict[iter_4_2.task_type], iter_4_2)
		end
	end
end

function MysteryChapterData:initStoryInfo()
	local var_5_0 = {}

	for iter_5_0 = 1, var_0_3.getLength() do
		local var_5_1 = var_0_3.indexOf(iter_5_0)

		if var_5_1.sub_id == self._chapterId then
			table.insert(var_5_0, var_5_1)
		end
	end

	for iter_5_1, iter_5_2 in ipairs(var_5_0) do
		self._storyTriggerDict[iter_5_2.trigger] = self._storyTriggerDict[iter_5_2.trigger] or {}

		table.insert(self._storyTriggerDict[iter_5_2.trigger], iter_5_2)
	end
end

function MysteryChapterData:updateServerInfo(arg_6_1)
	if arg_6_1.kill_elite_ids then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.kill_elite_ids) do
			if iter_6_1 == self._chapterCfg.elite_monster then
				self._isEliteDead = true
			end
		end
	end

	if arg_6_1.kill_monster_groups then
		local var_6_0 = arg_6_1.kill_monster_groups or {}

		for iter_6_2 = 1, #var_6_0 do
			if self._monsterGroupInfo[var_6_0[iter_6_2]] then
				self._monsterGroupInfo[var_6_0[iter_6_2]].isGroupPass = true

				for iter_6_3, iter_6_4 in pairs(self._monsterGroupInfo[var_6_0[iter_6_2]].stageInfo or {}) do
					var_0_5:getStageDataById(iter_6_4.id):setPassed(true)
				end
			end
		end
	end
end

function MysteryChapterData:getKillGroupCount()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(self._monsterGroupInfo) do
		if iter_7_1.isGroupPass then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function MysteryChapterData:getNextAttackGroup()
	local var_8_0 = self:getKillGroupCount() + 1

	if var_8_0 > self._monsterGroupLen then
		var_8_0 = self._monsterGroupLen
	end

	return self._chapterCfg["monster" .. var_8_0]
end

function MysteryChapterData:getMonsterIndexByGroup(arg_9_1)
	for iter_9_0 = 1, var_0_6.MONSTER_GROUP_MAX do
		if self._chapterCfg["monster" .. iter_9_0] > 0 and self._chapterCfg["monster" .. iter_9_0] == arg_9_1 then
			return iter_9_0
		end
	end
end

function MysteryChapterData:getGroupIsPass(arg_10_1)
	if not self._monsterGroupInfo[arg_10_1] then
		return false
	end

	return self._monsterGroupInfo[arg_10_1].isGroupPass
end

function MysteryChapterData:getPreStageInfoByGroup(arg_11_1)
	local var_11_0 = self:getMonsterIndexByGroup(arg_11_1)

	if self._chapterCfg["monster" .. var_11_0 - 1] then
		local var_11_1 = self:getMonsterListByGroup(self._chapterCfg["monster" .. var_11_0 - 1])

		if var_11_1 and next(var_11_1) then
			return var_11_1[1]
		end
	end
end

function MysteryChapterData:isPassed()
	return self._isEliteDead
end

function MysteryChapterData:isOpen()
	return g.core.model.User:getLevel() >= self._chapterCfg.open_level
end

function MysteryChapterData:isUnlockChapter()
	if self._chapterCfg.last_id == 0 then
		return true
	else
		return var_0_5:isChapterPass(self._chapterCfg.last_id)
	end
end

function MysteryChapterData:getChapterMapId()
	return self._chapterCfg.stage_map
end

function MysteryChapterData:getEliteAwards()
	return (g.core.common.Drops:getGoodsArray(self._chapterCfg.elite_reward))
end

function MysteryChapterData:getLastMysteryChapterId()
	return self._chapterCfg.last_id
end

function MysteryChapterData:getNextMysteryChapterId()
	return self._chapterCfg.next_id
end

function MysteryChapterData:getChapterConfig()
	return self._chapterCfg
end

function MysteryChapterData:getMonsterGroupCfg()
	return self._monsterGroupInfo
end

function MysteryChapterData:getMonsterListByGroup(arg_21_1)
	return self._monsterGroupInfo[arg_21_1].stageInfo
end

function MysteryChapterData:getEliteMonsterCfg()
	if not self._chapterCfg.elite_monster or self._chapterCfg.elite_monster <= 0 then
		return nil
	end

	return (var_0_1.get(self._chapterCfg.elite_monster))
end

function MysteryChapterData:getTaskNpcCfg()
	if not self._chapterCfg.task_npc or self._chapterCfg.task_npc <= 0 then
		return nil
	end

	return (var_0_1.get(self._chapterCfg.task_npc))
end

function MysteryChapterData:getStageInfoByBindId(arg_24_1)
	return self._refBindDict[arg_24_1]
end

function MysteryChapterData:getChapterTasks()
	return self._chapterTaskDict
end

function MysteryChapterData:isHaveStoryTrigger(arg_26_1, arg_26_2)
	if self._storyTriggerDict[arg_26_1] then
		for iter_26_0, iter_26_1 in ipairs(self._storyTriggerDict[arg_26_1]) do
			if arg_26_1 == var_0_6.STORY_TYPE.BATTLE then
				if iter_26_1.trigger_value == arg_26_2 then
					return true, iter_26_1.id
				end
			else
				return true, iter_26_1.id
			end
		end
	end
end

function MysteryChapterData:getUnlockBossId()
	local var_27_0 = 0
	local var_27_1 = var_0_4.match(function(arg_28_0)
		return arg_28_0.unlock_id == self._chapterId
	end)

	if var_27_1 and next(var_27_1) then
		for iter_27_0, iter_27_1 in ipairs(var_27_1) do
			if iter_27_1.type == 2 then
				var_27_0 = iter_27_1.id

				break
			end

			var_27_0 = iter_27_1.id
		end
	end

	return var_27_0
end

return MysteryChapterData
