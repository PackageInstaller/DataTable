local var_0_0 = g.core.config.dead_tower_zone_info
local var_0_1 = g.core.config.dead_tower_map_info
local var_0_2 = g.core.config.dead_tower_task_info
local var_0_3 = g.core.config.parameter_info
local var_0_4 = g.core.config.dead_tower_card_info
local var_0_5 = g.core.const.ConstMgr
local var_0_6 = g.core.const.ConstMgr.WushTowerConst
local var_0_7 = g.core.common.Path
local var_0_8 = g.core.common.ServerTime
local WushTowerTaskStruct = import(".WushTowerTaskStruct")
local WushTowerData = class("WushTowerData")

function WushTowerData:ctor()
	self:initData()
end

function WushTowerData:initData()
	self._nextResetTime = 0
	self._zoneId = 1
	self._challengeTime = 0
	self._challengeFloor = 0
	self._nextRecoverTime = 0
	self._myRanking = 0
	self._curIndex = 0
	self._sumUserHp = 0
	self._maxZoneId = 0
	self._svrCards = {}
	self._isCanTaskAward = false
	self._isCanChallenge = false
	self._isReset = false
	self._isRecover = false
	self._isPassParcel = false
	self._isGotoParcel = false
	self._passMaxZoneId = 0
	self._displayVersion = 1
	self._formationHpMap = {}
	self._passGrids = {}
	self._usingCards = {}
	self._rankArr = {}
	self._ownCards = {}
	self._taskStructDict = self:_getTaskStructDict()
	self._maxZoneId = self:getMaxZoneId()
end

function WushTowerData:onS2CDeadTowerEnterInfo(arg_3_1)
	self._zoneId = arg_3_1.zone_id or 1
	self._curIndex = arg_3_1.now_grid_id or 0
	self._challengeTime = arg_3_1.challenge_num or 0
	self._challengeFloor = arg_3_1.challenge_floor or 0
	self._nextResetTime = arg_3_1.next_reset_time or var_0_8:getTime()
	self._nextRecoverTime = arg_3_1.next_recover_time or var_0_8:getTime()
	self._ownCards = arg_3_1.cards or {}
	self._passGrids = arg_3_1.pass_grids or {}
	self._isReset = arg_3_1.reset_notice or false
	self._passMaxZoneId = arg_3_1.pass_max_zone_id or 0

	self:setGridData(arg_3_1.grids or {})
	self:setUserHp(arg_3_1.user_hp or {})
	self:_updateTaskStructDict(arg_3_1.tasks)
end

function WushTowerData:onS2CDeadTowerBattleFinish(arg_4_1)
	self._zoneId = arg_4_1.zone_id or 1
	self._challengeTime = arg_4_1.challenge_num or 0

	if arg_4_1.is_win then
		self:_syncWushTowerGridData(arg_4_1.grid_id)

		for iter_4_0, iter_4_1 in ipairs(self._svrCards) do
			self:deleteOneCard(iter_4_1)
		end
	end

	self:setUserHp(arg_4_1.user_hp or {})
end

function WushTowerData:onS2CDeadTowerNextGrids(arg_5_1)
	self:setGridData(arg_5_1.grids or {})

	self._isRecover = arg_5_1.reset_hp_notice or false
	self._zoneId = math.min(self._zoneId + 1, self._maxZoneId)
	self._curIndex = 0
	self._isPassParcel = false
	self._passGrids = {}
end

function WushTowerData:onS2CDeadTowerChooseGrid(arg_6_1)
	self._curIndex = arg_6_1.grid_id or 0
	self._isGotoParcel = true
end

function WushTowerData:onS2CDeadTowerBattleStart(arg_7_1)
	self._svrCards = {}

	if arg_7_1.cards then
		self._svrCards = arg_7_1.cards
	end
end

function WushTowerData:onS2CFlushRedPoint(arg_8_1)
	self._isCanTaskAward = arg_8_1.task_award or false
	self._isCanChallenge = arg_8_1.challenge or false
end

function WushTowerData:onS2cTaskAward(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.ids or {}) do
		local var_9_1 = self:getTaskStructById(iter_9_1)

		if var_9_1 then
			var_9_1:setToReceived()
		end
	end
end

function WushTowerData:onS2cOneKeySweepAward(arg_10_1)
	self._isCanTaskAward = false
	self._isCanChallenge = false
	self._zoneId = arg_10_1.zone_id
	self._curIndex = arg_10_1.grid_id
	self._challengeTime = arg_10_1.challenge_num
end

function WushTowerData:onS2CActionStatusFlush(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self._taskStructDict) do
		if iter_11_1.taskCfg.refresh == var_0_5.TaskConst.RESET_TYPE.WUSH_TOWER and iter_11_1.taskCfg.task_type == arg_11_1.status.id then
			iter_11_1:setValue(arg_11_1.status.status)
		end
	end
end

function WushTowerData:onS2CGetCommonRankList(arg_12_1)
	self._myRanking = arg_12_1.self_rank or 0
	self._rankArr = arg_12_1.rank_units or {}
end

function WushTowerData:onS2CGetCard(arg_13_1)
	self:addOneCard(arg_13_1.card_id)
	self:_syncWushTowerGridData(arg_13_1.grid_id)
end

function WushTowerData:_getTaskStructDict()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in var_0_2.ipairs() do
		var_14_0[iter_14_1.id] = WushTowerTaskStruct.new(iter_14_1)
	end

	return var_14_0
end

function WushTowerData:_updateTaskStructDict(arg_15_1)
	if not arg_15_1 then
		return
	end

	self._taskStructDict = self:_getTaskStructDict()

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1.actions or {}) do
			for iter_15_4, iter_15_5 in pairs(self._taskStructDict) do
				if iter_15_5.taskCfg.refresh == iter_15_1.reset_type and iter_15_5.taskCfg.task_type == iter_15_3.id then
					iter_15_5:setValue(iter_15_3.num)
				end
			end
		end

		for iter_15_6, iter_15_7 in ipairs(iter_15_1.award_task_ids or {}) do
			local var_15_1 = self:getTaskStructById(iter_15_7)

			if var_15_1 then
				var_15_1:setToReceived()
			end
		end
	end
end

function WushTowerData:getTaskStructById(arg_16_1)
	return self._taskStructDict[arg_16_1]
end

function WushTowerData:getTaskStructArr()
	return table.values(self._taskStructDict)
end

function WushTowerData:getTaskIdsRcvEnable()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self._taskStructDict) do
		if iter_18_1:isRcvEnable() then
			table.insert(var_18_0, iter_18_0)
		end
	end

	return var_18_0
end

function WushTowerData:sortTaskStructArr(arg_19_1)
	if not arg_19_1 then
		return
	elseif #arg_19_1 < 2 then
		return
	end

	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		if arg_20_0.state ~= arg_20_1.state then
			return arg_20_0.state < arg_20_1.state
		end

		local var_20_0 = arg_20_0.taskCfg
		local var_20_1 = arg_20_1.taskCfg

		if arg_20_0.taskCfg.task_type ~= arg_20_1.taskCfg.task_type then
			return arg_20_0.taskCfg.task_type < arg_20_1.taskCfg.task_type
		end

		return var_20_0.id < var_20_1.id
	end)
end

function WushTowerData:sortCardArr(arg_21_1)
	if #arg_21_1 < 2 then
		return
	end

	table.sort(arg_21_1, function(arg_22_0, arg_22_1)
		return arg_22_0.id < arg_22_1.id
	end)
end

function WushTowerData:getBackGroundUrlByZoneId(arg_23_1, arg_23_2)
	local var_23_1

	if arg_23_2 then
		var_23_1 = var_0_6.MAINLAYER_BG_URL or var_0_6.SUBLAYER_BG_URL
	end

	local var_23_2 = var_0_0.fetch(arg_23_1, 1)

	return string.format(var_23_1, tostring((var_23_2 or nil) and var_23_2.background))
end

function WushTowerData:getMapIdByZoneId(arg_24_1)
	local var_24_1 = var_0_0.fetch(arg_24_1, 1)

	return (var_24_1 or nil) and var_24_1.map_id
end

function WushTowerData:getFloorByParcel(arg_25_1, arg_25_2)
	local var_25_0 = var_0_1.fetch(self:getMapIdByZoneId(arg_25_1), arg_25_2)

	if var_25_0 then
		return var_25_0.floor
	end

	return 0
end

function WushTowerData:getCardNumById(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self._ownCards) do
		if arg_26_1 == iter_26_1.id then
			return iter_26_1.num
		end
	end

	return 0
end

function WushTowerData:setUsingCards(arg_27_1)
	if #self._usingCards > 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(408420))

		return false
	end

	local var_27_0 = true

	for iter_27_0, iter_27_1 in ipairs(self._usingCards) do
		if arg_27_1.id == iter_27_1.useCard.id then
			var_27_0 = false

			g.core.module.ModuleManager:tip(g.core.lang:get(408421))

			break
		end
	end

	if var_27_0 then
		if self._usingCards[1] and self._usingCards[1].pos == 1 then
			table.insert(self._usingCards, {
				pos = 2,
				useCard = arg_27_1
			})
		else
			table.insert(self._usingCards, {
				pos = 1,
				useCard = arg_27_1
			})
		end

		return true
	end

	return false
end

function WushTowerData:deletUsingCards(arg_28_1)
	for iter_28_0 = #self._usingCards, 1, -1 do
		if arg_28_1 == self._usingCards[iter_28_0].useCard.id then
			table.remove(self._usingCards, iter_28_0)
		end
	end
end

function WushTowerData:getUsingCards()
	return self._usingCards
end

function WushTowerData:getC2SUsingCards()
	local var_30_0 = {}

	for iter_30_0 = 1, #self._usingCards do
		table.insert(var_30_0, self._usingCards[iter_30_0].useCard.id)
	end

	return var_30_0
end

function WushTowerData:resetUsingCards()
	self._usingCards = {}
end

function WushTowerData:getCanUseCardCount()
	local var_32_0 = #self._ownCards

	for iter_32_0 = 1, #self._usingCards do
		for iter_32_1 = 1, #self._ownCards do
			if self._ownCards[iter_32_1].id == self._usingCards[iter_32_0].useCard.id then
				var_32_0 = var_32_0 - 1
			end
		end
	end

	local var_32_1 = 2 - #self._usingCards

	if 2 - #self._usingCards < var_32_0 then
		-- block empty
	else
		var_32_1 = var_32_0
	end

	return var_32_1
end

function WushTowerData:setGridData(arg_33_1)
	self._gridInfos = {}

	if arg_33_1 then
		for iter_33_0, iter_33_1 in pairs(arg_33_1) do
			self._gridInfos[iter_33_1.grid_id] = iter_33_1
		end
	end
end

function WushTowerData:_syncWushTowerGridData(arg_34_1)
	if arg_34_1 then
		self._isPassParcel = true

		table.insert(self._passGrids, arg_34_1)

		self._gridInfos[arg_34_1].grid_status = 1
		self._curIndex = arg_34_1
		self._challengeFloor = self._challengeFloor + 1
	end
end

function WushTowerData:isPassZone()
	local var_35_0 = var_0_6.WUSH_TOWER_STAGE_COUNT

	if self._gridInfos and self._gridInfos[var_35_0] then
		return checkbool(self._gridInfos[var_35_0].grid_status == 1)
	end

	return false
end

function WushTowerData:setUserHp(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		self._formationHpMap[iter_36_0] = self._formationHpMap[iter_36_0] or {}
		self._formationHpMap[iter_36_0] = iter_36_1
	end

	self._sumUserHp = 0

	for iter_36_2, iter_36_3 in ipairs(arg_36_1) do
		self._sumUserHp = self._sumUserHp + iter_36_3
	end
end

function WushTowerData:getSumUserHp()
	return self._sumUserHp
end

function WushTowerData:getWushTowerFormationHpMap()
	return self._formationHpMap
end

function WushTowerData:getChallengeNum()
	return self._challengeTime
end

function WushTowerData:getCurIndex()
	return self._curIndex
end

function WushTowerData:getZoneId()
	return self._zoneId
end

function WushTowerData:getCards()
	return self._ownCards
end

function WushTowerData:getCanChallengeCount()
	return (math.max(var_0_3.get(var_0_5.PARAMETER_CONST.WUSH_TOWER_STEP_VALUE).parameter - self._challengeFloor, 0))
end

function WushTowerData:getNextResetTime()
	return self._nextResetTime
end

function WushTowerData:isCanGoToParcel(arg_45_1)
	local var_45_0 = self:getLastPassParcel()

	if var_45_0 == 0 then
		if arg_45_1 == 1 or arg_45_1 == 2 then
			return true
		end
	else
		local var_45_1 = var_0_1.get(self:getMapIdByZoneId(self._zoneId), var_45_0)

		for iter_45_0 = 1, var_0_6.CAN_MOVE_INDEX do
			if var_45_0 == self._curIndex then
				if var_45_1["move_" .. iter_45_0] > 0 and var_45_1["move_" .. iter_45_0] == arg_45_1 then
					return true
				end
			elseif self._curIndex == arg_45_1 then
				return true
			end
		end
	end

	return false
end

function WushTowerData:getCanMoveParcels()
	local var_46_0 = self:getLastPassParcel()
	local var_46_1 = {}

	if var_46_0 == 0 then
		table.insert(var_46_1, 1)
		table.insert(var_46_1, 2)
	else
		local var_46_2 = var_0_1.get(self:getMapIdByZoneId(self._zoneId), var_46_0)

		for iter_46_0 = 1, var_0_6.CAN_MOVE_INDEX do
			if var_46_0 == self._curIndex then
				if var_46_2["move_" .. iter_46_0] > 0 then
					table.insert(var_46_1, var_46_2["move_" .. iter_46_0])
				end
			else
				table.insert(var_46_1, self._curIndex)
			end
		end
	end

	return var_46_1
end

function WushTowerData:getParcelInfo(arg_47_1)
	return self._gridInfos[arg_47_1]
end

function WushTowerData:getLastPassParcel()
	return (#self._passGrids > 0 or nil) and self._passGrids[#self._passGrids]
end

function WushTowerData:getStateByParcel(arg_49_1)
	return (self._gridInfos[arg_49_1] or nil) and (self._gridInfos[arg_49_1].grid_status == 1 and var_0_6.STAGE_STATE.PASS or self:isCanGoToParcel(arg_49_1) and var_0_6.STAGE_STATE.CHOOSE or self:getFloorByParcel(self._zoneId, arg_49_1) <= self:getFloorByParcel(self._zoneId, self._curIndex) and var_0_6.STAGE_STATE.OFF or var_0_6.STAGE_STATE.UNOPEN)
end

function WushTowerData:_sortTaskArr()
	if #self._taskArr < 2 then
		return
	end

	table.sort(self._taskArr, function(arg_51_0, arg_51_1)
		return
	end)
end

function WushTowerData:getMyRanking()
	return self._myRanking
end

function WushTowerData:getRankArr()
	return self._rankArr
end

function WushTowerData:getCardIconByCardId(arg_54_1)
	local var_54_0 = var_0_4.get(arg_54_1)

	if var_54_0 then
		return var_0_7:getWushCardIconById(var_54_0.icon)
	end

	return ""
end

function WushTowerData:addOneCard(arg_55_1)
	for iter_55_0, iter_55_1 in pairs(self._ownCards) do
		if arg_55_1 == iter_55_1.id then
			iter_55_1.num = iter_55_1.num + 1

			return
		end
	end

	table.insert(self._ownCards, {
		num = 1,
		id = arg_55_1
	})
end

function WushTowerData:deleteOneCard(arg_56_1)
	for iter_56_0, iter_56_1 in pairs(self._ownCards) do
		if arg_56_1 == iter_56_1.id then
			if iter_56_1.num > 1 then
				iter_56_1.num = math.max(0, iter_56_1.num - 1)

				break
			end

			table.remove(self._ownCards, iter_56_0)

			break
		end
	end
end

function WushTowerData:getZoneCfgByRankId(arg_57_1)
	return var_0_0.indexOf(arg_57_1)
end

function WushTowerData:getMaxZoneId()
	if self._maxZoneId > 0 then
		return self._maxZoneId
	end

	for iter_58_0 = 1, var_0_0.getLength() do
		local var_58_0 = var_0_0.indexOf(iter_58_0)

		if var_58_0.zone_id > self._maxZoneId then
			self._maxZoneId = var_58_0.zone_id
		end
	end

	return self._maxZoneId
end

function WushTowerData:setPeriodCardTips(arg_59_1)
	local var_59_0 = g.core.common.Storage:load("wush_tower_period_tip.json") or {}

	if not var_59_0.nextResetTime then
		var_59_0 = {
			nextResetTime = self._nextResetTime,
			select = arg_59_1
		}
	else
		var_59_0.nextResetTime = self._nextResetTime
		var_59_0.select = arg_59_1
	end

	g.core.common.Storage:save("wush_tower_period_tip.json", var_59_0)
end

function WushTowerData:getPeriodCardTips()
	local var_60_0 = g.core.common.Storage:load("wush_tower_period_tip.json") or {}

	if not var_60_0.nextResetTime then
		return false
	end

	if g.core.common.ServerTime:getTime() > var_60_0.nextResetTime then
		var_60_0 = g.core.common.Storage:save("wush_tower_period_tip.json", {
			select = false,
			nextResetTime = self._nextResetTime
		})

		return false
	end

	return var_60_0.select
end

function WushTowerData:checkCardOrChallengeLimit()
	if self:getChallengeNum() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(408414))

		return false
	end

	if self:getCanChallengeCount() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(408419))

		return false
	end

	if self:getSumUserHp() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(408418))

		return false
	end

	return true
end

function WushTowerData:isCanGetTaskAward()
	if self._isCanTaskAward then
		self._isCanTaskAward = false

		return true
	end

	return #self:getTaskIdsRcvEnable() > 0
end

function WushTowerData:isUnFinishCanChallenge()
	if self._isCanChallenge then
		self._isCanChallenge = false

		return true
	end

	if self._zoneId <= self._maxZoneId and self:getLastPassParcel() < var_0_6.WUSH_TOWER_STAGE_COUNT and self._challengeTime > 0 and self:getCanChallengeCount() > 6 then
		return true
	end

	return false
end

function WushTowerData:isPrePassParcel()
	return self._isPassParcel
end

function WushTowerData:resetPreParcelPass()
	self._isPassParcel = false
end

function WushTowerData:isGotoNextParcel()
	return self._isGotoParcel
end

function WushTowerData:resetGotoNextParcel()
	self._isGotoParcel = false
end

function WushTowerData:isWushTowerReset()
	return self._isReset
end

function WushTowerData:isWushTowerHpRecover()
	return self._isRecover
end

function WushTowerData:sortCardByParcelInfo(arg_70_1, arg_70_2)
	local var_70_0 = arg_70_2 or {}

	local function var_70_1(arg_71_0)
		local var_71_0 = 0

		for iter_71_0 = 1, var_0_6.RECOMMEND_NUM do
			if arg_70_1["recommend_" .. iter_71_0] > 0 and arg_70_1["recommend_" .. iter_71_0] == arg_71_0 then
				var_71_0 = 1
			end
		end

		return var_71_0
	end

	table.sort(var_70_0, function(arg_72_0, arg_72_1)
		local var_72_0 = var_70_1(arg_72_0.id)
		local var_72_1 = var_70_1(arg_72_1.id)

		if var_72_0 ~= var_72_1 then
			return var_72_1 < var_72_0
		end

		return arg_72_0.id > arg_72_1.id
	end)

	return var_70_0
end

function WushTowerData:isSkipBattle()
	local var_73_0 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.WUSH_TOWER_SKIP_BATTLE).parameter

	return var_73_0 <= self._passMaxZoneId or var_73_0 < self._zoneId
end

function WushTowerData:getStorageSkipBattleStatus()
	return (g.core.common.Storage:load("wush_tower_status.json", true) or {}).isSkip or false
end

function WushTowerData:saveStorageSkipBattleStatus(arg_75_1)
	g.core.common.Storage:save("wush_tower_status.json", {
		isSkip = arg_75_1
	}, true)
end

function WushTowerData:setDisplayVersion(arg_76_1)
	self._displayVersion = arg_76_1
end

function WushTowerData:getDisplayVersion()
	return self._displayVersion
end

return WushTowerData
