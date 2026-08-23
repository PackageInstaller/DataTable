local MineData = class("MineData")
local var_0_1 = g.core.config.mine_map_info
local var_0_2 = g.core.config.mine_task_info
local var_0_3 = true
local var_0_4 = g.core.common.ServerTime
local MineStruct = import(".MineStruct")

function MineData:ctor()
	self:initData()
end

function MineData:initData()
	self._cityMap = {}
	self._capitalList = {}
	self._cityList = {}
	self._ownCity = 0
	self._timeStage = 1
	self._goldRadio = 1
	self._startTime = 0
	self._totalWarTime = 0
	self._endTime = 0
	self._newLeagueStartTime = 0
	self._closeTime = 0
	self._gatherRedPointShow = false
	self._activityType = 0
	self._curGold = 0
	self._power = 0
	self._totalWinNum = 0
	self._winRate = 0
	self._totalGold = 0
	self._baseStartTime = 0
	self._taskMap = {}
	self._achieveMap = {}
	self._achieveNum = 0
	self._taskRedPoint = false
	self._isHintDead = false
	self._gatherCityId = 0
	self._lastGatherCityId = 0
	self._redTipsGatherId = 0
	self._gatherTs = 0
	self._enemyUsers = {}
	self._enemyGuilds = {}
	self._enemyUserMap = {}
	self._enemyGuildMap = {}
	self._shieldEndTime = 0
	self._todayGetFreeShieldNum = 0
	self._curSeasonGetShieldNum = 0

	local var_2_0 = g.core.common.Storage:load("mine_record_red.json") or {}

	self._recordTs = var_2_0.recordTs or 0
	self._enterRecordTs = var_2_0.enterRecordTs or 0

	self:_initCityInfo()
	self:_initTaskDataList()
end

function MineData:_initCityInfo()
	self._cityList = {}
	self._capitalList = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		local var_3_0 = MineStruct.new({
			cityId = iter_3_1.id
		})

		self._cityMap[iter_3_1.id] = var_3_0
		self._cityList[#self._cityList + 1] = var_3_0

		if iter_3_1.type == 1 then
			self._capitalList[#self._capitalList + 1] = var_3_0
		end

		var_3_0:setCfg(iter_3_1)
	end
end

function MineData:updateMineData(arg_4_1)
	self._timeStage = arg_4_1.status
	self._ownCity = arg_4_1.nowCityId or 0
	self._goldRadio = arg_4_1.nowGoldSpeed or 0
	self._activityType = arg_4_1.mineActivityType
	self._curGold = arg_4_1.nowGold or 0
	self._power = arg_4_1.power or 0
	self._totalGold = arg_4_1.goldAcc or 0
	self._totalWinNum = arg_4_1.winTime or 0
	self._winRate = arg_4_1.winRate or 0
	self._shieldEndTime = arg_4_1.shield_end_time or 0

	for iter_4_0, iter_4_1 in ipairs(self._cityList) do
		iter_4_1:resetData()
	end

	local var_4_0 = arg_4_1.mineCityInfo or {}

	for iter_4_2 = 1, #var_4_0 do
		if self._cityMap[var_4_0[iter_4_2].cityId] then
			self._cityMap[var_4_0[iter_4_2].cityId]:setServerData(var_4_0[iter_4_2])
		end
	end

	self._isHintDead = false

	self:updateEnemyUsers(arg_4_1.mineEnemyUser or {})
	self:updateEnemyGuilds(arg_4_1.mineEnemyGuild or {})
end

function MineData:updateEnemyUsers(arg_5_1)
	arg_5_1 = arg_5_1 or {}
	self._enemyUsers = arg_5_1
	self._enemyUserMap = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if iter_5_1.user then
			self._enemyUserMap[iter_5_1.user.id] = iter_5_1
		end
	end
end

function MineData:updateEnemyGuilds(arg_6_1)
	arg_6_1 = arg_6_1 or {}
	self._enemyGuilds = arg_6_1
	self._enemyGuildMap = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if iter_6_1.guild then
			self._enemyGuildMap[iter_6_1.guild.id] = iter_6_1
		end
	end
end

function MineData:updateCityData(arg_7_1)
	if not arg_7_1.cityId then
		return
	end

	local var_7_0 = self._cityMap[arg_7_1.cityId]

	self._cityMap[arg_7_1.cityId]:setEventId(arg_7_1.eventId)
	var_7_0:updateCityStatus(arg_7_1.cityStatusInfo)
end

function MineData:updateAttackFinish(arg_8_1)
	if arg_8_1.ret ~= g.core.network.proto.RET_OK then
		return
	end

	self._cityMap[arg_8_1.cityStatusInfo.cityId]:updateCityStatus(arg_8_1.cityStatusInfo)
	self:updatePower({
		power = arg_8_1.myBattleResult.powerAfter
	})

	if self:getCurPower() ~= 0 and self:getCurPower() == 0 then
		self._ownCity = g.core.config.mine_map_info.get(self._ownCity).reborn_id

		self:updateGoldRadio()
	end

	self._totalWinNum = arg_8_1.win_time or 0
	self._winRate = arg_8_1.win_rate or 0

	self:addTaskProgressByBattle()
end

function MineData:updateByMoveCity(arg_9_1)
	local var_9_0 = arg_9_1.cityId or {}

	self._ownCity = var_9_0[#var_9_0] or 1
	self._curGold = arg_9_1.nowGold
	self._goldRadio = arg_9_1.nowGoldSpeed

	self._cityMap[self._ownCity]:updateCityStatus(arg_9_1.cityStatusInfo)
end

function MineData:updateEventNotify(arg_10_1)
	local var_10_0 = arg_10_1.event or {}

	for iter_10_0, iter_10_1 in pairs(self._cityMap) do
		iter_10_1:setEventId(0)
	end

	for iter_10_2 = 1, #var_10_0 do
		self._cityMap[var_10_0[iter_10_2].cityId]:setEventId(var_10_0[iter_10_2].eventId)
	end

	self:updateGoldRadio()
end

function MineData:updateCaptureNotify(arg_11_1)
	self._cityMap[arg_11_1.cityStatusInfo.cityId]:updateCityStatus(arg_11_1.cityStatusInfo)

	if arg_11_1.cityStatusInfo.cityId == self._ownCity then
		self:updateGoldRadio()
	end
end

function MineData:updateDeadNotify(arg_12_1)
	self._power = 0
	self._isHintDead = true
end

function MineData:updatePowerNotify(arg_13_1)
	self:setRecordTs(g.core.common.ServerTime:getTime())

	if arg_13_1.power == 0 then
		self._ownCity = g.core.config.mine_map_info.get(self._ownCity).reborn_id

		self:updateGoldRadio()
	end

	self._power = arg_13_1.power or self._power
end

function MineData:updatePower(arg_14_1)
	self._power = arg_14_1.power or 0
end

function MineData:updateMissionState(arg_15_1)
	local var_15_0 = arg_15_1.mineActions or {}
	local var_15_1 = arg_15_1.mineAchieves or {}

	self._taskRedPoint = false
	self._achieveNum = 0

	for iter_15_0 = 1, #var_15_0 do
		local var_15_2 = var_15_0[iter_15_0]

		self._taskMap[var_15_0[iter_15_0].id].progress = var_15_0[iter_15_0].value
		self._taskMap[var_15_2.id].canRec = var_15_2.state == 1
		self._taskMap[var_15_2.id].isFinish = var_15_2.state == 2

		if var_15_2.state > 0 then
			self._achieveNum = self._achieveNum + 1
		end
	end

	for iter_15_1, iter_15_2 in g.core.config.mine_achievement_info.ipairs() do
		local var_15_3 = 0

		if self._achieveNum >= iter_15_2.num then
			var_15_3 = 1
		end

		for iter_15_3 = 1, #var_15_1 do
			if var_15_1[iter_15_3].id == iter_15_2.id then
				var_15_3 = var_15_1[iter_15_3].state

				break
			end
		end

		self._achieveMap[iter_15_2.id] = {
			info = iter_15_2,
			state = var_15_3
		}
	end
end

function MineData:updateGetMissionReward(arg_16_1)
	self._taskMap[arg_16_1.id].canRec = false
	self._taskMap[arg_16_1.id].isFinish = true
end

function MineData:updateGetAchieveReward(arg_17_1)
	self._achieveMap[arg_17_1.id].state = 2
end

function MineData:addTaskProgressByBattle()
	for iter_18_0, iter_18_1 in pairs(self._taskMap) do
		iter_18_1.progress = iter_18_1.progress + 1

		if not iter_18_1.canRec and not iter_18_1.isFinish and var_0_2.get(iter_18_0).num <= iter_18_1.progress then
			iter_18_1.canRec = true
			self._achieveNum = self._achieveNum + 1
		end
	end

	for iter_18_2, iter_18_3 in pairs(self._achieveMap) do
		if iter_18_3.state == 0 and self._achieveNum >= iter_18_3.info.num then
			iter_18_3.state = 1
		end
	end
end

function MineData:updateGoldRadio()
	if self._ownCity <= 0 then
		return
	end

	local var_19_0 = g.core.config.mine_map_info.get(self._ownCity)

	if not var_19_0 then
		return
	end

	local var_19_1 = self._cityMap[self._ownCity]
	local var_19_2 = self._cityMap[self._ownCity]:getEventId()
	local var_19_3 = g.core.config.mine_city_info.get(var_19_0.mine_parameter)
	local var_19_4 = 0

	if self._cityMap[self._ownCity]:isCityUnique() then
		var_19_4 = var_19_3.occu_bonus + var_19_3.exclusive_bonus
	elseif var_19_1:isCityOccu() then
		var_19_4 = var_19_3.occu_bonus
	end

	local var_19_5 = 1

	if var_19_2 > 0 then
		var_19_5 = g.core.config.mine_event_info.get(var_19_2).preduce_speed_rate1 / 1000
	end

	local var_19_6, var_19_7 = var_19_1:isDecrease()

	if var_19_6 then
		var_19_4 = var_19_4 - var_19_7 * 1000
	end

	self._goldRadio = math.floor(86400 / (var_19_3.preduce_speed * var_19_5 * (1 + var_19_4 / 1000)))
end

function MineData:getCityRadio(arg_20_1)
	if not arg_20_1 or arg_20_1 <= 0 then
		return
	end

	if not g.core.config.mine_map_info.get(arg_20_1) then
		return
	end

	local var_20_0
	local var_20_1 = self._cityMap[arg_20_1]
	local var_20_2 = self._cityMap[arg_20_1]:getCfg()
	local var_20_3 = self._cityMap[arg_20_1]:getEventId()
	local var_20_4 = self._cityMap[arg_20_1]:getPeopleNum()

	if self._cityMap[arg_20_1]:isCapital() then
		return (var_20_3 == g.core.const.ConstMgr.MineConst.EVENT_ID.CAPITAL or nil) and g.core.config.mine_event_info.get(var_20_3).cap_preduce_speed
	end

	local var_20_8 = g.core.config.mine_city_info.get(var_20_2.mine_parameter)
	local var_20_9, var_20_10 = var_20_1:isDecrease()
	local var_20_11 = g.core.platform.ServerListProxy:getSelectedServer().sid
	local var_20_12 = g.core.model.User.guildData:getGuildId()
	local var_20_13 = var_20_1:getGuildData()

	if not g.core.model.User.guildData:hasGuild() then
		var_20_0 = g.core.const.ConstMgr.MineConst.NOT_OCCU
	elseif g.core.model.User.mineData:getOwnCity() ~= var_20_2.id then
		if var_20_4 == 0 then
			var_20_0 = g.core.const.ConstMgr.MineConst.UNIQUE_STATE
		else
			var_20_9, var_20_10 = var_20_1:isDecrease(var_20_4 + 1)

			if not var_20_13 or tostring(var_20_13.id) ~= tostring(var_20_12) or tostring(var_20_11) ~= tostring(var_20_13.sid) then
				var_20_0 = g.core.const.ConstMgr.MineConst.NOT_OCCU
			end
		end
	elseif not var_20_13 or tostring(var_20_13.id) ~= tostring(var_20_12) or tostring(var_20_11) ~= tostring(var_20_13.sid) then
		var_20_0 = g.core.const.ConstMgr.MineConst.NOT_OCCU
	end

	if var_20_13 and var_20_0 ~= g.core.const.ConstMgr.MineConst.UNIQUE_STATE then
		var_20_0 = g.core.const.ConstMgr.MineConst.OCCU_STATE
	end

	local var_20_14 = 0

	if var_20_0 == g.core.const.ConstMgr.MineConst.OCCU_STATE then
		var_20_14 = var_20_8.occu_bonus
	elseif var_20_0 == g.core.const.ConstMgr.MineConst.UNIQUE_STATE then
		var_20_14 = var_20_8.occu_bonus + var_20_8.exclusive_bonus
	end

	if var_20_9 then
		var_20_14 = var_20_14 - var_20_10 * 1000
	end

	return var_20_8.preduce_speed * ((var_20_3 > 0 or nil) and g.core.config.mine_event_info.get(var_20_3).preduce_speed_rate1 / 1000) * (1 + var_20_14 / 1000)
end

function MineData:getMovePath(arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = {}
	local var_21_2 = {}
	local var_21_3 = false

	table.insert(var_21_0, arg_21_1)

	var_21_1[tostring(arg_21_1)] = true

	repeat
		local var_21_4 = var_0_1.get(var_21_0[1])

		for iter_21_0 = 1, 4 do
			if var_21_4["near_city_id" .. iter_21_0] > 0 and not var_21_1[tostring(var_21_4["near_city_id" .. iter_21_0])] then
				table.insert(var_21_0, var_21_4["near_city_id" .. iter_21_0])

				var_21_1[tostring(var_21_4["near_city_id" .. iter_21_0])] = true
				var_21_2[tostring(var_21_4["near_city_id" .. iter_21_0])] = var_21_0[1]
			end

			var_21_3 = var_21_4["near_city_id" .. iter_21_0] == arg_21_2

			if var_21_3 then
				break
			end
		end

		table.remove(var_21_0, 1)
	until next(var_21_0) == nil or var_21_3

	local var_21_5 = {}

	if var_21_3 then
		table.insert(var_21_5, arg_21_2)

		local function var_21_7(arg_22_0)
			local var_22_0 = var_21_2[tostring(arg_22_0)]

			if var_22_0 then
				table.insert(var_21_5, 1, var_22_0)
				var_21_7(var_22_0)
			end
		end

		;(nil)(arg_21_2)

		return var_21_5
	else
		return {}
	end
end

function MineData:getTimeStage()
	local var_23_0 = g.core.common.ServerTime:getTime()

	if var_23_0 <= self:getSeasonStartTime() then
		return g.core.const.ConstMgr.MineConst.TIME_STAGE.NOT_AVAILABLE
	elseif var_23_0 <= self:getTotalWarTime() then
		return g.core.const.ConstMgr.MineConst.TIME_STAGE.NORMAL
	elseif var_23_0 <= self:getSeasonEndTime() then
		return g.core.const.ConstMgr.MineConst.TIME_STAGE.TOTAL_WAR
	elseif var_23_0 <= self:getCloseTime() then
		return g.core.const.ConstMgr.MineConst.TIME_STAGE.RESULT
	end
end

function MineData:getBattleCostById(arg_24_1)
	if self:getTimeStage() == g.core.const.ConstMgr.MineConst.TIME_STAGE.TOTAL_WAR then
		return g.core.config.mine_parameter_info.indexOf(1).war_spend_num
	else
		return self._cityMap[arg_24_1]:getBattleCost()
	end
end

function MineData:getNotCapitalCityList(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(self._cityList) do
		if not iter_25_1:isCapital() then
			table.insert(var_25_0, iter_25_1)
		end
	end

	if arg_25_1 then
		local var_25_1 = {}

		for iter_25_2, iter_25_3 in ipairs(var_25_0) do
			var_25_1[iter_25_3:getCfg().id] = iter_25_3:getRankInfo()
		end

		table.sort(var_25_0, function(arg_26_0, arg_26_1)
			local var_26_0 = arg_26_0:getCfg()
			local var_26_1 = arg_26_1:getCfg()
			local var_26_2 = var_25_1[var_26_1.id]

			if var_25_1[var_26_0.id] and var_26_2 then
				return var_25_1[var_26_0.id].order < var_26_2.order
			end

			return var_26_0.id < var_26_1.id
		end)
	end

	return var_25_0
end

function MineData:_initTaskDataList()
	for iter_27_0, iter_27_1 in var_0_2.ipairs() do
		self._taskMap[iter_27_1.id] = {
			canRec = false,
			isFinish = false,
			progress = 0,
			info = iter_27_1
		}
	end
end

function MineData:getScoreProgress()
	return self._achieveNum, g.core.config.mine_achievement_info.indexOf((g.core.config.mine_achievement_info.getLength())).num
end

function MineData:isOwnCapital()
	return (self._cityMap[self._ownCity]:isCapital())
end

function MineData:isOutputGold()
	local var_30_0 = self._cityMap[self._ownCity]:getEventId()

	if not self._cityMap[self._ownCity]:isCapital() then
		return true
	else
		return var_30_0 == g.core.const.ConstMgr.MineConst.EVENT_ID.CAPITAL
	end
end

function MineData:updateGetGold(arg_31_1)
	self._totalGold = arg_31_1.goldAcc or 0
end

function MineData:updateRedPoint(arg_32_1)
	if not arg_32_1.mine_hint then
		return
	end

	self._todayGetFreeShieldNum = arg_32_1.mine_hint.daily_shield_num or 0
	self._curSeasonGetShieldNum = arg_32_1.mine_hint.buy_shield_count or 0
	self._startTime = arg_32_1.mine_hint.start_time or 0
	self._endTime = arg_32_1.mine_hint.end_time or 0
	self._taskRedPoint = arg_32_1.mine_hint.mission_reward == 1
	self._isHintDead = arg_32_1.mine_hint.power == 0

	if arg_32_1.mine_hint.city_id and arg_32_1.mine_hint.city_id > 0 then
		self._gatherCityId = arg_32_1.mine_hint.city_id
		self._gatherRedPointShow = self._redTipsGatherId ~= self._gatherCityId
	end

	self._totalWarTime = arg_32_1.mine_hint.war_time or 0
	self._closeTime = arg_32_1.mine_hint.show_time or 0
end

function MineData:onMineGetShield(arg_33_1)
	if arg_33_1.is_buy == 0 then
		self._todayGetFreeShieldNum = self._todayGetFreeShieldNum + 1
	else
		self._curSeasonGetShieldNum = self._curSeasonGetShieldNum + 1

		g.core.model.User.shopData:updateShopInfo({
			num = 1,
			id = g.core.config.shop_score_info.get(g.core.config.resource_info.get(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.MINE_SHIELD_ITEM).shop_id).id
		})
	end

	self._shieldEndTime = arg_33_1.shield_end_time
end

function MineData:_updateTime()
	local var_34_0 = g.core.common.ServerTime:getTime()
	local var_34_1 = g.core.config.mine_parameter_info.get(1)
	local var_34_2 = math.abs(var_34_1.war_time - var_34_1.end_time)

	var_34_2 = var_34_1.war_time > var_34_1.end_time and var_34_1.war_time - (var_34_1.end_time + 604800) or var_34_1.war_time - var_34_1.end_time

	local var_34_3 = 0

	var_34_3 = var_34_1.open_time > var_34_1.end_time and var_34_1.open_time - var_34_1.end_time or var_34_1.open_time + 604800 - var_34_1.end_time

	local var_34_4 = self._baseStartTime

	if self._baseStartTime == 0 then
		local var_34_5 = var_0_4:getMondayTime()
		local var_34_6 = var_34_5 + var_34_1.open_time

		if var_34_0 < var_34_5 + var_34_1.open_time then
			var_34_6 = var_34_6 - 604800
		end

		local var_34_7 = var_34_5 + var_34_1.end_time

		if var_34_5 + var_34_1.end_time < var_34_6 then
			var_34_7 = var_34_7 + 604800
		end

		self._startTime = var_34_6
		self._endTime = var_34_7
		self._totalWarTime = var_34_7 + var_34_2
		self._newLeagueStartTime = var_34_7 + var_34_3
	else
		local var_34_8 = var_0_4:getMondayTime(var_34_4) + var_34_1.end_time

		while var_34_8 < var_34_4 or var_0_4:getDeltaDays(var_34_4, var_34_8 + var_34_3) < 7 do
			var_34_8 = var_34_8 + 604800
		end

		self._startTime = var_34_4
		self._endTime = var_34_8
		self._totalWarTime = var_34_8 + var_34_2
		self._newLeagueStartTime = var_34_8 + var_34_3

		if var_34_0 > self._newLeagueStartTime then
			self._baseStartTime = 0

			self:_updateTime()
		end
	end
end

function MineData:_checkTime()
	return
end

function MineData:getSeasonStartTime()
	self:_checkTime()

	return self._startTime
end

function MineData:getSeasonEndTime()
	self:_checkTime()

	return self._endTime
end

function MineData:getTotalWarTime()
	self:_checkTime()

	return self._totalWarTime
end

function MineData:getCloseTime()
	self:_checkTime()

	return self._closeTime
end

function MineData:getNewLeagueStartTime()
	self:_checkTime()

	return self._newLeagueStartTime
end

function MineData:isSeasonUnlock()
	return g.core.common.ServerTime:getTime() >= self:getSeasonStartTime()
end

function MineData:isHasNewRecord()
	return self._enterRecordTs < self._recordTs
end

function MineData:setRecordTs(arg_43_1)
	self._recordTs = arg_43_1

	g.core.common.Storage:save("mine_record_red.json", {
		recordTs = self._recordTs,
		enterRecordTs = self._enterRecordTs
	})
end

function MineData:updateEnterRecordTs()
	self._enterRecordTs = g.core.common.ServerTime:getTime()

	g.core.common.Storage:save("mine_record_red.json", {
		recordTs = self._recordTs,
		enterRecordTs = self._enterRecordTs
	})
end

function MineData:updateGetRecord(arg_45_1)
	local var_45_1 = 0

	for iter_45_0, iter_45_1 in ipairs(arg_45_1.records or {}) do
		var_45_1 = math.max(var_45_1, iter_45_1.battle_ts)
	end

	if var_45_1 > self._recordTs then
		self._recordTs = var_45_1

		g.core.common.Storage:save("mine_record_red.json", {
			recordTs = self._recordTs,
			enterRecordTs = self._enterRecordTs
		})
	end
end

function MineData:getTaskDataList()
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in pairs(self._taskMap) do
		table.insert(var_46_0, iter_46_1)
	end

	table.sort(var_46_0, function(arg_47_0, arg_47_1)
		local var_47_0 = arg_47_0.info.sort
		local var_47_1 = arg_47_1.info.sort

		if arg_47_0.canRec ~= arg_47_1.canRec then
			return arg_47_0.canRec
		end

		if arg_47_0.isFinish ~= arg_47_1.isFinish then
			return not arg_47_0.isFinish
		end

		if var_47_0 ~= var_47_1 then
			return var_47_0 < var_47_1
		end
	end)

	return var_46_0
end

function MineData:getAchieveList()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in pairs(self._achieveMap) do
		table.insert(var_48_0, iter_48_1)
	end

	table.sort(var_48_0, function(arg_49_0, arg_49_1)
		if arg_49_0.info.num ~= arg_49_1.info.num then
			return arg_49_0.info.num < arg_49_1.info.num
		end
	end)

	return var_48_0
end

function MineData:canRecTaskFullReward()
	if not self:isInOpenTime() then
		return false
	end

	return self:canRecTaskReward() or self:canRecAchieveReward()
end

function MineData:isHintDead()
	if not self:isInOpenTime() then
		return false
	end

	return self._isHintDead
end

function MineData:setGatherRedPoint(arg_52_1)
	self._gatherRedPointShow = arg_52_1

	if not arg_52_1 then
		self._redTipsGatherId = self._gatherCityId
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINE_GATHER_RED_POINT)
end

function MineData:gatherRedPoint()
	if not self:isInOpenTime() then
		return false
	end

	if self:isInResultTime() then
		return false
	end

	return self._gatherRedPointShow
end

function MineData:getCityTaskDataList()
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(self._taskMap) do
		if var_0_2.get(iter_54_0).target == 1099 then
			table.insert(var_54_0, iter_54_1)
		end
	end

	table.sort(var_54_0, function(arg_55_0, arg_55_1)
		local var_55_0 = arg_55_0.info.sort
		local var_55_1 = arg_55_1.info.sort

		if arg_55_0.canRec ~= arg_55_1.canRec then
			return arg_55_0.canRec
		end

		if arg_55_0.isFinish ~= arg_55_1.isFinish then
			return not arg_55_0.isFinish
		end

		if var_55_0 ~= var_55_1 then
			return var_55_0 < var_55_1
		end
	end)

	return var_54_0
end

function MineData:isInOpenTime()
	local var_56_0 = g.core.common.ServerTime:getTime()

	self._startTime = self._startTime or 0
	self._closeTime = self._closeTime or 0

	if var_56_0 >= self._startTime and var_56_0 < self._closeTime then
		return true
	end

	return false
end

function MineData:isInResultTime()
	local var_57_0 = g.core.common.ServerTime:getTime()

	self._startTime = self._startTime or 0
	self._endTime = self._endTime or 0

	if var_57_0 >= self._endTime and var_57_0 < self._closeTime then
		return true
	end

	return false
end

function MineData:isInWarTime()
	local var_58_0 = g.core.common.ServerTime:getTime()

	self._startTime = self._startTime or 0
	self._endTime = self._endTime or 0

	if var_58_0 >= self._startTime and var_58_0 < self._endTime then
		return true
	end

	return false
end

function MineData:canRecTaskReward()
	if self._taskRedPoint then
		return true
	end

	for iter_59_0, iter_59_1 in pairs(self._taskMap) do
		if iter_59_1.canRec then
			return true
		end
	end

	return false
end

function MineData:canRecAchieveReward()
	if self._taskRedPoint then
		return true
	end

	for iter_60_0, iter_60_1 in pairs(self._achieveMap) do
		if iter_60_1.state == 1 then
			return true
		end
	end

	return false
end

function MineData:isNewServerSeason()
	if self:getTimeStage() == g.core.const.ConstMgr.MineConst.TIME_STAGE.NOT_AVAILABLE then
		if self:getSeasonStartTime() - (g.core.common.ServerTime:getOpenTime() - g.core.common.ServerTime:getOpenTimeFromZero()) < 345600 then
			return false
		end

		return true
	end

	return false
end

function MineData:getGuildOccupyCity(arg_62_1)
	local var_62_0

	for iter_62_0, iter_62_1 in ipairs((self:getCityList())) do
		local var_62_1 = iter_62_1:getGuildData()

		if var_62_1 and var_62_1.id == arg_62_1 then
			if not var_62_0 then
				var_62_0 = iter_62_1
			else
				local var_62_2 = var_62_0:getCfg()
				local var_62_3 = iter_62_1:getCfg()

				if var_62_2.quality ~= var_62_3.quality then
					var_62_0 = var_62_2.quality > var_62_3.quality and var_62_0 or iter_62_1
				else
					local var_62_4 = var_62_0:isInBonusEvent()

					var_62_0 = var_62_0:isInBonusEvent() and var_62_0 or iter_62_1
				end
			end
		end
	end

	return var_62_0
end

function MineData:isEnemyUser(arg_63_1)
	return checkbool(self._enemyUserMap[arg_63_1])
end

function MineData:isEnemyGuild(arg_64_1)
	return checkbool(self._enemyGuildMap[arg_64_1])
end

function MineData:updateMassInfo(arg_65_1)
	self._gatherCityId = 0

	if arg_65_1.cityId and arg_65_1.cityId > 0 then
		self._gatherCityId = arg_65_1.cityId

		self:setGatherRedPoint(self._redTipsGatherId ~= self._gatherCityId)
	end

	self._gatherTs = arg_65_1.stamp or 0
end

function MineData:updateMass(arg_66_1)
	if arg_66_1.type == 1 then
		self._lastGatherCityId = self._gatherCityId
		self._gatherCityId = arg_66_1.cityId or 0

		self:setGatherRedPoint(self._redTipsGatherId ~= self._gatherCityId)
	elseif arg_66_1.type == 2 then
		self._lastGatherCityId = self._gatherCityId
		self._gatherCityId = 0

		self:setGatherRedPoint(false)
	end

	self._gatherTs = arg_66_1.stamp or 0
end

function MineData:updateMassNotify(arg_67_1)
	if arg_67_1.type == 1 then
		self._lastGatherCityId = self._gatherCityId
		self._gatherCityId = arg_67_1.cityId or 0

		self:setGatherRedPoint(self._redTipsGatherId ~= self._gatherCityId)
	elseif arg_67_1.type == 2 then
		self._lastGatherCityId = self._gatherCityId
		self._gatherCityId = 0

		self:setGatherRedPoint(false)
	end
end

function MineData:isGathering()
	return self._gatherCityId > 0
end

function MineData:saveEnemyUserCache()
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in ipairs(self._enemyUsers) do
		var_69_0[tostring(iter_69_1.user.id)] = true
	end

	g.core.common.Storage:save("mine_enemy_user.json", var_69_0)
end

function MineData:hasNewEnemyUser()
	local var_70_0 = g.core.common.Storage:load("mine_enemy_user.json") or {}

	for iter_70_0, iter_70_1 in ipairs(self._enemyUsers) do
		if not var_70_0[tostring(iter_70_1.user.id)] then
			return true
		end
	end

	return false
end

function MineData:saveEnemyGuildCache()
	local var_71_0 = {}

	for iter_71_0, iter_71_1 in ipairs(self._enemyGuilds) do
		var_71_0[tostring(iter_71_1.guild.id)] = true
	end

	g.core.common.Storage:save("mine_enemy_guild.json", var_71_0)
end

function MineData:hasNewEnemyGuild()
	local var_72_0 = g.core.common.Storage:load("mine_enemy_guild.json") or {}

	for iter_72_0, iter_72_1 in ipairs(self._enemyGuilds) do
		if not var_72_0[tostring(iter_72_1.guild.id)] then
			return true
		end
	end

	return false
end

function MineData:setMoveReqPath(arg_73_1)
	self._moveReqPath = arg_73_1
end

function MineData:getMoveReqPath()
	if self._moveReqPath then
		self._moveReqPath = nil

		return true, self._moveReqPath
	else
		return false
	end
end

function MineData:isInSeason()
	local var_75_0 = self:getTimeStage()

	return var_75_0 == g.core.const.ConstMgr.MineConst.TIME_STAGE.NORMAL or var_75_0 == g.core.const.ConstMgr.MineConst.TIME_STAGE.TOTAL_WAR
end

function MineData:isInShopSeason()
	local var_76_0 = self:getTimeStage()

	return var_76_0 == g.core.const.ConstMgr.MineConst.TIME_STAGE.NORMAL or var_76_0 == g.core.const.ConstMgr.MineConst.TIME_STAGE.TOTAL_WAR or var_76_0 == g.core.const.ConstMgr.MineConst.TIME_STAGE.RESULT
end

function MineData:getTaskDesc(arg_77_1)
	if arg_77_1.target == 1338 then
		return g.core.lang:get(307552, {
			num = arg_77_1.num
		})
	elseif arg_77_1.target == 1099 then
		return g.core.lang:get(307553, {
			num = arg_77_1.num
		})
	end
end

function MineData:isMeHasShield()
	if var_0_3 then
		return false
	end

	return self._shieldEndTime ~= 0 and self._shieldEndTime >= var_0_4:getTime()
end

function MineData:getShieldLastTime()
	if self:isMeHasShield() then
		return self._shieldEndTime - var_0_4:getTime()
	end

	return 0
end

function MineData:getShieldLastTimeStr()
	local var_80_0 = self:getShieldLastTime()
	local var_80_1 = math.floor(var_80_0 / 60)
	local var_80_2 = math.floor(var_80_1 / 60)

	return g.core.utils.Number.getFormatNum(2, var_80_2) .. ":" .. g.core.utils.Number.getFormatNum(2, var_80_1 - var_80_2 * 60) .. ":" .. g.core.utils.Number.getFormatNum(2, (math.floor(var_80_0 % 60)))
end

function MineData:setShieldFightNotify(arg_81_1)
	self._shieldNotifyData = {
		svrTime = var_0_4:getTime()
	}

	g.core.common.Storage:save("mine_record_shield_notify.json", self._shieldNotifyData, true)
end

function MineData:isNeedShieldFightNotify()
	self._shieldNotifyData = self._shieldNotifyData or g.core.common.Storage:load("mine_record_shield_notify.json", true) or {
		svrTime = 0
	}

	return var_0_4:getIsSameDay(self._shieldNotifyData.svrTime)
end

function MineData:isShieldingShield()
	return var_0_3
end

function MineData:getCanFreeGetShieldNum()
	if var_0_3 then
		return 0
	end

	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MINE_FREE_SHIELD_NUM).parameter - self._todayGetFreeShieldNum
end

function MineData:getCurSeasonBuyShieldNum()
	return self._curSeasonGetShieldNum
end

function MineData:hasFreeShieldCanGet()
	if not self:isInSeason() then
		return false
	end

	return self:getCanFreeGetShieldNum() > 0
end

function MineData:getCityObjMap()
	return self._cityMap
end

function MineData:getCityList()
	return self._cityList
end

function MineData:getOwnCity()
	return self._ownCity
end

function MineData:getCityObjById(arg_90_1)
	return self._cityMap[arg_90_1]
end

function MineData:getGoldRadio()
	return self._goldRadio
end

function MineData:getActivtyType()
	return self._activityType
end

function MineData:getCurGold()
	return self._curGold
end

function MineData:getCurPower()
	return self._power
end

function MineData:getTotalWinNum()
	return self._totalWinNum
end

function MineData:getWinRate()
	return self._winRate
end

function MineData:getTotalGold()
	return self._totalGold
end

function MineData:getCapitalList()
	return self._capitalList
end

function MineData:getGatherCityId()
	return self._gatherCityId
end

function MineData:getLastGatherCityId()
	return self._lastGatherCityId
end

function MineData:getEnemyUsers()
	return self._enemyUsers
end

function MineData:getEnemyGuilds()
	return self._enemyGuilds
end

function MineData:getGatherTs()
	return self._gatherTs
end

function MineData:hasRichCity(arg_104_1)
	if self._power < 50 then
		return
	end

	local var_104_0 = arg_104_1.cityId
	local var_104_1 = {}
	local var_104_2 = {}

	if arg_104_1.cityId then
		if self._cityMap[var_104_0]:getEventId() > self._cityMap[self._ownCity]:getEventId() then
			var_104_1[#var_104_1 + 1] = var_104_0
		end
	else
		for iter_104_0, iter_104_1 in ipairs(self._cityList) do
			if iter_104_1:getEventId() > self._cityMap[self._ownCity]:getEventId() then
				var_104_1[#var_104_1 + 1] = var_104_0
			end
		end
	end

	local var_104_3 = g.core.config.mine_parameter_info.indexOf(1).move_spend
	local var_104_4 = g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_GRAIN)

	for iter_104_2, iter_104_3 in ipairs(var_104_1) do
		if var_104_4 >= var_104_3 * (#g.core.model.User.mineData:getMovePath(self._ownCity, iter_104_3) - 1) then
			var_104_2[#var_104_2 + 1] = iter_104_3
		end
	end

	return #var_104_2 > 0
end

function MineData:hasMoreHalfPower(arg_105_1)
	if self._ownCity == 0 then
		return false
	end

	if self._power >= 50 or not self._cityMap[self._ownCity]:isCapital() then
		return
	end

	return self._power + g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_GRAIN) > 50
end

function MineData:isShowOwnCoinRed(arg_106_1)
	if self._ownCity == 0 then
		return false
	end

	local var_106_0 = self:getCityRadio(self._ownCity)

	if not var_106_0 then
		return false
	end

	return (arg_106_1.curGold or self._curGold) >= math.ceil(var_106_0 / 2)
end

return MineData
