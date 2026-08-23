local var_0_0 = g.core.config.guild_alliance_trial_reward_info
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local var_0_2 = g.core.config.guild_alliance_trial_monster_info
local AllianceTrialData = class("AllianceTrialData")

function AllianceTrialData:ctor()
	self:initData()
end

function AllianceTrialData:initData()
	self._stage = 1
	self._level = 1
	self._challengeTimes = 0
	self._receiveTimes = 0
	self._giveTimes = 0
	self._weeklyBoxTimes = 0
	self._monsterServerDict = {}
	self._boxData = {}
	self._awardNumDict = {}
	self._hideAwardNumDict = {}
	self._boxInfoData = {}
	self._userDict = {}
	self._needRemoveUser = {}
	self._monsterLevelData = {}
	self._isEnter = false
	self._passMonsterDict = {}
	self._shamUserDict = {}
	self._isNeedCloud = false
	self._isGetBoxInfo = false
	self._serverRedBoxAward = false

	self:initMonsterInfoData()
end

function AllianceTrialData:isEnter()
	return self._isEnter
end

function AllianceTrialData:setEnter(arg_4_1)
	self._isEnter = arg_4_1
end

function AllianceTrialData:getStage()
	return self._stage
end

function AllianceTrialData:getLevel()
	return self._level
end

function AllianceTrialData:getChallengeTimes()
	return self._challengeTimes
end

function AllianceTrialData:getGiveCount()
	return self._giveTimes
end

function AllianceTrialData:getWeeklyBoxTimes()
	return self._weeklyBoxTimes
end

function AllianceTrialData:onS2CAllianceNotifyMove(arg_10_1)
	self:setUserMove(arg_10_1.user.id, arg_10_1.user.pos)
end

function AllianceTrialData:onS2CAllianceGetInfo(arg_11_1)
	self:setTrialStageLevel(arg_11_1.trial or {})
end

function AllianceTrialData:setUserMove(arg_12_1, arg_12_2)
	self._userDict[arg_12_1] = arg_12_2
end

function AllianceTrialData:onS2CAllianceNotifyExit(arg_13_1)
	self._userDict[arg_13_1.user_id] = nil
end

function AllianceTrialData:setTrialStageLevel(arg_14_1)
	if not arg_14_1.stage or arg_14_1.stage == 0 then
		arg_14_1.stage = 1
	end

	if not arg_14_1.level or arg_14_1.level == 0 then
		arg_14_1.level = 1
	end

	self._stage = arg_14_1.stage
	self._level = arg_14_1.level
end

function AllianceTrialData:onS2CAllianceTrialEnter(arg_15_1)
	self:setEnter(true)

	self._isNeedCloud = false
	self._shamUserDict = {}

	self:setTrialStageLevel(arg_15_1.alliance or {})

	self._challengeTimes = arg_15_1.times or 0
	self._giveTimes = arg_15_1.give_times or 0
	self._receiveTimes = arg_15_1.receive_times or 0
	self._weeklyBoxTimes = arg_15_1.box_times or 0

	self:_updateServerMonster(arg_15_1.monsters or {})

	self._passMonsterDict = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.pass_monsters or {}) do
		self._passMonsterDict[iter_15_1.monster_id] = {}

		for iter_15_2, iter_15_3 in ipairs(iter_15_1.difficulty_list or {}) do
			self._passMonsterDict[iter_15_1.monster_id][iter_15_3] = true
		end
	end

	self._needRemoveUser = self._userDict
	self._userDict = {}

	for iter_15_4, iter_15_5 in ipairs(arg_15_1.users or {}) do
		self._userDict[iter_15_5.id] = iter_15_5.pos
	end

	for iter_15_6, iter_15_7 in pairs(self._needRemoveUser) do
		if self._userDict[iter_15_6] then
			self._needRemoveUser[iter_15_6] = nil
		end
	end
end

function AllianceTrialData:initMonsterInfoData()
	for iter_16_0, iter_16_1 in var_0_2.ipairs() do
		self._monsterLevelData[iter_16_1.stage] = self._monsterLevelData[iter_16_1.stage] or {}

		local var_16_0 = iter_16_1.level

		if not self._monsterLevelData[iter_16_1.stage][iter_16_1.level] then
			self._monsterLevelData[iter_16_1.stage][var_16_0] = {}
		end

		table.insert(self._monsterLevelData[iter_16_1.stage][var_16_0], iter_16_1)
	end

	for iter_16_2, iter_16_3 in pairs(self._monsterLevelData) do
		for iter_16_4, iter_16_5 in pairs(iter_16_3) do
			table.sort(iter_16_5, function(arg_17_0, arg_17_1)
				return arg_17_0.id < arg_17_1.id
			end)
		end
	end
end

function AllianceTrialData:onS2CAllianceTrialGive(arg_18_1)
	self._giveTimes = self._giveTimes + 1
end

function AllianceTrialData:onS2CAllianceTrialBoxAward(arg_19_1)
	self._weeklyBoxTimes = self._weeklyBoxTimes + 1
	self:getBoxData(arg_19_1.level)[arg_19_1.box.index] = arg_19_1.box
	self._awardNumDict[arg_19_1.level] = self._awardNumDict[arg_19_1.level] or {}

	local var_19_0 = arg_19_1.box.reward_id

	if not self._awardNumDict[arg_19_1.level][arg_19_1.box.reward_id] then
		self._awardNumDict[arg_19_1.level][var_19_0] = 0
	end

	self._awardNumDict[arg_19_1.level][var_19_0] = self._awardNumDict[arg_19_1.level][var_19_0] + 1

	if var_0_0.get(var_19_0).box_type == var_0_1.TRIAL.BOX_TYPE0 then
		self._hideAwardNumDict[arg_19_1.level] = self._hideAwardNumDict[arg_19_1.level] or 0
		self._hideAwardNumDict[arg_19_1.level] = self._hideAwardNumDict[arg_19_1.level] + 1
	end
end

function AllianceTrialData:onS2CAllianceTrialBoxInfo(arg_20_1)
	self._serverRedBoxAward = false
	self._isGetBoxInfo = true

	if arg_20_1.level == 0 then
		self._boxData = {}
		self._awardNumDict = {}
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_1.boxes or {}) do
		self._boxData[iter_20_1.level] = {}
		self._awardNumDict[iter_20_1.level] = {}

		for iter_20_2, iter_20_3 in ipairs(iter_20_1.boxes or {}) do
			self._boxData[iter_20_1.level][iter_20_3.index] = iter_20_3
			self._awardNumDict[iter_20_1.level][iter_20_3.reward_id] = self._awardNumDict[iter_20_1.level][iter_20_3.reward_id] or 0
			self._awardNumDict[iter_20_1.level][iter_20_3.reward_id] = self._awardNumDict[iter_20_1.level][iter_20_3.reward_id] + 1

			if var_0_0.get(iter_20_3.reward_id).box_type == var_0_1.TRIAL.BOX_TYPE0 then
				self._hideAwardNumDict[iter_20_1.level] = self._hideAwardNumDict[iter_20_1.level] or 0
				self._hideAwardNumDict[iter_20_1.level] = self._hideAwardNumDict[iter_20_1.level] + 1
			end
		end
	end
end

function AllianceTrialData:onS2CAllianceTrialUpdateMonster(arg_21_1)
	self:getMonsterServerData(arg_21_1.monster.id).lost_hp = arg_21_1.monster.lost_hp
end

function AllianceTrialData:onS2CAllianceTrialChallenge(arg_22_1)
	if arg_22_1.is_win then
		self._challengeTimes = arg_22_1.times or self._challengeTimes
		self._passMonsterDict[arg_22_1.monster_id] = self._passMonsterDict[arg_22_1.monster_id] or {}
		self._passMonsterDict[arg_22_1.monster_id][arg_22_1.difficulty] = true
	end
end

function AllianceTrialData:onS2CAllianceTrialUpdateUser(arg_23_1)
	self._receiveTimes = arg_23_1.receive_times
end

function AllianceTrialData:onS2CAllianceTrialNotifyLevel(arg_24_1)
	self._level = arg_24_1.level
	self._serverRedBoxAward = true
	self._isNeedCloud = true

	self:_updateServerMonster(arg_24_1.monsters or {})
end

function AllianceTrialData:_updateServerMonster(arg_25_1)
	self._monsterServerDict = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		self._monsterServerDict[iter_25_1.id] = iter_25_1
	end
end

function AllianceTrialData:getBoxData(arg_26_1)
	local var_26_0 = self._boxData[arg_26_1] or {}

	self._boxData[arg_26_1] = var_26_0

	return var_26_0
end

function AllianceTrialData:getMonsterServerData(arg_27_1)
	self._monsterServerDict[arg_27_1] = self._monsterServerDict[arg_27_1] or {}

	return self._monsterServerDict[arg_27_1]
end

function AllianceTrialData:getUserDict()
	return self._userDict
end

function AllianceTrialData:getUserPos(arg_29_1)
	return self._userDict[arg_29_1] or cc.p(0, 0)
end

function AllianceTrialData:getNeedRemoveUser()
	return self._needRemoveUser
end

function AllianceTrialData:resetNeedRemoveUser()
	self._needRemoveUser = {}
end

function AllianceTrialData:resetDayTimes()
	self._challengeTimes = 0
	self._receiveTimes = 0
	self._giveTimes = 0
end

function AllianceTrialData:getBoxRewardNum(arg_33_1, arg_33_2)
	if not self._awardNumDict[arg_33_1] then
		return 0
	end

	return self._awardNumDict[arg_33_1][arg_33_2] or 0
end

function AllianceTrialData:getMonsterDataByStage(arg_34_1)
	arg_34_1 = arg_34_1 or self:getStage()

	return self._monsterLevelData[arg_34_1] or {}
end

function AllianceTrialData:getCurMonsterInfoList()
	return self:getMonsterDataByStageAndLevel(self:getStage(), self:getLevel())
end

function AllianceTrialData:getMonsterInfoByBindId(arg_36_1)
	return self:getCurMonsterInfoList()[arg_36_1]
end

function AllianceTrialData:getMonsterDataByStageAndLevel(arg_37_1, arg_37_2)
	if not self._monsterLevelData[arg_37_1] then
		return {}
	end

	return self._monsterLevelData[arg_37_1][arg_37_2] or {}
end

function AllianceTrialData:monsterIsDead(arg_38_1)
	return (self:getMonsterServerData(arg_38_1).lost_hp or 0) >= var_0_2.get(arg_38_1).monster_group_hp
end

function AllianceTrialData:canChallengeMonster(arg_39_1)
	return not self:monsterIsDead(arg_39_1) or self:isLevelFinish()
end

function AllianceTrialData:getLastChallengeCount()
	return g.core.model.User.allianceData:getParams(var_0_1.PARAMETER.TRIAL_DAILY_CHALLENGE) + self._receiveTimes - self._challengeTimes
end

function AllianceTrialData:getMonsterHp(arg_41_1)
	return var_0_2.get(arg_41_1).monster_group_hp - (self:getMonsterServerData(arg_41_1).lost_hp or 0)
end

function AllianceTrialData:getLastGiveCount()
	return g.core.model.User.allianceData:getParams(var_0_1.PARAMETER.TRIAL_DAILY_GIVE) - self._giveTimes
end

function AllianceTrialData:isLevelFinish(arg_43_1)
	arg_43_1 = arg_43_1 or self._level

	if arg_43_1 < self._level then
		return true
	end

	if arg_43_1 > self._level then
		return false
	end

	for iter_43_0, iter_43_1 in ipairs((self:getCurMonsterInfoList())) do
		if not self:monsterIsDead(iter_43_1.id) then
			return false
		end
	end

	return true
end

function AllianceTrialData:isBoxAwarded(arg_44_1)
	local var_44_0 = g.core.model.User:getId()

	for iter_44_0, iter_44_1 in pairs((self:getBoxData(arg_44_1))) do
		if iter_44_1.user_id == var_44_0 then
			return true
		end
	end

	return false
end

function AllianceTrialData:getRandomBoxIndex(arg_45_1)
	local var_45_0 = self:getBoxData(arg_45_1)
	local var_45_1 = self._hideAwardNumDict[arg_45_1]
	local var_45_2

	if not self._hideAwardNumDict[arg_45_1] then
		var_45_1 = 0
		var_45_2 = self:getBoxInfoData(arg_45_1).boxNum1
	end

	if var_45_2 <= #var_45_0 - var_45_1 then
		return #var_45_0 + 1
	end

	local var_45_3 = {}

	for iter_45_0 = 1, var_45_2 + var_45_1 do
		if not var_45_0[iter_45_0] then
			table.insert(var_45_3, iter_45_0)
		end
	end

	return var_45_3[math.random(1, #var_45_3)]
end

function AllianceTrialData:getBoxShowNum(arg_46_1)
	arg_46_1 = arg_46_1 or self._level

	local var_46_0 = #self:getBoxData(arg_46_1)
	local var_46_1 = self._hideAwardNumDict[arg_46_1]
	local var_46_2

	if not self._hideAwardNumDict[arg_46_1] then
		var_46_1 = 0
		var_46_2 = self:getBoxInfoData(arg_46_1).boxNum1
	end

	if var_46_2 <= var_46_0 - var_46_1 then
		return var_46_0 + 1
	else
		return var_46_2 + var_46_1
	end
end

function AllianceTrialData:getBoxInfoData(arg_47_1)
	arg_47_1 = arg_47_1 or self._level

	if self._boxInfoData[arg_47_1] then
		return self._boxInfoData[arg_47_1]
	end

	local var_47_0 = {}
	local var_47_1 = {}
	local var_47_2 = 0

	for iter_47_0, iter_47_1 in var_0_0.ipairs() do
		if iter_47_1.stage == self._stage and arg_47_1 == iter_47_1.level then
			if iter_47_1.box_type == var_0_1.TRIAL.BOX_TYPE1 then
				table.insert(var_47_0, iter_47_1)

				var_47_2 = var_47_2 + iter_47_1.max_num
				var_47_1[iter_47_1.id] = iter_47_1.max_num
			elseif iter_47_1.box_type == var_0_1.TRIAL.BOX_TYPE2 then
				table.insert(var_47_0, iter_47_1)
			end
		end
	end

	self._boxInfoData[arg_47_1] = {
		boxNum1 = var_47_2,
		boxAwardList = var_47_0,
		boxRewardNumDict = var_47_1
	}

	return self._boxInfoData[arg_47_1]
end

function AllianceTrialData:getBoxAwardData(arg_48_1, arg_48_2)
	return self:getBoxData(arg_48_1)[arg_48_2]
end

function AllianceTrialData:getLastWeeklyOpenCount()
	return g.core.model.User.allianceData:getParams(var_0_1.PARAMETER.TRIAL_WEEKLY_BOX_MAX) - self._weeklyBoxTimes
end

function AllianceTrialData:getShamUserDict(arg_50_1)
	if self._shamUserDict[arg_50_1] then
		return self._shamUserDict[arg_50_1]
	end

	local var_50_0 = g.core.model.User.allianceData:getAllianceMemberList()

	if not var_50_0 then
		return {}
	end

	local var_50_1 = {}
	local var_50_2 = g.core.model.User:getId()
	local var_50_3 = {}

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		if iter_50_1 ~= var_50_2 then
			table.insert(var_50_3, iter_50_1)
		end
	end

	self._shamUserDict[arg_50_1] = var_50_1

	local var_50_4 = g.core.model.User.allianceData:getParams(var_0_1.PARAMETER.TRIAL_SHAM_USER_MIN)
	local var_50_5 = g.core.model.User.allianceData:getParams(var_0_1.PARAMETER.TRIAL_SHAM_USER_MAX)

	for iter_50_2, iter_50_3 in ipairs(self:getCurMonsterInfoList()) do
		if self:canChallengeMonster(iter_50_3.id) then
			var_50_1[iter_50_2] = {}

			for iter_50_4 = 1, math.random(var_50_4, var_50_5) do
				if #var_50_3 == 0 then
					break
				end

				local var_50_6 = math.random(1, #var_50_3)

				table.insert(var_50_1[iter_50_2], var_50_3[var_50_6])
				table.remove(var_50_3, var_50_6)
			end
		end
	end

	return var_50_1
end

function AllianceTrialData:isPassMonster(arg_51_1, arg_51_2)
	return self._passMonsterDict[arg_51_1] and self._passMonsterDict[arg_51_1][arg_51_2]
end

function AllianceTrialData:getSuggestDiffByMonsterId(arg_52_1)
	if self._passMonsterDict[arg_52_1] and self._passMonsterDict[arg_52_1][3] then
		return 3
	elseif self._passMonsterDict[arg_52_1] and self._passMonsterDict[arg_52_1][2] then
		return 2
	else
		return 1
	end
end

function AllianceTrialData:isNeedCloud()
	return self._isNeedCloud
end

function AllianceTrialData:getMinCanGetBoxLevel()
	for iter_54_0, iter_54_1 in pairs((self:getMonsterDataByStage())) do
		if self:isLevelFinish(iter_54_0) and not self:isBoxAwarded(iter_54_0) then
			return iter_54_0
		end
	end

	return 1
end

function AllianceTrialData:onS2CRedPoint(arg_55_1)
	self._challengeTimes = arg_55_1.times or 0
	self._giveTimes = arg_55_1.give_times or 0
	self._receiveTimes = arg_55_1.receive_times or 0
	self._serverRedBoxAward = arg_55_1.box_award
end

function AllianceTrialData:hasRedGiveCount()
	local var_56_0 = g.core.model.User.allianceData:getAllianceMemberList()

	if var_56_0 and #var_56_0 <= 1 then
		return false
	end

	return self:getLastGiveCount() > 0
end

function AllianceTrialData:hasRedChallengeCount()
	return self:getLastChallengeCount() > 0
end

function AllianceTrialData:hasRedGetBoxAward(arg_58_1)
	if self._serverRedBoxAward then
		return true
	end

	if self:getLastWeeklyOpenCount() <= 0 then
		return false
	end

	if not self._isGetBoxInfo then
		return false
	end

	local var_58_0 = arg_58_1.level or 0

	if var_58_0 > 0 then
		return self:isLevelFinish(var_58_0) and not self:isBoxAwarded(var_58_0)
	else
		for iter_58_0, iter_58_1 in pairs((self:getMonsterDataByStage())) do
			if self:isLevelFinish(iter_58_0) and not self:isBoxAwarded(iter_58_0) then
				return true
			end
		end
	end

	return false
end

return AllianceTrialData
