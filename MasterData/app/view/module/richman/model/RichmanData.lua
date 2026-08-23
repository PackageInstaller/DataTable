local var_0_0 = g.core.config.richman_map_grid_info
local var_0_1 = g.core.config.richman_info
local var_0_2 = g.core.config.richman_map_level_info
local var_0_3 = g.core.config.richman_text_info
local var_0_4 = g.core.config.richman_event_info
local var_0_5 = g.core.config.richman_construct_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local RichmanGameData = require("app.view.module.richman.model.RichmanGameData")
local RichmanBuildStruct = require("app.view.module.richman.model.RichmanBuildStruct")
local RichmanTaskData = require("app.view.module.richman.model.RichmanTaskData")
local RichmanData = class("RichmanData")

function RichmanData:ctor()
	self:initData()
	self:initConstructCfg()
	self:initLogTxt()
end

function RichmanData:initData()
	self._curLevel = 1
	self._curIndex = 1
	self._mapId = 0
	self._exp = 0
	self._maxMapLv = 0
	self._nextDiceNum = 0
	self._xDir = 0
	self._yDir = 0
	self._isSvrRedPoint = false
	self._isSvrData = false
	self._inAutoDice = false
	self._svrLogs = {}
	self._cacheRobData = {}
	self._mapLvCfg = {}
	self._currentEventMap = {}
	self._gameData = RichmanGameData.new()
	self._richmanIndexMap = {}
	self._randomEvent = {}
	self._richmanPos2CfgMap = {}
	self._cacheEnemyList = {}
	self._curRobData = nil
	self._cacheMatchPasser = {}
	self._buildStruct = nil
	self._taskData = RichmanTaskData.new()
	self._constructTVMap = {}
	self._rewardTaskList = {}
	self._logTypeIdMap = {}
	self._challengeDict = {}
end

function RichmanData:initConstructCfg()
	for iter_3_0, iter_3_1 in var_0_5.ipairs() do
		self._constructTVMap[iter_3_1.type .. "_" .. iter_3_1.level] = iter_3_1
	end
end

function RichmanData:initLogTxt()
	for iter_4_0, iter_4_1 in var_0_3.ipairs() do
		self._logTypeIdMap[iter_4_1.type] = iter_4_1.id
	end
end

function RichmanData:getBuildCfgByTypeAndLv(arg_5_1, arg_5_2)
	return self._constructTVMap[arg_5_1 .. "_" .. arg_5_2]
end

function RichmanData:onGetRichManInfo(arg_6_1)
	self:updateMapData(arg_6_1.map_data)

	if not self._buildStruct then
		self._buildStruct = RichmanBuildStruct.new(arg_6_1.construct)
	else
		self._buildStruct:updateBuildData(arg_6_1.construct)
	end

	self._taskData:updateTaskData(arg_6_1.tasks)

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.events or {}) do
		self:updateEvent(iter_6_1, true)
	end

	self._isSvrData = true
end

function RichmanData:onRichManDice(arg_7_1)
	self._curIndex = self:formatStepFinishIndex(self._curIndex + arg_7_1.dice)

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.events or {}) do
		self:updateEvent(iter_7_1, true)
	end

	if arg_7_1.map_data then
		self:updateMapData(arg_7_1.map_data)
	end
end

function RichmanData:onRichManEventProcess(arg_8_1)
	self:updateEvent(arg_8_1.event, false, arg_8_1.is_remove)
end

function RichmanData:onRichManMapUpLevel(arg_9_1)
	self:updateMapData(arg_9_1.map_data)
	self._buildStruct:updateBuildCfg()
end

function RichmanData:onRichManRobData(arg_10_1)
	self._cacheRobData[arg_10_1.user_id] = arg_10_1

	if self._curRobData and self._curRobData.user_id == arg_10_1.user_id then
		self._ignoreChangeAnim = true
	end

	self._curRobData = arg_10_1
end

function RichmanData:onRichManAwardBuild(arg_11_1)
	if not self._buildStruct then
		self._buildStruct = RichmanBuildStruct.new(arg_11_1.construct)
	else
		self._buildStruct:updateBuildData(arg_11_1.construct)
	end
end

function RichmanData:onRichManAwardTask(arg_12_1)
	self._taskData:onTaskAward(arg_12_1.ids)
end

function RichmanData:updateConstruct(arg_13_1)
	if not self._buildStruct then
		self._buildStruct = RichmanBuildStruct.new(arg_13_1.construct)
	else
		self._buildStruct:updateBuildData(arg_13_1.construct)
	end
end

function RichmanData:onRichManAwardRob(arg_14_1)
	self._robReward = arg_14_1.awards

	self:delEvent(arg_14_1.event_id)
	self:clearRobData()
end

function RichmanData:onS2CRedPoint(arg_15_1)
	self._isSvrRedPoint = arg_15_1.is_hint
	self._isSvrData = false
end

function RichmanData:onCacheLogContent(arg_16_1)
	self._svrLogs = arg_16_1.logs or {}
end

function RichmanData:isIgnoreChangeAnim()
	self._ignoreChangeAnim = false

	return self._ignoreChangeAnim
end

function RichmanData:getRobPlayerData(arg_18_1)
	return self._cacheRobData[arg_18_1]
end

function RichmanData:getTaskData()
	return self._taskData
end

function RichmanData:getRobReward()
	return self._robReward or {}
end

function RichmanData:setRobType(arg_21_1)
	self._robType = arg_21_1
end

function RichmanData:getRobType()
	return self._robType
end

function RichmanData:addMapExp(arg_23_1)
	self._exp = self._exp + arg_23_1
end

function RichmanData:formatRobConstruct(arg_24_1)
	if not arg_24_1 then
		return nil
	end

	return (RichmanBuildStruct.new(arg_24_1))
end

function RichmanData:getBuildData()
	return self._buildStruct
end

function RichmanData:updateMapData(arg_26_1)
	self:checkAndUpdateMapData(arg_26_1.id)

	self._curLevel = arg_26_1.level
	self._exp = arg_26_1.exp
	self._curIndex = arg_26_1.grid_id
	self._nextDiceNum = arg_26_1.fixed_dice or 0
	self._randomEvent = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_1.random_event_landmine or {}) do
		self._randomEvent[iter_26_1.id] = iter_26_1.num
	end
end

function RichmanData:checkAndUpdateMapData(arg_27_1)
	if self._mapId == 0 or self._mapId ~= arg_27_1 then
		self._richmanIndexMap = {}
		self._richmanPos2CfgMap = {}
		self._mapId = arg_27_1

		local var_27_0 = var_0_1.get(arg_27_1).group

		for iter_27_0, iter_27_1 in var_0_0.ipairs() do
			if iter_27_1.group == var_27_0 then
				self._richmanIndexMap[iter_27_1.id] = {
					x = iter_27_1.lattice_x,
					y = iter_27_1.lattice_y
				}
				self._richmanPos2CfgMap[iter_27_1.lattice_x .. "_" .. iter_27_1.lattice_y] = iter_27_1
			end
		end

		self._mapLvCfg = {}

		for iter_27_2, iter_27_3 in var_0_2.ipairs() do
			if iter_27_3.map_id == arg_27_1 then
				self._mapLvCfg[iter_27_3.level] = iter_27_3
			end
		end

		self._maxMapLv = #self._mapLvCfg
	end
end

function RichmanData:getRandGridEvent(arg_28_1)
	return (self._randomEvent or nil) and (self._randomEvent[arg_28_1] or nil)
end

function RichmanData:getRichMapTypeMap()
	return self._richmanPos2CfgMap
end

function RichmanData:updateEvent(arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_1 or not arg_30_1.unique_id then
		return
	end

	if self._currentEventMap[arg_30_1.unique_id] then
		if arg_30_3 then
			self._currentEventMap[arg_30_1.unique_id] = nil
		else
			self._currentEventMap[arg_30_1.unique_id] = arg_30_1
		end
	elseif arg_30_2 then
		self._currentEventMap[arg_30_1.unique_id] = arg_30_1
	end
end

function RichmanData:delEvent(arg_31_1)
	self._currentEventMap[arg_31_1] = nil
end

function RichmanData:cacheMatchPasser(arg_32_1)
	self._cacheMatchPasser = {
		time = g.core.common.ServerTime:getTime(),
		data = arg_32_1
	}
end

function RichmanData:cacheEnemyList(arg_33_1)
	self._cacheEnemyList = {
		time = g.core.common.ServerTime:getTime(),
		data = arg_33_1
	}
end

function RichmanData:isNeedReqList(arg_34_1)
	if arg_34_1 == 0 then
		return not self._cacheEnemyList.time or g.core.common.ServerTime:getTime() - self._cacheEnemyList.time > RichmanConst.REQ_PLAYER_COOL_TIME
	else
		return not self._cacheMatchPasser.time or g.core.common.ServerTime:getTime() - self._cacheMatchPasser.time > RichmanConst.REQ_PLAYER_COOL_TIME
	end
end

function RichmanData:getEnemyList()
	local var_35_0

	if self._cacheEnemyList.data then
		var_35_0 = self._cacheEnemyList.data.list or {}
	end

	table.sort(var_35_0, function(arg_36_0, arg_36_1)
		if arg_36_0.rob_time and arg_36_1.rob_time and arg_36_0.rob_time ~= arg_36_1.rob_time then
			return arg_36_0.rob_time > arg_36_1.rob_time
		end

		return false
	end)

	return var_35_0
end

function RichmanData:getPasserList()
	return (self._cacheMatchPasser.data or nil) and (self._cacheMatchPasser.data.passers or {})
end

function RichmanData:getEventByTypeList(arg_38_1)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(self._currentEventMap) do
		if arg_38_1[iter_38_1.tp] then
			local var_38_1 = var_0_4.get(iter_38_1.base_id)

			var_38_0[iter_38_1.tp] = var_38_0[iter_38_1.tp] or {}

			if var_38_1.time ~= 0 then
				local var_38_2 = iter_38_1.create_time + var_38_1.time or nil

				if not var_38_2 or var_38_2 > g.core.common.ServerTime:getTime() then
					table.insert(var_38_0[iter_38_1.tp], {
						unique_id = iter_38_1.unique_id,
						create_time = iter_38_1.create_time,
						finishTime = var_38_2,
						value = iter_38_1.value,
						id = iter_38_1.base_id,
						tp = iter_38_1.tp,
						params = iter_38_1.params
					})
				end
			end
		end
	end

	for iter_38_2, iter_38_3 in pairs(var_38_0) do
		if #iter_38_3 > 1 and iter_38_3[1].finishTime then
			table.sort(iter_38_3, function(arg_39_0, arg_39_1)
				return arg_39_0.finishTime < arg_39_1.finishTime
			end)
		end
	end

	return var_38_0
end

function RichmanData:getRightEventList()
	local var_40_0 = self:getEventByTypeList({
		[RichmanConst.EVENT_TYPE.GAME_TURNTABLE] = true,
		[RichmanConst.EVENT_TYPE.GAME_TURNCARD] = true,
		[RichmanConst.EVENT_TYPE.GAME_REDPACKET] = true,
		[RichmanConst.EVENT_TYPE.STEAL_OTHER] = true
	})
	local var_40_1 = {}

	for iter_40_0, iter_40_1 in ipairs({
		RichmanConst.EVENT_TYPE.GAME_TURNTABLE,
		RichmanConst.EVENT_TYPE.GAME_TURNCARD,
		RichmanConst.EVENT_TYPE.GAME_REDPACKET,
		RichmanConst.EVENT_TYPE.STEAL_OTHER
	}) do
		if var_40_0[iter_40_1] and next(var_40_0[iter_40_1]) then
			table.insert(var_40_1, {
				list = var_40_0[iter_40_1],
				type = iter_40_1
			})
		end
	end

	return var_40_1
end

function RichmanData:isHasStealEvent()
	for iter_41_0, iter_41_1 in pairs(self._currentEventMap) do
		if iter_41_1.tp == RichmanConst.EVENT_TYPE.STEAL_OTHER then
			local var_41_0 = var_0_4.get(iter_41_1.base_id)

			if var_41_0.time ~= 0 then
				local var_41_1 = iter_41_1.create_time + var_41_0.time or nil

				if not var_41_1 or var_41_1 > g.core.common.ServerTime:getTime() then
					return true
				end
			end
		end
	end

	return false
end

function RichmanData:getMonsterEventList()
	local var_42_0 = self:getEventByTypeList({
		[RichmanConst.EVENT_TYPE.MONSTER] = true
	})[RichmanConst.EVENT_TYPE.MONSTER] or {}

	table.sort(var_42_0, function(arg_43_0, arg_43_1)
		if arg_43_0.create_time ~= arg_43_1.create_time then
			return arg_43_0.create_time > arg_43_1.create_time
		end

		return false
	end)

	return var_42_0
end

function RichmanData:getMapLevel()
	return self._curLevel
end

function RichmanData:getMapMaxLevel()
	return self._maxMapLv
end

function RichmanData:getMapExp()
	return self._exp
end

function RichmanData:getCurLvMaxExp()
	return (self._mapLvCfg[self._curLevel] or nil) and (self._mapLvCfg[self._curLevel].exp or 0)
end

function RichmanData:getAllMapRandEvent()
	return self._randomEvent
end

function RichmanData:getGameData()
	return self._gameData
end

function RichmanData:getGridType(arg_50_1)
	return (self._richmanPos2CfgMap[self._richmanIndexMap[arg_50_1].x .. "_" .. self._richmanIndexMap[arg_50_1].y] or nil) and (self._richmanPos2CfgMap[self._richmanIndexMap[arg_50_1].x .. "_" .. self._richmanIndexMap[arg_50_1].y].type or 0)
end

function RichmanData:getGridTypeByPos(arg_51_1)
	return (self._richmanPos2CfgMap[arg_51_1.x .. "_" .. arg_51_1.y] or nil) and (self._richmanPos2CfgMap[arg_51_1.x .. "_" .. arg_51_1.y].type or 0)
end

function RichmanData:getBuildPos()
	local var_52_0 = var_0_1.get(self._mapId)
	local var_52_1 = {}

	while var_0_1.hasKey("construct_type_" .. 1) do
		table.insert(var_52_1, {
			type = var_52_0["construct_type_" .. 1],
			x = var_52_0["coordinate_x_" .. 1],
			y = var_52_0["coordinate_y_" .. 1],
			dir = var_52_0["direction_" .. 1]
		})
	end

	return var_52_1
end

function RichmanData:getMapCfg()
	return var_0_1.get(self._mapId)
end

function RichmanData:getCurRobData()
	return self._curRobData
end

function RichmanData:clearRobData()
	self._curRobData = nil
end

function RichmanData:checkChallengeTime(arg_56_1)
	local var_56_0 = self._challengeDict[arg_56_1] or 0
	local var_56_1 = g.core.common.ServerTime:getTime()

	if var_56_0 <= var_56_1 then
		self._challengeDict[arg_56_1] = var_56_1 + 1
	else
		return false
	end

	return true
end

function RichmanData:getLogIdByType(arg_57_1)
	return self._logTypeIdMap[arg_57_1]
end

function RichmanData:getCurrentIndex()
	return self._curIndex
end

function RichmanData:getRoleIndexPos(arg_59_1)
	return self._richmanIndexMap[self:formatStepFinishIndex(arg_59_1)]
end

function RichmanData:formatStepFinishIndex(arg_60_1)
	local var_60_0 = #self._richmanIndexMap

	while arg_60_1 <= 0 do
		arg_60_1 = arg_60_1 + var_60_0
	end

	return var_60_0 == arg_60_1 and var_60_0 or arg_60_1 % var_60_0
end

function RichmanData:isNeedPauseWaitAnim(arg_61_1)
	local var_61_0 = self:getGridTypeByPos(arg_61_1)

	if var_61_0 == RichmanConst.GRID_TYPE.MONSTER_GRID or var_61_0 == RichmanConst.GRID_TYPE.STEAL_RESOURCE_GRID or var_61_0 == RichmanConst.GRID_TYPE.START_GRID then
		if var_61_0 == RichmanConst.GRID_TYPE.MONSTER_GRID and self:isMonsterFull() then
			return false
		end

		return true, var_61_0
	end

	return false
end

function RichmanData:mergeRunPath(arg_62_1)
	local var_62_0 = arg_62_1[1].x == arg_62_1[2].x and 0 or 1
	local var_62_1 = arg_62_1[1]
	local var_62_2 = {}
	local var_62_3 = 2
	local var_62_4 = {}

	while var_62_3 <= #arg_62_1 do
		local var_62_5 = var_62_0

		var_62_0 = arg_62_1[var_62_3].x == arg_62_1[var_62_3 - 1].x and 0 or 1

		local var_62_6 = false
		local var_62_7

		if not var_62_4[var_62_3] and var_62_3 - 1 > 1 then
			var_62_6, var_62_7 = self:isNeedPauseWaitAnim(arg_62_1[var_62_3 - 1])
		end

		var_62_4[var_62_3] = true

		if var_62_5 ~= var_62_0 or var_62_6 then
			table.insert(var_62_2, {
				startPos = var_62_1,
				endPos = arg_62_1[var_62_3 - 1],
				pauseEvent = var_62_7
			})

			var_62_1 = arg_62_1[var_62_3 - 1]
		else
			var_62_3 = var_62_3 + 1

			if var_62_3 > #arg_62_1 then
				local var_62_8, var_62_9 = self:isNeedPauseWaitAnim(arg_62_1[var_62_3 - 1])

				table.insert(var_62_2, {
					startPos = var_62_1,
					endPos = arg_62_1[var_62_3 - 1],
					pauseEvent = var_62_9
				})
			end
		end
	end

	return var_62_2
end

function RichmanData:getNextMoveDir()
	local var_63_0 = self._richmanIndexMap[self:formatStepFinishIndex(self._curIndex)]
	local var_63_1 = self._richmanIndexMap[self:formatStepFinishIndex(self._curIndex + 1)]

	if var_63_1.y ~= var_63_0.y then
		return var_63_1.y > var_63_0.y and -1 or 1
	else
		return var_63_1.x > var_63_0.x and 1 or -1
	end
end

function RichmanData:gotoPathWithStepAddBefore(arg_64_1)
	local var_64_0 = {}

	table.insert(var_64_0, self._richmanIndexMap[self:formatStepFinishIndex(self._curIndex)])

	for iter_64_0 = 1, arg_64_1 do
		table.insert(var_64_0, self._richmanIndexMap[self:formatStepFinishIndex(self._curIndex + iter_64_0)])
	end

	self._curIndex = self:formatStepFinishIndex(self._curIndex + arg_64_1)

	return self:mergeRunPath(var_64_0)
end

function RichmanData:gotoPathWithStepAddAfter(arg_65_1)
	local var_65_0 = {}
	local var_65_1 = self:formatStepFinishIndex(self._curIndex - arg_65_1)

	table.insert(var_65_0, self._richmanIndexMap[self:formatStepFinishIndex(var_65_1)])

	for iter_65_0 = 1, arg_65_1 do
		table.insert(var_65_0, self._richmanIndexMap[self:formatStepFinishIndex(var_65_1 + iter_65_0)])
	end

	return self:mergeRunPath(var_65_0)
end

function RichmanData:addStep(arg_66_1)
	self._curIndex = self:formatStepFinishIndex(self._curIndex + arg_66_1)
end

function RichmanData:setNextDice(arg_67_1)
	self._nextDiceNum = arg_67_1
end

function RichmanData:getNextDice()
	return self._nextDiceNum
end

function RichmanData:setInDiceAnim(arg_69_1)
	self._inDiceAnim = arg_69_1
end

function RichmanData:isInDiceAnim()
	return self._inDiceAnim
end

function RichmanData:setNeedStealAnim(arg_71_1)
	self._isNeedStaelAnim = arg_71_1
end

function RichmanData:isNeedStealAnim()
	return self._isNeedStaelAnim
end

function RichmanData:setNeedMonsterAnim(arg_73_1)
	self._isNeedMonsterAnim = arg_73_1
end

function RichmanData:isNeedMonsterAnim()
	return self._isNeedMonsterAnim
end

function RichmanData:getHangUpTime()
	return g.core.config.richman_parameter_info.get(RichmanConst.HANGUP_TIME_PARAM_ID).parameter
end

function RichmanData:getHangUpTimeMax()
	return g.core.config.richman_parameter_info.get(RichmanConst.HANGUP_TIME_PARAM_ID_MAX).parameter
end

function RichmanData:getMaxMonsterNum()
	return g.core.config.richman_parameter_info.get(RichmanConst.MONSTER_SAVE_MAX_PARAM_ID).parameter
end

function RichmanData:getCanStealTh()
	return g.core.config.richman_parameter_info.get(RichmanConst.MONSTER_STEAL_PARAM_ID).parameter
end

function RichmanData:isMonsterFull()
	return #self:getMonsterEventList() >= self:getMaxMonsterNum()
end

function RichmanData:isHasCanUseDice()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RICH_MAN) and (g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) > 0 or g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.RICH_MAN_RUN_DICE) > 0)
end

function RichmanData:isCanRewardTask()
	return self._taskData:isCanRewardTask()
end

function RichmanData:isHasMiniGame()
	if not self._isSvrData then
		return self._isSvrRedPoint
	end

	for iter_82_0, iter_82_1 in pairs(self._currentEventMap) do
		if iter_82_1.tp == RichmanConst.EVENT_TYPE.GAME_TURNTABLE or iter_82_1.tp == RichmanConst.EVENT_TYPE.GAME_TURNCARD or iter_82_1.tp == RichmanConst.EVENT_TYPE.GAME_REDPACKET or iter_82_1.tp == RichmanConst.EVENT_TYPE.STEAL_OTHER then
			local var_82_0 = var_0_4.get(iter_82_1.base_id)

			if var_82_0.time ~= 0 then
				local var_82_1 = iter_82_1.create_time + var_82_0.time or nil

				if not var_82_1 or var_82_1 > g.core.common.ServerTime:getTime() then
					return true
				end
			end
		end
	end

	return false
end

function RichmanData:isHangUpMax()
	if not self._isSvrData then
		return self._isSvrRedPoint
	end

	return g.core.common.ServerTime:getTime() - self._buildStruct:getBuildHangUpStartTime() >= self:getHangUpTimeMax()
end

function RichmanData:checkAndLoadStealCache()
	self._stealCache = self._stealCache or g.core.common.Storage:load("rich_man_steal_cache.json") or {}
end

function RichmanData:isBeSteal()
	local var_85_0 = {
		[3] = true,
		[4] = true
	}

	self:checkAndLoadStealCache()

	for iter_85_0, iter_85_1 in ipairs(self._svrLogs) do
		if not self._stealCache[tostring(iter_85_1.id)] and var_85_0[iter_85_1.tp] then
			return true
		end
	end

	return false
end

function RichmanData:saveStealCache()
	self._stealCache = {}

	for iter_86_0, iter_86_1 in ipairs(self._svrLogs) do
		self._stealCache[tostring(iter_86_1.id)] = true
	end

	g.core.common.Storage:save("rich_man_steal_cache.json", self._stealCache)
end

function RichmanData:isHasMonsterCanAttack()
	for iter_87_0, iter_87_1 in pairs(self._currentEventMap) do
		if iter_87_1.tp == RichmanConst.EVENT_TYPE.MONSTER then
			return true
		end
	end

	return false
end

function RichmanData:setAuto(arg_88_1)
	self._inAutoDice = arg_88_1
end

function RichmanData:isAuto()
	return self._inAutoDice
end

return RichmanData
