local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_1 = g.core.config.group_battle_map_info
local var_0_2 = g.core.config.group_battle_title_info
local var_0_3 = g.core.config.group_battle_match_info
local var_0_4 = g.core.config.group_battle_parameter_info
local var_0_5 = g.core.config.group_battle_info
local var_0_6 = g.core.config.group_battle_task_info
local var_0_7 = g.core.config.skin_info
local var_0_8 = g.core.config.knight_info
local var_0_9 = g.core.config.knight_base_info
local RankAward = require("app.core.common.RankAward")
local var_0_11 = g.core.model.User.friendData
local var_0_12 = g.core.common.ServerTime
local var_0_13 = g.core.const.ConstMgr.TeamPvpConst
local var_0_14 = g.core.common.Drops
local var_0_15 = g.core.common.ModuleUnlock
local var_0_16 = g.core.const.ConstMgr.FUNCTION_TYPE
local TeamPVPData = class("TeamPVPData")

function TeamPVPData:ctor()
	self:initData()
end

function TeamPVPData:initData()
	self._activityId = 0
	self._activitySubId = 0
	self._startTime = 0
	self._endTime = 0
	self._expireTime = 0
	self._openDay = 0
	self._mapId = 0
	self._myRank = 0
	self._myHonorNum = 0
	self._myGuid = ""
	self._titleId = 0
	self._oldTitleId = 0
	self._inviteTeamList = {}
	self._inviteCd = g.core.config.parameter_info.get(3004).parameter
	self._inviteTimeDict = {}
	self._receivedInvitedList = {}
	self._receivedInvitedPassList = {}
	self._teamInfo = nil
	self._enemyTeamInfo = nil
	self._extraPositions = {}
	self._teamPlayerInfoDict = {}
	self._enemyTeamPlayerInfoDict = {}
	self._guid2UidMap = {}
	self._randNames = {}
	self._randSkins = {}
	self._positions = {}
	self._rankRewardDict = {}
	self._rankList = {}
	self._taskTypeProgressDict = {}
	self._taskLastResetTimeDict = {}
	self._taskGotIdDict = {}
	self._addition = {}
	self._serverTaskRed = false
	self._isHelp = false

	self:_initEstimateMatchTime()
	self:_initHonorReward()

	local var_2_0 = g.core.config.play_num_info.fetch(var_0_13.PLAY_NUM_ID)

	if var_2_0 then
		self._fullTimes = var_2_0.reset or 0
	end
end

function TeamPVPData:_initEstimateMatchTime()
	self._estimateTime = {}

	for iter_3_0, iter_3_1 in var_0_3.ipairs() do
		if self._estimateTime[iter_3_1.type] then
			if iter_3_1.end_time > self._estimateTime[iter_3_1.type] then
				self._estimateTime[iter_3_1.type] = iter_3_1.end_time
			end
		else
			self._estimateTime[iter_3_1.type] = iter_3_1.end_time
		end
	end

	self._estimateTime[var_0_13.MATCH_TYPE.BATTLE] = self:getTeamPVPParameterById(var_0_13.PARAMETER_ID.MATCH_BATTLE_LIMIT)
end

function TeamPVPData:_initHonorReward()
	self._rankRewardDict[var_0_13.RANK_TAB_TYPE.HONOR] = {}

	for iter_4_0, iter_4_1 in var_0_2.ipairs() do
		table.insert(self._rankRewardDict[var_0_13.RANK_TAB_TYPE.HONOR], (iter_4_1.reward > 0 or nil) and var_0_14:getGoodsArray(iter_4_1.reward))
	end
end

function TeamPVPData:updateTeamInfo(arg_5_1)
	if arg_5_1 then
		self._addition = arg_5_1.addition or {}
	end

	if arg_5_1 and arg_5_1.room then
		self._teamInfo = arg_5_1.room
		self._mapId = self._teamInfo.map_id
		self._teamPlayerInfoDict = {}
		self._positions = {}

		local var_5_0 = {}

		for iter_5_0 = 1, #self._teamInfo.users do
			self._teamPlayerInfoDict[self._teamInfo.users[iter_5_0].guid] = self._teamPlayerInfoDict[self._teamInfo.users[iter_5_0].guid] or {}

			if self._teamInfo.users[iter_5_0].user_id == g.core.model.User:getId() then
				self._myGuid = self._teamInfo.users[iter_5_0].guid
				self._titleId = self._teamInfo.users[iter_5_0].title
			end

			self._teamPlayerInfoDict[self._teamInfo.users[iter_5_0].guid].battleUser = self._teamInfo.users[iter_5_0]
			self._positions[self._teamInfo.users[iter_5_0].position] = self._teamPlayerInfoDict[self._teamInfo.users[iter_5_0].guid]
			var_5_0[self._teamInfo.users[iter_5_0].guid] = self._teamInfo.users[iter_5_0].user_id
		end

		for iter_5_1 = 1, #self._teamInfo.users do
			local var_5_1 = self._teamInfo.user_show[iter_5_1]

			for iter_5_2, iter_5_3 in pairs(var_5_0) do
				if var_5_1.id == iter_5_3 then
					self._teamPlayerInfoDict[iter_5_2].snapshot = var_5_1

					local var_5_2 = self._teamPlayerInfoDict[iter_5_2]

					if self._teamPlayerInfoDict[iter_5_2].battleUser.is_robot then
						if self._randNames then
							if not (self._randNames[iter_5_2] or nil) then
								self._randNames[iter_5_2] = self:_onRandomName(var_5_1)
							end
						end

						var_5_2.robotName = self._randNames[iter_5_2]

						if self._randSkins then
							if not (self._randSkins[iter_5_2] or nil) then
								self._randSkins[iter_5_2] = self:_onRandomSKin(var_5_1)
							end
						end

						var_5_2.robotSkin = self._randSkins[iter_5_2]
						self._teamPlayerInfoDict[iter_5_2] = var_5_2
					end
				end
			end
		end
	end
end

function TeamPVPData:leaveTeam()
	self._teamInfo = nil
	self._teamPlayerInfoDict = {}
	self._enemyTeamInfo = nil
	self._enemyTeamPlayerInfo = nil
	self._randNames = {}
	self._randSkins = {}
end

function TeamPVPData:setEnemyTeamInfo(arg_7_1)
	if arg_7_1 then
		self._enemyTeamInfo = arg_7_1.room or nil
	end

	if self._enemyTeamInfo then
		self._enemyTeamPlayerInfo = {}

		for iter_7_0, iter_7_1 in ipairs(self._enemyTeamInfo.user_show) do
			self._enemyTeamPlayerInfo[iter_7_1.id] = iter_7_1
		end

		self._enemyPositions = {}

		for iter_7_2, iter_7_3 in ipairs(self._enemyTeamInfo.users) do
			self._enemyPositions[iter_7_3.position] = iter_7_3

			if iter_7_3.is_robot then
				if self._enemyTeamPlayerInfo then
					local var_7_0 = self._enemyTeamPlayerInfo[iter_7_3.user_id] or nil

					if var_7_0 then
						if self._randNames then
							if not (self._randNames[iter_7_3.guid] or nil) then
								self._randNames[iter_7_3.guid] = self:_onRandomName(var_7_0)
							end
						end

						var_7_0.robotName = self._randNames[iter_7_3.guid]

						if self._randSkins then
							if not (self._randSkins[iter_7_3.guid] or nil) then
								self._randSkins[iter_7_3.guid] = self:_onRandomSKin(var_7_0)
							end
						end

						var_7_0.robotSkin = self._randSkins[iter_7_3.guid]
						self._enemyTeamPlayerInfo[iter_7_3.user_id] = var_7_0
					end
				end
			end
		end
	end
end

function TeamPVPData:receiveBattleReport(arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_1.report or nil

		if var_8_0 then
			self._battleReport = var_8_0

			local var_8_1 = {}
			local var_8_2 = {}

			var_8_1.positions = {}
			var_8_1.users = {}
			var_8_1.userInfos = {}
			var_8_1.userPos = {}
			var_8_1.score = 0
			var_8_2.positions = {}
			var_8_2.users = {}
			var_8_2.userInfos = {}
			var_8_2.userPos = {}
			var_8_2.score = 0

			local var_8_3 = self._teamInfo and self._teamInfo.id == var_8_0.atk_room_id

			for iter_8_0, iter_8_1 in ipairs(var_8_0.atk_user_show) do
				if var_8_3 then
					var_8_1.userInfos[iter_8_1.id] = iter_8_1
				else
					var_8_2.userInfos[iter_8_1.id] = iter_8_1
				end
			end

			for iter_8_2, iter_8_3 in ipairs(var_8_0.def_user_show) do
				if var_8_3 then
					var_8_2.userInfos[iter_8_3.id] = iter_8_3
				else
					var_8_1.userInfos[iter_8_3.id] = iter_8_3
				end
			end

			for iter_8_4, iter_8_5 in ipairs(var_8_0.atk_user) do
				if var_8_3 then
					var_8_1.positions[iter_8_5.position] = iter_8_5
					var_8_1.users[iter_8_5.guid] = iter_8_5
					var_8_1.userPos[iter_8_5.guid] = iter_8_5.position
					var_8_1.userInfos[iter_8_5.user_id].is_robot = iter_8_5.is_robot

					if iter_8_5.is_robot then
						local var_8_4 = self:getRobotName(iter_8_5.guid)

						if var_8_4 and var_8_1.userInfos[iter_8_5.user_id] then
							var_8_1.userInfos[iter_8_5.user_id].robotName = var_8_4
						end

						local var_8_5 = self:getRobotSkin(iter_8_5.guid)

						if var_8_5 and var_8_1.userInfos[iter_8_5.user_id] then
							var_8_1.userInfos[iter_8_5.user_id].robotSkin = var_8_5
						end
					end
				else
					var_8_2.positions[iter_8_5.position] = iter_8_5
					var_8_2.users[iter_8_5.guid] = iter_8_5
					var_8_2.userPos[iter_8_5.guid] = iter_8_5.position
					var_8_2.userInfos[iter_8_5.user_id].is_robot = iter_8_5.is_robot

					if iter_8_5.is_robot then
						local var_8_6 = self:getRobotName(iter_8_5.guid)

						if var_8_6 and var_8_2.userInfos[iter_8_5.user_id] then
							var_8_2.userInfos[iter_8_5.user_id].robotName = var_8_6
						end

						local var_8_7 = self:getRobotSkin(iter_8_5.guid)

						if var_8_7 and var_8_2.userInfos[iter_8_5.user_id] then
							var_8_2.userInfos[iter_8_5.user_id].robotSkin = var_8_7
						end
					end
				end
			end

			for iter_8_6, iter_8_7 in ipairs(var_8_0.def_user) do
				if var_8_3 then
					var_8_2.positions[iter_8_7.position] = iter_8_7
					var_8_2.users[iter_8_7.guid] = iter_8_7
					var_8_2.userPos[iter_8_7.guid] = iter_8_7.position

					if iter_8_7.is_robot then
						local var_8_8 = self:getRobotName(iter_8_7.guid)

						if var_8_8 and var_8_2.userInfos[iter_8_7.user_id] then
							var_8_2.userInfos[iter_8_7.user_id].robotName = var_8_8
						end

						local var_8_9 = self:getRobotSkin(iter_8_7.guid)

						if var_8_9 and var_8_2.userInfos[iter_8_7.user_id] then
							var_8_2.userInfos[iter_8_7.user_id].robotSkin = var_8_9
						end
					end
				else
					var_8_1.positions[iter_8_7.position] = iter_8_7
					var_8_1.users[iter_8_7.guid] = iter_8_7
					var_8_1.userPos[iter_8_7.guid] = iter_8_7.position

					if iter_8_7.is_robot then
						local var_8_10 = self:getRobotName(iter_8_7.guid)

						if var_8_10 and var_8_1.userInfos[iter_8_7.user_id] then
							var_8_1.userInfos[iter_8_7.user_id].robotName = var_8_10
						end

						local var_8_11 = self:getRobotSkin(iter_8_7.guid)

						if var_8_11 and var_8_1.userInfos[iter_8_7.user_id] then
							var_8_1.userInfos[iter_8_7.user_id].robotSkin = var_8_11
						end
					end
				end
			end

			if var_8_3 then
				var_8_1.score = var_8_0.atk_score
				var_8_2.score = var_8_0.dfd_score
			else
				var_8_1.score = var_8_0.dfd_score
				var_8_2.score = var_8_0.atk_score
			end

			self._battleReport.playerInfos = var_8_1
			self._battleReport.enemyInfos = var_8_2
			self._battleReport.isAtk = var_8_3
			self._battleReport.isWin = self._teamInfo and self._teamInfo.id == var_8_0.win_room_id or false
			self._killNums = {}

			if var_8_0 then
				local var_8_12 = var_8_0.user_kill_num or nil

				if var_8_12 then
					for iter_8_8, iter_8_9 in ipairs(var_8_12) do
						self._killNums[iter_8_9.guid] = iter_8_9.kill_num
					end
				end
			end

			local var_8_13
			local var_8_14

			if var_8_0.atk_room_id and var_8_0.atk_room_id == self:getMyRoomId() then
				var_8_13 = var_8_0.atk_extra_match_pos
				var_8_14 = var_8_0.def_extra_match_pos
			else
				var_8_13 = var_8_0.def_extra_match_pos
				var_8_14 = var_8_0.atk_extra_match_pos
			end

			self._extraPositions = {}

			if var_8_13 then
				for iter_8_10 = 1, #var_8_13 do
					if var_8_0.map_id == 3 then
						if var_8_13[iter_8_10] ~= 1 and var_8_13[iter_8_10] ~= 4 and var_8_13[iter_8_10] ~= 7 then
							table.insert(self._extraPositions, (self._positions or nil) and (self._positions[var_8_13[iter_8_10]].battleUser or {}))
						end
					else
						table.insert(self._extraPositions, (self._positions or nil) and (self._positions[var_8_13[iter_8_10]].battleUser or {}))
					end
				end
			end

			self._enemyExtraPositions = {}

			if var_8_14 then
				for iter_8_11 = 1, #var_8_14 do
					if var_8_0.map_id == 3 then
						if var_8_14[iter_8_11] ~= 1 and var_8_14[iter_8_11] ~= 4 and var_8_14[iter_8_11] ~= 7 then
							table.insert(self._enemyExtraPositions, (self._enemyPositions or nil) and (self._enemyPositions[var_8_14[iter_8_11]] or {}))
						end
					else
						table.insert(self._enemyExtraPositions, (self._enemyPositions or nil) and (self._enemyPositions[var_8_14[iter_8_11]] or {}))
					end
				end
			end
		end
	end
end

function TeamPVPData:getRobotName(arg_9_1)
	return (self._randNames or nil) and (self._randNames[arg_9_1] or nil)
end

function TeamPVPData:getRobotSkin(arg_10_1)
	return (self._randSkins or nil) and (self._randSkins[arg_10_1] or nil)
end

function TeamPVPData:getExtraPosition()
	return self._extraPositions
end

function TeamPVPData:getEnemyExtraPosition()
	return self._enemyExtraPositions
end

function TeamPVPData:isBattleWin()
	return (self._battleReport or nil) and (self._battleReport.isWin or false)
end

function TeamPVPData:_onRandomName(arg_14_1)
	return g.core.config.rand2_surname_info.indexOf(math.random((g.core.config.rand2_surname_info.getLength()))).surname .. g.core.config.rand3_name_info.indexOf(math.random((g.core.config.rand3_name_info.getLength())))[g.core.config.knight_info.get(arg_14_1.base_id).sex == 1 and "name_boy" or "name_girl"]
end

function TeamPVPData:_onRandomSKin(arg_15_1)
	local var_15_0 = arg_15_1.base_id
	local var_15_1 = math.random(1, 2)

	if self:_checkKnightGender(var_0_8.get(arg_15_1.base_id).advance_id) == 0 then
		return ({
			210005,
			210003
		})[var_15_1]
	else
		return ({
			200005,
			200003
		})[var_15_1]
	end

	return var_15_0
end

function TeamPVPData:_checkKnightGender(arg_16_1)
	if arg_16_1 == 210000 then
		return 0
	else
		return 1
	end
end

function TeamPVPData:isLivePlayer(arg_17_1)
	for iter_17_0 = 1, #self._extraPositions do
		if self._extraPositions[iter_17_0].guid == arg_17_1 then
			return true
		end
	end

	for iter_17_1 = 1, #self._enemyExtraPositions do
		if self._enemyExtraPositions[iter_17_1].guid == arg_17_1 then
			return true
		end
	end

	return false
end

function TeamPVPData:_updateRankRewardDict()
	if self._activitySubId > 0 then
		self._rankRewardDict[var_0_13.RANK_TAB_TYPE.CROSS] = RankAward:getRankAwardArray(var_0_13.HONOR_REWARD_TYPE, var_0_5.get(self._activitySubId).reward_id)
	end
end

function TeamPVPData:_updateTasks(arg_19_1)
	self._taskGotIdDict = {}
	self._taskLastResetTimeDict = {}
	self._taskTypeProgressDict = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_0 = iter_19_1.reset_type or 0

		for iter_19_2, iter_19_3 in ipairs(iter_19_1.actions or {}) do
			if var_19_0 == g.core.const.ConstMgr.ShopConst.NUM_BAN_TYPE.DAY then
				self._taskLastResetTimeDict[iter_19_3.id .. "_" .. var_19_0] = iter_19_1.last_reset_time or 0
			end

			self._taskTypeProgressDict[iter_19_3.id .. "_" .. var_19_0] = iter_19_3.num
		end

		for iter_19_4, iter_19_5 in ipairs(iter_19_1.award_task_ids or {}) do
			self._taskGotIdDict[iter_19_5] = true
		end
	end
end

function TeamPVPData:updateTaskByStatus(arg_20_1)
	local var_20_0 = arg_20_1.reset_type or 0
	local var_20_1 = arg_20_1.id .. "_" .. var_20_0

	if var_20_0 == g.core.const.ConstMgr.ShopConst.NUM_BAN_TYPE.DAY then
		self._taskLastResetTimeDict[var_20_1] = g.core.common.ServerTime:getTime()
	end

	self._taskTypeProgressDict[var_20_1] = arg_20_1.status
end

function TeamPVPData:isMyselfHelp()
	return self._isHelp
end

function TeamPVPData:setHelpState()
	self._isHelp = self:getChallengeNum() == 0
end

function TeamPVPData:onS2CActivityInfo(arg_23_1)
	if arg_23_1.activity then
		self._activityId = arg_23_1.activity.activity_id or self._activityId
		self._activitySubId = arg_23_1.activity.activity_sub_id or self._activitySubId
		self._startTime = arg_23_1.activity.start_time or self._startTime
		self._endTime = arg_23_1.activity.end_time or self._endTime
		self._expireTime = arg_23_1.activity.expire_time or self._expireTime
		self._openDay = arg_23_1.activity.open_day or self._openDay
		self._mapId = arg_23_1.activity.map_id or self._mapId

		self:_updateRankRewardDict()
	end

	self._serverTaskRed = arg_23_1.task_award
end

function TeamPVPData:onS2CGroupBattleEnter(arg_24_1)
	if not arg_24_1 then
		return
	end

	self._myRank = arg_24_1.rank or 0
	self._myHonorNum = arg_24_1.honor or 0
	self._titleId = arg_24_1.title or 0
	self._oldTitleId = arg_24_1.title or 0
	self._mapId = arg_24_1.map_id or 0

	if arg_24_1.room then
		self:updateTeamInfo(arg_24_1)
	end

	if arg_24_1.tasks then
		self._serverTaskRed = false

		self:_updateTasks(arg_24_1.tasks)
	end
end

function TeamPVPData:onS2CGroupBattleCreateRoom(arg_25_1)
	self:updateTeamInfo(arg_25_1)
end

function TeamPVPData:onS2CGroupBattleQuickJoin(arg_26_1)
	return
end

function TeamPVPData:onS2CGroupBattleNotifyRoomChange(arg_27_1)
	self:updateTeamInfo(arg_27_1)
end

function TeamPVPData:onS2CGroupBattleInvite(arg_28_1)
	self._inviteTimeDict[arg_28_1.user_id] = var_0_12:getTime()
end

function TeamPVPData:onS2CGroupBattleQuitRoom(arg_29_1)
	self._teamInfo = nil
	self._teamPlayerInfoDict = {}
	self._enemyTeamInfo = nil
	self._enemyTeamPlayerInfoDict = {}
end

function TeamPVPData:onS2CGroupBattleTaskAward(arg_30_1)
	self._taskGotIdDict[arg_30_1.task_id] = true
end

function TeamPVPData:onS2CGroupBattleInviteeList(arg_31_1)
	self._inviteTeamList = {
		[var_0_13.INVITE_TAB.FRIEND] = {},
		[var_0_13.INVITE_TAB.GUILD] = {}
	}

	if arg_31_1.friends then
		for iter_31_0, iter_31_1 in ipairs(arg_31_1.friends) do
			table.insert(self._inviteTeamList[var_0_13.INVITE_TAB.FRIEND], iter_31_1)
		end
	end

	if arg_31_1.guild_members then
		for iter_31_2, iter_31_3 in ipairs(arg_31_1.guild_members) do
			table.insert(self._inviteTeamList[var_0_13.INVITE_TAB.GUILD], iter_31_3)
		end
	end
end

function TeamPVPData:onS2CCommonRankList(arg_32_1)
	self._myRank = arg_32_1.self_rank or 0
	self._rankList = arg_32_1.rank_units or {}

	local var_32_0 = g.core.model.User:getId()

	for iter_32_0, iter_32_1 in ipairs(self._rankList) do
		if iter_32_1.user and iter_32_1.user.id == var_32_0 then
			self._myHonorNum = iter_32_1.score or 0

			break
		end
	end
end

function TeamPVPData:onS2CGetInvited(arg_33_1)
	self._receivedInvitedList = arg_33_1 or {}
end

function TeamPVPData:delReceivedInvited(arg_34_1)
	self:confirmInvited(arg_34_1)
end

function TeamPVPData:confirmInvited(arg_35_1)
	for iter_35_0 = #self._receivedInvitedList, 1, -1 do
		if self._receivedInvitedList[iter_35_0].room_id == arg_35_1 then
			table.remove(self._receivedInvitedList, iter_35_0)
		end
	end
end

function TeamPVPData:addReceivedInvited(arg_36_1)
	table.insert(self._receivedInvitedList, arg_36_1)
end

function TeamPVPData:getInvitedInfo()
	return self._receivedInvitedList
end

function TeamPVPData:onS2CNotifyMapChange(arg_38_1)
	if arg_38_1 and arg_38_1.map_id then
		if self._mapId ~= arg_38_1.map_id then
			self:leaveTeam()
		end

		self._mapId = arg_38_1.map_id
	end
end

function TeamPVPData:getMapInfo()
	return var_0_1.fetch(self._mapId)
end

function TeamPVPData:getMapId()
	return self._mapId
end

function TeamPVPData:getMyTitleInfo()
	return self:getTitleInfoByBaseId(self._titleId)
end

function TeamPVPData:getBattleReport()
	return self._battleReport
end

function TeamPVPData:clearReport()
	self._battleReport = nil
end

function TeamPVPData:getTitleInfoByBaseId(arg_44_1)
	return var_0_2.fetch(arg_44_1)
end

function TeamPVPData:getTitleIdByHonor(arg_45_1)
	local var_45_0 = 0

	for iter_45_0, iter_45_1 in var_0_2.ipairs() do
		if arg_45_1 >= iter_45_1.limit then
			var_45_0 = iter_45_0
		else
			break
		end
	end

	return var_45_0
end

function TeamPVPData:getMyRank()
	return self._myRank
end

function TeamPVPData:getMyHonorNum()
	return self._myHonorNum
end

function TeamPVPData:getMatchEstimateTimeByType(arg_48_1)
	return self._estimateTime[arg_48_1] or 0
end

function TeamPVPData:getNextInviteTime(arg_49_1)
	if self._inviteTimeDict[arg_49_1] then
		return self._inviteTimeDict[arg_49_1] + self._inviteCd
	end

	return 0
end

function TeamPVPData:getFriendCd(arg_50_1)
	local var_50_0 = self:getNextInviteTime(arg_50_1)

	if var_50_0 > 0 then
		return var_50_0 - g.core.common.ServerTime:getTime()
	else
		return 0
	end
end

function TeamPVPData:getMapId()
	return self._mapId
end

function TeamPVPData:getTeamPlayerInfoByGuid(arg_52_1)
	return self._teamPlayerInfoDict[arg_52_1]
end

function TeamPVPData:getMyGuid()
	return self._myGuid or ""
end

function TeamPVPData:getTeamInfo()
	return self._teamInfo
end

function TeamPVPData:getTeamPlayerInfoByPosition(arg_55_1)
	return self._positions[arg_55_1]
end

function TeamPVPData:getTeamPlayers()
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in pairs(self._positions) do
		table.insert(var_56_0, iter_56_1)
	end

	return var_56_0
end

function TeamPVPData:isPositionValid(arg_57_1)
	return arg_57_1 <= self:getMapInfo().num
end

function TeamPVPData:getTeamPVPParameterById(arg_58_1)
	return var_0_4.get(arg_58_1).parameter
end

function TeamPVPData:getInviteTeamData(arg_59_1)
	return self._inviteTeamList[arg_59_1] or {}
end

function TeamPVPData:getTaskProgress(arg_60_1, arg_60_2)
	if self:isExpireTask(arg_60_1 .. "_" .. arg_60_2) then
		return 0
	end

	return self._taskTypeProgressDict[arg_60_1 .. "_" .. arg_60_2] or 0
end

function TeamPVPData:isExpireTask(arg_61_1)
	if not self:isActivityOpen() then
		return true
	end

	if self._taskLastResetTimeDict[arg_61_1] then
		return not g.core.common.ServerTime:isToday(self._taskLastResetTimeDict[arg_61_1])
	end

	return false
end

function TeamPVPData:isGotTaskById(arg_62_1, arg_62_2)
	arg_62_2 = arg_62_2 or var_0_6.get(arg_62_1)

	if self:isExpireTask(arg_62_2.task_type .. "_" .. arg_62_2.refresh) then
		return false
	end

	return self._taskGotIdDict[arg_62_2.id]
end

function TeamPVPData:isTaskCanGet(arg_63_1)
	local var_63_0 = var_0_6.get(arg_63_1)

	if self:isGotTaskById(nil, var_63_0) then
		return false
	end

	return self:getTaskProgress(var_63_0.task_type, var_63_0.refresh) >= var_63_0.goal
end

function TeamPVPData:switchPosition(arg_64_1, arg_64_2)
	local var_64_0 = self:getTeamPlayerInfoByGuid(arg_64_1)
	local var_64_1 = var_64_0.battleUser.position
	local var_64_2 = self:getTeamPlayerInfoByGuid(arg_64_2)

	var_64_0.battleUser.position, var_64_2.battleUser.position = var_64_2.battleUser.position, var_64_0.battleUser.position
	self._positions[var_64_1], self._positions[var_64_2.battleUser.position] = var_64_2, var_64_0
end

function TeamPVPData:switchEmptyPosition(arg_65_1, arg_65_2)
	local var_65_0 = self:getTeamPlayerInfoByGuid(arg_65_1)

	var_65_0.battleUser.position = arg_65_2
	self._positions[var_65_0.battleUser.position] = nil
	self._positions[arg_65_2] = var_65_0
end

function TeamPVPData:isAllPlayerReady()
	local var_66_0 = 0
	local var_66_1 = self._teamInfo.captain

	for iter_66_0, iter_66_1 in pairs(self._positions) do
		if var_66_1 ~= iter_66_1.battleUser.guid and not iter_66_1.battleUser.is_ready then
			return false
		end

		var_66_0 = var_66_0 + 1
	end

	if self._mapId == var_0_13.MAP_TYPE.SEA then
		return var_66_0 == var_0_13.SPECIAL_PLAYER_NUM
	elseif self._mapId == var_0_13.MAP_TYPE.FIVE then
		return var_66_0 == var_0_13.MASTER_PLAYER_NUM
	else
		return var_66_0 == var_0_13.REQUIRED_PLAYER_NUM
	end
end

function TeamPVPData:isHotTime()
	return var_0_12:checkTimeAreaByTypeT(1200, 1400) or var_0_12:checkTimeAreaByTypeT(1800, 2000)
end

function TeamPVPData:getTeamAdditionValue()
	local var_68_0 = 0
	local var_68_1 = g.core.model.User:getGuildId()
	local var_68_2 = 0
	local var_68_3 = 0
	local var_68_4 = 0

	for iter_68_0, iter_68_1 in pairs(self._teamPlayerInfoDict) do
		if iter_68_1.snapshot.id ~= g.core.model.User:getId() then
			if var_68_2 == 0 and var_0_11:isInAddFriendList(iter_68_1.snapshot.id) then
				var_68_2 = self:getTeamPVPParameterById(var_0_13.PARAMETER_ID.FRIEND_ADDITION)
				var_68_0 = var_68_0 + var_68_2
			end

			if var_68_3 == 0 and var_68_1 == iter_68_1.snapshot.guild_id then
				var_68_3 = self:getTeamPVPParameterById(var_0_13.PARAMETER_ID.GUILD_ADDITION)
				var_68_0 = var_68_0 + var_68_3
			end

			if var_68_4 == 0 and not iter_68_1.battleUser.is_robot then
				var_68_4 = self:getTeamPVPParameterById(var_0_13.PARAMETER_ID.ONLINE_ADDITION)
				var_68_0 = var_68_0 + var_68_4
			end
		end
	end

	return var_68_0 / 1000, {
		var_68_4,
		var_68_2,
		var_68_3
	}
end

function TeamPVPData:isOpenRoom()
	return self._teamInfo and self._teamInfo.is_open
end

function TeamPVPData:isAutoReady()
	return self:getTeamPlayerInfoByGuid((self:getMyGuid())).battleUser.is_ready
end

function TeamPVPData:getRankRewardByTab(arg_71_1)
	return self._rankRewardDict[arg_71_1] or {}
end

function TeamPVPData:getActivitySubId()
	return self._activitySubId
end

function TeamPVPData:isActivityOpen()
	local var_73_0 = var_0_12:getTime()

	return var_0_15:isModuleUnlock(var_0_16.TEAM_PVP) and var_73_0 >= self._startTime and var_73_0 <= self._expireTime
end

function TeamPVPData:isActivityInStart()
	local var_74_0 = var_0_12:getTime()

	return var_0_15:isModuleUnlock(var_0_16.TEAM_PVP) and var_74_0 >= self._startTime and var_74_0 <= self._endTime
end

function TeamPVPData:isActivityInExpire()
	local var_75_0 = var_0_12:getTime()

	return var_0_15:isModuleUnlock(var_0_16.TEAM_PVP) and var_75_0 >= self._endTime and var_75_0 <= self._expireTime
end

function TeamPVPData:isToDayPop()
	return g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TEAM_PVP_ACTIVE_RESULT_POP)
end

function TeamPVPData:setTodayNotPop(arg_77_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TEAM_PVP_ACTIVE_RESULT_POP, arg_77_1)
end

function TeamPVPData:getOpenDays()
	return self._openDay
end

function TeamPVPData:isOpenDaysSatisfy()
	return var_0_12:getOpenDays() >= self._openDay
end

function TeamPVPData:getOldTitleId()
	self._oldTitleId = self._titleId

	return self._oldTitleId
end

function TeamPVPData:getTitleId()
	return self._titleId
end

function TeamPVPData:getRankList()
	return self._rankList
end

function TeamPVPData:getChallengeNum()
	return g.core.model.User.shopData:getLeftCount(var_0_13.PLAY_NUM_ID) or 0
end

function TeamPVPData:getLineUpMsg()
	local var_84_0 = {}

	for iter_84_0, iter_84_1 in pairs(self._positions) do
		table.insert(var_84_0, {
			guid = iter_84_1.battleUser.guid,
			position = iter_84_0
		})
	end

	return var_84_0
end

function TeamPVPData:getMyRoomId()
	return (self._teamInfo or nil) and (self._teamInfo.id or 0)
end

function TeamPVPData:getCampaignEntranceCDTime()
	local var_86_0 = var_0_12:getTime()

	if var_86_0 >= self._startTime and var_86_0 <= self._endTime then
		return self._endTime
	elseif var_86_0 > self._endTime and var_86_0 <= self._expireTime then
		return self._expireTime
	end

	return 0
end

function TeamPVPData:getEndTime()
	return self._endTime
end

function TeamPVPData:isMyselfInRoom()
	if not self._teamInfo then
		return false
	end

	local var_88_0 = self:getMyGuid()

	if var_88_0 ~= "" then
		return self:getTeamPlayerInfoByGuid(var_88_0) ~= nil
	end

	return false
end

function TeamPVPData:getActivityExpireTime()
	return self._expireTime
end

function TeamPVPData:isMyselfCaptain()
	if not self._teamInfo then
		return false
	end

	return self._teamInfo.captain == self._myGuid
end

function TeamPVPData:getPlayFullTimes()
	return self._fullTimes
end

function TeamPVPData:getAddition()
	local var_92_0 = 0

	for iter_92_0, iter_92_1 in ipairs(self._addition) do
		if iter_92_1 > 0 then
			var_92_0 = var_92_0 + self:getTeamPVPParameterById(var_0_13.PARAMETER_ID[var_0_13.ADD_TYPE_MAP[iter_92_0]]) / 10 * iter_92_1
		end
	end

	return var_92_0, self._addition
end

function TeamPVPData:getCampaignStr()
	local var_93_0 = var_0_12:getTime()

	if var_93_0 >= self._startTime and var_93_0 <= self._endTime then
		return g.core.lang:get(420445)
	elseif var_93_0 > self._endTime and var_93_0 <= self._expireTime then
		return g.core.lang:get(420443)
	end

	return ""
end

function TeamPVPData:getActivityState()
	local var_94_0 = var_0_12:getTime()

	if var_94_0 >= self._startTime and var_94_0 < self._endTime then
		return var_0_13.SEASON_STATE.ON_SEASON
	end

	if var_94_0 >= self._endTime < self._expireTime then
		return var_0_13.SEASON_STATE.RESULT
	end

	return var_0_13.SEASON_STATE.DEFAULT
end

function TeamPVPData:getKnightResId(arg_95_1)
	if arg_95_1.battleUser.npc_type and arg_95_1.battleUser.npc_type > 0 then
		return var_0_13.NPC_BASE_ID[arg_95_1.battleUser.npc_type]
	end

	if arg_95_1.battleUser.is_robot then
		return arg_95_1.robotSkin
	end

	if arg_95_1.snapshot.skin and arg_95_1.snapshot.skin > 0 then
		local var_95_0 = var_0_7.fetch(arg_95_1.snapshot.skin)

		if var_95_0 then
			local var_95_1 = var_0_9.fetch(var_95_0.res)

			if var_95_1 then
				return var_95_1.fight_id
			end
		end
	end

	return var_0_8.get(arg_95_1.snapshot.base_id).res_id
end

function TeamPVPData:saveGuideVideoPopState(arg_96_1)
	local var_96_0 = g.core.common.Storage:load(var_0_13.JSON_FILE.GUIDE_VIDEO) or {}
	local var_96_1 = var_0_12:getDateObject()

	var_96_0.today_state = {
		day = string.format("%d_%d_%d", var_96_1.year, var_96_1.month, var_96_1.day),
		state = arg_96_1
	}

	g.core.common.Storage:save(var_0_13.JSON_FILE.GUIDE_VIDEO, var_96_0, true)
end

function TeamPVPData:isGuideVideoNeedPop()
	local var_97_0 = g.core.common.Storage:load(var_0_13.JSON_FILE.GUIDE_VIDEO) or {}
	local var_97_1 = var_0_12:getDateObject()

	if not var_97_0.today_state or var_97_0.today_state.day ~= string.format("%d_%d_%d", var_97_1.year, var_97_1.month, var_97_1.day) then
		return true
	end

	return not var_97_0.today_state.state
end

function TeamPVPData:isGuideVideoPopSelected()
	local var_98_0 = g.core.common.Storage:load(var_0_13.JSON_FILE.GUIDE_VIDEO) or {}
	local var_98_1 = var_0_12:getDateObject()

	if not var_98_0.today_state then
		return true
	end

	if var_98_0.today_state.day ~= string.format("%d_%d_%d", var_98_1.year, var_98_1.month, var_98_1.day) then
		return true
	end

	return var_98_0.today_state.state
end

function TeamPVPData:isGuideVideoPopToday()
	local var_99_0 = g.core.common.Storage:load(var_0_13.JSON_FILE.GUIDE_VIDEO) or {}
	local var_99_1 = var_0_12:getDateObject()

	return var_99_0.today_state and var_99_0.today_state.day == string.format("%d_%d_%d", var_99_1.year, var_99_1.month, var_99_1.day)
end

function TeamPVPData:saveOpenRoomState(arg_100_1, arg_100_2)
	local var_100_0 = g.core.common.Storage:load(var_0_13.JSON_FILE.OPEN_STATE) or {}

	var_100_0[arg_100_1] = arg_100_2

	g.core.common.Storage:save(var_0_13.JSON_FILE.OPEN_STATE, var_100_0, true)
end

function TeamPVPData:getOpenRoomState(arg_101_1)
	return (g.core.common.Storage:load(var_0_13.JSON_FILE.OPEN_STATE) or {})[arg_101_1]
end

function TeamPVPData:hasChallengeNum()
	return self:isActivityInStart() and self:getChallengeNum() > 0
end

function TeamPVPData:hasTaskCanReceive()
	if not self:isActivityInStart() then
		return false
	end

	if self._serverTaskRed then
		return true
	end

	for iter_103_0, iter_103_1 in var_0_6.ipairs() do
		if not self:isGotTaskById(nil, iter_103_1) and self:getTaskProgress(iter_103_1.task_type, iter_103_1.refresh) >= iter_103_1.goal then
			return true
		end
	end

	return false
end

return TeamPVPData
