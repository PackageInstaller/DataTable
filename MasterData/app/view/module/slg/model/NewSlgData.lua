local NewSlgData = class("NewSlgData", require("app.core.model.BaseData"))
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.allianceData
local var_0_3 = g.core.config.new_slg_info
local var_0_4 = g.core.config.new_slg_city_info
local var_0_5 = g.core.config.new_slg_component_info
local var_0_6 = g.core.config.new_slg_terrain_info
local var_0_7 = g.core.config.new_slg_province_info
local var_0_8 = g.core.config.new_slg_checkpoint_info
local var_0_9 = g.core.config.new_slg_main_quest_info
local var_0_10 = g.core.config.new_slg_city_quest_info
local var_0_11 = g.core.config.new_slg_monster_info
local var_0_12 = g.core.config.new_slg_parameter_info
local var_0_13 = g.core.config.new_slg_team_authority_info
local var_0_14 = g.core.config.new_slg_army_info
local var_0_15 = g.core.config.new_slg_boss_info
local var_0_16 = g.core.config.new_slg_rank_reward_info
local var_0_17 = g.core.config.new_slg_build_info
local var_0_18 = g.core.config.new_slg_achievement_info
local var_0_19 = g.core.config.new_slg_farm_cost_info
local var_0_20 = g.core.config.new_slg_farm_info
local var_0_21 = g.core.config.new_slg_element_info
local var_0_22 = g.core.config.new_slg_city_element_info
local var_0_23 = g.core.config.new_slg_city_element_random_info
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_25 = TileMapFunc.p2s
local var_0_26 = TileMapFunc.p3s
local var_0_28 = g.core.const.ConstMgr.NewSlgConst
local var_0_31 = g.core.const.ConstMgr.NewSlgConst.COMP_TYPE
local var_0_32 = g.core.const.ConstMgr.NewSlgConst.TaskState
local var_0_33 = cc.p
local var_0_35 = table.insert
local NewSlgFunc = require("app.view.module.slg.const.NewSlgFunc")
local var_0_37 = g.core.model.User.commonPassCardDataMgr

function NewSlgData:ctor()
	NewSlgData.super.ctor(self)
	self:resetInitData()
end

function NewSlgData:resetInitData()
	self._activityInfo = nil
	self._isFirstSeason = false
	self._seasonId = 1
	self._slgInfo = var_0_3.get(self._seasonId)
	self._actId = 0
	self._timePre = 0
	self._timeStart = 0
	self._timeEnd = 0
	self._timeShowEnd = 0
	self._firstEnterTime = 0
	self._getPreviewReward = false
	self._newestRecordTime = 0
	self._monsterCfgArrMap = {}
	self._rankDataMap = {}
	self._commonPassCardActId = 0
	self._kickCnt = 0
	self._pathCache = {}
	self._initMapComp = false
	self._barrierCvsData = nil
	self._provinceCvsData = nil
	self._monsterCvsData = nil
	self._parameterInfo = {}
	self._cityComponentMap = {}
	self._bossComponentMap = {}
	self._farmComponentMap = {}
	self._gateComponentMap = {}
	self._chariotComponentMap = {}
	self._mapObjectDataArr = {}
	self._mapObjectDataByRC = {}
	self._farmArrWithLevel = {}
	self._componentTmplArr = {}
	self._terrainCfgMap = {}
	self._monsterCfgMap = {}
	self._provinceCfgMap = {}
	self._provinceTypeIdMap = {}
	self._provinceLinkIds = {}
	self._checkPointInfoMap = nil
	self._preProvinceMap = {}
	self._monsterRCInProvince = {}
	self._bossRCInProvince = {}
	self._bossIdsByProvinceGID = {}
	self._userSerData = {}
	self._monsterSerDataByRC = {}
	self._monsterLvMax = 0
	self._monsterFightCount = 0
	self._score = 0
	self._lastMoveHomeTime = 0
	self._teamCurCnt = 0
	self._teamMaxCnt = self._teamCurCnt
	self._isInitFarm = false
	self._refreshMarch = false
	self._mapMarchUnitData = {}
	self.intoMapRedPoint = false
	self.gateBtnRedPoint = true
	self.isChariotFindPath = false
	self.cityResultServerData = nil
	self._myUserPosData = nil
	self._dailyBossTimes = 0
	self._dailyAssistBossTimes = 0
	self._curDayFarmRewardCount = 0
	self._myPos = nil
	self._newBattleReportCnt = 0
	self._targetPosArr = {}
	self._farmCostMap = {}
	self._farmTokenMap = {}
	self._cityElementMap = {}
	self._farmArrBelongCity = {}
	self._occTime = self:getNewSlgParamsValueById(184)
	self._protectTime = self:getNewSlgParamsValueById(192)

	self:_initParamsCfg()
	self:_initAllianceData()
	self:_initTeamData()
	self:_initBattleData()
	self:_initCityData()
	self:_initTeamBossData()
	self:_initTaskData()
	self:_initBattleReportData()
	self:_initRankData()

	local var_2_0 = self:loadCache("viewBattleReportMap")

	self._viewBattleReportMap = type(var_2_0) ~= "table" and {} or var_2_0
	self._strategyEffect = require("app.view.module.slg.model.NewSlgStrategyEffect").new()
end

function NewSlgData:getSName()
	return "S1"
end

function NewSlgData:getSlgInfo()
	return self._slgInfo
end

function NewSlgData:getSeasonId()
	return self._seasonId
end

function NewSlgData:setFirstEnterTime(arg_6_1)
	self._firstEnterTime = arg_6_1 or 0
end

function NewSlgData:isUnlock()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG)
end

function NewSlgData:isOpen()
	if self:getSeasonId() <= 0 then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG) then
		return false
	end

	local var_8_0 = g.core.common.ServerTime:getTime()

	if var_8_0 < self._timePre or var_8_0 > self._timeShowEnd then
		return false
	end

	return true
end

function NewSlgData:isForecasting()
	local var_9_0 = g.core.common.ServerTime:getTime()

	return var_9_0 >= self._timePre and var_9_0 < self._timeStart
end

function NewSlgData:isPlaying()
	if self:getSeasonId() <= 0 then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG) then
		return false
	end

	local var_10_0 = g.core.common.ServerTime:getTime()

	return var_10_0 >= self._timeStart and var_10_0 < self:getSettleStartTime()
end

function NewSlgData:isPlayingState()
	return self:isPlaying() or self:isSettle()
end

function NewSlgData:isSettle()
	local var_12_0 = g.core.common.ServerTime:getTime()

	if self:getSettleStartTime() <= var_12_0 and var_12_0 <= self._timeEnd then
		return true
	end

	return false
end

function NewSlgData:isEnding()
	local var_13_0 = g.core.common.ServerTime:getTime()

	return var_13_0 >= self._timeEnd and var_13_0 < self._timeShowEnd
end

function NewSlgData:isShowStrategy()
	return false
end

function NewSlgData:getEndStrategyTime()
	local var_15_0 = g.core.config.new_slg_parameter_info.get(var_0_28.STRATEGY_OPEN_TIME_PARAMETER_ID).parameter - 1
	local var_15_1 = g.core.config.new_slg_parameter_info.get(var_0_28.STRATEGY_REFRESH_TIME_PARAMETER_ID).parameter
	local var_15_2, var_15_3 = self:getOpenDays()

	return g.core.common.ServerTime:getTime() + math.ceil((var_15_0 + math.ceil((var_15_3 - var_15_0) / var_15_1) * var_15_1 - var_15_3) * 86400)
end

function NewSlgData:getForecastTime()
	local var_16_0 = self._timeStart - var_0_1:getTime()

	return var_16_0, var_0_1:getCountDownBySecond(var_16_0)
end

function NewSlgData:getActEndTime()
	return self._timeEnd or 0
end

function NewSlgData:getActStartTime()
	return self._timeStart or 0
end

function NewSlgData:getActPreTime()
	return self._timePre or 0
end

function NewSlgData:getActShowEndTime()
	return self._timeShowEnd or 0
end

function NewSlgData:getActShowTime()
	if self:isOpen() then
		if self:isPlaying() or self:isSettle() then
			return self:getActEndTime()
		elseif self:isEnding() then
			return self:getActShowEndTime()
		end

		return self:getActStartTime()
	end

	return 0
end

function NewSlgData:getSettleStartTime()
	return self._timeEnd - 86400 + (self:getNewSlgParamsValueByKey("attack_begin_time") + self:getNewSlgParamsValueByKey("result_time") + self:getNewSlgParamsValueByKey("max_city_time") / 1000)
end

function NewSlgData:isNewSlgLastDay()
	local var_23_0

	if not self._activityInfo then
		do return false end

		var_23_0 = 86400
	end

	local var_23_1 = self._timeEnd - g.core.common.ServerTime:getTime()

	return var_23_1 > 0 and var_23_1 <= var_23_0
end

function NewSlgData:getOpenDays()
	local var_24_0 = g.core.common.ServerTime:getTime() - self._timeStart
	local var_24_1 = g.core.common.ServerTime:getDateObject(self._timeStart)
	local var_24_2 = (var_24_0 + (var_24_1.hour * 3600 + var_24_1.min * 60 + var_24_1.sec)) / 86400
	local var_24_3 = math.ceil((var_24_0 + (var_24_1.hour * 3600 + var_24_1.min * 60 + var_24_1.sec)) / 86400)

	if (var_24_0 + (var_24_1.hour * 3600 + var_24_1.min * 60 + var_24_1.sec)) % 86400 == 0 then
		var_24_3 = var_24_3 + 1
		var_24_2 = var_24_3
	end

	return var_24_3, var_24_2
end

function NewSlgData:getMapPath(arg_25_1, arg_25_2)
	return (g.core.common.Path:getNewSlgMapPath(self:getMapId(), arg_25_1, arg_25_2))
end

function NewSlgData:getCsvPath(arg_26_1)
	return (g.core.common.Path:getNewSlgCsvPath(self:getMapId(), arg_26_1))
end

function NewSlgData:initComponents()
	self:_initCompCfg()
	self:_initProvinceCfg()
	self:_initCheckPointCfg()

	self._barrierCvsData = self:_updateCsvUsefulData(self._barrierCvsData, "barrier")
	self._monsterCvsData = self:_updateCsvUsefulData(self._monsterCvsData, "monster")
	self._provinceCvsData = self:_updateCsvUsefulData(self._provinceCvsData, "province")
end

function NewSlgData:initMapInfo()
	var_0_28.MAP_PARAMETER.data = self

	TileMapFunc.setTileMapInfo(var_0_28.MAP_PARAMETER)
end

function NewSlgData:updatePassCardData(arg_29_1)
	if arg_29_1 ~= self._commonPassCardActId then
		print("NewSlgData:updatePassCardData error")

		return
	end

	local var_29_0 = var_0_37:getPassCardData(self._commonPassCardActId)

	var_29_0:setActBETimeByModule(self._timeStart, self._timeEnd, self._timePre)
	self:_updateTeamCnt(var_29_0)
end

function NewSlgData:_updateTeamCnt(arg_30_1)
	local var_30_0 = g.core.model.User.newSlgDevelopData:getMaxTroopNum()
	local var_30_1 = arg_30_1:getRechargeType()
	local var_30_2 = arg_30_1:getPassCardPayInfo(self._commonPassCardActId, var_30_1)

	self._teamCurCnt = var_30_0 + ((var_30_2 or nil) and var_30_2.team)
	self._teamMaxCnt = (var_30_1 == 2 or var_30_1 == 3) and self._teamCurCnt or var_30_0 + arg_30_1:getPassCardPayInfo(self._commonPassCardActId, 2).team
end

function NewSlgData:getExtTeamPassCardPayType(arg_31_1)
	local var_31_0 = 0

	if arg_31_1 == 0 then
		return var_31_0
	end

	local var_31_1 = var_0_37:getPassCardData(self._commonPassCardActId)

	for iter_31_0 = 1, 2 do
		if arg_31_1 <= var_31_1:getPassCardPayInfo(self._commonPassCardActId, iter_31_0).team then
			var_31_0 = iter_31_0

			break
		end
	end

	return var_31_0
end

function NewSlgData:_updateCsvUsefulData(arg_32_1, arg_32_2)
	if not arg_32_1 then
		arg_32_1 = {}

		for iter_32_0, iter_32_1 in ipairs((string.split(cc.FileUtils:getInstance():getStringFromFile((self:getCsvPath(arg_32_2))), "\n"))) do
			for iter_32_2, iter_32_3 in ipairs((string.split(iter_32_1, ","))) do
				if iter_32_3 ~= "" and iter_32_3 ~= "0" then
					local var_32_0 = tonumber(iter_32_3)

					arg_32_1[var_0_25(iter_32_2 - 1, iter_32_0 - 1)] = var_32_0

					if arg_32_2 == "province" then
						self:_loadMonsterInProvince(var_32_0, iter_32_2 - 1, iter_32_0 - 1)
						self:_loadTeamBossInProvince(var_32_0, iter_32_2 - 1, iter_32_0 - 1)
					end
				end
			end
		end
	end

	return arg_32_1
end

function NewSlgData:_loadMonsterInProvince(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = var_0_25(arg_33_2, arg_33_3)

	self._monsterCvsData = self._monsterCvsData or self:_updateCsvUsefulData(self._monsterCvsData, "monster")

	local var_33_1 = self._monsterCvsData[var_33_0]

	if not self._monsterCvsData[var_33_0] then
		return
	end

	local var_33_2 = self:getMonsterInfoByGID(var_33_1)

	if not var_33_2 then
		return
	end

	local var_33_3 = var_0_26(arg_33_1, var_33_2.level, var_33_2.army_type)

	self._monsterRCInProvince[var_33_3] = self._monsterRCInProvince[var_33_3] or {}

	local var_33_4 = var_0_25(var_33_2.level, var_33_2.army_type)

	self._monsterRCInProvince[var_33_4] = self._monsterRCInProvince[var_33_4] or {}

	var_0_35(self._monsterRCInProvince[var_33_3], var_0_33(arg_33_2, arg_33_3))
	var_0_35(self._monsterRCInProvince[var_33_4], var_0_33(arg_33_2, arg_33_3))
end

function NewSlgData:_loadTeamBossInProvince(arg_34_1, arg_34_2, arg_34_3)
	self._barrierCvsData = self._barrierCvsData or self:_updateCsvUsefulData(self._barrierCvsData, "barrier")

	local var_34_0 = self._barrierCvsData[var_0_25(arg_34_2, arg_34_3)]

	if not var_34_0 then
		return
	end

	local var_34_1 = self:getComponentsByGID(var_34_0)

	if #var_34_1 == 0 then
		return
	end

	for iter_34_0, iter_34_1 in ipairs(var_34_1) do
		if iter_34_1.type == var_0_31.TEAMBOSS then
			local var_34_2 = self:getBossInfoById(iter_34_1.value)

			if var_34_2 then
				local var_34_3 = var_0_26(arg_34_1, var_34_2.level, var_34_2.boss_army_type)

				self._bossRCInProvince[var_34_3] = self._bossRCInProvince[var_34_3] or {}

				local var_34_4 = var_0_25(var_34_2.level, var_34_2.boss_army_type)

				self._bossRCInProvince[var_34_4] = self._bossRCInProvince[var_34_4] or {}
				self._bossIdsByProvinceGID[arg_34_1] = self._bossIdsByProvinceGID[arg_34_1] or {}

				var_0_35(self._bossIdsByProvinceGID[arg_34_1], iter_34_1.value)
				var_0_35(self._bossRCInProvince[var_34_3], var_0_33(arg_34_2, arg_34_3))
				var_0_35(self._bossRCInProvince[var_34_4], var_0_33(arg_34_2, arg_34_3))
			end
		end
	end
end

function NewSlgData:getMonsterCvsData()
	self._monsterCvsData = self._monsterCvsData or self:_updateCsvUsefulData(self._monsterCvsData, "monster")

	return self._monsterCvsData
end

function NewSlgData:_genObjectData(arg_36_1, arg_36_2)
	return {
		id = arg_36_1.id,
		type = arg_36_1.type,
		value = arg_36_1.value,
		value2 = arg_36_1.value_2,
		gid = arg_36_1.barrier_gid,
		includeRC = arg_36_2.rcs,
		centerRC = arg_36_2.centerRC,
		pos = var_0_33(arg_36_1.anchor_x, arg_36_1.anchor_y)
	}
end

function NewSlgData:_initCompCfg()
	if self._initMapComp then
		return
	end

	self._initMapComp = true
	self._componentTmplArr = {}
	self._mapObjectDataArr = {}
	self._mapObjectDataByRC = {}
	self._bossComponentMap = {}
	self._farmComponentMap = {}
	self._cityComponentMap = {}
	self._gateComponentMap = {}
	self._chariotComponentMap = {}

	for iter_37_0, iter_37_1 in var_0_5.ipairs() do
		if iter_37_1.group_id == self._slgInfo.component_group then
			self._componentTmplArr[iter_37_1.barrier_gid] = self._componentTmplArr[iter_37_1.barrier_gid] or {}

			var_0_35(self._componentTmplArr[iter_37_1.barrier_gid], iter_37_1)

			local var_37_0 = cc.p((iter_37_1.anchor_x - iter_37_1.x_1 + (iter_37_1.anchor_x - iter_37_1.x_1) + (iter_37_1.x_1 + iter_37_1.x_2)) / 2, (iter_37_1.anchor_y - iter_37_1.y_1 + (iter_37_1.anchor_y - iter_37_1.y_1) + (iter_37_1.y_1 + iter_37_1.y_2)) / 2)
			local var_37_1 = {}

			for iter_37_2 = iter_37_1.anchor_x - iter_37_1.x_1, iter_37_1.anchor_x - iter_37_1.x_1 + (iter_37_1.x_1 + iter_37_1.x_2) do
				for iter_37_3 = iter_37_1.anchor_y - iter_37_1.y_1, iter_37_1.anchor_y - iter_37_1.y_1 + (iter_37_1.y_1 + iter_37_1.y_2) do
					var_0_35(var_37_1, var_0_33(iter_37_2, iter_37_3))
				end
			end

			local var_37_2 = self:_genObjectData(iter_37_1, {
				rcs = var_37_1,
				centerRC = var_37_0
			})

			self._mapObjectDataArr[iter_37_1.type] = self._mapObjectDataArr[iter_37_1.type] or {}

			var_0_35(self._mapObjectDataArr[iter_37_1.type], var_37_2)

			for iter_37_4, iter_37_5 in ipairs(var_37_1) do
				self._mapObjectDataByRC[var_0_25(iter_37_5.x, iter_37_5.y)] = var_37_2
			end

			if iter_37_1.type == var_0_31.TEAMBOSS then
				self._bossComponentMap[iter_37_1.value] = iter_37_1
			elseif iter_37_1.type == var_0_31.CITY then
				self._cityComponentMap[iter_37_1.value] = iter_37_1
			elseif iter_37_1.type == var_0_31.GATE then
				self._gateComponentMap[iter_37_1.value] = self._gateComponentMap[iter_37_1.value] or {}

				var_0_35(self._gateComponentMap[iter_37_1.value], iter_37_1)
			elseif iter_37_1.type == var_0_31.CHARIOT then
				self:_initChariotCompData(iter_37_1)
			elseif iter_37_1.type == var_0_31.FARM then
				self._farmComponentMap[iter_37_1.value] = iter_37_1
			end
		end
	end

	for iter_37_6, iter_37_7 in var_0_20.ipairs() do
		if self._farmComponentMap[iter_37_7.id] then
			self._farmArrWithLevel[iter_37_7.level] = self._farmArrWithLevel[iter_37_7.level] or {}

			table.insert(self._farmArrWithLevel[iter_37_7.level], {
				compCfg = self._farmComponentMap[iter_37_7.id],
				baseCfg = iter_37_7
			})
		end
	end
end

function NewSlgData:getFarmMaxLevel()
	return #self._farmArrWithLevel
end

function NewSlgData:_initChariotCompData(arg_39_1)
	self._chariotComponentMap[arg_39_1.value] = arg_39_1
end

function NewSlgData:isWater(arg_40_1, arg_40_2)
	self._barrierCvsData = self._barrierCvsData or self:_updateCsvUsefulData(self._barrierCvsData, "barrier")

	local var_40_0 = var_0_25(arg_40_1, arg_40_2)

	if not self._barrierCvsData or not self._barrierCvsData[var_40_0] then
		return false
	end

	local var_40_1 = tonumber(self._barrierCvsData[var_40_0])

	return var_40_1 and var_40_1 == var_0_28.WATER_GID
end

function NewSlgData:isBarrier(arg_41_1, arg_41_2)
	local var_41_0 = var_0_25(arg_41_1, arg_41_2)

	if self.isChariotFindPath then
		if self:isWater(arg_41_1, arg_41_2) then
			return false
		end

		return true
	end

	self._barrierCvsData = self._barrierCvsData or self:_updateCsvUsefulData(self._barrierCvsData, "barrier")

	if not self._barrierCvsData or not self._barrierCvsData[var_41_0] then
		return false
	end

	if self:isWater(arg_41_1, arg_41_2) then
		return false
	end

	local var_41_1 = tonumber(self._barrierCvsData[var_41_0])

	return var_41_1 and var_41_1 > 0
end

function NewSlgData:isProvinceCanPass(arg_42_1, arg_42_2)
	return self:canChallengeProvinceByProvinceGID(self:getProvinceGIdByRC(arg_42_1.anchor_x, arg_42_1.anchor_y), arg_42_2)
end

function NewSlgData:getBarrierGIDByRC(arg_43_1, arg_43_2)
	local var_43_0 = var_0_25(arg_43_1, arg_43_2)

	self._barrierCvsData = self._barrierCvsData or self:_updateCsvUsefulData(self._barrierCvsData, "barrier")

	if not self._barrierCvsData or not self._barrierCvsData[var_43_0] then
		return nil
	end

	return tonumber(self._barrierCvsData[var_43_0])
end

function NewSlgData:getProvinceGIdByRC(arg_44_1, arg_44_2)
	local var_44_0 = var_0_25(arg_44_1, arg_44_2)

	self._provinceCvsData = self._provinceCvsData or self:_updateCsvUsefulData(self._provinceCvsData, "province")

	if not self._provinceCvsData or not self._provinceCvsData[var_44_0] then
		return nil
	end

	return tonumber(self._provinceCvsData[var_44_0])
end

function NewSlgData:getSelfProvinceGId()
	local var_45_0 = self:getMyUserData()

	if var_45_0 and var_45_0.pos then
		return self:getProvinceGIdByRC(var_45_0.pos.x, var_45_0.pos.y) or 0
	end

	return 0
end

function NewSlgData:getSelfProvincePID()
	local var_46_0 = self:getMyUserData()

	if var_46_0 and var_46_0.pos then
		local var_46_1 = self:getProvinceCfgByGID((self:getProvinceGIdByRC(var_46_0.pos.x, var_46_0.pos.y)))

		if var_46_1 then
			return var_46_1.id
		end
	end

	return 0
end

function NewSlgData:isCanAttackFarm(arg_47_1)
	local var_47_0 = self:getFarmComponentById(arg_47_1)
	local var_47_1 = self:getProvinceIdArrByType(var_0_28.PROVINCE_TYPE.BORN)
	local var_47_2 = table.indexof(var_47_1, self:getProvinceCfgByGID((self:getProvinceGIdByRC(var_47_0.anchor_x, var_47_0.anchor_y))).id)

	if var_47_2 then
		if var_47_1[var_47_2] ~= (self:getAllianceData().bornPID or 0) then
			return false
		end
	end

	return true
end

function NewSlgData:getComponentsByGID(arg_48_1)
	if self._componentTmplArr[arg_48_1] then
		return self._componentTmplArr[arg_48_1]
	end

	self:_initCompCfg()

	return self._componentTmplArr[arg_48_1] or {}
end

function NewSlgData:getBossComponentById(arg_49_1)
	self:_initCompCfg()

	return self._bossComponentMap[arg_49_1]
end

function NewSlgData:getCityComponentById(arg_50_1)
	self:_initCompCfg()

	return self._cityComponentMap[arg_50_1]
end

function NewSlgData:getChariotComponentById(arg_51_1)
	self:_initCompCfg()

	return self._chariotComponentMap[arg_51_1]
end

function NewSlgData:getGateComponentsById(arg_52_1)
	self:_initCompCfg()

	return self._gateComponentMap[arg_52_1] or {}
end

function NewSlgData:getObjectDataByType(arg_53_1)
	self:_initCompCfg()

	return self._mapObjectDataArr[arg_53_1] or {}
end

function NewSlgData:getObjectDataByRC(arg_54_1, arg_54_2)
	local var_54_0 = ""

	if type(arg_54_1) == "table" then
		arg_54_2 = arg_54_1.y
		arg_54_1 = arg_54_1.x
		var_54_0 = var_0_25(arg_54_1, arg_54_1.y)
	else
		var_54_0 = type(arg_54_1) == "string" and arg_54_1 or var_0_25(arg_54_1, arg_54_2)
	end

	return self._mapObjectDataByRC[var_54_0]
end

function NewSlgData:getMonsterGIDByRC(arg_55_1, arg_55_2)
	self._monsterCvsData = self._monsterCvsData or self:_updateCsvUsefulData(self._monsterCvsData, "monster")

	return self._monsterCvsData[var_0_25(arg_55_1, arg_55_2)] or 0
end

function NewSlgData:getTeamBossInfoByRC(arg_56_1, arg_56_2)
	local var_56_0 = self:getComponentsByGID((self:getBarrierGIDByRC(arg_56_1, arg_56_2)))[1]

	if var_56_0 and var_56_0.type == var_0_31.TEAMBOSS then
		return var_0_15.get(var_56_0.value)
	end

	return nil
end

function NewSlgData:getCityInfoByRC(arg_57_1, arg_57_2)
	local var_57_0 = self:getComponentsByGID((self:getBarrierGIDByRC(arg_57_1, arg_57_2)))[1]

	if var_57_0 and var_57_0.type == var_0_31.CITY then
		return var_0_4.get(var_57_0.value)
	end

	return nil
end

function NewSlgData:getChariotInfoByRC(arg_58_1, arg_58_2)
	local var_58_0 = self:getComponentsByGID((self:getBarrierGIDByRC(arg_58_1, arg_58_2)))[1]

	if var_58_0 and var_58_0.type == var_0_31.CHARIOT then
		return var_0_4.get(var_58_0.value)
	end

	return nil
end

function NewSlgData:getGateInfoByRC(arg_59_1, arg_59_2)
	local var_59_0 = self:getComponentsByGID((self:getBarrierGIDByRC(arg_59_1, arg_59_2)))[1]

	if var_59_0 and var_59_0.type == var_0_31.GATE then
		return self:getCheckPointInfoById(var_59_0.value)
	end

	return nil
end

function NewSlgData:getCheckPointState(arg_60_1)
	local var_60_0 = var_0_8.fetch(arg_60_1)

	if not var_60_0 then
		return var_0_28.CheckPointState.UnShown, "", var_0_28.SLGCheckPointQuestLockState.Lock
	end

	local var_60_1, var_60_2 = self:getCheckPointTaskCurVArr(var_60_0)

	if var_60_2 <= var_60_1 then
		return var_0_28.CheckPointState.Passed, "", var_0_28.SLGCheckPointQuestLockState.UnLock
	end

	local var_60_3, var_60_4 = self:getCheckPointConditionState(var_60_0.unlock_conditon_type, var_60_0.unlock_conditon_value)

	if var_60_3 == var_0_28.TaskState.COMPLETED then
		return var_0_28.CheckPointState.UnPass, "", var_0_28.SLGCheckPointQuestLockState.UnLock
	end

	local var_60_5, var_60_6 = self:getCheckPointConditionState(var_60_0.show_conditon_type, var_60_0.show_conditon_value)

	if var_60_5 == var_0_28.TaskState.COMPLETED then
		return var_0_28.CheckPointState.UnPass, var_60_4.name, var_0_28.SLGCheckPointQuestLockState.Lock
	end

	return var_0_28.CheckPointState.UnActive, var_60_6.name, var_0_28.SLGCheckPointQuestLockState.Lock
end

function NewSlgData:getCanChallengeProvinceGIDArr(arg_61_1, arg_61_2)
	local var_61_0 = self:getSelfProvinceGId()

	if arg_61_2 and self:getSName() == "S1" then
		return {
			var_61_0
		}
	end

	local var_61_1 = self:getProvinceCfgByGID(var_61_0)
	local var_61_2 = {}
	local var_61_3

	if var_61_1 then
		var_61_3 = var_61_1.id or 0

		if arg_61_1 and arg_61_1 > 0 then
			var_61_3 = arg_61_1
		end

		if var_61_3 == 0 then
			return var_61_2
		end
	end

	while true do
		local var_61_4 = var_0_7.get(var_61_3)

		if var_61_4.id == var_61_4.next then
			break
		end

		if not self:getCheckpointInfo(var_0_25(var_61_3, var_61_4.next)) then
			break
		end

		if self:getCheckPointState(var_61_3) == var_0_28.CheckPointState.Passed then
			var_61_3 = var_61_4.next
		else
			break
		end
	end

	local var_61_5 = var_0_7.get(var_61_3)

	if var_61_5 then
		var_61_2 = {
			var_61_5.province_gid
		}
	end

	table.insertto(var_61_2, self._preProvinceMap[var_61_3] or {})

	return var_61_2
end

function NewSlgData:canChallengeProvinceByProvinceGID(arg_62_1, arg_62_2)
	return table.indexof(self:getCanChallengeProvinceGIDArr(arg_62_2) or {}, arg_62_1)
end

function NewSlgData:_initTerrainCfg()
	self._terrainCfgMap = {}

	for iter_63_0, iter_63_1 in var_0_6.ipairs() do
		if iter_63_1.group_id == self._slgInfo.terrain_group then
			self._terrainCfgMap[iter_63_1.terrain_gid] = iter_63_1
		end
	end
end

function NewSlgData:_initProvinceCfg()
	self._provinceCfgMap = {}
	self._provinceTypeIdMap = {}

	for iter_64_0, iter_64_1 in var_0_7.ipairs() do
		if iter_64_1.group_id == self._slgInfo.province_group then
			self._provinceCfgMap[iter_64_1.province_gid] = iter_64_1
			self._provinceTypeIdMap[iter_64_1.level] = self._provinceTypeIdMap[iter_64_1.level] or {}

			table.insert(self._provinceTypeIdMap[iter_64_1.level], iter_64_1.id)
		end
	end
end

function NewSlgData:_initMonsterCfg()
	self._monsterCfgMap = {}
	self._monsterCfgArrMap = {}
	self._monsterMaxLevel = 0

	for iter_65_0, iter_65_1 in var_0_11.ipairs() do
		if iter_65_1.group_id == self._slgInfo.monster_group then
			self._monsterCfgMap[iter_65_1.monster_gid] = iter_65_1
			self._monsterCfgArrMap[iter_65_1.army_type] = self._monsterCfgArrMap[iter_65_1.army_type] or {}

			table.insert(self._monsterCfgArrMap[iter_65_1.army_type], iter_65_1)

			if iter_65_1.level > self._monsterMaxLevel then
				self._monsterMaxLevel = iter_65_1.level or self._monsterMaxLevel
			end
		end
	end
end

function NewSlgData:_initBossCfg()
	self._bossMaxLevel = 0

	for iter_66_0, iter_66_1 in var_0_15.ipairs() do
		if iter_66_1.group_id == self._slgInfo.boss_group then
			if iter_66_1.level > self._bossMaxLevel then
				self._bossMaxLevel = iter_66_1.level or self._bossMaxLevel
			end
		end
	end
end

function NewSlgData:_initCheckPointCfg()
	if self._checkPointInfoMap then
		return
	end

	self._checkPointInfoMap = {}

	for iter_67_0, iter_67_1 in var_0_8.ipairs() do
		if iter_67_1.group_id == self._slgInfo.checkpoint_group then
			self._checkPointInfoMap[var_0_25(iter_67_1.pre_province, iter_67_1.next_province)] = iter_67_1
		end
	end

	self._mainQuestArr = {}

	while true do
		local var_67_0 = self:getMainQuestInfoById(self._slgInfo.main_quest_first_id)

		table.insert(self._mainQuestArr, var_67_0)

		if var_67_0.next_id == 0 then
			break
		end
	end

	self._preProvinceMap = {}

	for iter_67_2, iter_67_3 in var_0_7.ipairs() do
		if iter_67_3.group_id == self._slgInfo.province_group and iter_67_3.id ~= iter_67_3.next then
			if self._preProvinceMap[iter_67_3.next] then
				var_0_35(self._preProvinceMap[iter_67_3.next], iter_67_3.province_gid)
			else
				self._preProvinceMap[iter_67_3.next] = {
					iter_67_3.province_gid
				}
			end

			if self._preProvinceMap[iter_67_3.id] and self._preProvinceMap[iter_67_3.next] then
				table.insertto(self._preProvinceMap[iter_67_3.next], self._preProvinceMap[iter_67_3.id])
			end
		end
	end
end

function NewSlgData:getComponentCfg(arg_68_1)
	return var_0_5.get(arg_68_1)
end

function NewSlgData:getTerrainCfg(arg_69_1)
	if self._terrainCfgMap[arg_69_1] then
		return self._terrainCfgMap[arg_69_1]
	end

	self:_initTerrainCfg()

	return self._terrainCfgMap[arg_69_1]
end

function NewSlgData:getProvinceCfgByGID(arg_70_1)
	if self._provinceCfgMap[arg_70_1] then
		return self._provinceCfgMap[arg_70_1]
	end

	self:_initProvinceCfg()

	return self._provinceCfgMap[arg_70_1]
end

function NewSlgData:getProvinceIdArrByType(arg_71_1)
	if self._provinceTypeIdMap[arg_71_1] then
		return self._provinceTypeIdMap[arg_71_1]
	end

	self:_initProvinceCfg()

	return self._provinceTypeIdMap[arg_71_1]
end

function NewSlgData:getProvinceLinkIds()
	if #self._provinceLinkIds == 0 then
		local var_72_0 = self:getAllianceData().bornPID or 0

		if var_72_0 > 0 then
			while true do
				local var_72_1 = self:getProvinceCfgById(var_72_0)

				table.insert(self._provinceLinkIds, var_72_1.id)

				if var_72_0 == var_72_1.next then
					break
				end

				var_72_0 = var_72_1.next
			end
		end
	end

	return self._provinceLinkIds
end

function NewSlgData:isInProvinceLinkIds(arg_73_1)
	local var_73_0 = self:getProvinceLinkIds()

	if #var_73_0 == 0 then
		return false
	end

	for iter_73_0, iter_73_1 in ipairs(var_73_0) do
		if iter_73_1 == arg_73_1 then
			return true
		end
	end

	return false
end

function NewSlgData:getProvinceCfgById(arg_74_1)
	return var_0_7.get(arg_74_1)
end

function NewSlgData:getCityInfoById(arg_75_1)
	return var_0_4.get(arg_75_1)
end

function NewSlgData:getBossInfoById(arg_76_1)
	if arg_76_1 == 0 then
		return {
			level = 0,
			name = g.core.lang:get(428944)
		}
	end

	return var_0_15.get(arg_76_1)
end

function NewSlgData:getMonsterInfoByGID(arg_77_1)
	if self._monsterCfgMap[arg_77_1] then
		return self._monsterCfgMap[arg_77_1]
	end

	self:_initMonsterCfg()

	return self._monsterCfgMap[arg_77_1]
end

function NewSlgData:getMonsterInfoById(arg_78_1)
	return var_0_11.get(arg_78_1, self._seasonId)
end

function NewSlgData:getCheckpointInfo(arg_79_1)
	self:_initCheckPointCfg()

	return self._checkPointInfoMap[arg_79_1]
end

function NewSlgData:getCheckPointInfoById(arg_80_1)
	return var_0_8.get(arg_80_1)
end

function NewSlgData:getMainQuestInfoById(arg_81_1)
	return var_0_9.get(arg_81_1)
end

function NewSlgData:getCityQuestInfoById(arg_82_1)
	return var_0_10.get(arg_82_1)
end

function NewSlgData:getSearchMonster1(arg_83_1, arg_83_2)
	return self._monsterRCInProvince[var_0_26(self:getSelfProvinceGId(), arg_83_1, arg_83_2)] or {}
end

function NewSlgData:getSearchMonsterMulti(arg_84_1, arg_84_2, arg_84_3)
	local var_84_0 = {}

	for iter_84_0, iter_84_1 in ipairs(arg_84_1) do
		table.insertto(var_84_0, self._monsterRCInProvince[var_0_26(iter_84_1, arg_84_2, arg_84_3)] or {})
	end

	return var_84_0
end

function NewSlgData:getSearchMonster2(arg_85_1, arg_85_2)
	return self._monsterRCInProvince[var_0_25(arg_85_1, arg_85_2)] or {}
end

function NewSlgData:getCurAttackTargetIds()
	local var_86_0 = {}
	local var_86_1 = self:getMyTeamMap()

	for iter_86_0 = 1, self._teamCurCnt do
		if var_86_1[iter_86_0] and var_86_1[iter_86_0] and not self:isTeamIdle(var_86_1[iter_86_0]) then
			local var_86_2, var_86_3, var_86_4 = self:getDestTargetInfo(var_86_1[iter_86_0].move.end_pos)

			if var_86_4 then
				var_86_0[var_86_4 .. "_" .. var_86_1[iter_86_0].target_type .. "_" .. var_86_1[iter_86_0].move.end_pos.x .. "_" .. var_86_1[iter_86_0].move.end_pos.y] = true
			end
		end
	end

	return var_86_0
end

function NewSlgData:searchCanChallengeMonster(arg_87_1, arg_87_2)
	local var_87_0 = self:getMyUserData().pos
	local var_87_1 = {}
	local var_87_2 = g.core.common.ServerTime:getTime()
	local var_87_3 = self:getCurAttackTargetIds()

	for iter_87_0, iter_87_1 in ipairs((self:getSearchMonsterMulti(self:getCanChallengeProvinceGIDArr(nil, true), arg_87_2 or self:getMaxMonsterLv() + 1, arg_87_1))) do
		local var_87_4 = self:getMonsterDataByRC(iter_87_1.x, iter_87_1.y)

		if var_87_4 then
			if (var_87_4.reviveTime or 0) - var_87_2 <= 0 then
				if var_87_4 then
					if not var_87_3[var_87_4.monsterId .. "_" .. var_0_28.BATTLE_TYPE.MONSTER .. "_" .. iter_87_1.x .. "_" .. iter_87_1.y] then
						var_87_1[#var_87_1 + 1] = iter_87_1
					end
				else
					var_87_1[#var_87_1 + 1] = iter_87_1
				end
			end
		end
	end

	local var_87_6

	for iter_87_2, iter_87_3 in ipairs(var_87_1) do
		local var_87_7 = math.pow(var_87_0.x - iter_87_3.x, 2) + math.pow(var_87_0.y - iter_87_3.y, 2)
		local var_87_8

		if 0 == 0 or var_87_7 < 0 then
			var_87_6 = iter_87_3
			var_87_8 = var_87_7
		end
	end

	return var_87_6
end

function NewSlgData:getSearchTeamBoss1(arg_88_1, arg_88_2)
	return self._bossRCInProvince[var_0_26(self:getSelfProvinceGId(), arg_88_1, arg_88_2)] or {}
end

function NewSlgData:getSearchTeamBossMulti(arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = {}

	for iter_89_0, iter_89_1 in ipairs(arg_89_1) do
		local var_89_1 = var_0_26(iter_89_1, arg_89_2, arg_89_3)

		if self._bossRCInProvince[var_89_1] then
			if #self._bossRCInProvince[var_89_1] == 4 and self._seasonId == 1 then
				table.insertto(var_89_0, {
					self._bossRCInProvince[var_89_1][4]
				})
			else
				table.insertto(var_89_0, self._bossRCInProvince[var_89_1] or {})
			end
		end
	end

	return var_89_0
end

function NewSlgData:getSearchTeamBoss2(arg_90_1, arg_90_2)
	return self._bossRCInProvince[var_0_25(arg_90_1, arg_90_2)] or {}
end

function NewSlgData:searchCanChallengeBoss(arg_91_1, arg_91_2)
	local var_91_0 = self:getMyUserData().pos
	local var_91_1
	local var_91_2 = self:getCurAttackTargetIds()

	for iter_91_0, iter_91_1 in ipairs((self:getSearchTeamBossMulti(self:getCanChallengeProvinceGIDArr(), arg_91_2 or self:getBossChallengedLevel() + 1, arg_91_1))) do
		local var_91_3 = math.pow(var_91_0.x - iter_91_1.x, 2) + math.pow(var_91_0.y - iter_91_1.y, 2)
		local var_91_4 = self:getTeamBossInfoByRC(iter_91_1.x, iter_91_1.y)
		local var_91_5

		if not var_91_2[var_91_4.id .. "_" .. var_0_28.BATTLE_TYPE.BOSS .. "_" .. iter_91_1.x .. "_" .. iter_91_1.y] and (0 == 0 or var_91_3 < 0) and var_91_4 then
			var_91_1 = iter_91_1
			var_91_5 = var_91_3
		end
	end

	return var_91_1
end

function NewSlgData:searchFarmNearestByLevel(arg_92_1)
	if not self._farmArrWithLevel[arg_92_1] then
		return
	end

	local var_92_0 = self._myPos
	local var_92_1

	for iter_92_0, iter_92_1 in ipairs(self._farmArrWithLevel[arg_92_1]) do
		local var_92_2 = cc.pGetDistance(var_92_0, cc.p(iter_92_1.compCfg.anchor_x, iter_92_1.compCfg.anchor_y))
		local var_92_3

		if var_92_2 < 99999999 then
			var_92_3 = var_92_2
			var_92_1 = iter_92_1
		end
	end

	return var_92_1
end

function NewSlgData:isGateCanPass(arg_93_1)
	if self:getCheckPointState(arg_93_1) == var_0_28.CheckPointState.Passed then
		return true
	end

	return false
end

function NewSlgData:getDestTargetInfo(arg_94_1)
	local var_94_0 = self:getMonsterGIDByRC(arg_94_1.x, arg_94_1.y)

	if var_94_0 ~= 0 then
		local var_94_1 = self:getMonsterInfoByGID(var_94_0)

		if var_94_1 then
			return var_94_1.level, var_94_1.name, var_94_1.id
		end

		return 0, ""
	end

	local var_94_2 = self:getBarrierGIDByRC(arg_94_1.x, arg_94_1.y)

	if var_94_2 ~= 0 then
		local var_94_3 = self:getComponentsByGID(var_94_2)

		if #var_94_3 > 0 then
			if var_94_3[1].type == var_0_31.TEAMBOSS then
				local var_94_4 = self:getBossInfoById(var_94_3[1].value)

				if var_94_4 then
					return var_94_4.level, var_94_4.name, var_94_4.id
				end
			elseif var_94_3[1].type == var_0_31.CITY or var_94_3[1].type == var_0_31.CHARIOT then
				local var_94_5 = self:getCityInfoById(var_94_3[1].value)

				if var_94_5 then
					return var_94_5.level, var_94_5.name, var_94_5.id
				end
			elseif var_94_3[1].type == var_0_31.FARM then
				local var_94_6 = self:getFarmInfoById(var_94_3[1].value)

				if var_94_6 then
					return var_94_6.level, var_94_6.name, var_94_6.id
				end
			end
		else
			local var_94_7 = self:getTerrainCfg(var_94_2)

			if var_94_7 then
				return 0, var_94_7.name
			end
		end
	end

	return 0, ""
end

function NewSlgData:setAStar(arg_95_1)
	self._aStar = arg_95_1
end

function NewSlgData:getAStar()
	return self._aStar
end

function NewSlgData:resetAStar()
	self._aStar = nil
end

function NewSlgData:getPath(arg_98_1, arg_98_2, arg_98_3, arg_98_4)
	if not self._aStar then
		return
	end

	arg_98_1 = arg_98_1 or self:getMyUserData().pos

	local var_98_0 = arg_98_1.x or 0
	local var_98_1 = arg_98_1.y or 0
	local var_98_2 = arg_98_2.x or 0
	local var_98_3 = arg_98_2.y or 0
	local var_98_4 = var_98_0 .. "_" .. var_98_1 .. "_" .. var_98_2 .. "_" .. var_98_3
	local var_98_5

	if not self._pathCache[var_98_0 .. "_" .. var_98_1 .. "_" .. var_98_2 .. "_" .. var_98_3] then
		var_98_5 = self._aStar:getPath(arg_98_1, arg_98_2)

		if var_98_5 and #var_98_5 > 30 then
			self._pathCache[var_98_4] = var_98_5
		end
	else
		var_98_5 = self._pathCache[var_98_4]
	end

	self._isAStarCancel = arg_98_3 or false
	self._isAStarRobot = arg_98_4 or false

	return var_98_5
end

function NewSlgData:clearPathCache()
	self._pathCache = {}
end

function NewSlgData:getPathByTmpl(arg_100_1)
	return (self:getPath(self:getMyUserData().pos, (cc.p(arg_100_1.anchor_x, arg_100_1.anchor_y))))
end

function NewSlgData:_initParamsCfg()
	for iter_101_0, iter_101_1 in var_0_12.ipairs() do
		self._parameterInfo[iter_101_1.field] = iter_101_1.parameter
	end
end

function NewSlgData:getNewSlgParamsCfg()
	return self._parameterInfo
end

function NewSlgData:getNewSlgParamsValueById(arg_103_1)
	return var_0_12.get(arg_103_1).parameter
end

function NewSlgData:getNewSlgParamsValueByKey(arg_104_1)
	return self._parameterInfo[arg_104_1]
end

function NewSlgData:loadCache(arg_105_1)
	return (g.core.common.Storage:load("new_slg_record.json") or {})[arg_105_1] or 0
end

function NewSlgData:saveCache(arg_106_1, arg_106_2)
	arg_106_2 = arg_106_2 or 1

	local var_106_0 = g.core.common.Storage:load("new_slg_record.json") or {}

	var_106_0[arg_106_1] = arg_106_2

	g.core.common.Storage:save("new_slg_record.json", var_106_0)
end

function NewSlgData:loadCacheWithActId(arg_107_1)
	return self:loadCache("new_slg_id" .. self._actId .. "_" .. arg_107_1)
end

function NewSlgData:saveCacheWithActId(arg_108_1, arg_108_2)
	return self:saveCache("new_slg_id" .. self._actId .. "_" .. arg_108_1, arg_108_2)
end

function NewSlgData:setRankData(arg_109_1, arg_109_2)
	self._rankDataMap[arg_109_1] = arg_109_2

	if arg_109_2 then
		arg_109_2.myRank = arg_109_2.self_unit and arg_109_2.self_unit.rank > 0 and self:getNewSlgParamsValueById(var_0_28.RANK_TYPE_ID_MAP[arg_109_1]) > arg_109_2.self_unit.rank and arg_109_2.self_unit.rank or 0
	end
end

function NewSlgData:getRankData(arg_110_1)
	return self._rankDataMap[arg_110_1]
end

function NewSlgData:updateCrossRedPoint(arg_111_1)
	g.core.model.User.newSlgDevelopData:updateDevelopData(arg_111_1)
	self:updateCheckPointTask(arg_111_1.checkpoint_quests or {}, true)
	self:updateCityQuestProgressSerData(arg_111_1.city_quest or {}, true)

	if arg_111_1.city_quest_awards then
		self:updateCityQuestAwarded(arg_111_1.city_quest_awards, true)
	end

	self:_setOccupiedCityId(arg_111_1.occupied_city)

	self._allianceSerData.bornPID = arg_111_1.born_province or 0

	self:setBossChallengedLevel(arg_111_1.challenged_boss_level or 0)

	self.gatherCityRedPoint = arg_111_1.city_gather
	self._cityStartAttackTime = arg_111_1.city_start_tm or 0
	self._cityEndAttackTime = arg_111_1.city_end_tm or 0

	if arg_111_1.battle_un_award then
		self._newBattleReportCnt = self._newBattleReportCnt + 1
	end

	self._monsterFightCount = arg_111_1.order_power_num

	if self:getSName() == "S2" then
		local var_111_0 = {}
		local var_111_1 = {
			id = g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ATK_ID
		}

		var_111_1.params = table.concat(arg_111_1.atk_city_ids or {}, ":")
		var_111_0[1] = var_111_1

		local var_111_2 = {
			id = g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_DEF_ID
		}

		var_111_2.params = table.concat(arg_111_1.def_city_ids or {}, ":")
		var_111_0[2] = var_111_2

		g.core.model.User.homeInfoRemindData:updateTipData({
			tips = var_111_0
		})
	end

	self._firstKillAwarded = arg_111_1.first_kill_award or false
	self._bountyTaskAwarded = arg_111_1.bounty_task_award or false
end

function NewSlgData:setActInfo(arg_112_1)
	self._seasonId = arg_112_1
	self._slgInfo = var_0_3.get(arg_112_1)
end

function NewSlgData:updateRedData(arg_113_1)
	self._activityInfo = arg_113_1.act_info or nil
	self._getPreviewReward = arg_113_1.obtain_preview_reward or false

	if not self._activityInfo or self._activityInfo.id <= 0 then
		return
	end

	if self._activityInfo and self._activityInfo.sub_id then
		self._actId = self._activityInfo.id or 0
		self._seasonId = self._activityInfo.sub_id or 1
		self._isFirstSeason = arg_113_1.is_first or false

		local var_113_0 = var_0_3.get(self._seasonId)

		if var_113_0 then
			self._slgInfo = var_113_0
		else
			assert("newslg错误的赛季Id: " .. self._seasonId)
		end

		self._timePre = self._activityInfo.preview_time
		self._timeStart = self._activityInfo.start_time
		self._timeEnd = self._activityInfo.end_time
		self._timeShowEnd = self._activityInfo.show_end_time

		if self:loadCache("new_slg_id") ~= self._seasonId then
			self:saveCache("new_slg_id", self._seasonId)
			self:_resetSeason()
		end
	end

	self:updateMainQuestDataById(arg_113_1.main_quest_id or 0)
	self:updateUnitMainQuest(arg_113_1.main_quest)
	self:updateAchievementSelfTaskData(arg_113_1.achievements, true)
	g.core.model.User.newSlgDevelopData:initCfg()
end

function NewSlgData:_resetSeason()
	self:_updateBattleReportRedPointData(0)
end

function NewSlgData:exitSlg()
	self:resetAStar()

	self._mapMarchUnitData = {}
	self._monsterSerDataByRC = {}
	self._userSerData = {}
	self._rankRewardData = {}
	self._initMapComp = false
	self._barrierCvsData = nil
	self._provinceCvsData = nil
	self._monsterCvsData = nil
	self._cityComponentMap = {}
	self._bossComponentMap = {}
	self._gateComponentMap = {}
	self._chariotComponentMap = {}
	self._monsterCfgArrMap = {}
	self._mapObjectDataArr = {}
	self._mapObjectDataByRC = {}
	self._componentTmplArr = {}
	self._terrainCfgMap = {}
	self._monsterCfgMap = {}
	self._provinceCfgMap = {}
	self._provinceTypeIdMap = {}
	self._provinceLinkIds = {}
	self._farmComponentMap = {}
	self._checkPointInfoMap = nil
	self._preProvinceMap = {}
	self._bossRCInProvince = {}
	self._monsterRCInProvince = {}
	self._farmArrWithLevel = {}
	self._bossIdsByProvinceGID = {}
	self._cityIdsByPID = {}
	self._serverList = {}
end

function NewSlgData:enterSlg(arg_116_1)
	self.intoMapRedPoint = true
	self._maxTeamAuthority = arg_116_1.max_team_authority or 4000
	self._movePrivilegePer = 0

	if arg_116_1.user_base then
		self:updateBaseData(arg_116_1.user_base)
	end

	if arg_116_1.teams then
		self:updateMyTeamData(arg_116_1.teams)
	end

	if arg_116_1.user_show then
		local var_116_0 = g.core.model.User:getId()

		self._myUserPosData = self._myUserPosData or self:getUserDataByUid(var_116_0)
		self._userSerData = {}

		self:updateUsersData(arg_116_1.user_show)

		local var_116_1 = self:getUserDataByUid(var_116_0)

		if var_116_1 then
			self._myUserPosData = var_116_1
		end
	end

	if arg_116_1.monsters then
		self:updateMonstersData(arg_116_1.monsters)
	end

	self:updateMarchRoutes(arg_116_1.move_units)

	if arg_116_1.alliance then
		self:_updateAllianceSerData(arg_116_1.alliance)
	end

	self:reqSLGEnterByBoss(arg_116_1)
	self:updateMainQuestDataById(arg_116_1.main_quest_id or 0)
	self:updateUnitMainQuest(arg_116_1.main_quest)
	self:_updateDevelopData(arg_116_1)

	if arg_116_1.max_report_id then
		self:_updateBattleReportRedPointData(arg_116_1.max_report_id)
	end

	if arg_116_1.city_elements then
		self:updateCityElement(arg_116_1.city_elements)
	end

	local var_116_2 = self:getSName()

	if var_116_2 == "S1" then
		if self._slgInfo.battlepass_group then
			self._commonPassCardActId = self._slgInfo.battlepass_group

			g.core.network.GameNetProxy:send_C2S_CommonPasscard_GetInfo({
				id = self._commonPassCardActId
			})

			if self._commonPassCardActId > 0 then
				self:updatePassCardData(self._commonPassCardActId)
			end
		end
	elseif var_116_2 == "S2" then
		self._commonPassCardActId = arg_116_1.battle_pass_id or 0

		if self._commonPassCardActId > 0 then
			g.core.network.GameNetProxy:send_C2S_CommonPasscard_GetInfo({
				id = self._commonPassCardActId
			})
			self:updatePassCardData(self._commonPassCardActId)
		end
	end
end

function NewSlgData:updateBaseData(arg_117_1)
	if arg_117_1.max_monster_level then
		self._monsterLvMax = arg_117_1.max_monster_level
	end

	if arg_117_1.order_power_num then
		self._monsterFightCount = arg_117_1.order_power_num
	end

	if arg_117_1.score then
		self._score = arg_117_1.score
	end

	self._farmTokenMap = {}

	for iter_117_0, iter_117_1 in ipairs(arg_117_1.farm_tokens or {}) do
		self._farmTokenMap[iter_117_1.id] = iter_117_1.num
	end

	if arg_117_1.latest_move_home_time then
		self._lastMoveHomeTime = arg_117_1.latest_move_home_time
	end

	self._dailyBossTimes = arg_117_1.daily_boss_times or 0
	self._dailyAssistBossTimes = arg_117_1.daily_boss_assist_times or 0

	if arg_117_1.city_quest_awards then
		self:updateCityQuestAwarded(arg_117_1.city_quest_awards, true)
	end

	if arg_117_1.kick_time then
		self._kickCnt = arg_117_1.kick_time
	end

	self._curDayFarmRewardCount = arg_117_1.farm_num or 0
	self._curDayFarmKillScore = arg_117_1.daily_farm_kill_score or 0

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.SLG_BASE_USER_INFO_BACK)
end

function NewSlgData:_genUserData(arg_118_1)
	if arg_118_1 and arg_118_1.pos then
		local var_118_0 = {
			pos = arg_118_1.pos,
			sid = arg_118_1.sid,
			uid = arg_118_1.uid
		}

		var_118_0.name = arg_118_1.name or ""
		var_118_0.allianceId = arg_118_1.alliance_id or 0
		var_118_0.allianceName = arg_118_1.alliance_name or ""
		var_118_0.mainCityLevel = arg_118_1.main_city_level or 1
		var_118_0.authority = arg_118_1.authority or 0

		return var_118_0
	end

	return nil
end

function NewSlgData:genMonsterData(arg_119_1)
	if arg_119_1 and arg_119_1.pos then
		local var_119_0 = {
			monsterId = arg_119_1.monster_id
		}

		var_119_0.troops = arg_119_1.troops or 0
		var_119_0.maxTroops = arg_119_1.max_troops or 0
		var_119_0.reviveTime = arg_119_1.revive_ts or 0
		var_119_0.initTime = arg_119_1.init_ts or 0
		var_119_0.pos = arg_119_1.pos

		return var_119_0
	end

	return nil
end

function NewSlgData:notifyUsersData(arg_120_1)
	if arg_120_1.delete then
		self:deleteUserData(arg_120_1)
	else
		return self:updateUsersData({
			arg_120_1
		})
	end
end

function NewSlgData:updateUsersData(arg_121_1)
	for iter_121_0, iter_121_1 in ipairs(arg_121_1) do
		local var_121_0 = self:_genUserData(iter_121_1)
		local var_121_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_121_0.uid)

		if var_121_1 then
			var_121_0.name = var_121_1.name
			var_121_0.allianceId = var_121_1.alliance_id or 0
			var_121_0.allianceName = var_121_1.alliance_name or ""
			var_121_0.sid = var_121_1.sid
		end

		if var_121_0.uid == g.core.model.User:getId() then
			if self._myPos and (var_121_0.pos.x ~= self._myPos.x or var_121_0.pos.y ~= self._myPos.y) then
				self._isMoveHome = true
			end

			self._myPos = var_121_0.pos
		end

		self._userSerData[string.format("%0.f", var_121_0.uid)] = var_121_0
	end
end

function NewSlgData:updateUserAsSvrSnapShot(arg_122_1)
	if not arg_122_1 then
		return
	end

	local var_122_0 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER

	for iter_122_0, iter_122_1 in ipairs(arg_122_1) do
		local var_122_1 = string.format("%0.f", iter_122_1.id)
		local var_122_2 = g.core.model.User.snapShotCacheData:getSnapShot(var_122_0, iter_122_1.id)

		if self._userSerData[var_122_1] and var_122_2 then
			self._userSerData[var_122_1].name = var_122_2.name
			self._userSerData[var_122_1].allianceId = var_122_2.alliance_id or 0
			self._userSerData[var_122_1].allianceName = var_122_2.alliance_name or ""
			self._userSerData[var_122_1].sid = var_122_2.sid
		end
	end
end

function NewSlgData:deleteUserData(arg_123_1)
	self._userSerData[string.format("%0.f", arg_123_1.uid)] = nil
end

function NewSlgData:getMyUserData()
	local var_124_0 = self:getUserDataByUid((g.core.model.User:getId()))

	if var_124_0 then
		local var_124_1 = g.core.model.User.newSlgDevelopData
		local var_124_2 = g.core.model.User.newSlgDevelopData:getTotalAuthority()

		var_124_0.authority = var_124_2 > 0 and var_124_2 or var_124_0.authority

		local var_124_3 = var_124_1:getMainCityLv()

		var_124_0.mainCityLevel = var_124_3 > 0 and var_124_3 or var_124_0.mainCityLevel
	end

	return var_124_0 or self._myUserPosData
end

function NewSlgData:getUsersData()
	return self._userSerData
end

function NewSlgData:onS2CGetServerInfo(arg_126_1)
	self._serverList = arg_126_1.serverInfo or {}
end

function NewSlgData:getServerList()
	return self._serverList
end

function NewSlgData:getUserDataByUid(arg_128_1)
	return self._userSerData[string.format("%0.f", arg_128_1)]
end

function NewSlgData:updateMonstersData(arg_129_1)
	self._monsterSerDataByRC = {}

	for iter_129_0, iter_129_1 in ipairs(arg_129_1) do
		local var_129_0 = self:genMonsterData(iter_129_1)

		self._monsterSerDataByRC[var_0_25(var_129_0.pos.x, var_129_0.pos.y)] = var_129_0
	end
end

function NewSlgData:getMonsterDataByRC(arg_130_1, arg_130_2)
	return self._monsterSerDataByRC[var_0_25(arg_130_1, arg_130_2)]
end

function NewSlgData:setMonsterData(arg_131_1)
	if arg_131_1 then
		local var_131_0 = arg_131_1.pos or {
			0,
			0
		}

		if self:isSameProvinceGID(self:getProvinceGIdByRC(var_131_0.x, var_131_0.y)) then
			self._monsterSerDataByRC[var_0_25(var_131_0.x, var_131_0.y)] = self:genMonsterData(arg_131_1)
		end
	end
end

function NewSlgData:isSameProvinceGID(arg_132_1)
	return self:getSelfProvinceGId() == arg_132_1
end

function NewSlgData:isMonsterCanChallengeBySameProvinceGID(arg_133_1)
	return self:isSameProvinceGID(arg_133_1)
end

function NewSlgData:getMaxMonsterLv()
	return self._monsterLvMax or 0
end

function NewSlgData:getLeftMonsterFightCount()
	return self._monsterFightCount or 0
end

function NewSlgData:getLastMoveHomeTime()
	return self._lastMoveHomeTime
end

function NewSlgData:canMoveToBornProvince(arg_137_1)
	local var_137_0 = self:getAllianceData().bornPID or 0

	if var_137_0 == 0 then
		return false
	end

	local var_137_1 = self:getObjectDataByRC(arg_137_1.x, arg_137_1.y)

	if var_137_1 and self:getPathByTmpl((self:getComponentCfg(var_137_1.id))) then
		return false
	end

	local var_137_2 = self:getSelfProvincePID()
	local var_137_3 = self:getProvinceGIdByRC(arg_137_1.x, arg_137_1.y)

	if var_137_3 then
		if not self:isInProvinceLinkIds(var_137_2) and self:isInProvinceLinkIds(self:getProvinceCfgByGID(var_137_3).id) and self:canChallengeProvinceByProvinceGID(var_137_3, var_137_0) then
			return true
		end
	end

	return false
end

function NewSlgData:isSelfInBornProvinces()
	return (table.indexof(self:getProvinceIdArrByType(var_0_28.PROVINCE_TYPE.BORN), (self:getSelfProvincePID())))
end

function NewSlgData:getMoveHomeCDTime()
	return self:getLastMoveHomeTime() + self._slgInfo.parameter_8 - g.core.common.ServerTime:getTime()
end

function NewSlgData:getMoveHomeFreeTime()
	return self._timeStart + self._slgInfo.parameter_11 - g.core.common.ServerTime:getTime()
end

function NewSlgData:onRecvMoveHome(arg_141_1)
	local var_141_0 = arg_141_1.target_pos

	if arg_141_1.path and #arg_141_1.path > 0 then
		var_141_0 = arg_141_1.path[#arg_141_1.path]
	end

	if var_141_0 then
		self:_moveHome(var_141_0)
	end

	if arg_141_1.latest_move_home_time then
		self._lastMoveHomeTime = arg_141_1.latest_move_home_time
	end
end

function NewSlgData:checkPlayMoveHomeEff()
	self._isMoveHome = false

	return self._isMoveHome
end

function NewSlgData:onRecvMoveHomeToBornProvince(arg_143_1)
	if not arg_143_1.pos then
		return
	end

	if arg_143_1.latest_move_home_time then
		self._lastMoveHomeTime = arg_143_1.latest_move_home_time
	end

	self:_moveHome(arg_143_1.pos)
end

function NewSlgData:_moveHome(arg_144_1)
	local var_144_0 = self:getMyUserData()

	if not var_144_0 then
		return
	end

	var_144_0.pos = arg_144_1
end

function NewSlgData:onRecvMonsterMarch(arg_145_1)
	if arg_145_1.monster then
		self:setMonsterData(arg_145_1.monster)
	end
end

function NewSlgData:_genMarchUnit(arg_146_1, arg_146_2, arg_146_3)
	if arg_146_1 then
		local var_146_0 = arg_146_1.cancel_time or 0
		local var_146_1 = var_146_0 > 0
		local var_146_2 = arg_146_1.start_pos
		local var_146_3 = arg_146_1.start_time
		local var_146_4 = self:getPath(arg_146_1.start_pos, arg_146_1.end_pos)

		if not var_146_4 then
			return
		end

		local var_146_5 = arg_146_1.move_privilege or 0
		local var_146_6 = NewSlgFunc.getMarchDurationByPath(var_146_4, var_146_5, arg_146_1.move_action_type)
		local var_146_7 = var_146_3 + var_146_6
		local var_146_8 = 1

		if var_146_4 and #var_146_4 > 1 then
			var_146_8 = var_146_6 / (#var_146_4 - 1)
			var_146_8 = math.max(var_146_6 / (#var_146_4 - 1), 1)
		end

		if var_146_1 then
			if var_146_6 <= var_146_0 - var_146_3 then
				return
			end

			local var_146_9 = math.ceil((var_146_0 - var_146_3) / var_146_8)

			var_146_4 = self:getPath(var_146_4[var_146_9 + 1], var_146_2, true)
			var_146_6 = NewSlgFunc.getMarchDurationByPath(var_146_4, var_146_5, arg_146_1.move_action_type)

			local var_146_10 = 1

			if var_146_4 and #var_146_4 > 1 then
				var_146_10 = var_146_6 / (#var_146_4 - 1)
				var_146_10 = math.max(var_146_6 / (#var_146_4 - 1), 1)
			end

			var_146_3 = var_146_0 - (var_146_3 + var_146_9 * var_146_10 - var_146_0)
			var_146_7 = var_146_3 + var_146_6
			var_146_2 = var_146_4[var_146_9 + 1]
		end

		if not var_146_1 and var_146_7 <= var_0_1:getTime() + 3 then
			print("NewSlgData行军即将过期，不创建了-------------")

			return
		end

		return {
			isPathEnd = false,
			id = arg_146_1.id,
			startTime = var_146_3,
			startPos = var_146_2,
			endTime = var_146_7,
			duration = var_146_6,
			path = var_146_4,
			teamData = arg_146_2,
			isRobot = arg_146_3
		}
	end

	return nil
end

function NewSlgData:updateMarchRoutes(arg_147_1)
	self._mapMarchUnitData = {}
	self._refreshMarch = false

	if not arg_147_1 then
		return
	end

	for iter_147_0, iter_147_1 in ipairs(arg_147_1) do
		self:_createMarchRoute(iter_147_1)
	end
end

function NewSlgData:notifyMarchRoute(arg_148_1)
	local var_148_0 = false
	local var_148_1 = g.core.common.ServerTime:getTime()

	for iter_148_0, iter_148_1 in pairs(self._mapMarchUnitData) do
		if iter_148_1.id == arg_148_1.move.id then
			iter_148_1.endTime = arg_148_1.move.start_time + (iter_148_1.endTime - iter_148_1.startTime)
		end

		if var_148_1 >= iter_148_1.endTime then
			self:deleteMarchUnit(iter_148_0)

			var_148_0 = true
		end
	end

	self:_createMarchRoute(arg_148_1)

	self._refreshMarch = self._refreshMarch or var_148_0
end

function NewSlgData:createBossRobotRoute(arg_149_1, arg_149_2, arg_149_3, arg_149_4, arg_149_5, arg_149_6, arg_149_7)
	if arg_149_4 and arg_149_4 > 0 then
		self:deleteMarchUnit("robot_" .. arg_149_6 .. "_" .. arg_149_2 .. "_" .. var_0_25(arg_149_1.x, arg_149_1.y) .. "_" .. arg_149_3)

		local var_149_0 = "robot_" .. arg_149_6 .. "_" .. arg_149_2 .. "_" .. var_0_25(arg_149_1.x, arg_149_1.y) .. "_" .. arg_149_4
	end

	local var_149_1 = NewSlgFunc.getMarchLengthByDuration(arg_149_2)
end

function NewSlgData:_createMarchRoute(arg_150_1, arg_150_2)
	if not self._aStar then
		return
	end

	local var_150_0 = arg_150_1.move
	local var_150_1 = arg_150_1.team_show

	if not arg_150_1.move or not var_150_1 then
		return
	end

	local var_150_2 = var_150_0.start_pos
	local var_150_3 = var_150_0.start_time or 0

	if not var_150_2 or not var_150_0.end_pos or var_150_3 == 0 then
		return
	end

	local var_150_4 = g.core.common.ServerTime:getTime()

	if var_150_3 - var_150_4 > 3 and not arg_150_2 then
		return
	end

	self._refreshMarch = false

	local var_150_5 = var_0_26(var_150_0.id, var_0_25(var_150_2.x, var_150_2.y), var_0_25(var_150_0.end_pos.x, var_150_0.end_pos.y))

	if self._mapMarchUnitData[var_150_5] and var_150_4 >= self._mapMarchUnitData[var_150_5].endTime then
		self:deleteMarchUnit(var_150_5)
	end

	local var_150_6 = var_0_26(var_150_0.id, var_0_25(var_150_0.end_pos.x, var_150_0.end_pos.y), var_0_25(var_150_2.x, var_150_2.y))

	if self._mapMarchUnitData[var_150_6] then
		self:deleteMarchUnit(var_150_6)
	end

	if (var_150_0.cancel_time or 0) > 0 and self._mapMarchUnitData[var_150_5] then
		self:deleteMarchUnit(var_150_5)

		self._refreshMarch = true
	end

	if self._mapMarchUnitData[var_150_5] then
		return
	end

	local var_150_7 = self:_genMarchUnit(var_150_0, var_150_1, arg_150_2)

	if var_150_7 then
		self._refreshMarch = true
		self._mapMarchUnitData[var_150_5] = var_150_7
	end
end

function NewSlgData:setRefreshMarch(arg_151_1)
	self._refreshMarch = arg_151_1
end

function NewSlgData:getRefreshMarch()
	return self._refreshMarch
end

function NewSlgData:getMarchUnit()
	return self._mapMarchUnitData
end

function NewSlgData:deleteMarchUnit(arg_154_1)
	self._mapMarchUnitData[arg_154_1] = nil
end

function NewSlgData:setMarchUnitEnd(arg_155_1)
	if self._mapMarchUnitData[arg_155_1] then
		self._mapMarchUnitData[arg_155_1].isPathEnd = true
	end
end

function NewSlgData:_initAllianceData()
	self._allianceSerData = {}
end

function NewSlgData:_updateAllianceSerData(arg_157_1)
	if not arg_157_1 then
		return
	end

	local var_157_0 = {}

	var_157_0.bornPID = arg_157_1.born_province or 0
	var_157_0.fightCityIds = arg_157_1.attacking_city or {}
	var_157_0.occupied_point = arg_157_1.occupied_point or 0
	var_157_0.daily_atk_point = arg_157_1.daily_atk_point or 0
	var_157_0.daily_occupied_point = arg_157_1.daily_occupied_point or 0
	self._allianceSerData = var_157_0

	self:_setOccupiedCityId(arg_157_1.occupied_city)
	self:updateCheckPointTask(arg_157_1.checkpoint_quests or {}, true)
	self:updateCityQuestProgressSerData(arg_157_1.city_progress or {}, true)
end

function NewSlgData:_setOccupiedCityId(arg_158_1)
	if arg_158_1 then
		if type(arg_158_1) == "table" then
			self._allianceSerData.occupiedCityId = arg_158_1[1] or 0
			self._allianceSerData.occupiedCities = arg_158_1
		elseif type(arg_158_1) == "number" then
			self._allianceSerData.occupiedCityId = arg_158_1
		end
	else
		self._allianceSerData.occupiedCityId = 0
		self._allianceSerData.occupiedCities = {}
	end
end

function NewSlgData:getAllianceData()
	return self._allianceSerData
end

function NewSlgData:getOccupiedCities()
	if type(self._allianceSerData.occupiedCities) == "table" then
		return self._allianceSerData.occupiedCities
	elseif type(self._allianceSerData.occupiedCities) == "number" then
		return {
			self._allianceSerData.occupiedCities
		}
	end

	return {}
end

function NewSlgData:_initTeamData()
	self._teamAuthorityGroupMap = nil
	self._myTeamMap = {}
	self._maxTeamAuthority = 4000
end

function NewSlgData:updateMyTeamData(arg_162_1)
	self._targetPosArr = {}

	if arg_162_1 and #arg_162_1 > 0 then
		for iter_162_0, iter_162_1 in ipairs(arg_162_1) do
			if iter_162_1.index and iter_162_1.index ~= 0 then
				self._myTeamMap[iter_162_1.index] = iter_162_1

				self:correctTeamTroopLevel(iter_162_1)

				if iter_162_1.boss_team_id ~= 0 and iter_162_1.status ~= var_0_28.TEAM_STATUS_TYPE.RETURN then
					table.insert(self._targetPosArr, iter_162_1.target_point)
				end
			end
		end
	end
end

function NewSlgData:formatTeamCharactersByTeam(arg_163_1)
	if arg_163_1 then
		arg_163_1.characters = self:formatTeamCharacters(arg_163_1.characters)
	end
end

function NewSlgData:formatTeamCharacters(arg_164_1)
	local var_164_0 = {}

	if arg_164_1 and #arg_164_1 > 0 then
		local var_164_1 = {}

		for iter_164_0, iter_164_1 in ipairs(arg_164_1) do
			if iter_164_1.tp == g.core.common.Goods.TYPE_KNIGHT then
				table.insert(var_164_0, iter_164_1)
			else
				table.insert(var_164_1, iter_164_1)
			end
		end

		if #var_164_1 > 0 then
			table.sort(var_164_1, function(arg_165_0, arg_165_1)
				return arg_165_0.tp < arg_165_1.tp
			end)

			for iter_164_2, iter_164_3 in ipairs(var_164_1) do
				table.insert(var_164_0, iter_164_3)
			end
		end
	end

	return var_164_0
end

function NewSlgData:correctTeamTroopLevel(arg_166_1)
	if not arg_166_1.troop_type or arg_166_1.troop_type == 0 then
		arg_166_1.troop_type = var_0_28.ARMY_TYPE.QI
	end

	arg_166_1.troop_level = g.core.model.User.newSlgDevelopData:getBarrackLvByType(arg_166_1.troop_type)
end

function NewSlgData:getMyTeamMap()
	return self._myTeamMap
end

function NewSlgData:getMyTeamByIndex(arg_168_1)
	return self._myTeamMap[arg_168_1]
end

function NewSlgData:getMyTeamByArmyType(arg_169_1)
	for iter_169_0, iter_169_1 in pairs(self._myTeamMap) do
		if iter_169_1.troop_type == arg_169_1 then
			return iter_169_1
		end
	end
end

function NewSlgData:isAllTeamIdle()
	for iter_170_0, iter_170_1 in pairs(self._myTeamMap) do
		if not self:isTeamIdle(iter_170_1) then
			return false
		end
	end

	return true
end

function NewSlgData:isTeamIdle(arg_171_1)
	if arg_171_1 then
		return arg_171_1.status == var_0_28.TEAM_STATUS_TYPE.NONE
	end

	return false
end

function NewSlgData:isTeamMove(arg_172_1)
	if arg_172_1 then
		return arg_172_1.status == var_0_28.TEAM_STATUS_TYPE.MOVE
	end

	return false
end

function NewSlgData:isTeamReturn(arg_173_1)
	if arg_173_1 then
		return arg_173_1.status == var_0_28.TEAM_STATUS_TYPE.RETURN
	end

	return false
end

function NewSlgData:getArmyRestInfoByType(arg_174_1)
	for iter_174_0, iter_174_1 in var_0_14.ipairs() do
		if iter_174_1.army_type == arg_174_1 then
			return iter_174_1
		end
	end
end

function NewSlgData:getTeamAuthorityCfgByType(arg_175_1)
	if self._teamAuthorityGroupMap == nil then
		self._teamAuthorityGroupMap = {}

		for iter_175_0, iter_175_1 in var_0_13.ipairs() do
			if self._teamAuthorityGroupMap[iter_175_1.group_id] == nil then
				self._teamAuthorityGroupMap[iter_175_1.group_id] = {}
			end

			local var_175_0 = iter_175_1.type

			if self._teamAuthorityGroupMap[iter_175_1.group_id][iter_175_1.type] == nil then
				self._teamAuthorityGroupMap[iter_175_1.group_id][var_175_0] = {}
			end

			table.insert(self._teamAuthorityGroupMap[iter_175_1.group_id][var_175_0], iter_175_1)
		end
	end

	return self._teamAuthorityGroupMap[self._slgInfo.team_authority_group][arg_175_1] or {}
end

function NewSlgData:geTeamItemList(arg_176_1, arg_176_2)
	local var_176_0 = {}
	local var_176_1 = {}

	for iter_176_0, iter_176_1 in ipairs((self:getTeamAuthorityCfgByType(arg_176_1))) do
		local var_176_2 = g.core.common.Goods.CFG[arg_176_1].get(iter_176_1.cards_id)
		local var_176_3 = g.core.common.GlobalFunc.getItemAdvIdByInfo(arg_176_1, var_176_2)

		if var_176_0[var_176_3] == nil then
			local var_176_4 = g.core.common.GlobalFunc.getStructByTypeAndValue(arg_176_1, var_176_3)

			if var_176_4 and var_176_4:isOwn() then
				var_176_0[var_176_3] = {
					struct = var_176_4,
					info = var_176_2,
					sid = g.core.common.GlobalFunc.getSerIdByTypeAndStruct(arg_176_1, var_176_4)
				}

				if var_176_4:getId() == iter_176_1.cards_id then
					var_176_0[var_176_3].authority = iter_176_1.authority_value
				end
			end
		elseif var_176_0[var_176_3].struct and var_176_0[var_176_3].struct:getId() == iter_176_1.cards_id then
			var_176_0[var_176_3].authority = iter_176_1.authority_value
		end
	end

	for iter_176_2, iter_176_3 in pairs(var_176_0) do
		table.insert(var_176_1, iter_176_3)
	end

	table.sort(var_176_1, function(arg_177_0, arg_177_1)
		if arg_176_2 and (arg_176_2[arg_177_0.sid] or arg_176_2[arg_177_1.sid]) then
			if arg_176_2[arg_177_0.sid] and arg_176_2[arg_177_1.sid] then
				if arg_176_2[arg_177_0.sid] ~= arg_176_2[arg_177_1.sid] then
					return arg_176_2[arg_177_0.sid] < arg_176_2[arg_177_1.sid]
				end
			else
				return arg_176_2[arg_177_0.sid]
			end
		end

		if arg_177_0.authority ~= arg_177_1.authority then
			return arg_177_0.authority > arg_177_1.authority
		end

		if arg_177_0.info.quality ~= arg_177_1.info.quality then
			return arg_177_0.info.quality > arg_177_1.info.quality
		end

		if arg_177_0.info.star ~= arg_177_1.info.star then
			return arg_177_0.info.star > arg_177_1.info.star
		end

		return arg_177_0.info.id > arg_177_1.info.id
	end)

	return var_176_1
end

function NewSlgData:getInitTeamData(arg_178_1)
	return {
		base_authority = 0,
		troops = 0,
		index = arg_178_1,
		uid = g.core.model.User:getId(),
		troop_type = var_0_28.ARMY_TYPE.QI,
		status = var_0_28.TEAM_STATUS_TYPE.NONE,
		troop_level = g.core.model.User.newSlgDevelopData:getBarrackLvByType(var_0_28.ARMY_TYPE.QI),
		source = var_0_28.TEAM_SOURCE_TYPE.CITY_DEVELOP_SOURCE
	}
end

function NewSlgData:getTeamAuthority(arg_179_1, arg_179_2)
	return math.floor(arg_179_1 * (1 + arg_179_2 / 10000))
end

function NewSlgData:getItemAuthorityByTypeAndBId(arg_180_1, arg_180_2)
	for iter_180_0, iter_180_1 in ipairs((self:getTeamAuthorityCfgByType(arg_180_1))) do
		if iter_180_1.cards_id == arg_180_2 then
			return iter_180_1.authority_value
		end
	end

	return 0
end

function NewSlgData:getItemAuthorityByCharacter(arg_181_1)
	if arg_181_1 then
		if arg_181_1.id then
			local var_181_0 = g.core.common.GlobalFunc.getStructByTypeAndSerId(arg_181_1.tp, arg_181_1.id)

			if not var_181_0 then
				return 0
			end

			return self:getItemAuthorityByTypeAndBId(arg_181_1.tp, var_181_0:getCfg().id)
		end
	end

	return 0
end

function NewSlgData:getTeamAuthorityByTeam(arg_182_1)
	if arg_182_1 then
		local var_182_0 = 0
		local var_182_1 = {}

		for iter_182_0, iter_182_1 in ipairs(arg_182_1.characters or {}) do
			var_182_0 = var_182_0 + self:getItemAuthorityByCharacter(iter_182_1)

			if iter_182_1.tp == g.core.common.Goods.TYPE_KNIGHT then
				local var_182_2 = g.core.common.GlobalFunc.getStructByTypeAndSerId(iter_182_1.tp, iter_182_1.id)

				if var_182_2 then
					local var_182_3 = var_182_2:getBaseInfo().classical

					if var_182_3 ~= 0 then
						var_182_1[#var_182_1 + 1] = var_182_3
					end
				end
			end
		end

		local var_182_4 = var_182_0 + g.core.model.User.newSlgDevelopData:getBarrackAuthorityByType(arg_182_1.troop_type)
		local var_182_5, var_182_6 = self:getTeamElementTypeAndAffectValue(var_182_1)

		if var_182_5 ~= 0 then
			for iter_182_2, iter_182_3 in ipairs(var_182_6) do
				var_182_4 = var_182_4 + iter_182_3.value
			end
		end

		return self:getTeamAuthority(g.core.model.User.newSlgDevelopData:getTotalAuthority(), var_182_4)
	end

	return 0
end

function NewSlgData:getMyTeamAuthorityByIndex(arg_183_1)
	return self:getTeamAuthorityByTeam(self:getMyTeamMap()[arg_183_1])
end

function NewSlgData:getMyTeamAllAuthority()
	local var_184_0 = 0
	local var_184_1 = self:getMyTeamMap()
	local var_184_2 = g.core.model.User.newSlgDevelopData:getUnlockTeamNum() + self:getUnlockPassCardTeamNum()

	for iter_184_0 = 1, self._teamCurCnt do
		if iter_184_0 <= var_184_2 then
			team = var_184_1[iter_184_0] or self:getInitTeamData(iter_184_0)
			var_184_0 = var_184_0 + g.core.model.User.newSlgData:getTeamAuthorityByTeam(team)
		end
	end

	return var_184_0
end

function NewSlgData:getTeamMoveToChariot()
	for iter_185_0, iter_185_1 in ipairs((self:getMyTeamMap())) do
		if self:isTeamMove(iter_185_1) and iter_185_1.target_type == var_0_28.MONSTER_TYPE.CITY then
			return iter_185_1
		end
	end

	return nil
end

function NewSlgData:getTeamMoveStatusByIndex(arg_186_1)
	return self:getTeamMoveStatusByTeam(self:getMyTeamMap()[arg_186_1])
end

function NewSlgData:getReachDestLeftTime(arg_187_1, arg_187_2, arg_187_3, arg_187_4)
	local var_187_0 = g.core.common.ServerTime:getTime()
	local var_187_1 = arg_187_2 + NewSlgFunc.getMarchDurationByPath(arg_187_1, arg_187_3, arg_187_4)

	if var_187_0 < var_187_1 then
		return var_187_1 - var_187_0
	end

	return 0
end

function NewSlgData:isReachDest(arg_188_1, arg_188_2, arg_188_3, arg_188_4)
	return self:getReachDestLeftTime(arg_188_1, arg_188_2, arg_188_3, arg_188_4) == 0
end

function NewSlgData:getLeftMarchTimeWithoutReturn(arg_189_1)
	if not arg_189_1 then
		return 0
	end

	if arg_189_1.cancel_time ~= 0 then
		return 0
	end

	return math.max(arg_189_1.start_time + NewSlgFunc.getMarchDurationByPath(self:getPath(arg_189_1.start_pos, arg_189_1.end_pos), arg_189_1.move_privilege or 0, arg_189_1.move_action_type) - g.core.common.ServerTime:getTime(), 0)
end

function NewSlgData:calMoveLeftTime(arg_190_1)
	if not arg_190_1 then
		return 0
	end

	if arg_190_1.robot_info_id > 0 then
		return math.max(0, arg_190_1.join_time + arg_190_1.robot_move_duration - g.core.common.ServerTime:getTime())
	else
		return self:getLeftMarchTimeWithoutReturn(arg_190_1.team.move)
	end
end

function NewSlgData:getTeamStateByTeam(arg_191_1)
	if arg_191_1 == nil then
		return
	end

	local var_191_0 = 0
	local var_191_1 = 0
	local var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.UNKNOWN
	local var_191_3
	local var_191_4 = ""
	local var_191_6 = arg_191_1
	local var_191_7 = arg_191_1.target_type or var_0_28.MONSTER_TYPE.NONE
	local var_191_8 = var_191_6.target_point
	local var_191_9 = 0

	if var_191_6.status ~= var_0_28.TEAM_STATUS_TYPE.NONE and var_191_6.move and var_191_6.move.start_pos and var_191_6.move.end_pos then
		local var_191_10 = cc.p(var_191_6.move.start_pos.x, var_191_6.move.start_pos.y)
		local var_191_11 = cc.p(var_191_6.move.end_pos.x, var_191_6.move.end_pos.y)

		var_191_0 = var_191_6.move.start_time

		local var_191_12 = var_191_6.move.start_time
		local var_191_13 = self:getPath(var_191_10, var_191_11)
		local var_191_14 = var_191_6.move.cancel_time or 0
		local var_191_15, var_191_16, var_191_17 = self:getDestTargetInfo(var_191_11)
		local var_191_18 = var_191_6.move.move_privilege or 0
		local var_191_19 = var_191_6.target_type

		if var_191_14 == 0 and self:isReachDest(var_191_13, var_191_12, var_191_18, var_191_6.move.move_action_type) then
			if var_191_15 > 0 then
				if var_191_19 == var_0_28.MONSTER_TYPE.MONSTER then
					var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.FIGHTING
					var_191_4 = g.core.lang:get(428832, {
						level = var_191_15,
						name = var_191_16
					})
				elseif var_191_19 == var_0_28.MONSTER_TYPE.CITY then
					if self:isChariotGatherTime() then
						var_191_0 = self:getChariotGatherStartTime()
						var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
						var_191_3 = var_0_28.TEAM_CLIENT_STATUS1_TYPE.CITY_ASSEMBLE
						var_191_4 = g.core.lang:get(429035, {
							level = var_191_15,
							name = var_191_16
						})
						var_191_1 = self:getChariotGatherTotalTime()
					elseif self:isChariotMoveTime() then
						var_191_0 = self:getChariotMoveTimeStartTime()
						var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
						var_191_4 = not self:isCityOccupied(var_191_17) and g.core.lang:get(428836) or g.core.lang:get(429057)
						var_191_1 = self:getChariotMoveTotalTime()
					else
						var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.FIGHTING
						var_191_4 = g.core.lang:get(428832, {
							level = var_191_15,
							name = var_191_16
						})
					end
				elseif var_191_19 == var_0_28.MONSTER_TYPE.BOSS then
					local var_191_20 = self:getBossTeamInfo(var_191_6.boss_team_id)

					if var_191_20 then
						var_191_0 = var_191_6.boss_team_create_time or 0

						if var_191_20.state == var_0_28.SLGBossTeamState.STATE_2 then
							var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.FIGHTING
							var_191_4 = g.core.lang:get(428837, {
								level = var_191_15,
								name = var_191_16
							})
						else
							var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
							var_191_4 = g.core.lang:get(428838, {
								level = var_191_15,
								name = var_191_16
							})
							var_191_3 = var_0_28.TEAM_CLIENT_STATUS1_TYPE.BOSS_ASSEMBLE
							var_191_1 = self:getBossTeamGatherTotalTime()
						end
					end
				elseif var_191_19 == var_0_28.MONSTER_TYPE.FARM then
					var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
					var_191_0 = var_191_6.farm_win_start_time
					var_191_1 = 0
					var_191_4 = g.core.lang:get(429704, {
						level = var_191_15,
						name = var_191_16
					})

					local var_191_21 = g.core.lang:get(429703)

					var_191_3 = var_0_28.TEAM_CLIENT_STATUS1_TYPE.FARMING
					var_191_9 = var_191_6.farm_win_start_time
				end
			end

			return {
				isReachDest = true,
				state = var_191_2,
				startTime = var_191_0,
				totalTime = var_191_1,
				text = var_191_4,
				monsterType = var_191_7,
				teamId = var_191_6.boss_team_id,
				targetPoint = var_191_8,
				state1 = var_191_3,
				move = var_191_6.move,
				targetId = var_191_17,
				farmTime = var_191_9
			}
		end

		if var_191_6.status == var_0_28.TEAM_STATUS_TYPE.RETURN or var_191_14 > 0 then
			var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.RETURNING
			var_191_4 = g.core.lang:get(428833)
		else
			if var_191_19 == var_0_28.MONSTER_TYPE.FARM then
				var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
				var_191_4 = g.core.lang:get(429702, {
					name = var_191_16
				})
			end

			if var_191_15 > 0 then
				if var_191_19 == var_0_28.MONSTER_TYPE.CITY then
					var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
					var_191_4 = g.core.lang:get(429036, {
						level = var_191_15,
						name = var_191_16
					})
				else
					var_191_2 = var_0_28.TEAM_CLIENT_STATUS_TYPE.MARCHING
					var_191_4 = g.core.lang:get(428831, {
						level = var_191_15,
						name = var_191_16
					})
				end
			end
		end

		local var_191_22 = NewSlgFunc.getMarchDurationByPath(var_191_13, var_191_18, var_191_19)

		var_191_1 = var_191_22

		if var_191_14 > 0 then
			local var_191_23 = 1

			if var_191_13 and #var_191_13 > 1 then
				var_191_23 = var_191_22 / (#var_191_13 - 1)
				var_191_23 = math.max(var_191_22 / (#var_191_13 - 1), 1)
			end

			local var_191_24 = var_191_14 - var_191_12

			if var_191_22 <= var_191_14 - var_191_12 then
				var_191_0 = var_191_12

				return {
					state = var_191_2,
					startTime = var_191_12,
					totalTime = var_191_1,
					text = var_191_4,
					monsterType = var_191_7,
					move = var_191_6.move
				}
			end

			local var_191_25 = math.ceil(var_191_24 / var_191_23)

			if var_191_13 and var_191_13[var_191_25 + 1] then
				var_191_13 = self:getPath(var_191_13[var_191_25 + 1], var_191_10)
			end

			local var_191_26 = NewSlgFunc.getMarchDurationByPath(var_191_13, var_191_18, var_191_19)

			var_191_1 = var_191_26

			local var_191_27 = 1

			if var_191_13 and #var_191_13 > 1 then
				var_191_27 = var_191_26 / (#var_191_13 - 1)
				var_191_27 = math.max(var_191_26 / (#var_191_13 - 1), 1)
			end

			var_191_0 = var_191_14 - (var_191_12 + var_191_25 * var_191_27 - var_191_14)
		end
	end

	return {
		state = var_191_2,
		startTime = var_191_0,
		totalTime = var_191_1,
		text = var_191_4,
		monsterType = var_191_7,
		teamId = var_191_6.boss_team_id,
		move = var_191_6.move
	}
end

function NewSlgData:getMyPrivilegePer()
	return self._movePrivilegePer
end

function NewSlgData:getMaxTeamAuthority()
	return self._maxTeamAuthority
end

function NewSlgData:getCommonPassCardActId()
	return self._commonPassCardActId
end

function NewSlgData:getArmyCtrlByType(arg_195_1)
	for iter_195_0, iter_195_1 in g.core.config.new_slg_army_info.ipairs() do
		if iter_195_1.army_type == arg_195_1 then
			for iter_195_2 = 1, 3 do
				if iter_195_1["value" .. iter_195_2] > 0 then
					return iter_195_2, iter_195_1.des, iter_195_1["value" .. iter_195_2]
				end
			end
		end
	end
end

function NewSlgData:getDebuffArmyCtrlByType(arg_196_1)
	for iter_196_0, iter_196_1 in g.core.config.new_slg_army_info.ipairs() do
		if iter_196_1["value" .. arg_196_1] > 0 then
			return iter_196_1.army_type
		end
	end
end

function NewSlgData:_initBattleData()
	self._battleReportMap = {}
	self._battleDataMap = {}
	self._hasBattleResultData = false
	self._battleResult = {}
	self._battleResultReceiveSet = {}
	self._battleReportTimers = {}
	self._hasBattleUnAward = false
	self._hasBattleResultRedPoint = false
end

function NewSlgData:clearBattleReportTimer()
	return
end

function NewSlgData:saveBattleReport(arg_199_1, arg_199_2, arg_199_3)
	if g.core.common.ServerTime:getTime() > arg_199_2.end_tm then
		return
	end

	local var_199_0 = self:getBattleReportKey(arg_199_1, arg_199_2.def_id, arg_199_2.def_axis)

	if var_199_0 == nil then
		return
	end

	local var_199_1 = self._battleReportMap[var_199_0] or {}

	self:addReportExtraData(arg_199_2)
	table.insert(var_199_1, arg_199_2)
	table.sort(var_199_1, function(arg_200_0, arg_200_1)
		return arg_200_0.start_tm < arg_200_1.start_tm
	end)

	self._battleReportMap[var_199_0] = var_199_1

	if config.DEBUG_VERSION and not arg_199_3 then
		self:exportRealBattleData(arg_199_1, arg_199_2)
	end
end

function NewSlgData:addReportExtraData(arg_201_1)
	local var_201_0 = {}
	local var_201_1 = {}
	local var_201_2 = {}

	for iter_201_0, iter_201_1 in ipairs(arg_201_1.battles or {}) do
		table.insert(var_201_1, iter_201_1)
	end

	for iter_201_2, iter_201_3 in ipairs(arg_201_1.battles2 or {}) do
		table.insert(var_201_1, iter_201_3)
	end

	for iter_201_4, iter_201_5 in ipairs(arg_201_1.atk_teams or {}) do
		table.insert(var_201_2, iter_201_5)
	end

	for iter_201_6, iter_201_7 in ipairs(arg_201_1.def_teams or {}) do
		table.insert(var_201_2, iter_201_7)
	end

	for iter_201_8, iter_201_9 in ipairs(var_201_2) do
		var_201_0[iter_201_9.team_id] = iter_201_9.troops or 0
	end

	for iter_201_10, iter_201_11 in ipairs(var_201_1) do
		local var_201_3 = var_201_0[iter_201_11.atk_team] or 0
		local var_201_4 = var_201_0[iter_201_11.def_team] or 0
		local var_201_5 = iter_201_11.troops_dec or 0
		local var_201_6 = iter_201_11

		var_201_6.atk_init_troops = var_201_3
		var_201_6.def_init_troops = var_201_4

		if iter_201_11.is_win then
			var_201_0[iter_201_11.atk_team] = var_201_3 - var_201_5
			var_201_0[iter_201_11.def_team] = 0
		else
			var_201_0[iter_201_11.atk_team] = 0
			var_201_0[iter_201_11.def_team] = var_201_4 - var_201_5
		end
	end
end

function NewSlgData:getBattleReportKey(arg_202_1, arg_202_2, arg_202_3)
	local var_202_0 = 0
	local var_202_1 = 0

	if arg_202_1 == var_0_28.BATTLE_TYPE.CITY then
		local var_202_2 = self:getCityComponentById(arg_202_2)

		if var_202_2 == nil then
			return
		end

		var_202_0 = var_202_2.anchor_x
		var_202_1 = var_202_2.anchor_y
	elseif arg_202_1 == var_0_28.BATTLE_TYPE.BOSS then
		local var_202_3 = self:getBossComponentById(arg_202_2)

		if var_202_3 == nil then
			return
		end

		var_202_0 = var_202_3.anchor_x
		var_202_1 = var_202_3.anchor_y
	elseif arg_202_1 == var_0_28.BATTLE_TYPE.MONSTER then
		var_202_0 = arg_202_3.x
		var_202_1 = arg_202_3.y
	end

	return string.format("%s-%s-%s-%s", arg_202_1, var_202_0, var_202_1, arg_202_2)
end

function NewSlgData:exportRealBattleData(arg_203_1, arg_203_2)
	local var_203_0

	if arg_203_1 == var_0_28.BATTLE_TYPE.MONSTER then
		var_203_0 = "Monster"
	elseif arg_203_1 == var_0_28.BATTLE_TYPE.BOSS then
		var_203_0 = "Boss"
	elseif arg_203_1 == var_0_28.BATTLE_TYPE.CITY then
		var_203_0 = "City"
	end

	local var_203_1 = g.core.common.ServerTime:getTime()
	local var_203_2 = string.format("simulate_battle_%s.json", var_203_1)

	if var_203_0 then
		var_203_2 = string.format("%s_battle_%s.json", var_203_0, var_203_1)
	end

	local var_203_3 = lfs.currentdir() .. "/new_slg_battle_report"
	local var_203_4

	if not cc.FileUtils:getInstance():isFileExist(var_203_3) then
		lfs.mkdir(var_203_3)

		var_203_4 = io.open(var_203_3 .. "/" .. var_203_2, "w")
	end

	var_203_4:write((json.encode(arg_203_2)))
	var_203_4:close()
end

function NewSlgData:getBattleReportData(arg_204_1, arg_204_2, arg_204_3)
	local var_204_0 = g.core.common.ServerTime:getTime()

	for iter_204_0, iter_204_1 in pairs(self._battleReportMap) do
		for iter_204_2 = #iter_204_1, 1, -1 do
			if var_204_0 >= iter_204_1[iter_204_2].end_tm then
				table.remove(iter_204_1, iter_204_2)
			end
		end

		if #self._battleReportMap[iter_204_0] <= 0 then
			self._battleReportMap[iter_204_0] = nil
		end
	end

	for iter_204_3, iter_204_4 in pairs(self._battleDataMap) do
		for iter_204_5 = #iter_204_4, 1, -1 do
			if var_204_0 >= iter_204_4[iter_204_5].battleEndTime then
				table.remove(iter_204_4, iter_204_5)
			end
		end

		if #self._battleDataMap[iter_204_3] <= 0 then
			self._battleDataMap[iter_204_3] = nil
		end
	end

	local var_204_1 = self:getBattleReportKey(arg_204_1, arg_204_2, arg_204_3)

	if var_204_1 == nil then
		return
	end

	if self._battleDataMap[var_204_1] then
		return self._battleDataMap[var_204_1][1]
	end

	local var_204_2 = self._battleReportMap[var_204_1]

	if self._battleReportMap[var_204_1] == nil then
		return
	end

	local var_204_3 = require("app.view.module.slg.model.NewSlgReportStruct").new(var_204_2[1])

	if self._battleDataMap[var_204_1] then
		table.insert(self._battleDataMap[var_204_1], var_204_3)
	else
		self._battleDataMap[var_204_1] = {
			var_204_3
		}
	end

	return var_204_3
end

function NewSlgData:updateBattleMonsterReport(arg_205_1)
	if arg_205_1 and arg_205_1.report then
		self:saveBattleReport(var_0_28.BATTLE_TYPE.MONSTER, arg_205_1.report)
	end
end

function NewSlgData:updateBattleFarmReport(arg_206_1)
	if arg_206_1 and arg_206_1.report then
		self:saveBattleReport(var_0_28.BATTLE_TYPE.FARM, arg_206_1.report)
	end
end

function NewSlgData:getBattleWinPercent(arg_207_1, arg_207_2, arg_207_3, arg_207_4, arg_207_5)
	local var_207_1, var_207_2, var_207_3 = self:getArmyCtrlByType(arg_207_3)

	return (self._parameterInfo.battle_parameter_5 / 10000 * math.pow(arg_207_2, self._parameterInfo.battle_parameter_6 / 10000) + self._parameterInfo.battle_parameter_7 / 10000 * arg_207_2 + self._parameterInfo.battle_parameter_8 / 10000) * (1 + ((var_207_1 == arg_207_4 or nil) and var_207_3) / 10000) * math.pow(self._parameterInfo.battle_parameter_1 / 10000 * math.pow(arg_207_1, self._parameterInfo.battle_parameter_2 / 10000) + self._parameterInfo.battle_parameter_3 / 10000 * arg_207_1 + self._parameterInfo.battle_parameter_4 / 10000, self._parameterInfo.battle_parameter_9 / 10000)
end

function NewSlgData:_initDevelopData()
	return
end

function NewSlgData:_updateDevelopData(arg_209_1)
	g.core.model.User.newSlgDevelopData:updateDevelopData(arg_209_1)
end

function NewSlgData:getAuthorityGroupId()
	return (self._slgInfo or nil) and (self._slgInfo.authority_group or 1)
end

function NewSlgData:getMainCityGroupId()
	return (self._slgInfo or nil) and (self._slgInfo.main_city_group or 1)
end

function NewSlgData:getBarrackGroupId()
	return (self._slgInfo or nil) and (self._slgInfo.barrack_group or 1)
end

function NewSlgData:getSupplyGroupId()
	return (self._slgInfo or nil) and (self._slgInfo.supply_group or 1)
end

function NewSlgData:_initCityData()
	self._citySerData = {}
	self._lastCityId = 0
	self._infiniteCityId = 0
	self._cityIdsByPID = {}
	self.checkCityFloat = false
	self.shareCityTime = 0
	self.gatherCityRedPoint = false
	self._cityStartAttackTime = 0
	self._cityEndAttackTime = 0
	self._cityChariotsMap = {}
end

function NewSlgData:updateCityChariots(arg_215_1, arg_215_2)
	self._cityChariotsMap[arg_215_2] = {}

	for iter_215_0, iter_215_1 in ipairs(arg_215_1 or {}) do
		table.insert(self._cityChariotsMap[arg_215_2], iter_215_1)
	end
end

function NewSlgData:getCityChariots(arg_216_1)
	return self._cityChariotsMap[arg_216_1] or {}
end

function NewSlgData:getNearPos(arg_217_1, arg_217_2)
	local var_217_0 = self:getCityComponentById(arg_217_1)
	local var_217_1 = self:getChariotComponentById(arg_217_1, arg_217_2)
	local var_217_2 = cc.p(var_217_1.anchor_x, var_217_1.anchor_y)
	local var_217_3 = cc.p(var_217_0.anchor_x, var_217_0.anchor_y)

	for iter_217_0, iter_217_1 in ipairs(self:getObjectDataByRC(var_217_0.anchor_x, var_217_0.anchor_y).includeRC) do
		local var_217_4 = math.pow(math.abs(iter_217_1.x - var_217_2.x), 2) + math.pow(math.abs(iter_217_1.y - var_217_2.y), 2)
		local var_217_5

		if 0 == 0 or var_217_4 < 0 then
			var_217_5 = var_217_4
			var_217_3 = iter_217_1
		end
	end

	return var_217_3
end

function NewSlgData:getCityFloatInfo()
	local var_218_0 = {}

	for iter_218_0, iter_218_1 in ipairs((self:getNextAttackCityIds())) do
		if iter_218_1 > 0 then
			local var_218_1 = self:getCityInfoById(iter_218_1)

			if self:isCityPointUnlock(iter_218_1) then
				if self:isChariotGatherTime() then
					table.insert(var_218_0, {
						startTime = self:getChariotGatherStartTime(),
						totalTime = self:getChariotGatherTotalTime(),
						compId = self:getCityComponentById(iter_218_1).id,
						desc = g.core.lang:get(428883, {
							name = var_218_1.name
						})
					})
				elseif self:isChariotAboutAttackTime(iter_218_1) then
					table.insert(var_218_0, {
						compId = self:getCityComponentById(iter_218_1).id,
						desc = g.core.lang:get(428885, {
							name = var_218_1.name
						})
					})
				end
			else
				local var_218_2, var_218_3 = self:getCheckPointTaskCurVArr((self:getCheckPointInfoById(var_218_1.unlock_quest)))

				table.insert(var_218_0, {
					progress = var_218_2,
					goal = var_218_3,
					compId = self:getGateComponentsById(var_218_1.unlock_quest)[1].id,
					desc = g.core.lang:get(428901)
				})
			end
		end
	end

	if self._hasBattleResultRedPoint then
		table.insert(var_218_0, {
			desc = g.core.lang:get(428902)
		})
	end

	return var_218_0
end

function NewSlgData:reqCityBattleEnd(arg_219_1)
	if not arg_219_1 then
		return
	end

	local var_219_0 = arg_219_1.result

	if arg_219_1.result then
		if var_219_0.city_battle_result and var_219_0.city_battle_result.is_win and var_219_0.city_battle_result.city_id and var_219_0.city_battle_result.city_id > 0 then
			self:_setOccupiedCityId(var_219_0.city_battle_result.city_id)
		end
	end
end

function NewSlgData:updateCitySerData(arg_220_1, arg_220_2)
	arg_220_1 = arg_220_1 or {}

	if arg_220_2 then
		self._citySerData = {}
	end

	for iter_220_0, iter_220_1 in ipairs(arg_220_1) do
		self._citySerData[iter_220_1.city_id] = self:_updateCitySerDataUnit(iter_220_1)

		self:setCityDeclaration(iter_220_1.city_id, iter_220_1.declaration)
	end
end

function NewSlgData:_updateCitySerDataUnit(arg_221_1)
	local var_221_0 = {
		id = arg_221_1.city_id
	}

	var_221_0.defTroopNum = arg_221_1.def_num or 0
	var_221_0.report = arg_221_1.report

	if var_221_0.report then
		self:saveBattleReport(var_0_28.BATTLE_TYPE.CITY, var_221_0.report)
	end

	self:updateCityChariots(arg_221_1.cars, var_221_0.id)

	local var_221_1 = self:getCityChariots(var_221_0.id)

	if var_221_1 and #var_221_1 > 0 then
		var_221_0.chariotFightValue = var_221_1[1].car_fv or 0
		var_221_0.gatherNum = var_221_1[1].car_gather or 0
	else
		var_221_0.chariotFightValue = 0
		var_221_0.gatherNum = 0
	end

	return var_221_0
end

function NewSlgData:getCitySerData(arg_222_1)
	local var_222_1 = var_0_22.fetch(arg_222_1)

	return self._citySerData[arg_222_1], (var_222_1 or nil) and self._cityElementMap[table.concat({
		var_222_1.group,
		var_222_1.random_group
	}, "_")]
end

function NewSlgData:getCityDistanceScore(arg_223_1)
	return
end

function NewSlgData:getLastCityInfo()
	if self._lastCityId ~= 0 then
		return self:getCityInfoById(self._lastCityId)
	end

	for iter_224_0, iter_224_1 in var_0_4.ipairs() do
		if self._slgInfo.city_group == iter_224_1.group_id and iter_224_1.type == var_0_28.CITY_TYPE.FINAL_DRAGON then
			self._lastCityId = iter_224_1.id

			return iter_224_1
		end
	end
end

function NewSlgData:getInfiniteCityInfo()
	if self._infiniteCityId ~= 0 then
		return self:getCityInfoById(self._infiniteCityId)
	end

	for iter_225_0, iter_225_1 in var_0_4.ipairs() do
		if self._slgInfo.city_group == iter_225_1.group_id and iter_225_1.type == var_0_28.CITY_TYPE.INFINITE_DRAGON then
			self._infiniteCityId = iter_225_1.id

			return iter_225_1
		end
	end
end

function NewSlgData:isLastCity(arg_226_1)
	return self:getCityInfoById(arg_226_1).type == var_0_28.CITY_TYPE.FINAL_DRAGON
end

function NewSlgData:isInfiniteCity(arg_227_1)
	return self:getCityInfoById(arg_227_1).type == var_0_28.CITY_TYPE.INFINITE_DRAGON
end

function NewSlgData:isNormalCity(arg_228_1)
	return self:getCityInfoById(arg_228_1).type == var_0_28.CITY_TYPE.NORMAL
end

function NewSlgData:getCityIdsByPID(arg_229_1)
	if arg_229_1 == 0 then
		return {}
	end

	if self._cityIdsByPID[arg_229_1] then
		return self._cityIdsByPID[arg_229_1]
	end

	local var_229_0 = self:getProvinceCfgById(arg_229_1)

	self._cityIdsByPID[arg_229_1] = {}

	for iter_229_0, iter_229_1 in ipairs({
		var_229_0.id,
		var_229_0.next,
		self:getProvinceCfgById(var_229_0.next).next
	}) do
		for iter_229_2, iter_229_3 in var_0_4.ipairs() do
			if self._slgInfo.city_group == iter_229_3.group_id and iter_229_3.city_state == iter_229_1 then
				var_0_35(self._cityIdsByPID[arg_229_1], iter_229_3.id)
			end
		end
	end

	return self._cityIdsByPID[arg_229_1]
end

function NewSlgData:isCityOccupied(arg_230_1)
	if self:isInfiniteCity(arg_230_1) then
		return false
	end

	local var_230_0 = self:getAllianceData()

	if table.contain(self:getCityIdsByPID(var_230_0.bornPID or 0), arg_230_1) and arg_230_1 <= (var_230_0.occupiedCityId or 0) then
		return true
	end

	return false
end

function NewSlgData:isContainAttackCityId(arg_231_1)
	if table.contain(self:getCityIdsByPID(self:getAllianceData().bornPID or 0), arg_231_1) then
		return true
	end

	return false
end

function NewSlgData:getAssistTroopNum()
	return 0
end

function NewSlgData:isCityAssisted(arg_233_1)
	return false
end

function NewSlgData:getAssistCities()
	return {}
end

function NewSlgData:setAssistCities()
	return
end

function NewSlgData:getCityOccupyAlliance()
	return
end

function NewSlgData:isCityDeclared(arg_237_1)
	return false
end

function NewSlgData:isCityCanDeclare(arg_238_1)
	return false
end

function NewSlgData:getCityOccupyAllianceId(arg_239_1)
	if self:isCityOccupied(arg_239_1) then
		return var_0_2:getAllianceId()
	else
		return 0
	end
end

function NewSlgData:setCityDeclarations()
	return
end

function NewSlgData:getCityDeclaration(arg_241_1)
	return ""
end

function NewSlgData:setCityDeclaration(arg_242_1, arg_242_2)
	return
end

function NewSlgData:getMapId()
	return self._slgInfo.map
end

function NewSlgData:getNextIdWithoutJudge()
	local var_244_0 = self:getAllianceData()
	local var_244_1 = var_244_0.occupiedCityId or 0
	local var_244_2 = clone(self:getCityIdsByPID(var_244_0.bornPID or 0))
	local var_244_3 = table.indexof(var_244_2, var_244_1) or 0
	local var_244_4 = self:getLastCityInfo()
	local var_244_5 = self:getInfiniteCityInfo()
	local var_244_6 = table.indexof(var_244_2, var_244_4.id)

	if var_244_6 then
		table.remove(var_244_2, var_244_6)
	end

	local var_244_7 = table.indexof(var_244_2, var_244_5.id)

	if var_244_7 then
		table.remove(var_244_2, var_244_7)
	end

	local var_244_8 = var_244_1 >= var_244_2[#var_244_2]

	if self:isNewSlgLastDay() then
		return var_244_4.id
	else
		if var_244_1 == 0 then
			return var_244_2[1]
		end

		if var_244_8 then
			return var_244_5.id
		end
	end

	return var_244_2[math.min(var_244_3 + 1, #var_244_2)]
end

function NewSlgData:getNextAttackCityIds()
	if not g.core.model.User.allianceData:hasAlliance() then
		return {
			0
		}
	end

	if not self:isPlaying() then
		return {
			0
		}
	end

	local var_245_0 = self:getAllianceData()
	local var_245_1 = var_245_0.occupiedCityId or 0
	local var_245_2 = clone(self:getCityIdsByPID(var_245_0.bornPID or 0))
	local var_245_3 = table.indexof(var_245_2, var_245_1)
	local var_245_4 = self:getLastCityInfo()
	local var_245_5 = self:getInfiniteCityInfo()
	local var_245_6 = table.indexof(var_245_2, var_245_4.id)

	if var_245_6 then
		table.remove(var_245_2, var_245_6)
	end

	local var_245_7

	if var_245_5 and var_245_5.id then
		var_245_7 = table.indexof(var_245_2, var_245_5.id)
	end

	if var_245_7 then
		table.remove(var_245_2, var_245_7)
	end

	local var_245_8 = var_245_2[#var_245_2]

	if var_245_2[#var_245_2] == nil then
		return {
			0
		}
	end

	local var_245_9 = var_245_8 <= var_245_1

	if self:isNewSlgLastDay() then
		if var_245_9 and self:isCityPointUnlock(var_245_8) then
			if self:isCityDayUnlock(var_245_4.id) then
				return {
					var_245_4.id
				}
			else
				return {
					0
				}
			end
		end
	else
		if var_245_1 == 0 then
			return {
				var_245_2[1]
			}
		end

		if var_245_9 and self:isCityPointUnlock(var_245_8) then
			if self:isCityDayUnlock(var_245_5.id) then
				return {
					var_245_5.id
				}
			else
				return {
					0
				}
			end
		end

		if not var_245_3 then
			return {
				0
			}
		end

		local var_245_10 = var_245_2[var_245_3 + 1]

		if var_245_2[var_245_3 + 1] ~= nil then
			if self:isCityPointUnlock(var_245_1) and self:isCityDayUnlock(self:getCityInfoById(var_245_10).id) then
				return {
					var_245_10
				}
			end
		end
	end

	return {
		0
	}
end

function NewSlgData:isCityDayUnlock(arg_246_1)
	local var_246_0 = self:getCityInfoById(arg_246_1)

	if not var_246_0 then
		return false
	end

	local var_246_1 = self:getOpenDays()

	if var_246_0.unlock_time <= var_246_1 then
		return true
	end

	return false, var_246_0.unlock_time - var_246_1
end

function NewSlgData:isCityPointUnlock(arg_247_1)
	local var_247_0 = self:getCityInfoById(arg_247_1)

	if var_247_0.unlock_quest > 0 and self:getCheckPointState(var_247_0.unlock_quest) ~= var_0_28.CheckPointState.Passed then
		return false
	end

	return true
end

function NewSlgData:getDailyGatherTimeStr()
	local var_248_0 = math.floor(self._slgInfo.gather_time / 3600)
	local var_248_1 = math.floor(self._slgInfo.gather_time % 3600 / 60)

	if var_248_1 == 0 then
		var_248_1 = "00"
	end

	if var_248_0 < 10 then
		var_248_0 = "0" .. var_248_0
	end

	return (g.core.lang:get(428978, {
		hour = var_248_0,
		minute = var_248_1
	}))
end

function NewSlgData:isChariotAboutAttackTime(arg_249_1)
	local var_249_0 = g.core.common.ServerTime:getTime()
	local var_249_1 = self._cityStartAttackTime <= var_249_0 and var_249_0 <= self._cityEndAttackTime
	local var_249_2 = false

	if arg_249_1 == 0 then
		var_249_2 = false
	else
		local var_249_3 = self:getCityComponentById(arg_249_1)
		local var_249_4 = self:getBattleReportData(var_0_28.BATTLE_TYPE.CITY, arg_249_1, cc.p(var_249_3.anchor_x, var_249_3.anchor_y))

		if var_249_4 and var_249_4:inBattle() then
			var_249_2 = true
		end
	end

	return (var_249_1 or var_249_2) and self.gatherCityRedPoint
end

function NewSlgData:isChariotGatherTime()
	local var_250_0 = g.core.common.ServerTime:getTime()

	return var_250_0 >= self:getChariotGatherStartTime() and var_250_0 <= self:getChariotGatherEndTime()
end

function NewSlgData:getChariotGatherTotalTime()
	return self._slgInfo.attack_begin_time - self._slgInfo.gather_time
end

function NewSlgData:isChariotMoveTime()
	local var_252_0 = g.core.common.ServerTime:getTime()

	return var_252_0 >= self:getChariotMoveTimeStartTime() and var_252_0 <= self:getChariotMoveTimeEndTime()
end

function NewSlgData:getChariotGatherStartTime()
	return g.core.common.ServerTime:getTime() - g.core.common.ServerTime:secondsFromToday() + self._slgInfo.gather_time
end

function NewSlgData:getChariotGatherEndTime()
	return g.core.common.ServerTime:getTime() - g.core.common.ServerTime:secondsFromToday() + self._slgInfo.attack_begin_time
end

function NewSlgData:getChariotMoveTimeStartTime()
	return g.core.common.ServerTime:getTime() - g.core.common.ServerTime:secondsFromToday() + self._slgInfo.attack_begin_time
end

function NewSlgData:getChariotMoveTimeEndTime()
	return self:getChariotMoveTimeStartTime() + self:getChariotMoveTotalTime()
end

function NewSlgData:getChariotMoveTotalTime()
	return self:getNewSlgParamsValueByKey("result_time")
end

function NewSlgData:getCityBattleStartTime()
	return var_0_1:getTime() - var_0_1:secondsFromToday() + self._slgInfo.attack_begin_time
end

function NewSlgData:getCityBattleEndTime()
	return var_0_1:getTime() - var_0_1:secondsFromToday() + (self._slgInfo.attack_begin_time + self._slgInfo.battle_time)
end

function NewSlgData:isCityBattleTime()
	local var_260_0 = var_0_1:getTime()

	return var_260_0 >= self:getCityBattleStartTime() and var_260_0 <= self:getCityBattleEndTime()
end

function NewSlgData:isCityPopTime()
	local var_261_0 = var_0_1:getTime()

	if var_261_0 >= self:getCityBattleStartTime() and var_261_0 <= self:getCityBattleEndTime() then
		return false
	else
		return true, var_261_0 < self:getCityBattleStartTime() and self:getCityBattleStartTime() or self:getCityBattleStartTime() + 86400
	end
end

function NewSlgData:isInCityBattleFinishTime()
	if self:getCityBattleStartTime() < var_0_1:getTime() and not self:isCityBattleTime() then
		return true
	end

	return false
end

function NewSlgData:getCityPeriod()
	if not self:isPlaying() then
		return var_0_28.Slg2CityState.none, 0, 0
	end

	if self:isCityBattleTime() then
		return var_0_28.Slg2CityState.battle, self:getCityBattleStartTime(), self:getCityBattleEndTime()
	elseif self:isChariotGatherTime() then
		return var_0_28.Slg2CityState.gather, self:getChariotGatherStartTime(), self:getChariotGatherEndTime()
	else
		local var_263_2 = var_0_1:secondsFromToday()

		if self._slgInfo.attack_begin_time + self._slgInfo.battle_time < var_263_2 then
			local var_263_3 = self:getCityBattleEndTime()
			local var_263_4 = 86400 - (self._slgInfo.attack_begin_time + self._slgInfo.battle_time) + self:getCityBattleEndTime()

			if self:isNewSlgLastDay() then
				return var_0_28.Slg2CityState.last_day_declare_war, var_263_3, var_263_4
			else
				return var_0_28.Slg2CityState.declare_war, var_263_3, var_263_4 + self._slgInfo.gather_time
			end
		else
			return var_0_28.Slg2CityState.declare_war, var_0_1:getTime() - var_263_2, (self:getChariotGatherStartTime())
		end
	end
end

function NewSlgData:reqBossAuthority(arg_264_1)
	if not arg_264_1 then
		return
	end

	local var_264_0 = arg_264_1.boss_id
	local var_264_1

	if self:hasBossTotalAuthority(arg_264_1.boss_id) then
		do return end

		var_264_1 = {
			key = var_264_0
		}
	end

	var_264_1.value = arg_264_1.team.authority * self:getBossInfoById(var_264_0).num

	self:updateBossAuthority({
		var_264_1
	})
end

function NewSlgData:getChariotBelongAlliance(arg_265_1, arg_265_2)
	return var_0_2:getAllianceId()
end

function NewSlgData:getChariotShowState(arg_266_1, arg_266_2)
	for iter_266_0, iter_266_1 in ipairs((self:getNextAttackCityIds())) do
		if iter_266_1 == arg_266_1 then
			if self:getCityPeriod() == var_0_28.Slg2CityState.gather then
				return var_0_28.Slg2ChariotShowState.gather, true
			elseif self:isChariotMoveTime() and self:getChariotGatherNum(arg_266_1) > 0 then
				return var_0_28.Slg2ChariotShowState.move, true
			end
		end
	end

	return var_0_28.Slg2ChariotShowState.none
end

function NewSlgData:hasBossTotalAuthority(arg_267_1)
	return self._bossAuthorityMap[arg_267_1]
end

function NewSlgData:getChariotAuthority(arg_268_1)
	local var_268_0 = self:getCitySerData(arg_268_1)

	return (var_268_0 or nil) and (var_268_0.chariotFightValue or 0)
end

function NewSlgData:getCityDefNum(arg_269_1)
	local var_269_0 = self:getCitySerData(arg_269_1)

	return (var_269_0 or nil) and (var_269_0.defTroopNum or self:getCityInfoById(arg_269_1).num)
end

function NewSlgData:getCityNpcDefNum(arg_270_1)
	return self:getCityInfoById(arg_270_1).num
end

function NewSlgData:getCityMaxRealDefNum(arg_271_1)
	return self:getCityInfoById(arg_271_1).defend_team_num
end

function NewSlgData:getChariotGatherNum(arg_272_1)
	local var_272_0 = self:getCitySerData(arg_272_1)

	return (var_272_0 or nil) and (var_272_0.gatherNum or 0)
end

function NewSlgData:getChariotGatherMaxNum(arg_273_1, arg_273_2)
	return self:getCityInfoById(arg_273_1).team_num
end

function NewSlgData:getCurrentOccupiedCityLevel()
	local var_274_0 = self:getAllianceData().occupiedCityId or 0

	if var_274_0 == 0 then
		return 0
	end

	return self:getCityInfoById(var_274_0).level
end

function NewSlgData:getCurrentBattleData()
	local var_275_0 = self:getNextAttackCityIds()
	local var_275_1 = self:getCityComponentById(var_275_0)
	local var_275_2 = self:getBattleReportData(var_0_28.BATTLE_TYPE.CITY, var_275_0, cc.p(var_275_1.anchor_x, var_275_1.anchor_y))

	if var_275_2 and var_275_2:inBattle() then
		return var_275_2
	end

	return nil
end

function NewSlgData:isInAttackCityProcess()
	if self:isChariotGatherTime() then
		return true
	end

	if self:isChariotMoveTime() then
		return true
	end

	for iter_276_0, iter_276_1 in ipairs((self:getNextAttackCityIds())) do
		if iter_276_1 > 0 and self:isCityFighting(iter_276_1) then
			return true
		end
	end

	return false
end

function NewSlgData:isCityFighting(arg_277_1)
	local var_277_0 = self:getCityComponentById(arg_277_1)
	local var_277_1 = self:getBattleReportData(var_0_28.BATTLE_TYPE.CITY, arg_277_1, cc.p(var_277_0.anchor_x, var_277_0.anchor_y))

	if var_277_1 and var_277_1:inBattle() then
		return true
	end

	return false
end

function NewSlgData:canCityClick(arg_278_1)
	if self:isChariotMoveTime() and self:isCityFighting(arg_278_1) then
		return false, g.core.lang:get(g.core.lang:get(429052))
	end

	return true
end

function NewSlgData:isCityCanGather(arg_279_1)
	for iter_279_0, iter_279_1 in ipairs((self:getNextAttackCityIds())) do
		if iter_279_1 == arg_279_1 then
			return true
		end
	end

	return false
end

function NewSlgData:_initTeamBossData()
	self._bossTeamsInfoMap = {}
	self._challengedBossLevel = 0
	self._inviteCodeKey = "wdzy"
	self._inviteSplitKey = "_"
	self._bossTeamInviteIsShow = {}
	self.bossInviteIsRefuse = false
	self._privateContentArr = {}
	self._bossAuthorityMap = {}
end

function NewSlgData:updateBossAuthority(arg_281_1)
	for iter_281_0, iter_281_1 in ipairs(arg_281_1 or {}) do
		self._bossAuthorityMap[iter_281_1.key] = iter_281_1.value
	end
end

function NewSlgData:getBossTotalAuthority(arg_282_1)
	local var_282_0 = self:getBossInfoById(arg_282_1)

	if self._bossAuthorityMap[arg_282_1] then
		return self._bossAuthorityMap[arg_282_1]
	end

	return var_282_0.authority * var_282_0.num
end

function NewSlgData:isBossFighting(arg_283_1)
	local var_283_0 = self:getBossComponentById(arg_283_1)
	local var_283_1 = self:getBattleReportData(var_0_28.BATTLE_TYPE.BOSS, arg_283_1, cc.p(var_283_0.anchor_x, var_283_0.anchor_y))

	if var_283_1 and var_283_1:inBattle() then
		return true
	end

	return false
end

function NewSlgData:reqBossTeamKickOut(arg_284_1)
	if not arg_284_1 then
		return
	end

	local var_284_0 = arg_284_1.user_id or 0
	local var_284_1 = self:getBossTeamInfo(arg_284_1.team_id or 0)

	if var_284_1 then
		local var_284_2 = var_284_1.users or {}

		for iter_284_0, iter_284_1 in ipairs(var_284_2) do
			if iter_284_1.user_id == 0 then
				if (iter_284_1.robot_info_id or iter_284_1.user_id) == var_284_0 then
					table.remove(var_284_2, iter_284_0)

					break
				end
			end
		end
	end
end

function NewSlgData:reqBossTeamTransferLeader(arg_285_1)
	if not arg_285_1 then
		return
	end

	local var_285_0 = arg_285_1.user_id or 0
	local var_285_1 = self:getBossTeamInfo(arg_285_1.team_id or 0)

	if var_285_1 then
		for iter_285_0, iter_285_1 in ipairs(var_285_1.users or {}) do
			iter_285_1.is_leader = iter_285_1.user_id == var_285_0
		end
	end
end

function NewSlgData:reqBossTeamLeave(arg_286_1)
	if not arg_286_1 then
		return
	end

	if arg_286_1.is_dismissed then
		self:clearBossTeam(arg_286_1.team_id)
	else
		local var_286_0 = self:getBossTeamInfo(arg_286_1.team_id)

		if var_286_0 then
			local var_286_1 = var_286_0.users or {}

			for iter_286_0, iter_286_1 in ipairs(var_286_1) do
				if var_286_1.user_id == g.core.model.User:getId() then
					table.remove(var_286_1, iter_286_0)

					break
				end
			end
		end
	end
end

function NewSlgData:reqBossTeamInfoDeal(arg_287_1)
	if not arg_287_1 then
		return
	end

	self:updateBossTeamsInfoSerData(arg_287_1.teams or {})

	local var_287_0 = arg_287_1.team_ids or {}

	for iter_287_0, iter_287_1 in ipairs(arg_287_1.teams or {}) do
		table.filter(var_287_0, function(arg_288_0, arg_288_1)
			return arg_288_0 ~= iter_287_1.team_id
		end)
	end

	for iter_287_2, iter_287_3 in pairs(var_287_0) do
		self:clearBossTeam(iter_287_3)
	end
end

function NewSlgData:_createRobotRoute(arg_289_1, arg_289_2, arg_289_3)
	if not arg_289_1 then
		return
	end

	if not arg_289_1.robot_info_id or arg_289_1.robot_info_id == 0 then
		return
	end

	local var_289_0 = arg_289_1.team.move.end_pos or cc.p(0, 0)
	local var_289_1 = arg_289_1.robot_move_duration or 0
	local var_289_2 = arg_289_1.team.move.start_time or 0
	local var_289_3 = arg_289_1.team.move.cancel_time or 0
	local var_289_4 = arg_289_1.robot_info_id or 0
	local var_289_5 = g.core.common.GlobalFunc.getRandomName()
	local var_289_7 = {
		uid = 0,
		name = var_289_5,
		show_character = (arg_289_1.team.characters and #arg_289_1.team.characters > 0 or nil) and arg_289_1.team.characters[1],
		authority = arg_289_1.team.authority,
		troop_type = arg_289_1.team.troop_type
	}

	if var_289_1 > 10 then
		if not arg_289_3 or var_289_3 ~= 0 then
			var_289_2 = var_289_2 + var_289_1
		end

		var_289_1 = 10
	end

	if arg_289_2 then
		var_289_2 = g.core.common.ServerTime:getTime()
	end

	self:createBossRobotRoute(var_289_0, var_289_1, var_289_2, var_289_3, var_289_7, var_289_4, var_289_3 == 0 and (arg_289_2 or arg_289_3))
end

function NewSlgData:reqBossUserStateNotify(arg_290_1)
	if not arg_290_1 then
		return
	end

	local var_290_0 = arg_290_1.tp

	if arg_290_1.tp == var_0_28.SLGBossUserStateType.STATE_TYEP1 or var_290_0 == var_0_28.SLGBossUserStateType.STATE_TYEP2 then
		local var_290_1 = self:getBossTeamInfo(arg_290_1.team_id)

		if var_290_1 then
			local var_290_2 = var_290_1.users or {}

			for iter_290_0, iter_290_1 in ipairs(var_290_2) do
				if iter_290_1.user_id == 0 then
					if (iter_290_1.robot_info_id or iter_290_1.user_id) == arg_290_1.user_id then
						table.remove(var_290_2, iter_290_0)

						break
					end
				end
			end
		end
	elseif var_290_0 == var_0_28.SLGBossUserStateType.STATE_TYEP3 then
		self:clearBossTeam(arg_290_1.team_id)
	elseif var_290_0 == var_0_28.SLGBossUserStateType.STATE_TYEP4 then
		local var_290_4 = self:getBossTeamInfo(arg_290_1.team_id)

		if var_290_4 then
			for iter_290_2, iter_290_3 in ipairs(var_290_4.users or {}) do
				iter_290_3.is_leader = iter_290_3.user_id == arg_290_1.new_leader_id
			end
		end
	end

	if var_290_0 == var_0_28.SLGBossUserStateType.STATE_TYEP1 or var_290_0 == var_0_28.SLGBossUserStateType.STATE_TYEP2 or var_290_0 == var_0_28.SLGBossUserStateType.STATE_TYEP3 then
		for iter_290_4, iter_290_5 in ipairs((not arg_290_1.robot_users or nil) and {}) do
			self:_createRobotRoute(iter_290_5, false, true)
		end
	end
end

function NewSlgData:reqBossTeamJoinNotify(arg_291_1)
	if not arg_291_1 then
		return
	end

	local var_291_0 = self:getBossTeamInfo(arg_291_1.team_id)

	if var_291_0 and arg_291_1.join_user then
		table.insert(var_291_0.users, arg_291_1.join_user)
		self:_createRobotRoute(arg_291_1.join_user)
	end
end

function NewSlgData:reqBossBattleStartNotify(arg_292_1)
	if not arg_292_1 then
		return
	end

	if arg_292_1.report then
		self:saveBattleReport(var_0_28.BATTLE_TYPE.BOSS, arg_292_1.report)
	end

	if arg_292_1.team_id then
		local var_292_0 = self:getBossTeamInfo(arg_292_1.team_id)

		if var_292_0 then
			var_292_0.state = var_0_28.SLGBossTeamState.STATE_2
		end
	end
end

function NewSlgData:reqBossBattleFinishNotify(arg_293_1)
	if not arg_293_1 then
		return
	end

	local var_293_0 = self:getBossTeamInfo(arg_293_1.team_id)

	if var_293_0 then
		var_293_0.state = var_0_28.SLGBossTeamState.STATE_3

		for iter_293_0, iter_293_1 in ipairs(var_293_0.users) do
			self:_createRobotRoute(iter_293_1, true)
		end
	end

	self:setBossChallengedLevel(arg_293_1.challenged_boss_level)
end

function NewSlgData:setBossChallengedLevel(arg_294_1)
	self._challengedBossLevel = arg_294_1
end

function NewSlgData:getBossChallengedLevel()
	return self._challengedBossLevel
end

function NewSlgData:reqSLGEnterByBoss(arg_296_1)
	if not arg_296_1 then
		return
	end

	self:setBossChallengedLevel(arg_296_1.challenged_boss_level or 0)

	for iter_296_0, iter_296_1 in ipairs(arg_296_1.boss_teams or {}) do
		self:updateBossTeamsInfoSerData({
			iter_296_1
		})

		for iter_296_2, iter_296_3 in ipairs(iter_296_1.users or {}) do
			self:_createRobotRoute(iter_296_3)
		end
	end
end

function NewSlgData:dealBossTeamUserSort(arg_297_1)
	for iter_297_0, iter_297_1 in ipairs(arg_297_1) do
		if iter_297_1.users then
			table.sort(iter_297_1.users, function(arg_298_0, arg_298_1)
				local var_298_0 = arg_298_0.user_id == g.core.model.User:getId() and 1 or 0
				local var_298_1 = arg_298_1.user_id == g.core.model.User:getId() and 1 or 0

				if var_298_0 ~= var_298_1 then
					return var_298_1 < var_298_0
				end

				if arg_298_0.join_time ~= arg_298_1.join_time then
					return arg_298_0.join_time < arg_298_1.join_time
				end

				return arg_298_0.user_id < arg_298_1.user_id
			end)
		end
	end
end

function NewSlgData:updateBossTeamsInfoSerData(arg_299_1, arg_299_2)
	arg_299_1 = arg_299_1 or {}

	if arg_299_2 then
		self._bossTeamsInfoMap = {}
	end

	self:dealBossTeamUserSort(arg_299_1)

	for iter_299_0, iter_299_1 in ipairs(arg_299_1) do
		self._bossTeamsInfoMap[iter_299_1.team_id] = iter_299_1
	end
end

function NewSlgData:getBossTeamInfo(arg_300_1)
	return self._bossTeamsInfoMap[arg_300_1]
end

function NewSlgData:isSelfInBossTeam(arg_301_1)
	if not arg_301_1 then
		return false
	end

	for iter_301_0, iter_301_1 in ipairs(arg_301_1.users or {}) do
		if iter_301_1.user_id == g.core.model.User:getId() then
			return true
		end
	end

	return false
end

function NewSlgData:clearBossTeam(arg_302_1)
	self._bossTeamsInfoMap[arg_302_1] = nil
end

function NewSlgData:getBossChallengeTime()
	local var_303_0 = self:getNewSlgParamsValueById(89)

	return var_303_0 - self._dailyBossTimes, var_303_0
end

function NewSlgData:getBossChallengeAssistTime()
	local var_304_0 = self:getNewSlgParamsValueById(90)
	local var_304_1 = g.core.config.play_num_info.get(var_304_0)

	return var_304_0 - self._dailyAssistBossTimes, var_304_0
end

function NewSlgData:getBossTeamGatherTotalTime()
	return (self:getNewSlgParamsValueById(87))
end

function NewSlgData:getPrivateContentArrWithoutShow()
	local var_306_0 = {}

	for iter_306_0, iter_306_1 in ipairs((self:getPrivateContentArr())) do
		if not self:isBossTeamInvitedShow(iter_306_1.teamId, iter_306_1.inviteTime) then
			table.insert(var_306_0, iter_306_1)
		end
	end

	return var_306_0
end

function NewSlgData:setPrivateContentData(arg_307_1)
	table.insert(self._privateContentArr, arg_307_1)
end

function NewSlgData:getPrivateContentArr()
	local var_308_0 = {}

	for iter_308_0, iter_308_1 in pairs(self._privateContentArr) do
		if iter_308_1.user_id ~= g.core.model.User:getId() then
			table.insert(var_308_0, iter_308_1)
		end
	end

	return self:_dealContentLegal((self:_dealContentSame(var_308_0)))
end

function NewSlgData:getPrivateContentData(arg_309_1)
	for iter_309_0, iter_309_1 in ipairs((self:getPrivateContentArr())) do
		if iter_309_1.teamId == arg_309_1 then
			return iter_309_1
		end
	end
end

function NewSlgData:dealContentIsShow(arg_310_1)
	for iter_310_0, iter_310_1 in ipairs(arg_310_1) do
		self:saveCache(var_0_25(iter_310_1.teamId, iter_310_1.inviteTime), 1)
	end
end

function NewSlgData:isBossTeamInvitedShow(arg_311_1, arg_311_2)
	local var_311_0 = self:loadCache(var_0_25(arg_311_1, arg_311_2))

	if var_311_0 and var_311_0 == 1 then
		return true
	end

	return false
end

function NewSlgData:_dealContentLegal(arg_312_1)
	local var_312_0 = g.core.common.ServerTime:getTime()
	local var_312_1 = {}

	for iter_312_0, iter_312_1 in ipairs(arg_312_1) do
		if var_312_0 < iter_312_1.createTime + self:getBossTeamGatherTotalTime() then
			table.insert(var_312_1, iter_312_1)
		end
	end

	return var_312_1
end

function NewSlgData:_dealContentSame(arg_313_1)
	local var_313_0 = {}

	for iter_313_0, iter_313_1 in ipairs(arg_313_1) do
		if not var_313_0[iter_313_1.teamId] then
			var_313_0[iter_313_1.teamId] = iter_313_1
		elseif var_313_0[iter_313_1.teamId].inviteTime < iter_313_1.inviteTime then
			var_313_0[iter_313_1.teamId] = iter_313_1
		end
	end

	return table.values(var_313_0)
end

function NewSlgData:getInvitedDataByBossId(arg_314_1)
	local var_314_0 = {}

	for iter_314_0, iter_314_1 in ipairs((self:getPrivateContentArr())) do
		if iter_314_1.bossId == arg_314_1 then
			table.insert(var_314_0, iter_314_1)
		end
	end

	return var_314_0
end

function NewSlgData:decodeInviteContent(arg_315_1)
	if not arg_315_1 then
		return
	end

	local var_315_0 = string.split(arg_315_1, self._inviteSplitKey)

	if #var_315_0 > 0 and var_315_0[1] == self._inviteCodeKey then
		return {
			code = var_315_0[1],
			bossId = tonumber(var_315_0[2]),
			teamId = tonumber(var_315_0[3]),
			inviteTime = g.core.common.GlobalFunc.convert_abc2longNumber(var_315_0[4]),
			createTime = g.core.common.GlobalFunc.convert_abc2longNumber(var_315_0[5]),
			authority = tonumber(var_315_0[6])
		}
	end
end

function NewSlgData:encodeInviteContent(arg_316_1)
	return self._inviteCodeKey .. self._inviteSplitKey .. arg_316_1.bossId .. self._inviteSplitKey .. arg_316_1.teamId .. self._inviteSplitKey .. ((arg_316_1.inviteTime or nil) and g.core.common.GlobalFunc.convert_longNumber2abc(arg_316_1.inviteTime)) .. self._inviteSplitKey .. ((arg_316_1.createTime or nil) and g.core.common.GlobalFunc.convert_longNumber2abc(arg_316_1.createTime)) .. self._inviteSplitKey .. arg_316_1.authority
end

function NewSlgData:getCanChallengeBossIds(arg_317_1)
	local var_317_0 = {}

	for iter_317_0, iter_317_1 in ipairs(self:getCanChallengeProvinceGIDArr() or {}) do
		table.insertto(var_317_0, self._bossIdsByProvinceGID[iter_317_1] or {})
	end

	if arg_317_1 then
		table.sort(var_317_0, function(arg_318_0, arg_318_1)
			local var_318_0 = self:getBossInfoById(arg_318_0)
			local var_318_1 = self:getBossInfoById(arg_318_1)

			if var_318_0.level ~= var_318_1.level then
				return var_318_0.level < var_318_1.level
			end

			return arg_318_0 < arg_318_1
		end)
	end

	table.insert(var_317_0, 1, 0)

	return var_317_0
end

function NewSlgData:getCanChallengeBossIdsByLevel(arg_319_1, arg_319_2)
	local var_319_0 = self:getBossChallengedLevel() + 1
	local var_319_1 = {}
	local var_319_2 = {}

	for iter_319_0, iter_319_1 in ipairs((self:getCanChallengeBossIds(arg_319_1))) do
		if iter_319_1 ~= 0 then
			local var_319_3 = self:getBossInfoById(iter_319_1)

			if not arg_319_2 or arg_319_2 and var_319_3.level <= var_319_0 then
				if not var_319_2[var_0_25(var_319_3.level, var_319_3.boss_army_type)] then
					var_319_2[var_0_25(var_319_3.level, var_319_3.boss_army_type)] = {}

					table.insert(var_319_1, iter_319_1)
				end

				table.insert(var_319_2[var_0_25(var_319_3.level, var_319_3.boss_army_type)], iter_319_1)
			end
		else
			table.insert(var_319_1, iter_319_1)
		end
	end

	return var_319_1, var_319_2
end

function NewSlgData:_initTaskData()
	self._checkPointTaskSerData = {}
	self._mainQuestId = 0
	self._mainQuestTaskSerData = {}
	self._cityQuestProgressSerData = {}
	self._cityQuestAwardedMap = {}
	self._cityQuestInfoArrMap = {}
	self._cityQuestTabArr = {}
	self._achievementSelfTaskData = {}
end

function NewSlgData:getCityQuestTabArr()
	if #self._cityQuestTabArr == 0 then
		local var_321_0 = {}

		for iter_321_0, iter_321_1 in var_0_10.ipairs() do
			if self._slgInfo.city_quest_group == iter_321_1.group_id and not var_321_0[iter_321_1.level] then
				var_321_0[iter_321_1.level] = true
			end
		end

		local var_321_1 = self:getAllianceData().bornPID or 0

		if var_321_1 == 0 then
			var_321_1 = 1
		end

		for iter_321_2, iter_321_3 in ipairs((self:getCityIdsByPID(var_321_1))) do
			local var_321_2 = self:getCityInfoById(iter_321_3)

			if var_321_0[var_321_2.level] then
				table.insert(self._cityQuestTabArr, {
					name = var_321_2.name,
					level = var_321_2.level,
					cityIdIndex = iter_321_2
				})
			end
		end

		table.sort(self._cityQuestTabArr, function(arg_322_0, arg_322_1)
			return arg_322_0.level < arg_322_1.level
		end)
	end

	return self._cityQuestTabArr
end

function NewSlgData:getCityQuestArrByLevel(arg_323_1)
	if table.nums(self._cityQuestInfoArrMap) == 0 then
		for iter_323_0, iter_323_1 in var_0_10.ipairs() do
			if self._slgInfo.city_quest_group == iter_323_1.group_id then
				self._cityQuestInfoArrMap[iter_323_1.level] = self._cityQuestInfoArrMap[iter_323_1.level] or {}

				table.insert(self._cityQuestInfoArrMap[iter_323_1.level], iter_323_1)
			end
		end
	end

	return self._cityQuestInfoArrMap[arg_323_1] or {}
end

function NewSlgData:getCityQuestProgress(arg_324_1)
	return self._cityQuestProgressSerData[arg_324_1] or 0
end

function NewSlgData:isCityQuestAwarded(arg_325_1)
	return self._cityQuestAwardedMap[arg_325_1]
end

function NewSlgData:updateCityQuestProgressSerData(arg_326_1, arg_326_2)
	if arg_326_2 then
		self._cityQuestProgressSerData = {}
	end

	for iter_326_0, iter_326_1 in ipairs(arg_326_1 or {}) do
		self._cityQuestProgressSerData[iter_326_1.id] = iter_326_1.num
	end
end

function NewSlgData:updateCityQuestAwarded(arg_327_1, arg_327_2)
	if arg_327_2 then
		self._cityQuestAwardedMap = {}
	end

	for iter_327_0, iter_327_1 in ipairs(arg_327_1 or {}) do
		self._cityQuestAwardedMap[iter_327_1] = true
	end
end

function NewSlgData:isAllCityQuestAwardedByLevel(arg_328_1)
	for iter_328_0, iter_328_1 in ipairs((self:getCityQuestArrByLevel(arg_328_1))) do
		if not self:isCityQuestAwarded(iter_328_1.id) then
			return false
		end
	end

	return true
end

function NewSlgData:dealCityQuestArrByLevel(arg_329_1, arg_329_2)
	local var_329_0 = {}

	for iter_329_0, iter_329_1 in ipairs((self:getCityQuestArrByLevel(arg_329_1))) do
		local var_329_1 = self:getCityQuestProgress(iter_329_1.level)
		local var_329_2 = var_0_32.NO_COMPLETED
		local var_329_3

		if self:isCityQuestAwarded(iter_329_1.id) then
			var_329_2 = var_0_32.RECEIVED
		elseif var_329_1 >= iter_329_1.num then
			var_329_2 = var_0_32.COMPLETED
		else
			var_329_2 = var_0_32.NO_COMPLETED
			var_329_3 = var_329_0
		end

		table.insert(var_329_0, {
			cfg = iter_329_1,
			state = var_329_2,
			cityIdIndex = self:getCityQuestTabArr()[iter_329_1.level].cityIdIndex
		})
	end

	if arg_329_2 then
		table.sort(var_329_0, function(arg_330_0, arg_330_1)
			if arg_330_0.state ~= arg_330_1.state then
				return arg_330_0.state < arg_330_1.state
			end

			return arg_330_0.cfg.order < arg_330_1.cfg.order
		end)
	end

	return var_329_0
end

function NewSlgData:canAchieveCityQuest(arg_331_1)
	if not arg_331_1 then
		for iter_331_0, iter_331_1 in ipairs(self:getCityQuestTabArr()) do
			for iter_331_2, iter_331_3 in ipairs((self:dealCityQuestArrByLevel(iter_331_1.level))) do
				if iter_331_3.state == var_0_32.COMPLETED then
					return true, iter_331_0
				end
			end
		end
	else
		for iter_331_4, iter_331_5 in ipairs((self:dealCityQuestArrByLevel(arg_331_1))) do
			if iter_331_5.state == var_0_32.COMPLETED then
				return true, arg_331_1
			end
		end
	end

	return false
end

function NewSlgData:updateCheckPointTask(arg_332_1, arg_332_2)
	if arg_332_2 then
		self._checkPointTaskSerData = {}
	end

	for iter_332_0, iter_332_1 in ipairs(arg_332_1 or {}) do
		self._checkPointTaskSerData[iter_332_1.id] = iter_332_1.num
	end
end

function NewSlgData:getCheckPointProgressByGroup(arg_333_1)
	return self._checkPointTaskSerData[arg_333_1] or 0
end

function NewSlgData:getCheckPointTaskCurVArr(arg_334_1)
	for iter_334_0, iter_334_1 in var_0_8.ipairs() do
		if arg_334_1.group == iter_334_1.group and self:getCheckPointProgressByGroup(arg_334_1.group) >= arg_334_1.quest_value_2 then
			return arg_334_1.quest_value_2, arg_334_1.quest_value_2
		end
	end

	return self:getCheckPointProgressByGroup(arg_334_1.group), arg_334_1.quest_value_2
end

function NewSlgData:getCheckPointConditionState(arg_335_1, arg_335_2)
	if arg_335_1 == var_0_28.CheckPointUnlockType.CityUnlock then
		local var_335_0 = self:getCityInfoById(arg_335_2)

		if self:isCityOccupied(arg_335_2) then
			return var_0_28.TaskState.COMPLETED, var_335_0
		end

		return var_0_28.TaskState.NO_COMPLETED, var_335_0
	end

	return var_0_28.TaskState.NO_COMPLETED
end

function NewSlgData:_getMainQuestIndex(arg_336_1)
	local var_336_0 = false

	for iter_336_0, iter_336_1 in ipairs(self:getMainQuestArr() or {}) do
		if iter_336_1.id == arg_336_1 then
			var_336_0 = iter_336_0

			break
		end
	end

	return var_336_0
end

function NewSlgData:updateMainQuestDataById(arg_337_1)
	self._mainQuestId = arg_337_1
	self._mainQuestTaskSerData = {}

	local var_337_0 = self:_getMainQuestIndex(arg_337_1)

	if var_337_0 then
		for iter_337_0 = 1, var_337_0 do
			local var_337_1 = self:getMainQuestArr()[iter_337_0]

			self._mainQuestTaskSerData[var_337_1.id] = {
				awarded = true,
				id = var_337_1.id,
				value = self:getMainQuestGoal(var_337_1)
			}
		end
	end
end

function NewSlgData:updateUnitMainQuest(arg_338_1)
	if not arg_338_1 then
		return
	end

	self._mainQuestTaskSerData[arg_338_1.id] = arg_338_1
end

function NewSlgData:updateAchievementSelfTaskData(arg_339_1, arg_339_2)
	if arg_339_2 then
		self._achievementSelfTaskData = {}
	end

	for iter_339_0, iter_339_1 in ipairs(arg_339_1 or {}) do
		self._achievementSelfTaskData[iter_339_1.id] = iter_339_1
	end
end

function NewSlgData:getAchievementSelfTaskData(arg_340_1)
	return self._achievementSelfTaskData[arg_340_1] or {
		value = 0,
		awarded = false,
		id = arg_340_1
	}
end

function NewSlgData:getCurMainQuest()
	local var_341_0
	local var_341_1 = self:_getMainQuestIndex(self._mainQuestId)

	if var_341_1 then
		local var_341_2 = self:getMainQuestArr()[var_341_1 + 1]

		if var_341_2 then
			var_341_0 = self._mainQuestTaskSerData[var_341_2.id] or {
				value = 0,
				awarded = false,
				id = var_341_2.id
			}
		end
	else
		local var_341_3 = self:getMainQuestArr()[1]

		var_341_0 = self._mainQuestTaskSerData[var_341_3.id] or {
			value = 0,
			awarded = false,
			id = var_341_3.id
		}
	end

	return var_341_0
end

function NewSlgData:getMainQuestArr()
	if not self._mainQuestArr or #self._mainQuestArr == 0 then
		self:_initCheckPointCfg()
	end

	return self._mainQuestArr
end

function NewSlgData:getMainQuestGoal(arg_343_1)
	return arg_343_1.quest_value_1
end

function NewSlgData:_initBattleReportData()
	self._localReportId = 0
	self._netReportId = 0
end

function NewSlgData:_updateBattleReportRedPointData(arg_345_1)
	self._netReportId = arg_345_1
end

function NewSlgData:_initRankData()
	self._rankRewardData = {}
end

function NewSlgData:getNewSlgCurrentRankReward(arg_347_1, arg_347_2)
	arg_347_2 = arg_347_2 or 0

	local var_347_0 = arg_347_1 .. "_" .. arg_347_2

	if self._rankRewardData[arg_347_1 .. "_" .. arg_347_2] then
		return self._rankRewardData[var_347_0]
	end

	local var_347_1 = {}

	for iter_347_0, iter_347_1 in var_0_16.ipairs() do
		if iter_347_1.rank_type == arg_347_1 and iter_347_1.group_id == self._slgInfo.rank_group then
			if not arg_347_2 then
				table.insert(var_347_1, iter_347_1)
			elseif iter_347_1.rank_value == arg_347_2 then
				table.insert(var_347_1, iter_347_1)
			end
		end
	end

	table.sort(var_347_1, function(arg_348_0, arg_348_1)
		return arg_348_0.min_rank < arg_348_1.min_rank
	end)

	self._rankRewardData[var_347_0] = var_347_1

	return var_347_1
end

function NewSlgData:getRankAwardByTypeAndValueAndRank(arg_349_1, arg_349_2, arg_349_3)
	local var_349_0 = {}

	for iter_349_0, iter_349_1 in ipairs((self:getNewSlgCurrentRankReward(arg_349_1, arg_349_3))) do
		if arg_349_2 >= iter_349_1.min_rank and arg_349_2 <= iter_349_1.max_rank then
			for iter_349_2, iter_349_3, iter_349_4 in iter_349_1.gmatch({
				"reward_type_%d+",
				"reward_value_%d+",
				"reward_size_%d+"
			}) do
				if iter_349_4[1] and iter_349_4[1] ~= 0 then
					table.insert(var_349_0, {
						type = iter_349_4[1],
						value = iter_349_4[2],
						size = iter_349_4[3]
					})
				end
			end

			break
		end
	end

	return var_349_0
end

function NewSlgData:getNewSlgMyPathCity()
	local var_350_0 = self:getAllianceData().bornPID or 0

	if var_350_0 == 0 then
		var_350_0 = 1
	end

	local var_350_1 = {
		[var_350_0] = true
	}
	local var_350_2 = var_350_0
	local var_350_3 = var_0_7.get(var_350_0)

	while var_350_3.next ~= var_350_2 do
		var_350_2 = var_350_3.next
		var_350_1[var_350_3.next] = true
		var_350_3 = var_0_7.get(var_350_2)
	end

	local var_350_4 = {}

	for iter_350_0, iter_350_1 in var_0_4.ipairs() do
		if var_350_1[iter_350_1.city_state] and iter_350_1.type ~= var_0_28.CITY_TYPE.INFINITE_DRAGON then
			table.insert(var_350_4, iter_350_1)
		end
	end

	return var_350_4
end

function NewSlgData:getNewSlgCity()
	local var_351_0 = {}

	for iter_351_0, iter_351_1 in var_0_4.ipairs() do
		if iter_351_1.type ~= var_0_28.CITY_TYPE.INFINITE_DRAGON then
			table.insert(var_351_0, iter_351_1)
		end
	end

	return var_351_0
end

function NewSlgData:getLastCityOpenTime()
	return self._timeEnd - 86400
end

function NewSlgData:getIsGotPreviewReward(arg_353_1)
	return self._getPreviewReward
end

function NewSlgData:setIsGotPreviewReward(arg_354_1)
	self._getPreviewReward = arg_354_1
end

function NewSlgData:getMainQuestTaskSerDataById(arg_355_1)
	return self._mainQuestTaskSerData[arg_355_1] or {}
end

function NewSlgData:checkIsGotTaskAwardById(arg_356_1)
	return self:getMainQuestTaskSerDataById(arg_356_1).awarded
end

function NewSlgData:checkTaskCanGetAwardById(arg_357_1)
	local var_357_0 = self:_getMainQuestIndex(arg_357_1)

	if var_357_0 then
		local var_357_1 = self:getMainQuestTaskSerDataById(arg_357_1)

		return var_357_1.value and not var_357_1.awarded and self:getMainQuestGoal(self:getMainQuestArr()[var_357_0]) <= var_357_1.value
	end

	return false
end

function NewSlgData:checkTaskFinishById(arg_358_1)
	local var_358_0 = self:_getMainQuestIndex(arg_358_1)

	if var_358_0 then
		local var_358_1 = self:getMainQuestTaskSerDataById(arg_358_1)

		return var_358_1.value and self:getMainQuestGoal(self:getMainQuestArr()[var_358_0]) <= var_358_1.value
	end

	return false
end

function NewSlgData:setJumpPos(arg_359_1)
	self._jumpPos = arg_359_1
end

function NewSlgData:getJumpPos()
	if self._jumpPos then
		self._jumpPos = nil

		return (clone(self._jumpPos))
	end
end

function NewSlgData:recordBattleReport(arg_361_1)
	self._newestRecordTime = arg_361_1
end

function NewSlgData:isShowNewReportPoint()
	return (g.core.model.User.newSlgData:loadCache("lsat_Battle_report_time") or 0) < self._newestRecordTime
end

function NewSlgData:oneNewBattleEnd()
	if self._newBattleReportCnt == 0 then
		self._newBattleReportCnt = 1
	end
end

function NewSlgData:onS2CNewSlgGetReportList(arg_364_1)
	self:onStoreNewBattleReport(arg_364_1)

	if self._battleReportList and self._battleReportList[1] then
		self:recordBattleReport(self._battleReportList[1].start_tm)
	end

	self:checkNewBattleReportCnt(arg_364_1)
end

function NewSlgData:onS2CNewSlgGetReport(arg_365_1)
	self._battleReportListMap[arg_365_1.report.report_id].detail = arg_365_1.report
end

function NewSlgData:getBattleReportById(arg_366_1)
	if not self._battleReportListMap then
		return
	end

	return self._battleReportListMap[arg_366_1]
end

function NewSlgData:onStoreNewBattleReport(arg_367_1)
	self._battleReportList = {}
	self._battleReportListMap = {}

	for iter_367_0, iter_367_1 in ipairs(arg_367_1.reports or {}) do
		self._battleReportList[iter_367_0] = iter_367_1
		self._battleReportListMap[iter_367_1.report_id] = iter_367_1
	end

	table.sort(self._battleReportList, function(arg_368_0, arg_368_1)
		if arg_368_0.start_tm ~= arg_368_1.start_tm then
			return arg_368_0.start_tm > arg_368_1.start_tm
		end

		return false
	end)
end

function NewSlgData:getNewBattleReportList()
	return self._battleReportList
end

function NewSlgData:checkNewBattleReportCnt(arg_370_1)
	self._newBattleReportCnt = 0

	for iter_370_0, iter_370_1 in ipairs(arg_370_1.reports or {}) do
		if not self._viewBattleReportMap[tostring(iter_370_1.report_id)] then
			self._newBattleReportCnt = self._newBattleReportCnt + 1
			iter_370_1.isNew = true
		end
	end
end

function NewSlgData:isViewedBattleReport(arg_371_1)
	return self._viewBattleReportMap[tostring(arg_371_1)]
end

function NewSlgData:viewedBattleReport(arg_372_1)
	if not self._viewBattleReportMap[tostring(arg_372_1)] then
		self._viewBattleReportMap[tostring(arg_372_1)] = true

		self:saveCache("viewBattleReportMap", self._viewBattleReportMap)

		self._newBattleReportCnt = self._newBattleReportCnt - 1
	end
end

function NewSlgData:getCampaignStr()
	if g.core.model.User.newSlgData:isForecasting() then
		return g.core.lang:get(429546)
	elseif g.core.model.User.newSlgData:isEnding() then
		return g.core.lang:get(429547)
	else
		return g.core.lang:get(429548)
	end
end

function NewSlgData:cacheTeamData(arg_374_1)
	local var_374_0 = {}
	local var_374_1 = {
		[var_0_28.TEAM_SOURCE_TYPE.CITY_DEVELOP_SOURCE] = 1,
		[var_0_28.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE] = 1
	}

	for iter_374_0, iter_374_1 in pairs(arg_374_1) do
		var_374_0[iter_374_0] = {
			characters = iter_374_1.characters,
			source = iter_374_1.source,
			localIndex = var_374_1[iter_374_1.source]
		}
		var_374_1[iter_374_1.source] = var_374_1[iter_374_1.source] + 1
	end

	self._teamCache = var_374_0

	g.core.common.Storage:save("new_slg_team_record" .. self:getSeasonId() .. "_" .. self._actId .. ".json", var_374_0)
end

function NewSlgData:getCacheTeamData()
	if not self._teamCache then
		self._teamCache = g.core.common.Storage:load("new_slg_team_record" .. self:getSeasonId() .. "_" .. self._actId .. ".json", true) or {}

		if self._teamCache[1] and self._teamCache[1].source == nil then
			local var_375_0 = {}

			for iter_375_0, iter_375_1 in ipairs(self._teamCache) do
				var_375_0[iter_375_0] = {
					characters = iter_375_1,
					source = var_0_28.TEAM_SOURCE_TYPE.CITY_DEVELOP_SOURCE,
					localIndex = iter_375_0
				}
			end

			self._teamCache = var_375_0
		end
	end

	return self._teamCache
end

function NewSlgData:checkNewSlgCityGather()
	if not self:isPlaying() then
		return false
	end

	if self:getNextAttackCityIds()[1] > 0 and self:isChariotGatherTime() then
		return not self.gatherCityRedPoint
	end

	return false
end

function NewSlgData:checkNewSlgCityGatherOutMap()
	if not self:isPlaying() then
		return false
	end

	if self:getNextAttackCityIds()[1] > 0 and self:isChariotGatherTime() then
		return not self.intoMapRedPoint
	end

	return false
end

function NewSlgData:isHaveCheckPointPassed(arg_378_1)
	if arg_378_1.id and self:getCheckPointState(arg_378_1.id) == var_0_28.CheckPointState.Passed then
		return true
	end

	return false
end

function NewSlgData:updateMoveTargetRightNow(arg_379_1)
	local var_379_0

	for iter_379_0, iter_379_1 in pairs(self._mapMarchUnitData) do
		if arg_379_1.move_id == iter_379_1.id then
			var_379_0 = iter_379_0

			break
		end
	end

	if var_379_0 then
		self:deleteMarchUnit(var_379_0)

		self._refreshMarch = true
	end
end

function NewSlgData:checkHasTeamInvite(arg_380_1)
	if not self:isPlaying() then
		return false
	end

	local var_380_0 = g.core.common.Storage:load("new_slg_team_invite.json", true) or {}

	if not g.core.common.ServerTime:getIsSameDay((tonumber(var_380_0.check_time or 0))) then
		var_380_0 = {}
	end

	local var_380_1 = g.core.common.ServerTime:getTime()

	for iter_380_0, iter_380_1 in ipairs((g.core.model.User.homeInfoRemindData:getTipDataList(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG, var_0_28.BOSS_INVITE_TIP_ID))) do
		if not var_380_0[tostring(iter_380_1.uid)] and iter_380_1._expire_time and var_380_1 < iter_380_1._expire_time then
			return true
		end
	end

	return false
end

function NewSlgData:setOpenSearch()
	self._openSearch = true
end

function NewSlgData:isNeedOpenSearch()
	self._openSearch = false

	return self._openSearch
end

function NewSlgData:setOpenTeamBattle()
	self._openTeamBattle = true
end

function NewSlgData:isNeedOpenTeamBattle()
	self._openTeamBattle = false

	return self._openTeamBattle
end

function NewSlgData:isMyTarget(arg_385_1)
	for iter_385_0, iter_385_1 in ipairs(self._targetPosArr) do
		if arg_385_1.x == iter_385_1.x and arg_385_1.y == iter_385_1.y then
			return true
		end
	end

	return false
end

function NewSlgData:hasNewBattleReport()
	return self._newBattleReportCnt > 0
end

function NewSlgData:saveMyOldFightValue()
	self._oldFv = g.core.model.User.newSlgDevelopData:getTotalAuthority()
end

function NewSlgData:getFightValueChange()
	self._oldFv = self._oldFv or g.core.model.User.newSlgDevelopData:getTotalAuthority()

	return g.core.model.User.newSlgDevelopData:getTotalAuthority() - self._oldFv
end

function NewSlgData:setClearSpriteFrameCache(arg_389_1)
	self._spriteUseCache = self._spriteUseCache or 0
	self._spriteUseCache = self._spriteUseCache + arg_389_1
	self._spriteUseCache = math.max(self._spriteUseCache, 0)
end

function NewSlgData:isClearSpriteFrameCache()
	if self._spriteUseCache > 0 then
		return false
	end

	return true
end

function NewSlgData:getScoreAddition()
	return 0
end

function NewSlgData:getResAddition(arg_392_1)
	return 0
end

function NewSlgData:reqObtainAchievementReward(arg_393_1)
	return
end

function NewSlgData:isCityInShare()
	return false
end

function NewSlgData:updateCityGatherNum(arg_395_1, arg_395_2)
	return
end

function NewSlgData:updateCitySimpleData()
	return
end

function NewSlgData:_initBuildCfg()
	return
end

function NewSlgData:getAchievementKey(arg_398_1)
	return
end

function NewSlgData:_initAchievement()
	return
end

function NewSlgData:getAchievementDataArrByType(arg_400_1)
	return
end

function NewSlgData:getAchievementInfoById(arg_401_1)
	return var_0_18.get(arg_401_1)
end

function NewSlgData:getCurAchievementTask(arg_402_1, arg_402_2)
	return
end

function NewSlgData:getBuildInfoById(arg_403_1)
	return var_0_17.get(arg_403_1)
end

function NewSlgData:getBuildInfoArrByTempId(arg_404_1)
	return
end

function NewSlgData:getBuildInfoByTempIdAndLevelIdx(arg_405_1, arg_405_2)
	return
end

function NewSlgData:updateCityOccupyAlliance(arg_406_1, arg_406_2)
	return
end

function NewSlgData:updateBuildData(arg_407_1, arg_407_2)
	return
end

function NewSlgData:_updateBuildDataUnit(arg_408_1)
	return
end

function NewSlgData:updateCityOccupierId(arg_409_1, arg_409_2)
	return
end

function NewSlgData:updateCityDeclaredAlliance(arg_410_1, arg_410_2)
	return
end

function NewSlgData:setCityDeclaredSelfAlliance()
	return
end

function NewSlgData:updateSelfDeclareCities(arg_412_1, arg_412_2)
	return
end

function NewSlgData:setScoreAddition(arg_413_1)
	return
end

function NewSlgData:updateResAddition(arg_414_1, arg_414_2)
	return
end

function NewSlgData:getBeginCityId()
	return 0
end

function NewSlgData:getCanDeclareCities()
	return {}
end

function NewSlgData:getAdjacentCities(arg_417_1)
	return {}
end

function NewSlgData:getAdjacentOccupiedCities(arg_418_1)
	return {}
end

function NewSlgData:getSelfAdjacentOccupyCities(arg_419_1)
	return {}
end

function NewSlgData:isS2CityUnlock(arg_420_1)
	return false
end

function NewSlgData:getCityDeclaredAlliances(arg_421_1)
	return {}
end

function NewSlgData:getSelfGatherNum(arg_422_1)
	return self:getChariotGatherNum(arg_422_1)
end

function NewSlgData:getOtherGatherNum(arg_423_1)
	return 0
end

function NewSlgData:isCityInSelfBorn(arg_424_1)
	return false
end

function NewSlgData:getBuildDataById(arg_425_1)
	return
end

function NewSlgData:getAssistAuthority(arg_426_1)
	return 0
end

function NewSlgData:hasBoxCanUse()
	return g.core.model.User.bagData:getCountById(3, 2669) + g.core.model.User.bagData:getCountById(3, 2670) > 0
end

function NewSlgData:getSelfDeclaredCities()
	return (self:getAllianceData() or {}).declareCities or {}
end

function NewSlgData:isCityGather(arg_429_1)
	return false
end

function NewSlgData:checkSendCrossPointMsg()
	if self:isOpen() and g.core.model.User.allianceData:isInAlliance() then
		g.core.network.GameNetProxy:send_C2S_FlushRedPoint({
			cross_modules = {
				var_0_28.CROSS_RED_ID
			}
		})
	end
end

function NewSlgData:isCanDeclaredCity()
	return false
end

function NewSlgData:_deleteDeclareCity(arg_432_1)
	return
end

function NewSlgData:hasAchievementRed()
	return false
end

function NewSlgData:setGiveUpCities(arg_434_1)
	return
end

function NewSlgData:getGiveUpCities()
	return {}
end

function NewSlgData:getKickCnt()
	return self._kickCnt
end

function NewSlgData:isS3ForceUnlock()
	return false
end

function NewSlgData:getMonsterCfgArrByType(arg_438_1)
	if not self._monsterCfgArrMap[arg_438_1] then
		self:_initMonsterCfg()
	end

	return self._monsterCfgArrMap[arg_438_1]
end

function NewSlgData:getMonsterMaxLevel()
	if not self._monsterMaxLevel then
		self:_initMonsterCfg()
	end

	return self._monsterMaxLevel
end

function NewSlgData:getBossMaxLevel()
	if not self._bossMaxLevel then
		self:_initBossCfg()
	end

	return self._bossMaxLevel
end

function NewSlgData:checkIsMyOccupy(arg_441_1)
	return false
end

function NewSlgData:getAuthorityScale()
	return 1
end

function NewSlgData:updateFarmSerData()
	return
end

function NewSlgData:updateFarmUnitSerData()
	return
end

function NewSlgData:updateFarmUnitQuit()
	return
end

function NewSlgData:getFarmDataById(arg_446_1)
	return
end

function NewSlgData:updateBountyInfo()
	return
end

function NewSlgData:updateBountyTask()
	return
end

function NewSlgData:hasBountyTasks()
	return self._slgInfo.bounty_group > 0
end

function NewSlgData:canGetBountyTaskAward()
	return false
end

function NewSlgData:canGetFirstKillAward()
	return false
end

function NewSlgData:canGetFarmAward()
	return false
end

function NewSlgData:getFarmMaxLimit()
	return self:getNewSlgParamsValueById(185)
end

function NewSlgData:getFarmGroup()
	return self._slgInfo.farm_group
end

function NewSlgData:isFarmOpen()
	if self._slgInfo.farm_group == 0 then
		return false
	end

	return self:getOpenDays() >= self:getNewSlgParamsValueById(183)
end

function NewSlgData:isFarmPeriod()
	if not self:isFarmOpen() then
		return false, 86400 - g.core.common.ServerTime:secondsFromToday() + (self:getNewSlgParamsValueById(183) - self:getOpenDays() - 1) * 86400 + self._slgInfo.farm_open, var_0_28.FARM_PERIOD.UNLOCK
	end

	local var_456_0 = g.core.common.ServerTime:secondsFromToday()

	if var_456_0 >= self._slgInfo.farm_open and var_456_0 <= self._slgInfo.farm_open + self._slgInfo.farm_last then
		return true, self._slgInfo.farm_open + self._slgInfo.farm_last - var_456_0, var_0_28.FARM_PERIOD.OPEN
	end

	local var_456_1 = 0

	if var_456_0 < self._slgInfo.farm_open then
		var_456_1 = self._slgInfo.farm_open - var_456_0
	elseif not self:isNewSlgLastDay() then
		var_456_1 = 86400 - var_456_0 + self._slgInfo.farm_open
	end

	return false, var_456_1, var_0_28.FARM_PERIOD.CLOSE
end

function NewSlgData:getNextResetFoodSec()
	local var_457_0 = g.core.common.ServerTime:secondsFromToday()

	if var_457_0 - self._slgInfo.farm_open > 0 then
		return self._slgInfo.farm_open + self._slgInfo.farm_reset * (math.floor((var_457_0 - self._slgInfo.farm_open) / self._slgInfo.farm_reset) + 1) - var_457_0
	elseif var_457_0 - self._slgInfo.farm_open < 0 then
		return self._slgInfo.farm_open - self._slgInfo.farm_reset * math.floor((self._slgInfo.farm_open - var_457_0) / self._slgInfo.farm_reset) - var_457_0
	end
end

function NewSlgData:getFarmInfoById(arg_458_1)
	return var_0_20.get(arg_458_1)
end

function NewSlgData:getNextResetFoodSec()
	local var_459_0 = g.core.common.ServerTime:secondsFromToday()

	if var_459_0 - self._slgInfo.farm_open > 0 then
		return self._slgInfo.farm_open + self._slgInfo.farm_reset * (math.floor((var_459_0 - self._slgInfo.farm_open) / self._slgInfo.farm_reset) + 1) - var_459_0
	elseif var_459_0 - self._slgInfo.farm_open < 0 then
		return self._slgInfo.farm_open - self._slgInfo.farm_reset * math.floor((self._slgInfo.farm_open - var_459_0) / self._slgInfo.farm_reset) - var_459_0
	end
end

function NewSlgData:isFarmLandOpen(arg_460_1)
	local var_460_0

	if self._slgInfo.farm_group == 0 then
		do return false, 0 end

		var_460_0 = self:getOpenDays()
	end

	local var_460_1 = self:getFarmInfoById(arg_460_1).open_time

	if var_460_0 < var_460_1 then
		return false, 86400 - g.core.common.ServerTime:secondsFromToday() + 86400 * (var_460_1 - var_460_0 - 1)
	else
		return true
	end
end

function NewSlgData:getFarmCost(arg_461_1)
	if self._slgInfo.farm_cost_group == 0 then
		return {}
	end

	local var_461_0 = self:getFarmInfoById(arg_461_1).level

	if self._farmCostMap[self._slgInfo.farm_cost_group .. "_" .. var_461_0] then
		return self._farmCostMap[self._slgInfo.farm_cost_group .. "_" .. var_461_0]
	end

	local var_461_1 = {}

	for iter_461_0, iter_461_1, iter_461_2 in var_0_19.get(self._slgInfo.farm_cost_group, var_461_0).gmatch({
		"value_%d+"
	}) do
		if iter_461_2[1] ~= 0 then
			table.insert(var_461_1, {
				size = 1,
				type = g.core.common.Goods.TYPE_ITEM,
				value = iter_461_2[1]
			})
		end
	end

	self._farmCostMap[self._slgInfo.farm_cost_group .. "_" .. var_461_0] = var_461_1

	return var_461_1
end

function NewSlgData:getMaxFarmCount(arg_462_1)
	local var_462_0 = 0

	for iter_462_0, iter_462_1 in ipairs((self:getFarmCost(arg_462_1))) do
		var_462_0 = var_462_0 + (self._farmTokenMap[iter_462_1.value] or 0)
	end

	return var_462_0
end

function NewSlgData:getFarmTokenNum(arg_463_1)
	return self._farmTokenMap[arg_463_1] or 0
end

function NewSlgData:getFarmTokenMap()
	return self._farmTokenMap
end

function NewSlgData:getAuthorityDecreaseNum()
	return 0
end

function NewSlgData:_initFarmInfo()
	if self._isInitFarm then
		return
	end

	self._isInitFarm = true
	self._farmArrBelongCity = {}
	self._farmArr = {}

	for iter_466_0, iter_466_1 in var_0_20.ipairs() do
		if iter_466_1.farm_group == self._slgInfo.farm_group then
			self._farmArrBelongCity[iter_466_1.belong] = self._farmArrBelongCity[iter_466_1.belong] or {}

			table.insert(self._farmArrBelongCity[iter_466_1.belong], iter_466_1)
			table.insert(self._farmArr, iter_466_1)
		end
	end
end

function NewSlgData:getFarmArrBelongCity(arg_467_1)
	self:_initFarmInfo()

	return self._farmArrBelongCity[arg_467_1] or {}
end

function NewSlgData:getAtkingFarmArr()
	return {}
end

function NewSlgData:getFarmComponentById(arg_469_1)
	self:_initCompCfg()

	return self._farmComponentMap[arg_469_1]
end

function NewSlgData:getFarmAwardDecreasePer()
	return self:getNewSlgParamsValueById(186) / 1000
end

function NewSlgData:hasTeamFarm(arg_471_1)
	for iter_471_0, iter_471_1 in pairs((self:getMyTeamMap())) do
		local var_471_0 = self:getTeamStateByTeam(iter_471_1)
	end

	return false
end

function NewSlgData:getFarmInfoByRC(arg_472_1, arg_472_2)
	local var_472_0 = self:getComponentsByGID((self:getBarrierGIDByRC(arg_472_1, arg_472_2)))[1]

	if var_472_0 and var_472_0.type == var_0_31.FARM then
		return var_0_20.get(var_472_0.value)
	end

	return nil
end

function NewSlgData:useFarmToken(arg_473_1)
	local var_473_0

	if arg_473_1 then
		::label_473_0::

		var_473_0 = arg_473_1.awards and arg_473_1.awards[1].size
	end

	self._curDayFarmRewardCount = self._curDayFarmRewardCount + var_473_0
end

function NewSlgData:updateFarmAward(arg_474_1)
	local var_474_0

	if arg_474_1 then
		::label_474_0::

		var_474_0 = arg_474_1.awards and arg_474_1.awards[1].size
	end

	self._curDayFarmRewardCount = self._curDayFarmRewardCount + var_474_0
end

function NewSlgData:getCurDayFarmRewardCount()
	return self._curDayFarmRewardCount, (g.core.model.User.newSlgDevelopData:getFarmDailyRewardLimit())
end

function NewSlgData:getCurDayFarmKillScore()
	return self._curDayFarmKillScore, (g.core.model.User.newSlgDevelopData:getFarmKillScoreLimit())
end

function NewSlgData:updateFarmAward(arg_477_1)
	return
end

function NewSlgData:getSeasonTask()
	return
end

function NewSlgData:updateTaskSeasonData()
	return
end

function NewSlgData:rewardTaskSeasonData()
	return
end

function NewSlgData:getSeasonTaskAddition()
	return
end

function NewSlgData:getAndUpdateItemNumAfterAddition()
	return
end

function NewSlgData:isHasSeasonTaskAward()
	return
end

function NewSlgData:getCityAuthorityDecreaseNumAndScoreDecrease()
	return self:getCityAuthorityDecreaseNum(...), (self:getCityScoreDecrease(...))
end

function NewSlgData:getCityAuthorityDecreaseNum()
	return
end

function NewSlgData:getCityScoreDecrease()
	return
end

function NewSlgData:getCurTeamCnt()
	return self._teamCurCnt
end

function NewSlgData:getMaxTeamCnt()
	return self._teamMaxCnt
end

function NewSlgData:getTeamElementTypeAndAffectValue(arg_489_1)
	local var_489_0 = {
		matchNum = 0,
		matchIndex = 0
	}

	if not arg_489_1 or #arg_489_1 == 0 then
		return 0, nil, var_489_0
	end

	local var_489_1 = {}
	local var_489_2 = 0
	local var_489_3 = 0

	for iter_489_0, iter_489_1 in ipairs(arg_489_1) do
		local var_489_4 = var_489_1[iter_489_1] or 0
		local var_489_5 = var_489_4 + 1

		var_489_1[iter_489_1] = var_489_4 + 1

		if var_489_3 < var_489_5 then
			var_489_3 = var_489_5
			var_489_2 = iter_489_1
		end
	end

	local var_489_6 = 0
	local var_489_7 = {}
	local var_489_8
	local var_489_9

	for iter_489_2 = 1, var_0_21.getLength() do
		local var_489_10 = var_0_21.indexOf(iter_489_2)

		if var_489_3 >= var_489_10.num then
			var_489_6 = var_489_2
			var_489_8 = var_489_10
			var_489_0.matchIndex = iter_489_2
		elseif var_489_8 then
			var_489_9 = var_489_9 or var_489_10
		end
	end

	if var_489_8 then
		local var_489_11 = 1
		local var_489_12 = {
			"affect_type_"
		}

		var_489_12[2] = 1

		local var_489_13 = table.concat(var_489_12)
		local var_489_14 = table.concat({
			"affect_value_",
			var_489_11
		})

		while var_0_21.hasKey(var_489_13) do
			var_489_7[#var_489_7 + 1] = {
				type = var_489_8[var_489_13],
				value = var_489_8[var_489_14]
			}
			var_489_11 = var_489_11 + 1
			var_489_13 = table.concat({
				"affect_type_",
				var_489_11
			})
			var_489_14 = table.concat({
				"affect_value_",
				var_489_11
			})
		end

		if var_489_9 then
			var_489_0.nextCfg = var_489_9
		end
	end

	var_489_0.matchNum = var_489_3

	return var_489_6, var_489_7, var_489_0
end

function NewSlgData:onUpdateAllianceStrategy(arg_490_1)
	local var_490_0 = {}

	if arg_490_1 and arg_490_1 ~= 0 then
		var_490_0 = {
			arg_490_1
		}
		self._allianceSerData.strategy_base_id = arg_490_1
	else
		self._allianceSerData.strategy_base_id = 0
	end

	self._strategyEffect:setCurStrategyIds(var_490_0)
end

function NewSlgData:updateAllianceSerData(arg_491_1)
	self:_updateAllianceSerData(arg_491_1)
end

function NewSlgData:getDeclaredCityMaxCnt()
	return self:getNewSlgParamsValueById(163) + self._strategyEffect:getEffect(var_0_28.STRATEGY_EFFECT_TYPE.ATTACK_TIMES_TYPE)
end

function NewSlgData:updateCityElement(arg_493_1)
	self._cityElementMap = {}

	for iter_493_0, iter_493_1 in ipairs(arg_493_1) do
		self._cityElementMap[table.concat({
			iter_493_1.group,
			iter_493_1.random_group
		}, "_")] = var_0_23.get(iter_493_1.random_base_id)
	end
end

function NewSlgData:getTeamUnlockLevelByIndex(arg_494_1)
	local var_494_0 = g.core.model.User.newSlgDevelopData:getUnlockTeamNum()
	local var_494_1 = self:getUnlockPassCardTeamNum()
	local var_494_2 = var_494_0 + var_494_1
	local var_494_3 = arg_494_1 <= var_494_0 + var_494_1

	if arg_494_1 > var_494_0 + var_494_1 then
		local var_494_4 = arg_494_1 - var_494_2

		if arg_494_1 - var_494_2 <= self._teamMaxCnt - self._teamCurCnt then
			var_494_4 = var_494_4 + var_494_1

			return var_494_3, self:getExtTeamPassCardPayType(var_494_4), var_0_28.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE
		elseif var_494_4 <= g.core.model.User.newSlgDevelopData:getMaxTroopNum() - var_494_0 + (self._teamMaxCnt - self._teamCurCnt) then
			return g.core.model.User.newSlgDevelopData:getTeamUnlockLevelByIndex(var_494_4 - (self._teamMaxCnt - self._teamCurCnt) + var_494_0)
		end
	end

	return var_494_3, 0
end

function NewSlgData:getTeamUnlockLevelBySourceAndIndex(arg_495_1, arg_495_2)
	if arg_495_1 == var_0_28.TEAM_SOURCE_TYPE.CITY_DEVELOP_SOURCE then
		return g.core.model.User.newSlgDevelopData:getTeamUnlockLevelByIndex(arg_495_2)
	elseif arg_495_1 == var_0_28.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE then
		local var_495_0 = arg_495_2 <= self:getUnlockPassCardTeamNum()

		return var_495_0, (not var_495_0 or nil) and self:getExtTeamPassCardPayType(arg_495_2)
	end
end

function NewSlgData:getUnlockPassCardTeamNum()
	return self._teamCurCnt - g.core.model.User.newSlgDevelopData:getMaxTroopNum()
end

return NewSlgData
