local NewSlgReportStruct = class("NewSlgReportStruct")

function NewSlgReportStruct:ctor(arg_1_1)
	self.atkTeams = {}
	self.defTeams = {}
	self.watchTeams = {}
	self.report = nil
	self.battleReadyTime = 0
	self.battleStartTime = 0
	self.cityBattleStartTime = 0
	self.battleEndTime = 0
	self.battleTeamRoundDatas = {}
	self.firstRoundData = nil
	self.enemyCount = 0
	self.totalEnemyCount = 0
	self.defId = 0
	self._rolePosMap = {}
	self._roleHpMap = {}
	self._watchRemoveTimeMap = {}
	self._atkTeamKillCountMap = {}
	self._reportType = nil
	self._parameterInfo = g.core.model.User.newSlgData:getNewSlgParamsCfg()

	self:_initBattleReport(arg_1_1)
end

function NewSlgReportStruct:_initBattleReport(arg_2_1)
	self.report = arg_2_1
	self._reportType = arg_2_1.report_type
	self.atkTeams = arg_2_1.atk_teams or {}
	self.defTeams = arg_2_1.def_teams or {}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.watch_teams or {}) do
		local var_2_1

		if iter_2_1.team then
			iter_2_1.team.team_id = 100000
			var_2_1 = 100000 + 1

			table.insert(var_2_0, iter_2_1.team)

			self._watchRemoveTimeMap[iter_2_1.team.team_id] = iter_2_1.end_tm
		end
	end

	self.defId = arg_2_1.def_id
	self.watchTeams = var_2_0
	self.battleReadyTime = arg_2_1.start_tm or 0
	self.battleStartTime = self.battleReadyTime + self._parameterInfo.battle_start_time / 1000

	self:_convertBattleReport(arg_2_1)
end

function NewSlgReportStruct:_convertBattleReport(arg_3_1)
	local var_3_0 = self._parameterInfo.battle_change_time / 1000
	local var_3_1 = self._parameterInfo.show_parameter_21 / 1000
	local var_3_2 = self.battleStartTime
	local var_3_3 = {}
	local var_3_4 = {}
	local var_3_5 = arg_3_1.atk_teams or {}
	local var_3_6 = arg_3_1.def_teams or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_5) do
		table.insert(var_3_4, iter_3_1)

		if iter_3_1.team_id then
			var_3_3[iter_3_1.team_id] = iter_3_1
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_6) do
		table.insert(var_3_4, iter_3_3)

		if iter_3_3.team_id then
			var_3_3[iter_3_3.team_id] = iter_3_3
		end
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_5) do
		self._roleHpMap[iter_3_5.team_id] = {
			max = iter_3_5.troops,
			current = iter_3_5.troops
		}
	end

	local var_3_7 = {}
	local var_3_8 = {}
	local var_3_9 = {}

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.battles or {}) do
		var_3_8[iter_3_7.def_team] = true

		if var_3_9[iter_3_7.atk_team] == nil then
			var_3_9[iter_3_7.atk_team] = {}

			table.insert(var_3_7, iter_3_7.atk_team)
			table.insert(var_3_9[iter_3_7.atk_team], iter_3_7)
		else
			table.insert(var_3_9[iter_3_7.atk_team], iter_3_7)
		end
	end

	self.enemyCount = arg_3_1.is_win and table.nums(var_3_8) or #var_3_6
	self.totalEnemyCount = self.enemyCount

	local var_3_10 = {}

	for iter_3_8, iter_3_9 in ipairs(var_3_7) do
		local var_3_11 = var_3_9[iter_3_9] or {}
		local var_3_12 = {}

		for iter_3_10, iter_3_11 in ipairs(var_3_11) do
			if iter_3_11 and iter_3_11.is_win then
				table.insert(var_3_12, iter_3_11)
			end
		end

		self._atkTeamKillCountMap[iter_3_9] = #var_3_12

		if #var_3_11 > 0 then
			for iter_3_12, iter_3_13 in ipairs(var_3_11) do
				table.insert(var_3_10, iter_3_13)
			end
		end
	end

	local var_3_13
	local var_3_14 = 0
	local var_3_15 = self.battleStartTime + self._parameterInfo.max_city_time / 1000 - 10

	for iter_3_14, iter_3_15 in ipairs(var_3_10) do
		local var_3_16 = var_3_2
		local var_3_17 = var_3_3[iter_3_15.atk_team]
		local var_3_19 = iter_3_15.is_win and var_3_17 or var_3_3[iter_3_15.def_team]
		local var_3_21 = iter_3_15.troops_dec or 0
		local var_3_22 = math.ceil(((var_3_19 == var_3_17 or nil) and (var_3_21 / var_3_19.troops or var_3_21 / iter_3_15.def_init_troops)) / (self._parameterInfo.show_parameter_8 / 10000))

		if var_3_22 < self._parameterInfo.attack_num_min then
			var_3_22 = self._parameterInfo.attack_num_min
		end

		if var_3_22 > self._parameterInfo.attack_num_max then
			var_3_22 = self._parameterInfo.attack_num_max
		end

		if var_3_15 < var_3_2 + var_3_22 * var_3_1 then
			break
		end

		var_3_2 = var_3_2 + var_3_0

		if var_3_13 == var_3_19.team_id then
			var_3_14 = var_3_14 + 1
		else
			var_3_13 = var_3_19.team_id
			var_3_14 = 1
		end

		local var_3_23 = {}
		local var_3_24 = iter_3_15.atk_init_troops
		local var_3_25 = iter_3_15.def_init_troops
		local var_3_26 = iter_3_15.is_win and var_3_21 or var_3_24
		local var_3_27 = not iter_3_15.is_win and var_3_21 or var_3_25
		local var_3_28 = math.floor((iter_3_15.is_win and var_3_21 or var_3_24) / var_3_22)
		local var_3_29 = math.floor((not iter_3_15.is_win and var_3_21 or var_3_25) / var_3_22)

		for iter_3_16 = 1, var_3_22 do
			local var_3_30 = math.min(var_3_28, var_3_26)
			local var_3_31 = math.min(var_3_29, var_3_27)

			var_3_2 = var_3_2 + var_3_1
			var_3_26 = var_3_26 - var_3_30
			var_3_27 = var_3_27 - var_3_31

			table.insert(var_3_23, {
				atkDecValue = var_3_30,
				defDecValue = var_3_31,
				roundStartTime = var_3_2,
				atkHp = iter_3_15.atk_init_troops - var_3_26 + var_3_26,
				defHp = iter_3_15.def_init_troops - var_3_27 + var_3_27
			})
		end

		var_3_23[#var_3_23].atkDecValue = var_3_23[#var_3_23].atkDecValue + var_3_26
		var_3_23[#var_3_23].defDecValue = var_3_23[#var_3_23].defDecValue + var_3_27

		table.insert(self.battleTeamRoundDatas, {
			atkTeamId = iter_3_15.atk_team,
			defTeamId = iter_3_15.def_team,
			atkInitHp = var_3_24,
			defInitHp = var_3_25,
			atkMaxHp = var_3_17.troops,
			changeRoleStartTime = var_3_16,
			defMaxHp = var_3_25,
			roundDataArr = var_3_23,
			isWin = iter_3_15.is_win,
			continueKill = var_3_14
		})
	end

	self.firstRoundData = self.battleTeamRoundDatas[1].roundDataArr[1]
	self.cityBattleStartTime = var_3_2
	self.battleEndTime = arg_3_1.end_tm
end

function NewSlgReportStruct:isFirstRound()
	return self:getNextRoundData() == self.firstRoundData
end

function NewSlgReportStruct:getNextRoundData()
	if self.battleTeamRoundDatas[1] then
		return self.battleTeamRoundDatas[1].roundDataArr[1]
	end

	return nil
end

function NewSlgReportStruct:splitOutTimeRound()
	local var_6_0 = g.core.common.ServerTime:getTime()

	while self.battleTeamRoundDatas[1] do
		if #self.battleTeamRoundDatas[1].roundDataArr > 0 then
			while self.battleTeamRoundDatas[1].roundDataArr[1] do
				if var_6_0 < self.battleTeamRoundDatas[1].roundDataArr[1].roundStartTime then
					return
				end

				local var_6_2 = table.shift(self.battleTeamRoundDatas[1].roundDataArr)

				if var_6_2 then
					self:updateRoleHp(var_6_2, self.battleTeamRoundDatas[1].atkTeamId)
				end
			end
		end

		if self.battleTeamRoundDatas[1].isWin then
			self.enemyCount = self.enemyCount - 1
		end

		table.shift(self.battleTeamRoundDatas)
	end
end

function NewSlgReportStruct:isBattleFinish()
	if g.core.common.ServerTime:getTime() >= self.battleEndTime then
		return true
	end

	if self._reportType == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.MONSTER or self._reportType == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.BOSS then
		if #self.battleTeamRoundDatas == 0 then
			return true
		end
	elseif self._reportType == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.CITY and #self.battleTeamRoundDatas == 0 and not self.report.is_win then
		return true
	end

	return false
end

function NewSlgReportStruct:hasBattleStage2()
	return self._reportType == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.CITY and self.report.is_win
end

function NewSlgReportStruct:isBattleStage2()
	return self:hasBattleStage2() and #self.battleTeamRoundDatas <= 0
end

function NewSlgReportStruct:getLastTime()
	return self.battleEndTime - g.core.common.ServerTime:getTime()
end

function NewSlgReportStruct:cacheRolePos(arg_11_1, arg_11_2)
	self._rolePosMap[arg_11_1] = arg_11_2
end

function NewSlgReportStruct:getCacheRolePos(arg_12_1)
	return self._rolePosMap[arg_12_1]
end

function NewSlgReportStruct:updateRoleHp(arg_13_1, arg_13_2)
	if self._roleHpMap[arg_13_2] then
		self._roleHpMap[arg_13_2].current = self._roleHpMap[arg_13_2].current - arg_13_1.atkDecValue
	end
end

function NewSlgReportStruct:getRoleHp(arg_14_1)
	return self._roleHpMap[arg_14_1].current
end

function NewSlgReportStruct:getRoleMaxHp(arg_15_1)
	return self._roleHpMap[arg_15_1].max
end

function NewSlgReportStruct:shiftBattleTeamRoundDatas()
	local var_16_0 = table.shift(self.battleTeamRoundDatas)

	if var_16_0 and var_16_0.isWin then
		self.enemyCount = self.enemyCount - 1

		print("EVENT_SLG_ATTACK_CITY_ENEMY_COUNT_CHANGE")
	end

	print("EVENT_SLG_BATTLE_ROUND_END")
end

function NewSlgReportStruct:getWatchTeamRemoveTime(arg_17_1)
	return self._watchRemoveTimeMap[arg_17_1] or 0
end

function NewSlgReportStruct:inBattle()
	local var_18_0 = g.core.common.ServerTime:getTime()

	return var_18_0 >= self.battleReadyTime and var_18_0 < self.battleEndTime
end

function NewSlgReportStruct:getAtkTeamKillCount(arg_19_1)
	return self._atkTeamKillCountMap[arg_19_1] or 0
end

function NewSlgReportStruct:getAtkTeamAllKillCount()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self._atkTeamKillCountMap) do
		var_20_0 = var_20_0 + iter_20_1
	end

	return var_20_0
end

function NewSlgReportStruct:getLeftBattleTeamRound()
	return #self.battleTeamRoundDatas
end

function NewSlgReportStruct:getNamePro()
	return self._parameterInfo.name_pro
end

function NewSlgReportStruct:getDefId()
	return self.defId
end

function NewSlgReportStruct:getBattleType()
	return self._reportType
end

return NewSlgReportStruct
