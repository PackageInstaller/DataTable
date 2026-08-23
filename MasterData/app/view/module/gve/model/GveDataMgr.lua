local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.const.ConstMgr.RankAwardConst
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.const.ConstMgr.GveConst
local var_0_5 = g.core.common.Storage
local var_0_6 = g.core.config.gve_equipment_info
local var_0_7 = g.core.config.talent_skill_info
local GveDataMgr = class("GveDataMgr")

function GveDataMgr:ctor()
	self._gveData = nil
	self._bagData = nil
	self._formationData = nil
	self._taskData = nil
	self._instituteData = nil

	self:initData()
end

function GveDataMgr:initData()
	if self._gveData then
		self._gveData:initData()
	end

	if self._bagData then
		self._bagData:initData()
	end

	if self._formationData then
		self._formationData:initData()
	end

	if self._taskData then
		self._taskData:initData()
	end

	if self._instituteData then
		self._instituteData:initData()
	end

	self._seasonId = 0
	self._gveBaseId = 1
	self._signupStartTime = 0
	self._signupEndTime = 0
	self._formalStartTime = 0
	self._formalEndTime = 0
	self._expireTime = 0
	self._gveState = 0
	self._svrOpenDaysLimit = 0
	self._isSignUp = false
	self._rankAwardCfg = nil
	self._rankListData = {}
	self._honorListData = {}
	self._selfRank = 0
	self._allRankShowBoss = {}
	self._honorAwardData = {}
	self._newRankListData = {}
	self._isModify = false
	self._isBelongGuild = false
	self._allUserData = {}
	self._teamId = 0
	self._matchGuild = nil
	self._matchPlayer = nil
	self._gveLastBossDamageList = {}
	self._selfGuildIndex = 0
end

function GveDataMgr:getGveData()
	self._gveData = self._gveData or require("app.view.module.gve.model.GveData").new()

	return self._gveData
end

function GveDataMgr:getGveBagData()
	self._bagData = self._bagData or require("app.view.module.gve.model.GveBagData").new()

	return self._bagData
end

function GveDataMgr:getGveFormationData()
	self._formationData = self._formationData or require("app.view.module.gve.model.GveFormationData").new()

	return self._formationData
end

function GveDataMgr:getGveTaskData()
	self._taskData = self._taskData or require("app.view.module.gve.model.GveTaskData").new()

	return self._taskData
end

function GveDataMgr:getGveInstituteData()
	self._instituteData = self._instituteData or require("app.view.module.gve.model.GveInstituteData").new()

	return self._instituteData
end

function GveDataMgr:onS2CGVEUserDataFlush(arg_8_1)
	self:getGveFormationData():setKnightPosAndActionByList(arg_8_1.knights, arg_8_1.recover_ts)
	self:getGveData():onUpdatePosCellCtrlData(arg_8_1.cells)
	self:getGveData():updateMyAtkNums(arg_8_1.challenge_win_count)
end

function GveDataMgr:onS2CGVESelectedKnight(arg_9_1)
	self:getGveFormationData():setKnightPosAndAction(arg_9_1)
end

function GveDataMgr:onWorldCellDetail(arg_10_1)
	self:getGveFormationData():onWorldCellDetail(arg_10_1)
	self:getGveData():onWorldCellDetail(arg_10_1)
end

function GveDataMgr:onS2CFlushRedPoint(arg_11_1)
	self:onS2CGVEGetInfo(arg_11_1)
	self:getGveInstituteData():updateWithRedPoint(arg_11_1)
	self:getGveData():onRedPointInfo(arg_11_1)

	if arg_11_1.team_id then
		self:setPioneerTeamId(arg_11_1.team_id)
	end
end

function GveDataMgr:onS2CGVEGetInfo(arg_12_1)
	if arg_12_1.activity then
		self._seasonId = arg_12_1.activity.activity_id or 0
		self._gveBaseId = arg_12_1.activity.activity_sub_id or 1
		self._signupStartTime = arg_12_1.activity.signup_start_time or 0
		self._signupEndTime = arg_12_1.activity.signup_end_time or 0
		self._formalStartTime = arg_12_1.activity.start_time or 0
		self._formalEndTime = arg_12_1.activity.end_time or 0
		self._expireTime = arg_12_1.activity.expire_time or 0
		self._svrOpenDaysLimit = arg_12_1.activity.open_day or 0
	end

	if arg_12_1.signup then
		self._isSignUp = arg_12_1.signup
	end

	if arg_12_1.halidom_info and next(arg_12_1.halidom_info) then
		self:getGveBagData():updateRedInfo(arg_12_1)
	end

	self:getGveTaskData():updateTaskRewardStatus(arg_12_1.task_award_enable)
	self:_initSeasonRankAwardCfg()

	if self:isOpen() and not self._isReqGveChatData then
		self._isReqGveChatData = true
	end

	self:getGveData():setTodayRandBossRandTime(arg_12_1.day_award_time)
end

function GveDataMgr:onS2CGVESignUpSuccess()
	self._isSignUp = true
end

function GveDataMgr:onS2CGetGVETeamInfo(arg_14_1)
	self._isModify = arg_14_1.modify or false
	self._isBelongGuild = arg_14_1.notice or false

	if arg_14_1.team then
		self._teamId = arg_14_1.team.team_id
		self._teamAllianceId = arg_14_1.team.alliance_id

		self:getTeamAllianceInfo()
	end

	self._playerFirstEnterTime = arg_14_1.start_time or var_0_1:getTime()
end

function GveDataMgr:getMyFirstEnterTime()
	return self._playerFirstEnterTime or var_0_1:getTime()
end

function GveDataMgr:onS2CGetGVEUserList(arg_16_1)
	if arg_16_1.list then
		self._matchPlayer = arg_16_1.list

		self:sortMatchPlayerList(self._matchPlayer)
	end
end

function GveDataMgr:getMatchPlayerByJob(arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self._matchPlayer) do
		local var_17_1 = var_0_6.fetch(iter_17_1.halidom_id)

		if var_17_1 and var_17_1.job == arg_17_1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	self:sortMatchPlayerList(var_17_0)

	return var_17_0
end

function GveDataMgr:sortMatchPlayerList(arg_18_1)
	if not arg_18_1 then
		return
	end

	table.sort(arg_18_1, function(arg_19_0, arg_19_1)
		local var_19_0 = var_0_6.fetch(arg_19_0.halidom_id)
		local var_19_1 = 0
		local var_19_2 = 0

		if var_19_0 then
			var_19_1 = var_19_0.level
		end

		local var_19_3 = var_0_6.fetch(arg_19_1.halidom_id)

		if var_19_3 then
			var_19_2 = var_19_3.level
		end

		if var_19_1 ~= var_19_2 then
			return var_19_2 < var_19_1
		end

		if arg_19_0.user_id ~= arg_19_1.user_id then
			return arg_19_0.user_id < arg_19_1.user_id
		end

		return false
	end)
end

function GveDataMgr:onS2CGetGVEGuildList(arg_20_1)
	if arg_20_1.list then
		self._matchGuild = arg_20_1.list

		table.sort(self._matchGuild, function(arg_21_0, arg_21_1)
			if arg_21_0.guild.sid ~= arg_21_1.guild.sid then
				return arg_21_0.guild.sid < arg_21_1.guild.sid
			end

			if arg_21_0.guild.id ~= arg_21_1.guild.id then
				return arg_21_0.guild.id < arg_21_1.guild.id
			end

			return false
		end)
	end
end

function GveDataMgr:onS2CGVETeamModify(arg_22_1)
	self._isModify = true
end

function GveDataMgr:onS2CGVETeamRankList(arg_23_1)
	if arg_23_1.list then
		self._rankListData = arg_23_1.list
	end
end

function GveDataMgr:onS2CGVEHonorRankList(arg_24_1)
	if not next(self._allRankShowBoss) then
		for iter_24_0, iter_24_1 in g.core.config.gve_boss_info.ipairs() do
			if iter_24_1.rank_award_1 ~= 0 then
				table.insert(self._allRankShowBoss, iter_24_1.id)
			end
		end
	end

	local var_24_0 = self:getGveTimeState()

	for iter_24_2, iter_24_3 in ipairs(self._allRankShowBoss) do
		local var_24_1 = self._gveData:getBossData(iter_24_3, nil, nil)

		self._honorListData[iter_24_3] = {
			isDead = var_24_0 == var_0_4.GVE_TIME_STATE.RESULT and true or var_24_1:getBossData().isDead,
			id = iter_24_3
		}
	end

	if arg_24_1.first_kill_datas then
		for iter_24_4, iter_24_5 in ipairs(arg_24_1.first_kill_datas or {}) do
			self._honorListData[iter_24_5.id] = self._honorListData[iter_24_5.id] or {}
			self._honorListData[iter_24_5.id].isDead = true
			self._honorListData[iter_24_5.id].deadData = iter_24_5
			self._honorListData[iter_24_5.id].id = iter_24_5.id
			self._honorListData[iter_24_5.id].userId = iter_24_5.user_id
			self._honorListData[iter_24_5.id].team = iter_24_5.team
		end

		table.sort(self._honorListData, function(arg_25_0, arg_25_1)
			if arg_25_0.id ~= arg_25_1.id then
				return arg_25_0.id < arg_25_1.id
			end

			return false
		end)

		self._honorAwardData = {}

		if arg_24_1.award_id then
			for iter_24_6, iter_24_7 in ipairs(arg_24_1.award_id) do
				self._honorAwardData[iter_24_7] = true
			end
		end
	end
end

function GveDataMgr:getAwardHonor(arg_26_1)
	self._honorAwardData[arg_26_1] = true
end

function GveDataMgr:isAwardHonor(arg_27_1)
	return self._honorAwardData[arg_27_1]
end

function GveDataMgr:isHasHonorAward()
	local var_28_0 = self:getPioneerTeamId()

	if not (var_28_0 and var_28_0 > 0) then
		return false
	end

	for iter_28_0, iter_28_1 in pairs(self._honorListData) do
		if iter_28_1.isDead and not self._honorAwardData[iter_28_0] then
			return true
		end
	end

	return false
end

function GveDataMgr:onUpdateBossDeadState()
	for iter_29_0, iter_29_1 in pairs(self._honorListData) do
		iter_29_1.isDead = not self:getGveData():isBossAlive(iter_29_1.id)
	end
end

function GveDataMgr:isOpen()
	if not var_0_0:isModuleUnlock(var_0_3.GVE) then
		return false
	end

	if var_0_1:getOpenDays() < self._svrOpenDaysLimit then
		return false
	end

	local var_30_0 = var_0_1:getTime()

	if var_30_0 < self._signupStartTime or var_30_0 > self._expireTime then
		return false
	end

	return true
end

function GveDataMgr:isGveModuleOpen()
	if var_0_1:getOpenDays() < self._svrOpenDaysLimit then
		return false
	end

	local var_31_0 = var_0_1:getTime()

	if var_31_0 < self._signupStartTime or var_31_0 > self._expireTime then
		return false
	end

	return true
end

function GveDataMgr:isOpenChat()
	if not var_0_0:isModuleUnlock(var_0_3.GVE) then
		return false
	end

	if var_0_1:getOpenDays() < self._svrOpenDaysLimit then
		return false
	end

	local var_32_0 = var_0_1:getTime()

	if var_32_0 < self._signupStartTime or var_32_0 > self._expireTime then
		return false
	end

	if self:getGveTimeState() ~= var_0_4.GVE_TIME_STATE.FORMAL then
		return false
	end

	return true
end

function GveDataMgr:getGveTimeState()
	local var_33_0 = 0

	if not self:isOpen() then
		var_33_0 = var_0_4.GVE_TIME_STATE.NOTOPEN
	else
		local var_33_1 = var_0_1:getTime()

		if var_33_1 > self._signupStartTime and var_33_1 < self._formalStartTime then
			var_33_0 = var_0_4.GVE_TIME_STATE.SIGNUP
		elseif var_33_1 > self._formalStartTime and var_33_1 < self._formalEndTime then
			var_33_0 = var_0_4.GVE_TIME_STATE.FORMAL
		elseif var_33_1 > self._formalEndTime and var_33_1 < self._expireTime then
			var_33_0 = var_0_4.GVE_TIME_STATE.RESULT
		end
	end

	return var_33_0
end

function GveDataMgr:_initSeasonRankAwardCfg()
	if self._rankAwardCfg and self._gveBaseId ~= 0 then
		return
	end

	if self:getGveBaseCfg() then
		self._rankAwardCfg = {}
		self._rankAwardCfg = g.core.config.rank_award_info.match(function(arg_35_0)
			return arg_35_0.rank_type == var_0_2.GVE and arg_35_0.activity_id == self._gveBaseId
		end)
	end
end

function GveDataMgr:getSeasonRankAwardList()
	return self._rankAwardCfg
end

function GveDataMgr:getSeasonRankList()
	return self._rankListData
end

function GveDataMgr:getSeasonHonorList()
	return self._honorListData
end

function GveDataMgr:getGveBaseId()
	return self._gveBaseId
end

function GveDataMgr:getGveBaseCfg()
	return g.core.config.gve_info.fetch(self._gveBaseId)
end

function GveDataMgr:getChallengeReward()
	local var_41_0 = self:getGveBaseCfg()

	if var_41_0 then
		return g.core.common.Drops:getGoodsArray(var_41_0.challenge_reward)
	end

	return {}
end

function GveDataMgr:getGveIsSignUp()
	return self._isSignUp
end

function GveDataMgr:isCanSignUp()
	local var_43_1 = var_0_1:getTime()

	return (var_43_1 > self._signupStartTime and var_43_1 < self._signupEndTime or nil) and true
end

function GveDataMgr:getGveSignUpStartTime()
	return self._signupStartTime
end

function GveDataMgr:getGveSignUpEndTime()
	return self._formalStartTime
end

function GveDataMgr:getGveFormalEndTime()
	return self._formalEndTime
end

function GveDataMgr:getGveExpireEndTime()
	return self._expireTime
end

function GveDataMgr:setPioneerTeamId(arg_48_1)
	self._teamId = arg_48_1
end

function GveDataMgr:getPioneerTeamId()
	return self._teamId
end

function GveDataMgr:getPioneerTeamLeader()
	local var_50_0 = self:getTeamAllianceInfo()

	return (var_50_0 or nil) and {
		id = var_50_0.leader_id,
		name = var_50_0.leader_name
	}
end

function GveDataMgr:isModifyTeamInfo()
	return self._isModify
end

function GveDataMgr:isBelongGuildTeam()
	return self._isBelongGuild
end

function GveDataMgr:getTeamAllianceInfo()
	local var_53_0 = self._teamAllianceId or g.core.model.User:getAllianceId()

	if var_53_0 then
		self._teamAllianceInfo = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_53_0)
	end

	return self._teamAllianceInfo
end

function GveDataMgr:getPioneerTeamName()
	local var_54_0 = ""
	local var_54_1 = self:getTeamAllianceInfo()

	if var_54_1 then
		var_54_0 = var_54_1.name

		if string.len(var_54_1.name) == 0 then
			var_54_0 = g.core.lang:get(309135, {
				num = self._teamId
			})
		end
	end

	return var_54_0
end

function GveDataMgr:getPioneerTeamIconId()
	local var_55_1 = self:getTeamAllianceInfo()

	return (var_55_1 or nil) and var_55_1.flag
end

function GveDataMgr:isTeamInSeasonRank()
	if self._selfRank > 0 then
		return true
	end

	return false
end

function GveDataMgr:getMyRankIdx()
	local var_57_0 = g.core.lang:get(302501)

	return (self._selfRank > 0 or nil) and self._selfRank
end

function GveDataMgr:getBestTeamRankData()
	return self._newRankListData[1]
end

function GveDataMgr:getMatchGuildList()
	return self._matchGuild
end

function GveDataMgr:getMatchPlayerList()
	return self._matchPlayer
end

function GveDataMgr:isHasHalidomJob()
	if self._matchPlayer then
		for iter_61_0, iter_61_1 in ipairs(self._matchPlayer) do
			local var_61_0 = var_0_6.fetch(iter_61_1.halidom_id)

			if var_61_0 and var_61_0.job > 0 then
				return true
			end
		end
	end

	return false
end

function GveDataMgr:getCampaignEntranceCDTime()
	local var_62_0 = 0
	local var_62_1 = self:getGveTimeState()

	if var_62_1 == var_0_4.GVE_TIME_STATE.SIGNUP then
		var_62_0 = self._formalStartTime
	elseif var_62_1 == var_0_4.GVE_TIME_STATE.FORMAL then
		var_62_0 = self._formalEndTime
	elseif var_62_1 == var_0_4.GVE_TIME_STATE.RESULT then
		var_62_0 = self._expireTime
	end

	return var_62_0
end

function GveDataMgr:getCampaignEntranceStr()
	local var_63_0 = g.core.lang:get(100539)
	local var_63_1 = self:getGveTimeState()

	if var_63_1 == var_0_4.GVE_TIME_STATE.SIGNUP then
		var_63_0 = g.core.lang:get(309167)
	elseif var_63_1 == var_0_4.GVE_TIME_STATE.FORMAL then
		var_63_0 = g.core.lang:get(309168)
	elseif var_63_1 == var_0_4.GVE_TIME_STATE.RESULT then
		var_63_0 = g.core.lang:get(309169)
	end

	return var_63_0
end

function GveDataMgr:isCurSeasonOpenConfirmPop()
	for iter_64_0, iter_64_1 in ipairs(var_0_5:load("season_open_confirmPop.json", true) or {}) do
		if iter_64_1.seasonId == self._seasonId then
			return iter_64_1.isPop
		end
	end

	return true
end

function GveDataMgr:setCurSeasonNoConfirmPop(arg_65_1)
	local var_65_0 = var_0_5:load("season_open_confirmPop.json", true) or {}
	local var_65_1 = false

	for iter_65_0, iter_65_1 in ipairs(var_65_0) do
		if iter_65_1.seasonId == self._seasonId then
			iter_65_1.isPop = not arg_65_1
			var_65_1 = true
		end
	end

	if not var_65_1 then
		table.insert(var_65_0, {
			seasonId = self._seasonId,
			isPop = not arg_65_1
		})
	end

	var_0_5:save("season_open_confirmPop.json", var_65_0, true)
end

function GveDataMgr:onAllUserData(arg_66_1)
	self._allUserData = {}

	if arg_66_1.user_num then
		for iter_66_0, iter_66_1 in ipairs(arg_66_1.user_num) do
			local var_66_0 = bit.rshift(iter_66_1.id, 16)

			self._allUserData[var_66_0] = self._allUserData[var_66_0] or {}

			table.insert(self._allUserData[var_66_0], {
				level = iter_66_1.id % 32768,
				playerNum = iter_66_1.num
			})
		end
	end
end

function GveDataMgr:getAllUpLvUserNum(arg_67_1, arg_67_2, arg_67_3)
	arg_67_3 = arg_67_3 or 9999999

	local var_67_0 = 0

	if arg_67_1 == -1 then
		for iter_67_0, iter_67_1 in pairs(self._allUserData) do
			for iter_67_2, iter_67_3 in ipairs(iter_67_1) do
				if arg_67_2 <= iter_67_3.level and arg_67_3 > iter_67_3.level then
					var_67_0 = var_67_0 + iter_67_3.playerNum
				end
			end
		end
	else
		for iter_67_4, iter_67_5 in ipairs(self._allUserData[arg_67_1] or {}) do
			if arg_67_2 <= iter_67_5.level and arg_67_3 > iter_67_5.level then
				var_67_0 = var_67_0 + iter_67_5.playerNum
			end
		end
	end

	return var_67_0
end

function GveDataMgr:getCurArmyAddProduct()
	local var_68_0 = 0
	local var_68_1 = self:getGveBagData()

	if self:getGveBagData():getCoreHalidomBranch() == var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH then
		if self:getGveBagData():getCoreHalidomLevel() >= var_68_1.cfg.main_skill_unlock_level then
			var_68_0 = var_68_1.cfg.main_skill_param_3 / 1000
		end
	end

	local var_68_2 = self:getAllUpLvUserNum(var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH, var_68_1:getAllTargetJobSkillCfg(var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH)[1].needLv)

	if var_68_2 > 0 then
		return var_68_1.cfg.main_skill_param_1 * math.min(var_68_1.cfg.main_skill_param_2, var_68_2) / 1000 + var_68_0
	end

	return var_68_0
end

function GveDataMgr:getAllArmyBuff(arg_69_1)
	local var_69_0 = {}
	local var_69_1 = self:getGveBagData():getAllTargetJobSkillCfg(var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH)

	for iter_69_0, iter_69_1 in ipairs(var_69_1) do
		if var_69_1[iter_69_0 + 1] then
			-- block empty
		end

		if iter_69_1.cfg.main_skill_type == var_0_4.GVE_SKILL_BUFF.ARMY_1 then
			local var_69_4 = self:getAllUpLvUserNum(var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH, iter_69_1.needLv)

			if var_69_4 > 0 then
				table.insert(var_69_0, {
					cfg = iter_69_1.cfg,
					param = iter_69_1.cfg.main_skill_param_1 * math.min(iter_69_1.cfg.main_skill_param_2, var_69_4) / 10
				})
			end

			if arg_69_1 then
				if self:getGveBagData():getCoreHalidomLevel() >= iter_69_1.needLv then
					table.insert(var_69_0, {
						isMine = true,
						cfg = iter_69_1.cfg,
						param = iter_69_1.cfg.main_skill_param_3 / 10
					})
				end
			end
		elseif iter_69_1.cfg.main_skill_type == var_0_4.GVE_SKILL_BUFF.ARMY_2 then
			local var_69_5 = self:getAllUpLvUserNum(var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH, iter_69_1.needLv)
			local var_69_6 = self:getAllUpLvUserNum(-1, iter_69_1.needLv)

			if var_69_5 > 0 and var_69_6 >= iter_69_1.cfg.main_skill_param_1 then
				local var_69_7 = var_0_7.get(iter_69_1.cfg.main_skill_param_2).affect_value_1 / 10

				table.insert(var_69_0, {
					cfg = iter_69_1.cfg,
					param = math.min(math.floor(var_69_6 / iter_69_1.cfg.main_skill_param_1) * var_69_7 * var_69_5, iter_69_1.cfg.main_skill_param_3 * var_69_7)
				})
			end

			if arg_69_1 then
				if self:getGveBagData():getCoreHalidomLevel() >= iter_69_1.needLv then
					table.insert(var_69_0, {
						isMine = true,
						cfg = iter_69_1.cfg,
						param = iter_69_1.cfg.main_skill_param_4 / 10
					})
				end
			end
		elseif iter_69_1.cfg.main_skill_type == var_0_4.GVE_SKILL_BUFF.ARMY_3 then
			local var_69_8 = self:getAllUpLvUserNum(var_0_4.GVE_HALIDOM_BRANCH.ARMY_BRANCH, iter_69_1.needLv)
			local var_69_9 = self:getAllUpLvUserNum(var_0_4.GVE_HALIDOM_BRANCH.SERVICE_BRANCH, iter_69_1.needLv)

			if var_69_8 > 0 and var_69_9 >= iter_69_1.cfg.main_skill_param_1 then
				local var_69_10 = var_0_7.get(iter_69_1.cfg.main_skill_param_2).affect_value_1 / 10

				table.insert(var_69_0, {
					cfg = iter_69_1.cfg,
					param = math.min(math.floor(var_69_9 / iter_69_1.cfg.main_skill_param_1) * var_69_10 * var_69_8, iter_69_1.cfg.main_skill_param_3 * var_69_10)
				})
			end

			if arg_69_1 then
				if self:getGveBagData():getCoreHalidomLevel() >= iter_69_1.needLv then
					table.insert(var_69_0, {
						isMine = true,
						cfg = iter_69_1.cfg,
						param = iter_69_1.cfg.main_skill_param_4 / 10
					})
				end
			end
		end
	end

	return var_69_0
end

function GveDataMgr:isArmyBuffEffective()
	return
end

function GveDataMgr:getAllUserData()
	return self._allUserData
end

function GveDataMgr:isSiteHasKnightAdd(arg_72_1)
	if not self:isInFormalStage() then
		return false
	end

	if arg_72_1 and arg_72_1.point then
		return self:getGveData():isSiteCanUpKnight(arg_72_1.point)
	else
		return self:getGveData():hasSiteCanUpKnight()
	end
end

function GveDataMgr:hasKnightPoolSpace()
	if not self:isInFormalStage() then
		return false
	end

	local var_73_0 = self:getGveFormationData()
	local var_73_1 = false
	local var_73_2 = self:getGveBaseCfg().position_max

	for iter_73_0, iter_73_1 in pairs(var_73_0:getEquipKnightList()) do
		if not iter_73_1.knight and var_73_2 >= iter_73_1.pos then
			var_73_1 = true

			break
		end
	end

	if not var_73_1 then
		return false
	end

	return (var_73_0:hasKnightCanEquip())
end

function GveDataMgr:hasKnightActionFull()
	if not self:isInFormalStage() then
		return false
	end

	local var_74_0 = self:getGveFormationData()
	local var_74_1 = false
	local var_74_2 = self:getGveBaseCfg().action_max

	for iter_74_0, iter_74_1 in pairs(var_74_0:getEquipKnightList()) do
		if iter_74_1.knight and var_74_2 <= iter_74_1.action then
			var_74_1 = true

			break
		end
	end

	return var_74_1
end

function GveDataMgr:hasUniteCanLineUp()
	return false
end

function GveDataMgr:hasPetCanLineUp()
	return false
end

function GveDataMgr:hasIdleTimeAward()
	if not self:isInFormalStage() then
		return false
	end

	return self:getGveData():getAllIdleTime() > 64800
end

function GveDataMgr:hasEquipNormalHalidom()
	local var_78_0 = self:getGveBagData()

	for iter_78_0 = 1, 6 do
		if var_78_0:getPositionStatus(iter_78_0) == var_0_4.HALIDOM_STATUS.CAN_EUIP then
			return true
		end
	end

	return false
end

function GveDataMgr:isCanLevelUpCoreHalidom()
	if not self:isInFormalStage() then
		return false
	end

	return self:getGveBagData():canCoreHalidomLevelUp1()
end

function GveDataMgr:isComposeAnylHalidom(arg_80_1)
	if not self:isInFormalStage() then
		return false
	end

	local var_80_0 = var_0_4.HALIDOM_STATUS
	local var_80_1 = self:getGveBagData()
	local var_80_2 = 0
	local var_80_3 = false

	for iter_80_0 = 1, 6 do
		if var_80_1:getPositionStatus(iter_80_0) == var_80_0.CAN_NOT_EUIP then
			var_80_2 = var_80_2 + 1
		end

		if var_80_1:getPositionStatus(iter_80_0) == var_80_0.CAN_COMPOSE then
			var_80_3 = true
		end
	end

	if var_80_3 and var_80_2 == 0 then
		var_80_3 = false
	end

	return var_80_3
end

function GveDataMgr:isComposeAllHalidom(arg_81_1)
	if not self:isInFormalStage() then
		return false
	end

	local var_81_0 = var_0_4.HALIDOM_STATUS
	local var_81_1 = self:getGveBagData()
	local var_81_2 = true
	local var_81_3 = 0

	for iter_81_0 = 1, 6 do
		local var_81_4 = var_81_1:getPositionStatus(iter_81_0)

		if var_81_4 == var_81_0.HAVE_EQUIP then
			var_81_3 = var_81_3 + 1
		end

		if var_81_4 ~= var_81_0.CAN_COMPOSE and var_81_4 ~= var_81_0.HAVE_EQUIP then
			var_81_2 = false
		end
	end

	return (var_81_3 == 6 or nil) and false
end

function GveDataMgr:isTaskHaveAward(arg_82_1)
	if not self:isInFormalStage() then
		return false
	end

	return self:getGveTaskData():haveTaskRedPoint()
end

function GveDataMgr:getSeasonId()
	return self._seasonId
end

function GveDataMgr:isInSignUpStage()
	return self:getGveTimeState() == var_0_4.GVE_TIME_STATE.SIGNUP
end

function GveDataMgr:isInFormalStage()
	return self:getGveTimeState() == var_0_4.GVE_TIME_STATE.FORMAL
end

function GveDataMgr:isKillResearchOpenAndNotIn()
	if not self:isInFormalStage() then
		return false
	end

	return self:getGveData():isKillResearchOpenAndNotIn()
end

function GveDataMgr:isHasCanResearchKnight()
	if not self:isInFormalStage() then
		return false
	end

	return self:getGveInstituteData():isHasCanResearchKnight()
end

function GveDataMgr:getKnightActionNeedTime(arg_88_1)
	local var_88_0 = self:getGveBaseCfg()
	local var_88_1 = var_88_0.action_cost - self:getGveFormationData():getKnightActionByPos(arg_88_1)

	return (var_88_1 > 0 or nil) and (math.ceil(var_88_1 / var_88_0.action_rate) - 1) * var_88_0.action_time + math.max(0, var_88_0.action_time - (var_0_1:getTime() - self:getGveFormationData():getActionReplyTime()))
end

function GveDataMgr:onSeasonRankDataBack(arg_89_1)
	self._newRankListData = {}

	local var_89_0 = {}
	local var_89_1 = {}

	for iter_89_0, iter_89_1 in ipairs(arg_89_1.data or {}) do
		if not var_89_0[iter_89_1.id] then
			local var_89_2 = {
				bossDamage = iter_89_1.first,
				id = iter_89_1.id
			}

			var_89_0[iter_89_1.id] = var_89_2

			table.insert(var_89_1, var_89_2)
		else
			var_89_0[iter_89_1.id].bossDamage = var_89_0[iter_89_1.id].bossDamage + iter_89_1.first
		end
	end

	table.sort(var_89_1, function(arg_90_0, arg_90_1)
		if arg_90_0.bossDamage ~= arg_90_1.bossDamage then
			return arg_90_0.bossDamage > arg_90_1.bossDamage
		end

		if arg_90_0.id ~= arg_90_1.id then
			return arg_90_0.id < arg_90_1.id
		end

		return false
	end)

	self._selfRank = 0

	for iter_89_2, iter_89_3 in ipairs(var_89_1) do
		if iter_89_3.id == g.core.model.User:getAllianceId() and iter_89_3.bossDamage ~= 0 then
			self._selfRank = iter_89_2

			break
		end
	end

	local var_89_3 = {}

	for iter_89_4, iter_89_5 in ipairs(var_89_1) do
		if iter_89_4 <= 20 and iter_89_5.bossDamage ~= 0 then
			table.insert(var_89_3, iter_89_5)
		else
			break
		end
	end

	self._newRankListData = var_89_3
end

function GveDataMgr:getTempSnapShotWithGuildSnapshot(arg_91_1)
	return {
		frame_id = 0,
		card_id = 0,
		fight_value = 0,
		vip_level = 0,
		avata_id = 0,
		level = 1,
		id = arg_91_1.leader_id,
		sid = arg_91_1.sid,
		name = arg_91_1.leader_name,
		base_id = arg_91_1.leader_base_id,
		dress_id = arg_91_1.leader_dress_id,
		guild_name = arg_91_1.name,
		server_name = arg_91_1.server_name,
		guild_id = arg_91_1.id,
		show_knight_id = arg_91_1.leader_show_knight_id,
		show_knight_dress = arg_91_1.leader_show_knight_dress
	}
end

function GveDataMgr:getRankWorldGuild()
	return self._newRankListData
end

function GveDataMgr:setLastBossDamageDataList(arg_93_1)
	self._gveLastBossDamageList = arg_93_1.data or {}

	table.sort(self._gveLastBossDamageList, function(arg_94_0, arg_94_1)
		if arg_94_0.first ~= arg_94_1.first then
			return arg_94_0.first > arg_94_1.first
		end

		return arg_94_0.id < arg_94_1.id
	end)

	for iter_93_0, iter_93_1 in ipairs(self._gveLastBossDamageList) do
		if iter_93_1.id == g.core.model.User:getAllianceId() and iter_93_1.first ~= 0 then
			self._selfGuildIndex = iter_93_0
		end

		g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, iter_93_1.id)
	end
end

function GveDataMgr:getLastBossDamageDataList()
	return self._gveLastBossDamageList
end

function GveDataMgr:getLastBossDamageGuildRank()
	return self._selfGuildIndex
end

function GveDataMgr:getCondIsUnlock(arg_97_1)
	if not arg_97_1 then
		return false
	end

	if arg_97_1.unlock_type == 1 then
		return self:getGveBagData():getCoreHalidomLevel() >= arg_97_1.unlock_value, arg_97_1.unlock_value
	end

	return true
end

return GveDataMgr
