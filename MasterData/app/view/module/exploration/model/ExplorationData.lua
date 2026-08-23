local var_0_0 = g.core.config.exploration_info
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local RankAward = require("app.core.common.RankAward")
local var_0_4 = g.core.model.User.knightsData
local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationGameData = require("app.view.module.exploration.model.ExplorationGameData")
local ExplorationMapData = require("app.view.module.exploration.model.ExplorationMapData")
local ExplorationFormationData = require("app.view.module.exploration.model.ExplorationFormationData")
local ExplorationTaskData = require("app.view.module.exploration.model.ExplorationTaskData")
local ExplorationData = class("ExplorationData")

function ExplorationData:ctor()
	self:initData()
end

function ExplorationData:initData()
	self._mapData = ExplorationMapData.new()
	self._gameData = ExplorationGameData.new()
	self._formationData = nil
	self._taskData = ExplorationTaskData.new()
	self._serverList = {}
	self._clearRankList = {}
	self._damageRankList = {}
	self._guildRankList = {}
	self._myClearRank = 0
	self._myDamageRank = 0
	self._myGuildRank = 0
	self._rewardList = {}
	self._guildBuffList = {}
	self._guildBuffPlayerList = {}
	self._eventBuffList = {}
	self._shopEnsureSelect = false
	self._challengeTimeDict = {}
	self._bossChallengeNum = 0
	self._passTime = 0
end

function ExplorationData:_initRankAward()
	self._rankAwardDict = {}
	self._rankAwardDict[ExplorationConst.RANK_TYPE.CLEAR] = RankAward:getRankAwardArray(ExplorationConst.RANK_AWARD_TYPE.CLEAR, self._activityId)
	self._rankAwardDict[ExplorationConst.RANK_TYPE.DAMAGE] = RankAward:getRankAwardArray(ExplorationConst.RANK_AWARD_TYPE.DAMAGE, self._activityId)
	self._rankAwardDict[ExplorationConst.RANK_TYPE.GUILD] = RankAward:getRankAwardArray(ExplorationConst.RANK_AWARD_TYPE.GUILD, self._activityId)
end

function ExplorationData:getBaseInfo()
	return var_0_0.fetch(self._activityId)
end

function ExplorationData:getMapData()
	return self._mapData
end

function ExplorationData:getGameData()
	return self._gameData
end

function ExplorationData:getFormationData()
	self._formationData = self._formationData or ExplorationFormationData.new()

	return self._formationData
end

function ExplorationData:getTaskData()
	return self._taskData
end

function ExplorationData:onS2CActionStatusFlush(arg_9_1)
	self._taskData:updateTaskInfo(arg_9_1.status)
end

function ExplorationData:onS2CExplorationUnlockCell(arg_10_1)
	self._mapData:unlockCoordinateAndUpdateEvent(arg_10_1)
	self._mapData:usedActionPoint(arg_10_1.used_action)
end

function ExplorationData:onS2CExplorationMove(arg_11_1)
	self._mapData:setMainRoleCoordinate(arg_11_1.room_id, arg_11_1.x, arg_11_1.y)
end

function ExplorationData:updateBossChallengeCount(arg_12_1)
	self._mapData:setBossChallengeCount(arg_12_1)
end

function ExplorationData:onS2CExplorationEventProcess(arg_13_1)
	if not arg_13_1.event then
		return
	end

	self._mapData:processEvent(arg_13_1)

	if arg_13_1.event.tp == ExplorationConst.EVENT_TYPE.TYPE_BUFF then
		self:addEventBuffId()
	elseif arg_13_1.event.tp == ExplorationConst.EVENT_TYPE.TIP_TASK then
		self._taskData:setCurTaskInfo(self:getBaseInfo().first_task_id)
	end
end

function ExplorationData:onS2CExplorationInfo(arg_14_1)
	if arg_14_1.activity then
		self._activityId = arg_14_1.activity.sub_id
	end

	self:updateExplorationActiveTime(arg_14_1.activity)
	self._mapData:clearEvent()

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.events or {}) do
		self._mapData:addExplorationMiniGame(iter_14_1)
	end

	self._mapData:updateRoomTab(arg_14_1.rooms or {}, true)

	local var_14_0 = arg_14_1.game or {}

	self._mapData:usedActionPoint(var_14_0.used_action or 0)
	self._mapData:setMainRoleCoordinate(var_14_0.room_id, var_14_0.x, var_14_0.y)
	self._mapData:updateMirrorShowUser(arg_14_1.boss_battle_team)
	self._mapData:setBossChallengeCount(arg_14_1.boss_daily_challenge_count)
	self:updateGuildBuff(arg_14_1.guild_buffs)

	if arg_14_1.exploration then
		self:updateEventBuff(arg_14_1.exploration.buff_ids)
	end

	local var_14_1 = {}

	for iter_14_2, iter_14_3 in ipairs(arg_14_1.reward_task_ids or {}) do
		var_14_1[iter_14_3] = true
	end

	if var_14_0.task_id and var_14_0.task_id ~= 0 and not var_14_1[var_14_0.task_id] then
		self._taskData:setCurTaskInfo(var_14_0.task_id)
	end

	if arg_14_1.task_progress then
		for iter_14_4, iter_14_5 in ipairs(arg_14_1.task_progress) do
			self._taskData:updateTaskInfo(iter_14_5)
		end
	end

	self._bossChallengeNum = arg_14_1.boss_daily_challenge_count or 0
end

function ExplorationData:onS2CGetServerInfo(arg_15_1)
	self._serverList = arg_15_1.server_infos or {}
end

function ExplorationData:onS2CFlushRedPoint(arg_16_1)
	self._activityId = arg_16_1.info.sub_id

	self:updateExplorationActiveTime(arg_16_1.info)
	self:updateRedPointInfo(arg_16_1)
	self:_initRankAward()
end

function ExplorationData:onS2CGetCommonRankList(arg_17_1)
	if arg_17_1.id == g.core.network.proto.EXPLORATION_PASS_CROSS then
		self._clearRankList = arg_17_1.rank_units or {}
		self._myClearRank = arg_17_1.self_rank or 0
	elseif arg_17_1.id == g.core.network.proto.EXPLORATION_BOSS_USER_CROSS then
		self._damageRankList = arg_17_1.rank_units or {}
		self._myDamageRank = arg_17_1.self_rank or 0
	elseif arg_17_1.id == g.core.network.proto.EXPLORATION_BOSS_GUILD_CROSS then
		self._guildRankList = arg_17_1.rank_units or {}
		self._myGuildRank = arg_17_1.self_rank or 0
	end
end

function ExplorationData:onS2CGetBossBattleTeam(arg_18_1)
	self._mapData:updateMirrorShowUser(arg_18_1.boss_battle_team)

	if self._passTime == 0 and arg_18_1.boss_battle_team then
		self._passTime = 1
	end
end

function ExplorationData:updateExplorationActiveTime(arg_19_1)
	if arg_19_1 then
		if self._activityData and self._activityData.start_time ~= arg_19_1.start_time then
			self._mapData:resetMapInfo(self._activityData.map_group)
			self._taskData:resetData()
		end

		self._activityData = arg_19_1

		self._mapData:setCurMapId(arg_19_1.map_group)
	end
end

function ExplorationData:updateRedPointInfo(arg_20_1)
	self._passTime = arg_20_1.pass_time or 0

	self._mapData:usedActionPoint(arg_20_1.used_action or 0)
	self._mapData:setBossChallengeCount(arg_20_1.boss_daily_challenge_count or 0)

	self._bossChallengeNum = arg_20_1.boss_daily_challenge_count or 0
end

function ExplorationData:isActivityOpen()
	if not self._activityData then
		return false
	end

	if not var_0_1:isModuleUnlock(var_0_2.EXPLORATION) then
		return false
	end

	return self:isInActiveTime()
end

function ExplorationData:isInActiveTime()
	if not self._activityData then
		return
	end

	local var_22_0 = g.core.common.ServerTime:getTime()

	return var_22_0 >= self._activityData.start_time and var_22_0 <= self._activityData.expire_time
end

function ExplorationData:isOpenDaySatisfy()
	if not self._activityData then
		return
	end

	return g.core.common.ServerTime:getOpenDays() >= self._activityData.open_day
end

function ExplorationData:getTimeData()
	local var_24_0 = 0
	local var_24_1 = 0
	local var_24_2 = 0

	if self._activityData then
		var_24_2 = self._activityData.expire_time
		var_24_1 = self._activityData.end_time
		var_24_0 = self._activityData.start_time
	end

	return var_24_0, var_24_1, var_24_2
end

function ExplorationData:getCurStage()
	local var_25_0 = g.core.common.ServerTime:getTime()

	if var_25_0 >= self._activityData.start_time and var_25_0 <= self._activityData.end_time then
		return ExplorationConst.OPEN_STATE.NORMAL
	elseif var_25_0 >= self._activityData.end_time and var_25_0 <= self._activityData.expire_time then
		return ExplorationConst.OPEN_STATE.FINISH
	else
		return ExplorationConst.OPEN_STATE.NONE
	end
end

function ExplorationData:getBossChallengeNum()
	return self._bossChallengeNum
end

function ExplorationData:getFinishTime()
	if not self._activityData then
		return 0
	end

	local var_27_0 = self:getCurStage()

	if var_27_0 == ExplorationConst.OPEN_STATE.NORMAL then
		return self._activityData.end_time
	elseif var_27_0 == ExplorationConst.OPEN_STATE.FINISH then
		return self._activityData.expire_time
	end

	return 0
end

function ExplorationData:getExplorationStr()
	if not self._activityData then
		return g.core.lang:get(420603)
	end

	local var_28_0 = self:getCurStage()

	if var_28_0 == ExplorationConst.OPEN_STATE.NORMAL then
		return g.core.lang:get(420601)
	elseif var_28_0 == ExplorationConst.OPEN_STATE.FINISH then
		return g.core.lang:get(420602)
	elseif var_28_0 == ExplorationConst.OPEN_STATE.NONE then
		return g.core.lang:get(420603)
	end
end

function ExplorationData:getServerList()
	return self._serverList
end

function ExplorationData:getRankList(arg_30_1)
	if arg_30_1 == ExplorationConst.RANK_TYPE.CLEAR then
		return self._clearRankList, self._myClearRank
	elseif arg_30_1 == ExplorationConst.RANK_TYPE.DAMAGE then
		return self._damageRankList, self._myDamageRank
	elseif arg_30_1 == ExplorationConst.RANK_TYPE.GUILD then
		return self._guildRankList, self._myGuildRank
	end
end

function ExplorationData:getRewardListByType(arg_31_1)
	return self._rankAwardDict[arg_31_1] or {}
end

function ExplorationData:updateGuildBuff(arg_32_1)
	arg_32_1 = arg_32_1 or {}
	self._guildBuffList = {}

	local var_32_0 = {}

	for iter_32_0 = 1, #arg_32_1 do
		var_32_0[arg_32_1[iter_32_0].buff_group] = arg_32_1[iter_32_0].user_ids or {}
	end

	for iter_32_1, iter_32_2 in g.core.config.exploration_guild_buff_info.ipairs() do
		local var_32_1 = var_32_0[iter_32_2.group] or {}

		if iter_32_2.num == math.max(1, #var_32_1) then
			local var_32_2 = 0
			local var_32_3 = iter_32_2.monster
			local var_32_4 = g.core.config.exploration_map_info.match(function(arg_33_0)
				if arg_33_0.guard_level == var_32_3 then
					return arg_33_0
				end
			end)
			local var_32_5

			if #var_32_4 > 0 then
				var_32_2 = var_32_4[1].room
				var_32_5 = var_32_4[1].group
			end

			if not var_32_2 or var_32_5 == self._mapData:getCurMapId() then
				table.insert(self._guildBuffList, {
					id = iter_32_2.id,
					userIdList = var_32_1,
					roomId = var_32_2
				})
			end
		end
	end

	table.sort(self._guildBuffList, function(arg_34_0, arg_34_1)
		local var_34_0 = g.core.config.exploration_guild_buff_info.get(arg_34_0.id)
		local var_34_1 = g.core.config.exploration_guild_buff_info.get(arg_34_1.id)

		if var_34_0.group ~= var_34_1.group then
			return var_34_0.group < var_34_1.group
		end

		return arg_34_0.id > arg_34_1.id
	end)
end

function ExplorationData:getGuildBuffInfoByRoomId(arg_35_1)
	for iter_35_0 = 1, #self._guildBuffList do
		if self._guildBuffList[iter_35_0].roomId == arg_35_1 then
			return g.core.config.exploration_guild_buff_info.get(self._guildBuffList[iter_35_0].id)
		end
	end

	return nil
end

function ExplorationData:updateGuildPlayer(arg_36_1)
	arg_36_1 = arg_36_1 or {}
	self._guildBuffPlayerList = {}

	for iter_36_0 = 1, #arg_36_1 do
		self._guildBuffPlayerList[arg_36_1[iter_36_0].id] = arg_36_1[iter_36_0]
	end
end

function ExplorationData:getGuildBuffList()
	return self._guildBuffList
end

function ExplorationData:getGuildBuffPlayerInfo(arg_38_1)
	return self._guildBuffPlayerList[arg_38_1]
end

function ExplorationData:updateEventBuff(arg_39_1)
	arg_39_1 = arg_39_1 or {}
	self._eventBuffList = {}

	for iter_39_0 = 1, #arg_39_1 do
		table.insert(self._eventBuffList, arg_39_1[iter_39_0])
	end

	self:sortEventBuffList()
end

function ExplorationData:sortEventBuffList()
	return
end

function ExplorationData:saveTempEventBuffId(arg_41_1)
	self._tempEventBuffId = arg_41_1
end

function ExplorationData:addEventBuffId()
	if self._tempEventBuffId then
		table.insert(self._eventBuffList, self._tempEventBuffId)
		self:sortEventBuffList()

		self._tempEventBuffId = nil
	end
end

function ExplorationData:getEventBuffList()
	return self._eventBuffList
end

function ExplorationData:getEventBuffAttrList()
	local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
	local var_44_1 = {}
	local var_44_2 = {}

	for iter_44_0 = 1, #self._eventBuffList do
		var_44_2 = FightValueCalculation.getAttrListByTalentSkillId(g.core.config.exploration_buff_info.get(self._eventBuffList[iter_44_0]).buff_id, var_44_2)
	end

	for iter_44_1, iter_44_2 in pairs(var_44_2) do
		table.insert(var_44_1, {
			type = iter_44_1,
			value = iter_44_2
		})
	end

	return var_44_1
end

function ExplorationData:getBossCanChallengeCount()
	return g.core.config.exploration_boss_info.get(self:getBaseInfo().boss_id).battle_num - self:getMapData():getBossChallengeCount()
end

function ExplorationData:getGameStage()
	return (self._passTime > 0 or nil) and (ExplorationConst.GAME_STAGE.BOSS or ExplorationConst.GAME_STAGE.MIRROR)
end

function ExplorationData:isNotHaveKnight(arg_47_1)
	local var_47_0 = self:getFormationData():getKnightByServerId(arg_47_1)

	if not var_47_0 then
		return false
	end

	if not self:getFormationData():isWithinKnight(arg_47_1) then
		return false
	end

	local var_47_1 = var_47_0:getAdvanceId()

	if checkbool((g.core.common.Storage:load("knight_is_card_click.json", g.core.model.User:getId()) or {})[tostring(var_47_1)]) then
		return false
	else
		local var_47_2 = g.core.common.Storage:load("Exploration_Within_Knight_Dict.json", true) or {}
		local var_47_3 = "season_" .. self._activityId

		if not checkbool(var_47_2["season_" .. self._activityId]) then
			return true
		else
			return not checkbool(var_47_2[var_47_3]["advId_" .. var_47_1])
		end
	end

	return false
end

function ExplorationData:saveWithInKnightStatus(arg_48_1)
	local var_48_0 = g.core.common.Storage:load("Exploration_Within_Knight_Dict.json", true) or {}
	local var_48_1 = "season_" .. self._activityId

	if not var_48_0["season_" .. self._activityId] then
		var_48_0[var_48_1] = {}
	end

	var_48_0[var_48_1]["advId_" .. arg_48_1] = true

	g.core.common.Storage:save("Exploration_Within_Knight_Dict.json", var_48_0, true)
end

function ExplorationData:checkChallengeTime(arg_49_1, arg_49_2)
	local var_49_0 = table.concat({
		arg_49_1,
		arg_49_2
	}, "_")
	local var_49_1 = self._challengeTimeDict[var_49_0] or 0
	local var_49_2 = g.core.common.ServerTime:getTime()

	if var_49_1 <= var_49_2 then
		self._challengeTimeDict[var_49_0] = var_49_2 + 1
	else
		return false
	end

	return true
end

function ExplorationData:hasStepsCanMove()
	if self:isActivityOpen() and self:getCurStage() == ExplorationConst.OPEN_STATE.NORMAL then
		return self._mapData:getActionPoint() > 0
	end

	return false
end

function ExplorationData:hasGameCanPlay(arg_51_1)
	if self:isActivityOpen() and self:getCurStage() == ExplorationConst.OPEN_STATE.NORMAL then
		if arg_51_1.gameType then
			return checkbool(self._mapData:getEventByType(arg_51_1.gameType))
		else
			if self._mapData:getEventByType(ExplorationConst.EVENT_TYPE.GAME_FLOP) then
				return true
			end

			if self._mapData:getEventByType(ExplorationConst.EVENT_TYPE.GAME_TURNTABLE) then
				return true
			end

			if self._mapData:getEventByType(ExplorationConst.EVENT_TYPE.GAME_WALLET) then
				return true
			end
		end
	end

	return false
end

function ExplorationData:canReceiveOrChallenge()
	if self:isActivityOpen() and self:getCurStage() == ExplorationConst.OPEN_STATE.NORMAL then
		if self:getGameStage() == ExplorationConst.GAME_STAGE.MIRROR then
			return self._mapData:canGetMirror()
		else
			return self:getBossCanChallengeCount() > 0
		end
	end

	return false
end

function ExplorationData:hasBossChallengeNum()
	if self:isActivityOpen() and self:getCurStage() == ExplorationConst.OPEN_STATE.NORMAL then
		return self:getBossCanChallengeCount() > 0
	end

	return false
end

function ExplorationData:canAssist()
	if self:isActivityOpen() and self:getCurStage() == ExplorationConst.OPEN_STATE.NORMAL and g.core.model.User:getGuildId() > 0 then
		local var_54_0 = self:getFormationData()

		if math.min(#var_0_4:getOwnKnightListWithOutMain(), ExplorationConst.MAX_HELP_NUM) > #table.values((var_54_0:getSelfHelpKnightDict())) then
			return true
		end

		if #var_54_0:getGuildHelperList() == 0 then
			return false
		end

		for iter_54_0, iter_54_1 in ipairs((var_54_0:getAllKnightList())) do
			if var_54_0:isOtherUserKnight((iter_54_1:getServerId())) then
				return false
			end
		end

		return true
	end

	return false
end

function ExplorationData:isNewKnight(arg_55_1)
	if self:isActivityOpen() then
		if arg_55_1 and arg_55_1.sid then
			return self:isNotHaveKnight(arg_55_1.sid)
		else
			for iter_55_0, iter_55_1 in ipairs((self:getFormationData():getWithinKnightList())) do
				if self:isNotHaveKnight((iter_55_1:getServerId())) then
					return true
				end
			end
		end
	end

	return false
end

function ExplorationData:canRecycleLineUpKnight(arg_56_1)
	local var_56_0 = self:getFormationData()
	local var_56_1 = false
	local var_56_2 = g.core.common.ServerTime:getDateObject()

	if (g.core.common.Storage:load("exploration_recycle.json", true) or {})[var_56_2.year .. "_" .. var_56_2.month .. "_" .. var_56_2.day] then
		return false
	end

	if arg_56_1 and arg_56_1.sid then
		var_56_1 = var_56_0:canRecycle(arg_56_1.sid)
	else
		for iter_56_0, iter_56_1 in ipairs((var_56_0:getAllKnightList())) do
			if var_56_0:canRecycle((iter_56_1:getServerId())) then
				var_56_1 = true

				break
			end
		end
	end

	return var_56_1
end

function ExplorationData:recycleLineUpKnightHasChecked()
	local var_57_0 = g.core.common.ServerTime:getDateObject()

	g.core.common.Storage:save("exploration_recycle.json", {
		[var_57_0.year .. "_" .. var_57_0.month .. "_" .. var_57_0.day] = true
	}, true)
end

function ExplorationData:canReplaceLineUpKnight(arg_58_1)
	local var_58_0 = self:getFormationData()
	local var_58_1 = {}
	local var_58_2 = {}

	for iter_58_0, iter_58_1 in ipairs((var_58_0:getAllKnightList())) do
		local var_58_3 = iter_58_1:getAdvanceId()

		if var_58_0:isUsingKnight((iter_58_1:getServerId())) then
			local var_58_4 = var_58_1[var_58_3]

			if not var_58_1[var_58_3] then
				var_58_4 = {
					star = iter_58_1:getStarLv()
				}
				var_58_1[iter_58_1:getAdvanceId()] = var_58_4
			elseif var_58_4.star < iter_58_1:getStarLv() then
				var_58_4.star = iter_58_1:getStarLv()
			end
		elseif not var_58_2[var_58_3] then
			var_58_2[var_58_3] = iter_58_1
		elseif var_58_2[var_58_3]:getStarLv() < iter_58_1:getStarLv() then
			var_58_2[var_58_3] = iter_58_1
		end
	end

	if arg_58_1 and arg_58_1.formationIndex then
		local var_58_5 = var_58_0:getFormationStruct(arg_58_1.formationIndex)

		if var_58_5 then
			if arg_58_1.pos then
				local var_58_6 = var_58_5:getKnightSid(arg_58_1.pos)

				if var_58_6 and var_58_6 > 0 then
					if arg_58_1.checkSid then
						local var_58_7 = var_58_0:getKnightByServerId(arg_58_1.checkSid)

						if var_58_7 then
							return self:_knightCanReplace(var_58_7, var_58_1)
						end
					else
						local var_58_8 = var_58_2[var_58_0:getKnightByServerId(var_58_6):getAdvanceId()]

						if var_58_8 and self:_knightCanReplace(var_58_8, var_58_1) then
							return true
						end
					end
				end
			else
				for iter_58_2 = 1, g.core.const.ConstMgr.LineUpConst.MAX_KNIGHT_NUM do
					local var_58_9 = var_58_5:getKnightSid(iter_58_2)

					if var_58_9 and var_58_9 > 0 then
						local var_58_10 = var_58_2[var_58_0:getKnightByServerId(var_58_9):getAdvanceId()]

						if var_58_10 and self:_knightCanReplace(var_58_10, var_58_1) then
							return true
						end
					end
				end
			end
		end
	else
		for iter_58_3, iter_58_4 in pairs(var_58_2) do
			if self:_knightCanReplace(iter_58_4, var_58_1) then
				return true
			end
		end
	end

	return false
end

function ExplorationData:_knightCanReplace(arg_59_1, arg_59_2)
	local var_59_0 = arg_59_2[arg_59_1:getAdvanceId()]

	if var_59_0 then
		return arg_59_1:getStarLv() > var_59_0.star
	end

	return false
end

function ExplorationData:taskCanGetAwards()
	local var_60_0 = self:getTaskData():getCurTaskInfo()

	if not var_60_0 then
		return
	end

	return var_60_0.state == ExplorationConst.TASK_STATE.MATCH
end

return ExplorationData
