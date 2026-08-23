local var_0_0 = g.core.config.elder_boss_info
local var_0_1 = g.core.const.ConstMgr.ElderBossConst
local ElderBossData = class("ElderBossData")

function ElderBossData:ctor()
	self:initData()
end

function ElderBossData:initData()
	self._bossId = 0
	self._startTime = 0
	self._endTime = 0
	self._bossData = {}
	self._chooseBuff = 0
	self._maxHonor = 0
	self._oldHonor = 0
	self._maxRank = 0
	self._totalHonor = 0
	self._totalRank = 0
	self._guildRank = 0
	self._challengeTimes = 0
	self._taskAwardIds = {}
	self._showUserArray = {}
	self._resultRankUser = {}
	self._gameServerList = {}
	self._isExitElderBoss = false
	self._elderBossAttackRecord = {}
	self._rankDic = {}
	self._reportList = {}
	self._taskDic = {}

	self:_initElderBossTaskInfo()
end

function ElderBossData:_getTaskSortRule()
	return function(arg_4_0, arg_4_1)
		if arg_4_0.got ~= arg_4_1.got then
			return arg_4_1.got
		else
			return arg_4_0.info.id < arg_4_1.info.id
		end
	end
end

function ElderBossData:_initElderBossTaskInfo()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs((g.core.config.elder_boss_task_info.match(function(arg_6_0)
		return arg_6_0.require_type == 1
	end))) do
		local var_5_1 = {
			info = iter_5_1
		}

		var_5_1.canGet = false
		var_5_1.got = false

		table.insert(var_5_0, var_5_1)
	end

	table.insert(self._taskDic, var_5_0)

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in pairs((g.core.config.elder_boss_task_info.match(function(arg_7_0)
		return arg_7_0.require_type == 2
	end))) do
		local var_5_3 = {
			info = iter_5_3
		}

		var_5_3.canGet = false
		var_5_3.got = false

		table.insert(var_5_2, var_5_3)
	end

	table.insert(self._taskDic, var_5_2)
end

function ElderBossData:_updateNormalTaskCanGetState()
	for iter_8_0, iter_8_1 in pairs(self._taskDic[1]) do
		if iter_8_1.info.require_value <= self._challengeTimes then
			iter_8_1.canGet = true
		end
	end
end

function ElderBossData:_updateShareTaskCanGetState()
	for iter_9_0, iter_9_1 in pairs(self._taskDic[2]) do
		if iter_9_1.info.require_value < self._bossData.grade then
			iter_9_1.canGet = true
		end
	end
end

function ElderBossData:_updateElderBossTaskGotState(arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		for iter_10_1 = 1, #self._taskDic do
			for iter_10_2 = 1, #self._taskDic[iter_10_1] do
				if self._taskDic[iter_10_1][iter_10_2].info.id == arg_10_1[iter_10_0] then
					self._taskDic[iter_10_1][iter_10_2].got = true
				end
			end
		end
	end

	for iter_10_3 = 1, #self._taskDic do
		table.sort(self._taskDic[iter_10_3], self:_getTaskSortRule())
	end
end

function ElderBossData:onS2CRedPoint(arg_11_1)
	if arg_11_1.activity then
		self._bossId = arg_11_1.activity.sub_id or 0
		self._startTime = arg_11_1.activity.start_time or 0
		self._endTime = arg_11_1.activity.end_time or 0
	end

	if arg_11_1.buff then
		self._chooseBuff = arg_11_1.buff
	end
end

function ElderBossData:onS2CElderBossEnter(arg_12_1)
	if arg_12_1.boss then
		self._bossData.grade = arg_12_1.boss.grade or 0
		self._bossData.maxHp = arg_12_1.boss.max_hp or 1
		self._bossData.curHp = arg_12_1.boss.rest_hp or 0
		self._bossData.rebornTime = arg_12_1.boss.reborn_time or 0
	end

	if arg_12_1.user then
		self._chooseBuff = arg_12_1.user.buff or 0
		self._maxHonor = arg_12_1.user.max_honor or 0
		self._maxDamage = arg_12_1.user.max_damage or 0
		self._maxRank = arg_12_1.user.max_rank or 0
		self._totalHonor = arg_12_1.user.total_honor or 0
		self._totalRank = arg_12_1.user.total_rank or 0
		self._guildRank = arg_12_1.user.guild_rank or 0
		self._challengeTimes = arg_12_1.user.challenge_times or 0
		self._taskAwardIds = arg_12_1.user.task_award_ids or {}
	end

	if arg_12_1.show_users then
		self._showUserArray = arg_12_1.show_users or {}
	end

	if arg_12_1.rank_users then
		self._resultRankUser = arg_12_1.rank_users
	end

	self:_updateNormalTaskCanGetState()
	self:_updateShareTaskCanGetState()
	self:_updateElderBossTaskGotState(self._taskAwardIds)
end

function ElderBossData:onS2CElderBossGetReport(arg_13_1)
	local var_13_0 = arg_13_1.reports or {}

	self._reportList = {}

	for iter_13_0 = #var_13_0, #var_13_0 - (#var_13_0 > 20 and g.core.config.parameter_info.get(var_0_1.REPORT_SIZE_LIMIT_PARAMETER).parameter or #var_13_0) + 1, -1 do
		table.insert(self._reportList, var_13_0[iter_13_0])
	end
end

function ElderBossData:onS2CElderBossChooseBuff(arg_14_1)
	self._chooseBuff = arg_14_1.buff
end

function ElderBossData:onS2CElderBossJoinExit(arg_15_1)
	self._isExitElderBoss = true
end

function ElderBossData:onS2CElderBossChallengeNotify(arg_16_1)
	if arg_16_1.boss then
		self._bossData.grade = arg_16_1.boss.grade
		self._bossData.maxHp = arg_16_1.boss.max_hp
		self._bossData.curHp = arg_16_1.boss.rest_hp
		self._bossData.rebornTime = arg_16_1.boss.reborn_time or 0
	end

	if arg_16_1.user_id and arg_16_1.damage then
		local var_16_0 = {
			userId = arg_16_1.user_id
		}

		var_16_0.damage = arg_16_1.damage or 0

		if next(var_16_0) then
			if (g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ELDER_BOSS_CHALLENGE_NOTIFY).parameter or 3) <= #self._elderBossAttackRecord then
				table.remove(self._elderBossAttackRecord, 1)
			end

			table.insert(self._elderBossAttackRecord, var_16_0)
		end

		self._bossData.luckyUserId = arg_16_1.lucky and (arg_16_1.user_id or 0) or 0
	end

	self:_updateShareTaskCanGetState()
end

function ElderBossData:onS2CElderBossTaskAward(arg_17_1)
	self:_updateElderBossTaskGotState(arg_17_1.ids)
end

function ElderBossData:onS2CElderBossChallengeFinish(arg_18_1)
	self._maxRank = arg_18_1.new_max_rank or self._maxRank
	self._totalRank = arg_18_1.new_total_rank or self._totalRank
	self._totalHonor = self._totalHonor + (arg_18_1.honor or 0)
	self._maxHonor = math.max(self._maxHonor, arg_18_1.honor or 0)
	self._guildRank = arg_18_1.guild_rank or self._guildRank
end

function ElderBossData:onS2CServerInfos(arg_19_1)
	self._gameServerList = arg_19_1.server_infos or {}
end

function ElderBossData:onS2CCommonRankList(arg_20_1)
	self._rankDic[arg_20_1.id] = arg_20_1.rank_units or {}
end

function ElderBossData:getCurStage()
	local var_21_0 = g.core.common.ServerTime:getTime()

	if var_21_0 >= self._startTime and var_21_0 < self._endTime then
		return var_0_1.STAGE.GAME
	else
		return var_0_1.STAGE.SHOW_RESULT
	end
end

function ElderBossData:getCampaignStr()
	local var_22_0 = self:getCurStage()

	if var_22_0 == var_0_1.STAGE.GAME then
		return g.core.lang:get(432501)
	elseif var_22_0 == var_0_1.STAGE.SHOW_RESULT then
		return g.core.lang:get(432502)
	else
		return g.core.lang:get(430914)
	end
end

function ElderBossData:getCurStageFinishTime()
	if self:getCurStage() == var_0_1.STAGE.GAME then
		return self._endTime
	else
		return self:getResultStageFinishTime()
	end
end

function ElderBossData:getResultStageFinishTime()
	local var_24_0 = g.core.common.ServerTime:getWeekDay()

	if var_24_0 == 0 then
		var_24_0 = 7
	end

	local var_24_3 = 0

	repeat
		if var_24_0 == 7 then
			var_24_0 = 0
		end

		var_24_0 = var_24_0 + 1
		var_24_3 = var_24_3 + 1
	until var_24_0 == var_0_0.get((self._bossId + 1 > var_0_0.indexOf((var_0_0.getLength())).id or nil) and 1).week_day

	return g.core.common.ServerTime:getZeroClockSeconds() + var_24_3 * 24 * 3600
end

function ElderBossData:isShowEntrance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ELDER_BOSS) then
		return false
	end

	return true
end

function ElderBossData:getBossId()
	return self._bossId or 0
end

function ElderBossData:getBossSvrData()
	return self._bossData
end

function ElderBossData:isChooseBuff()
	return self._chooseBuff > 0
end

function ElderBossData:getChooseBuff()
	return self._chooseBuff
end

function ElderBossData:getMaxHonor()
	return self._maxHonor
end

function ElderBossData:setOldMaxHonor(arg_31_1)
	self._oldHonor = arg_31_1
end

function ElderBossData:getOldMaxHonor()
	return self._oldHonor
end

function ElderBossData:getMaxHonorRank()
	return self._maxRank
end

function ElderBossData:getTotalHonor()
	return self._totalHonor
end

function ElderBossData:getTotalHonorRank()
	return self._totalRank
end

function ElderBossData:getGuildRank()
	return self._guildRank
end

function ElderBossData:getRankListById(arg_37_1)
	return self._rankDic[arg_37_1]
end

function ElderBossData:getReportList()
	return self._reportList
end

function ElderBossData:getChallengeTimes()
	return self._challengeTimes
end

function ElderBossData:getKillBossLevel()
	return self._bossData.grade - 1
end

function ElderBossData:getFrontAttackRecord()
	if next(self._elderBossAttackRecord) then
		table.remove(self._elderBossAttackRecord, 1)

		return self._elderBossAttackRecord[1]
	else
		return nil
	end
end

function ElderBossData:getTaskDic()
	return self._taskDic
end

function ElderBossData:getAllCanGetAwardId(arg_43_1)
	local var_43_0 = {}

	for iter_43_0 = 1, #self._taskDic[arg_43_1 + 1] do
		if self._taskDic[arg_43_1 + 1][iter_43_0].canGet and not self._taskDic[arg_43_1 + 1][iter_43_0].got then
			table.insert(var_43_0, self._taskDic[arg_43_1 + 1][iter_43_0].info.id)
		end
	end

	return var_43_0
end

function ElderBossData:hasTaskAwardCanGet(arg_44_1)
	if arg_44_1.tabIdx then
		if #self:getAllCanGetAwardId(arg_44_1.tabIdx) > 0 then
			return true
		end
	else
		for iter_44_0 = 1, #self._taskDic do
			for iter_44_1 = 1, #self._taskDic[iter_44_0] do
				if self._taskDic[iter_44_0][iter_44_1].canGet and not self._taskDic[iter_44_0][iter_44_1].got then
					return true
				end
			end
		end
	end

	return false
end

function ElderBossData:getGameServerList()
	return self._gameServerList
end

function ElderBossData:getShowUserArray()
	return self._showUserArray
end

function ElderBossData:resetBossRebornTime()
	self._bossData.rebornTime = 0
end

function ElderBossData:setMaxDamage(arg_48_1)
	self._maxDamage = arg_48_1
end

function ElderBossData:getMaxDamage()
	return self._maxDamage
end

function ElderBossData:getElderBossResultRankData()
	return self._resultRankUser
end

function ElderBossData:getElderBossResultRankMap()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(self._resultRankUser) do
		var_51_0[iter_51_1.buff] = var_51_0[iter_51_1.buff] or {}
		var_51_0[iter_51_1.buff] = iter_51_1
	end

	return var_51_0
end

function ElderBossData:isBossDead()
	return checkbool(self._bossData.rebornTime - g.core.common.ServerTime:getTime() > 0)
end

function ElderBossData:getChallengeNum()
	return g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.ELDER_BOSS_NUM)
end

function ElderBossData:getMonsterInfoByTeamId(arg_54_1)
	return (g.core.config.monster_info.fetch(g.core.config.monster_team_info.get(arg_54_1, 1).monster_5))
end

function ElderBossData:isHaveElderBossChallengeCount()
	if self:getCurStage() ~= var_0_1.STAGE.GAME then
		return false
	end

	return self:getChallengeNum() > 0
end

return ElderBossData
