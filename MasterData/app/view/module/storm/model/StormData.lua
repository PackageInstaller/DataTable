local StormData = class("StormData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.storm_area
local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_3 = StormConst.CITY_TYPE

function StormData:ctor()
	self:initData()
end

function StormData:initData()
	self._stormInfo = {}
	self._totalProgress = 0
	self._curSmallCityId = 0
	self._clueEventId = 0
	self._smallCityMap = {}
	self._middleCityMap = {}
	self._bigCityMap = {}
	self._nextIdMap = {}
	self._finishedIdMap = {}
	self._isRcvSkillInfo = false
	self._smallCityList = {}
	self._finishedEvent = {}
	self._cityMaxPageMap = {}
	self._clearStormMap = {}
	self._cityOwnerMap = {}
	self._hasRewardIds = {}
	self._clearDataResetTime = 0
	self._maxOrderMap = {}
	self._skillPoint = 0
	self._costSkillPoint = 0
	self._allStormEventCount = {}
	self._finishStormIdMap = {}
	self._requestStormIds = {}
	self._isSmallCitySkipBattle = false
	self._isMiddleCitySkipBattle = false

	self:_initStormInfo()
end

function StormData:_initStormInfo()
	self._smallCityMap = {}
	self._middleCityMap = {}

	for iter_3_0, iter_3_1 in g.core.config.storm_info.ipairs() do
		if iter_3_1.city_type == var_0_3.SMALL_CITY then
			self._smallCityMap[iter_3_1.id] = {
				percent = 0,
				state = 0,
				info = iter_3_1,
				events = {}
			}
		elseif iter_3_1.city_type == var_0_3.MIDDLE_CITY then
			self._middleCityMap[iter_3_1.id] = {
				maxOrder = 0,
				info = iter_3_1,
				events = {}
			}
		elseif iter_3_1.city_type == var_0_3.BIG_CITY then
			self._bigCityMap[iter_3_1.id] = {
				info = iter_3_1
			}
		end

		if iter_3_1.city_type == var_0_3.SMALL_CITY and iter_3_1.map_id > 0 then
			self._nextIdMap[iter_3_1.preset_id] = iter_3_1.id
		end
	end

	self._allStormEventCount = {}

	for iter_3_2 = 1, g.core.config.storm_cell_event_info.getLength() do
		local var_3_0 = g.core.config.storm_cell_event_info.indexOf(iter_3_2)

		self._allStormEventCount[var_3_0.city_map] = self._allStormEventCount[var_3_0.city_map] or 0
		self._allStormEventCount[var_3_0.city_map] = self._allStormEventCount[var_3_0.city_map] + 1
	end
end

function StormData:getMapCurOpenIndex(arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.small) do
		if self._smallCityMap[iter_4_1].state ~= 0 then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0
end

function StormData:getLandDataByIndex(arg_5_1)
	local var_5_0 = var_0_1.fetch(arg_5_1)

	if not var_5_0 then
		return
	end

	local var_5_1 = {
		small = {}
	}

	for iter_5_0 = 1, 5 do
		if var_5_0["storm" .. iter_5_0] and var_5_0["storm" .. iter_5_0] ~= 0 then
			table.insert(var_5_1.small, var_5_0["storm" .. iter_5_0])
		end
	end

	var_5_1.middle = var_5_0.storm6
	var_5_1.big = var_5_0.storm7
	var_5_1.title = var_5_0.name
	var_5_1.en_title = var_5_0.name_en
	var_5_1.name_en_2 = var_5_0.name_en_2
	var_5_1.longitude = var_5_0.longitude
	var_5_1.latitude = var_5_0.latitude
	var_5_1.chapterId = var_5_0.id
	var_5_1.group = var_5_0.group

	return var_5_1
end

function StormData:getMaxLandNum()
	return var_0_1.getLength()
end

function StormData:getCurFightingPage()
	local var_7_0 = self:getMaxLandNum()

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = g.core.model.User.stormData:getCityState(var_0_1.fetch(iter_7_0).storm1)

		if var_7_1 == 1 then
			return iter_7_0
		elseif var_7_1 == 0 then
			return iter_7_0 - 1
		elseif var_7_1 == 2 and iter_7_0 == var_7_0 then
			return var_7_0
		end
	end
end

function StormData:getCurSmallCityPage()
	for iter_8_0, iter_8_1 in ipairs(self._smallCityMap) do
		if iter_8_1.state == 1 then
			return iter_8_0
		end
	end

	return #self._smallCityMap
end

function StormData:getCityPercent(arg_9_1)
	if self._smallCityMap[arg_9_1] then
		local var_9_0 = self:getMapMaxProgress(self._smallCityMap[arg_9_1].info.id)

		if self._smallCityMap[arg_9_1].state == 0 then
			return 0, 0, var_9_0
		elseif self._smallCityMap[arg_9_1].state == 1 then
			local var_9_1, var_9_2 = self:getCurSmallStormIdByScore(self._totalProgress)

			return (var_9_1 == arg_9_1 and var_9_0 > 0 or nil) and math.floor(var_9_2 / var_9_0 * 100) / 100, var_9_2, var_9_0
		elseif self._smallCityMap[arg_9_1].state == 2 then
			return 1, var_9_0, var_9_0
		end
	end

	return 0
end

function StormData:getCityState(arg_10_1)
	if self._smallCityMap[arg_10_1] then
		return self._smallCityMap[arg_10_1].state
	end

	if arg_10_1 == 0 then
		return 2
	end

	return 0
end

function StormData:updateInfo(arg_11_1)
	self:updateRedPoint(arg_11_1)

	self._cityOwnerMap = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.units or {}) do
		if iter_11_1.city then
			self._cityOwnerMap[iter_11_1.city] = iter_11_1
		end
	end

	self._finishedIdMap = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.finish_storm_ids or {}) do
		self._finishedIdMap[iter_11_3] = true
	end

	g.core.model.User.stormCityData:updateSelfData(arg_11_1.current_city, arg_11_1.current_rank)

	self._hasRewardIds = arg_11_1.finish_award_ids or {}
end

function StormData:isGetStormAward(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._hasRewardIds) do
		if iter_12_1 == arg_12_1 then
			return true
		end
	end

	return false
end

function StormData:updateFinishAwardInfo(arg_13_1)
	table.insert(self._hasRewardIds, arg_13_1.storm_id)
end

function StormData:updateStormInfo(arg_14_1)
	local var_14_0 = g.core.config.storm_info.get(arg_14_1.storm_id)

	if var_14_0.city_type == StormConst.CITY_TYPE.SMALL_CITY then
		if self._smallCityMap[arg_14_1.storm_id] then
			self._smallCityMap[arg_14_1.storm_id].events = arg_14_1.events or {}
		end
	elseif var_14_0.city_type == StormConst.CITY_TYPE.MIDDLE_CITY then
		if self._middleCityMap[arg_14_1.storm_id] then
			self._middleCityMap[arg_14_1.storm_id].events = arg_14_1.events or {}
		end
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.events or {}) do
		self._finishedEvent[iter_14_1.cell_id] = nil
	end
end

function StormData:isMiddleCityFight(arg_15_1)
	if self._middleCityMap[arg_15_1] then
		return #(self._middleCityMap[arg_15_1].events or {}) < self._allStormEventCount[arg_15_1]
	end

	return true
end

function StormData:updateStormClear(arg_16_1)
	self._clearStormMap[arg_16_1.storm_id] = true

	if self._middleCityMap[arg_16_1.storm_id] then
		self._middleCityMap[arg_16_1.storm_id].events = {}
		self._middleCityMap[arg_16_1.storm_id].maxOrder = self:getStormMaxOrder(arg_16_1.storm_id)
	end
end

function StormData:updateStormReset(arg_17_1)
	self._clearStormMap[arg_17_1.storm_id] = true

	if self._middleCityMap[arg_17_1.storm_id] then
		self._middleCityMap[arg_17_1.storm_id].events = arg_17_1.events or {}
		self._middleCityMap[arg_17_1.storm_id].maxOrder = 0

		for iter_17_0, iter_17_1 in ipairs(self._middleCityMap[arg_17_1.storm_id].events) do
			self._finishedEvent[iter_17_1.cell_id] = nil
		end
	end
end

function StormData:updateStormEnemy(arg_18_1)
	if self._middleCityMap[arg_18_1.storm_id] then
		local var_18_0 = {}

		for iter_18_0, iter_18_1 in ipairs(arg_18_1.events or {}) do
			var_18_0[iter_18_1.cell_id] = iter_18_1
			self._finishedEvent[iter_18_1.cell_id] = nil
		end

		local var_18_1 = self._middleCityMap[arg_18_1.storm_id].events or {}

		for iter_18_2 = 1, #var_18_1 do
			if var_18_0[var_18_1[iter_18_2].cell_id] then
				var_18_1[iter_18_2] = var_18_0[var_18_1[iter_18_2].cell_id]
			end
		end
	end
end

function StormData:getCityOwner(arg_19_1)
	return self._cityOwnerMap[arg_19_1]
end

function StormData:getAllCityOverlord()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(self._cityOwnerMap) do
		if iter_20_1.user and iter_20_1.robot_id == 0 then
			table.insert(var_20_0, iter_20_1)
		end
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		if arg_21_0.city and arg_21_1.city and arg_21_0.city ~= arg_21_1.city then
			return arg_21_0.city < arg_21_1.city
		end
	end)

	return var_20_0
end

function StormData:getSmallCityData(arg_22_1)
	return self._smallCityMap[arg_22_1]
end

function StormData:getSmallCityList()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(self._smallCityMap) do
		table.insert(var_23_0, iter_23_1)
	end

	return var_23_0
end

function StormData:getMiddleCityData(arg_24_1)
	return self._middleCityMap[arg_24_1]
end

function StormData:getMiddleCityMap()
	return self._middleCityMap
end

function StormData:getUnlockMiddleCityList()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self._middleCityMap) do
		if self:isPresetUnlock(iter_26_0) then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function StormData:isMiddleCityOpen()
	return #self:getUnlockMiddleCityList() > 0
end

function StormData:getBigCityData(arg_28_1)
	return self._bigCityMap[arg_28_1]
end

function StormData:getBigCityMap()
	return self._bigCityMap
end

function StormData:getCurSmallStorm()
	return self._smallCityMap[self._curSmallCityId]
end

function StormData:getMapMaxProgress(arg_31_1)
	local var_31_0 = g.core.config.storm_info.get(arg_31_1).map_id

	if not self._mapProgressMap then
		self._mapProgressMap = {}

		for iter_31_0, iter_31_1 in g.core.config.storm_cell_event_info.ipairs() do
			self._mapProgressMap[iter_31_1.city_map] = self._mapProgressMap[iter_31_1.city_map] or 0
			self._mapProgressMap[iter_31_1.city_map] = self._mapProgressMap[iter_31_1.city_map] + g.core.config.storm_event_info.get(iter_31_1.event_id_1).weight
		end
	end

	return self._mapProgressMap[var_31_0] or 0
end

function StormData:getCurSmallStormIdByScore(arg_32_1)
	arg_32_1 = arg_32_1 or self._totalProgress

	local var_32_0 = self._nextIdMap[0]

	while var_32_0 do
		local var_32_1 = self:getMapMaxProgress(var_32_0)

		if var_32_1 <= arg_32_1 and self._nextIdMap[var_32_0] then
			arg_32_1 = arg_32_1 - var_32_1
			var_32_0 = self._nextIdMap[var_32_0]
		else
			break
		end
	end

	local var_32_2 = self:getMapMaxProgress(var_32_0)

	return var_32_0, math.min(arg_32_1, var_32_2), var_32_2
end

function StormData:updateStormChallenge(arg_33_1)
	if arg_33_1.is_win then
		self:updateStormEvent(arg_33_1)
	end
end

function StormData:updateStormEvent(arg_34_1)
	local var_34_0 = g.core.config.storm_info.get(arg_34_1.storm_id)

	if var_34_0.city_type == var_0_3.SMALL_CITY then
		self._totalProgress = self._totalProgress + self:getEventProgress(arg_34_1.cell_id)

		local var_34_1 = self._smallCityMap[arg_34_1.storm_id].events or {}

		for iter_34_0, iter_34_1 in ipairs(var_34_1) do
			if iter_34_1.cell_id == arg_34_1.cell_id then
				table.remove(var_34_1, iter_34_0)

				self._finishedEvent[iter_34_1.cell_id] = iter_34_1

				break
			end
		end

		if #var_34_1 == 0 then
			self._smallCityMap[arg_34_1.storm_id].state = 2

			if self._nextIdMap[self._smallCityMap[arg_34_1.storm_id].info.id] then
				if self._smallCityMap[self._nextIdMap[self._smallCityMap[arg_34_1.storm_id].info.id]] and self._smallCityMap[self._nextIdMap[self._smallCityMap[arg_34_1.storm_id].info.id]].state == 0 then
					self._smallCityMap[self._nextIdMap[self._smallCityMap[arg_34_1.storm_id].info.id]].state = 1
				end

				self._curSmallCityId = self._nextIdMap[self._smallCityMap[arg_34_1.storm_id].info.id]
			end

			self._finishedIdMap[self._smallCityMap[arg_34_1.storm_id].info.id] = true
		end

		self._smallCityMap[arg_34_1.storm_id].percent = self:getCityPercent(arg_34_1.storm_id)
	elseif var_34_0.city_type == var_0_3.MIDDLE_CITY then
		local var_34_2 = self._middleCityMap[arg_34_1.storm_id].events or {}

		for iter_34_2, iter_34_3 in ipairs(var_34_2) do
			if iter_34_3.cell_id == arg_34_1.cell_id then
				table.remove(var_34_2, iter_34_2)

				self._finishedEvent[iter_34_3.cell_id] = iter_34_3

				break
			end
		end

		self._middleCityMap[arg_34_1.storm_id].maxOrder = math.max(self._middleCityMap[arg_34_1.storm_id].maxOrder, g.core.config.storm_cell_event_info.get(arg_34_1.cell_id).order)
	end
end

function StormData:isPerEventFinish(arg_35_1, arg_35_2)
	if not self._middleCityMap[arg_35_2].events then
		return true
	end

	local var_35_0 = g.core.config.storm_cell_event_info.get(arg_35_1)
	local var_35_1 = {
		var_35_0.pre_id,
		var_35_0.pre_id_2,
		var_35_0.pre_id_3
	}

	for iter_35_0 = 1, 3 do
		if var_35_1[iter_35_0] == 0 then
			var_35_1[iter_35_0] = nil
		end
	end

	if not var_35_1[1] or var_35_1[1] == 0 then
		return true
	else
		local var_35_2 = {}

		for iter_35_1, iter_35_2 in ipairs(self._middleCityMap[arg_35_2].events) do
			var_35_2[iter_35_2.cell_id] = true
		end

		if #var_35_1 == 1 then
			if var_35_2[var_35_1[1]] then
				return false
			end
		else
			for iter_35_3, iter_35_4 in ipairs(var_35_1) do
				if not var_35_2[iter_35_4] then
					return true
				end
			end

			return false
		end
	end

	return true
end

function StormData:getEventProgress(arg_36_1)
	return g.core.config.storm_event_info.get(g.core.config.storm_cell_event_info.get(arg_36_1).event_id_1).weight
end

function StormData:getFinishedEventByCellId(arg_37_1)
	return self._finishedEvent[arg_37_1]
end

function StormData:getCurSmallCityId()
	return self._curSmallCityId
end

function StormData:_initSkillInfo()
	self._skillData = {}

	for iter_39_0, iter_39_1 in g.core.config.storm_skill_info.ipairs() do
		if not self._skillData[iter_39_1.id] then
			local var_39_0 = require("app.view.module.storm.model.StormSkillStruct").new({
				id = iter_39_1.id,
				info = iter_39_1
			})

			var_39_0:setLevel(0)

			self._skillData[iter_39_1.id] = var_39_0
		else
			self._skillData[iter_39_1.id]:setMaxLevel(math.max(iter_39_1.level, self._skillData[iter_39_1.id]:getMaxLevel()))
		end
	end
end

function StormData:updateSkillData(arg_40_1)
	self:_initSkillInfo()

	self._skillPoint = 0
	self._costSkillPoint = 0

	if arg_40_1.storm_skill then
		local var_40_1 = arg_40_1.storm_skill.lvs or {}

		for iter_40_0, iter_40_1 in ipairs(arg_40_1.storm_skill.ids or {}) do
			self._skillData[iter_40_1]:setLevel(var_40_1[iter_40_0])
		end

		self._skillPoint = arg_40_1.storm_skill.score
		self._costSkillPoint = arg_40_1.storm_skill.cost_score
	end

	self._isRcvSkillInfo = true
end

function StormData:getSkillPoint()
	return self._skillPoint
end

function StormData:getCostSkillPoint()
	return self._costSkillPoint
end

function StormData:updateSkillLvUp(arg_43_1)
	if not self._skillData then
		self:_initSkillInfo()
	end

	self._skillData[arg_43_1.id]:setLevel(arg_43_1.tg_lv)
end

function StormData:resetSkill()
	self:_initSkillInfo()
end

function StormData:getSkillData()
	if not self._skillData then
		self:_initSkillInfo()
	end

	return self._skillData
end

function StormData:getSkillDataById(arg_46_1)
	if not self._skillData then
		self:_initSkillInfo()
	end

	return self._skillData[arg_46_1]
end

function StormData:isRcvSkillInfo()
	return self._isRcvSkillInfo
end

function StormData:getSkillAttrs()
	if not self._skillData then
		self:_initSkillInfo()
	end

	local var_48_0 = {}

	for iter_48_0, iter_48_1 in pairs(self._skillData) do
		local var_48_1 = iter_48_1:getInfo()

		if var_48_1.level > 0 then
			local var_48_2 = g.core.config.talent_skill_info.get(var_48_1.talent_id)

			var_48_0[var_48_2.affect_type_1] = var_48_0[var_48_2.affect_type_1] or 0
			var_48_0[var_48_2.affect_type_1] = var_48_0[var_48_2.affect_type_1] + var_48_2.affect_value_1
		end
	end

	return var_48_0
end

function StormData:isPresetUnlock(arg_49_1)
	local var_49_0 = g.core.config.storm_info.get(arg_49_1)

	if var_49_0.preset_id == 0 then
		return true
	end

	if self._smallCityMap[var_49_0.preset_id] then
		return self._smallCityMap[var_49_0.preset_id].state == 2
	end

	return false
end

function StormData:isPassStorm(arg_50_1)
	return self._finishedIdMap[arg_50_1]
end

function StormData:getMapCellEventCfgs(arg_51_1)
	if not self._cellEventCfgs then
		self._cellEventCfgs = {}

		for iter_51_0, iter_51_1 in g.core.config.storm_cell_event_info.ipairs() do
			self._cellEventCfgs[iter_51_1.city_map] = self._cellEventCfgs[iter_51_1.city_map] or {}

			table.insert(self._cellEventCfgs[iter_51_1.city_map], iter_51_1)
		end
	end

	return self._cellEventCfgs[arg_51_1]
end

function StormData:getCityMaxPage(arg_52_1)
	local var_52_0 = g.core.config.storm_info.get(arg_52_1).map_id

	if not self._cityMaxPageMap[var_52_0] then
		local var_52_1 = self:getMapCellEventCfgs(var_52_0)
		local var_52_2 = 1

		if var_52_1 then
			for iter_52_0, iter_52_1 in ipairs(var_52_1) do
				var_52_2 = math.max(var_52_2, iter_52_1.page)
			end
		end

		self._cityMaxPageMap[var_52_0] = var_52_2
	end

	return self._cityMaxPageMap[var_52_0]
end

function StormData:getMiddleCityPlayNumId(arg_53_1)
	return g.core.const.ConstMgr.ShopConst.PLAY_TYPE["STORM_MIDDLE_CITY" .. arg_53_1 - 2000]
end

function StormData:getMiddleCityPlayNum(arg_54_1)
	return g.core.model.User.shopData:getLeftCount((self:getMiddleCityPlayNumId(arg_54_1)))
end

function StormData:isMiddleCityCleared(arg_55_1)
	if not g.core.common.ServerTime:isToday(self._clearDataResetTime) then
		self._clearStormMap = {}
		self._clearDataResetTime = g.core.common.ServerTime:getTime()
	end

	return checkbool(self._clearStormMap[arg_55_1])
end

function StormData:isMiddleCityInOpenTime()
	local var_56_0 = g.core.config.time_event_info.get(7, 0)
	local var_56_1 = var_56_0.end_time
	local var_56_2 = g.core.common.ServerTime:secondsFromCurMonday(g.core.common.ServerTime:getTime())

	return var_56_0.open_time <= var_56_2 and var_56_2 < var_56_1
end

function StormData:getCurMiddleCityId()
	local var_57_0 = 0
	local var_57_1

	for iter_57_0, iter_57_1 in pairs(self._middleCityMap) do
		if self:isPresetUnlock(iter_57_0) then
			var_57_0 = math.max(var_57_0, iter_57_0)
		end

		var_57_1 = not var_57_1 and iter_57_0 or math.min(var_57_1, iter_57_0)
	end

	if var_57_0 > 0 then
		return var_57_0
	else
		return var_57_1
	end
end

function StormData:getCurUnlockMiddleCityId()
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in pairs(self._middleCityMap) do
		if self:isPresetUnlock(iter_58_0) then
			var_58_0 = math.max(var_58_0, iter_58_0)
		end
	end

	if var_58_0 > 0 then
		return var_58_0
	end
end

function StormData:getUnlockCitys(arg_59_1)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in g.core.config.storm_info.ipairs() do
		if iter_59_1.preset_id == arg_59_1 then
			if iter_59_1.city_type == var_0_3.MIDDLE_CITY then
				table.insert(var_59_0, iter_59_1)
			elseif iter_59_1.city_type == var_0_3.BIG_CITY then
				table.insert(var_59_0, iter_59_1)
			end
		end
	end

	return var_59_0
end

function StormData:getCurBigCityId()
	local var_60_0 = 0
	local var_60_1

	for iter_60_0, iter_60_1 in pairs(self._bigCityMap) do
		if self:isPresetUnlock(iter_60_0) then
			var_60_0 = math.max(var_60_0, iter_60_0)
		end

		var_60_1 = not var_60_1 and iter_60_0 or math.min(var_60_1, iter_60_0)
	end

	if var_60_0 > 0 then
		return var_60_0
	else
		return var_60_1
	end
end

function StormData:isUnlockBlitz(arg_61_1)
	local var_61_0 = g.core.config.storm_info.get(arg_61_1)

	if var_61_0.sweep > 0 then
		return self:isPresetUnlock(var_61_0.sweep)
	end

	return false
end

function StormData:getMapAllEventInfo(arg_62_1)
	if not self._allEventInfoMap then
		self._allEventInfoMap = {}

		for iter_62_0, iter_62_1 in g.core.config.storm_cell_event_info.ipairs() do
			self._allEventInfoMap[iter_62_1.city_map] = self._allEventInfoMap[iter_62_1.city_map] or {}

			table.insert(self._allEventInfoMap[iter_62_1.city_map], iter_62_1)
		end
	end

	return self._allEventInfoMap[arg_62_1] or {}
end

function StormData:getMapAllEventInfoByStormId(arg_63_1)
	return self:getMapAllEventInfo(g.core.config.storm_info.get(arg_63_1).map_id)
end

function StormData:getStormMaxOrder(arg_64_1)
	if not self._maxOrderMap[arg_64_1] then
		local var_64_0 = 0

		for iter_64_0, iter_64_1 in ipairs((self:getMapAllEventInfoByStormId(arg_64_1))) do
			var_64_0 = math.max(iter_64_1.order, var_64_0)
		end

		self._maxOrderMap[arg_64_1] = var_64_0
	end

	return self._maxOrderMap[arg_64_1] or 0
end

function StormData:isMiddleCityStageClear(arg_65_1)
	local var_65_0 = self:getMiddleCityData(arg_65_1)

	if var_65_0 then
		return var_65_0.maxOrder == self:getStormMaxOrder(arg_65_1)
	end

	return false
end

function StormData:onS2CFlushRedPoint(arg_66_1)
	if not arg_66_1.storm_hint then
		return
	end

	self:updateRedPoint(arg_66_1.storm_hint)
end

function StormData:updateRedPoint(arg_67_1)
	self._hasRewardIds = arg_67_1.award_storm_ids or {}
	self._totalProgress = arg_67_1.total_progress

	local var_67_0 = arg_67_1.finish_storm_ids or {}
	local var_67_1 = {}

	for iter_67_0, iter_67_1 in ipairs(var_67_0) do
		var_67_1[iter_67_1] = true
	end

	self._finishedIdMap = var_67_1

	local var_67_2 = self._nextIdMap[0]

	for iter_67_2, iter_67_3 in ipairs(var_67_0) do
		if self._nextIdMap[iter_67_3] then
			if not var_67_1[self._nextIdMap[iter_67_3]] then
				var_67_2 = self._nextIdMap[iter_67_3]

				break
			end
		else
			var_67_2 = iter_67_3

			break
		end
	end

	self._curSmallCityId = var_67_2

	for iter_67_4, iter_67_5 in pairs(self._smallCityMap) do
		if var_67_1[iter_67_4] then
			iter_67_5.state = 2
			iter_67_5.percent = 1
		elseif iter_67_4 == var_67_2 then
			iter_67_5.state = 1

			local var_67_3, var_67_4, var_67_5 = self:getCurSmallStormIdByScore(self._totalProgress)

			if var_67_3 == var_67_2 and var_67_5 > 0 then
				iter_67_5.percent = math.floor(var_67_4 / var_67_5 * 100) / 100
			end
		else
			iter_67_5.state = 0
			iter_67_5.percent = 0
		end
	end

	self._clearStormMap = {}

	for iter_67_6, iter_67_7 in ipairs(arg_67_1.clear_storm_ids or {}) do
		self._clearStormMap[iter_67_7] = true
	end

	local var_67_7 = arg_67_1.max_order or {}

	for iter_67_8, iter_67_9 in ipairs(arg_67_1.storm_ids or {}) do
		if g.core.config.storm_info.get(iter_67_9).city_type == StormConst.CITY_TYPE.MIDDLE_CITY then
			local var_67_8 = self:getMiddleCityData(iter_67_9)

			if var_67_8 then
				var_67_8.maxOrder = var_67_7[iter_67_8]
			end
		end
	end

	self._clearDataResetTime = g.core.common.ServerTime:getTime()
end

function StormData:isSmallStormClear(arg_68_1)
	return checkbool(self._finishedIdMap[arg_68_1])
end

function StormData:setSmallCityFinish()
	self._smallCityFinish = true
end

function StormData:checkSmallCityFinish()
	if self._smallCityFinish then
		self._smallCityFinish = false

		return true
	end

	return false
end

function StormData:isAllStormFinish(arg_71_1)
	if arg_71_1 == var_0_3.SMALL_CITY then
		for iter_71_0, iter_71_1 in pairs(self._smallCityMap) do
			if iter_71_1.state == 1 then
				return false
			end
		end
	elseif arg_71_1 == var_0_3.MIDDLE_CITY and self:isMiddleCityOpen() then
		return false
	end

	return true
end

function StormData:getLeftMiddleCitySweepTimes(arg_72_1)
	for iter_72_0, iter_72_1 in pairs(self._middleCityMap) do
		if self:isPresetUnlock(iter_72_0) and not self:isMiddleCityCleared(iter_72_0) then
			-- block empty
		end
	end
end

function StormData:isCanGetFreeReward()
	for iter_73_0, iter_73_1 in pairs((self:getSmallCityList())) do
		if not self:isGetStormAward(iter_73_1.info.id) and iter_73_1.state == 2 then
			return true
		end
	end

	return false
end

function StormData:getAllCanRewardIds()
	local var_74_0 = {}

	for iter_74_0, iter_74_1 in pairs((self:getSmallCityList())) do
		if not self:isGetStormAward(iter_74_1.info.id) and iter_74_1.state == 2 then
			table.insert(var_74_0, iter_74_1.info.id)
		end
	end

	return var_74_0
end

function StormData:isCanStormSkillLvUp()
	local var_75_0 = self:getSkillPoint()

	if var_75_0 <= 0 then
		return false
	end

	local var_75_1 = {}

	for iter_75_0, iter_75_1 in g.core.config.storm_skill_info.ipairs() do
		if iter_75_1.level == 0 then
			for iter_75_2 = 1, 4 do
				if iter_75_1["preset_skill_" .. iter_75_2] > 0 then
					-- block empty
				end
			end

			var_75_1[iter_75_1.order1] = var_75_1[iter_75_1.order1] or {}
			var_75_1[iter_75_1.order1][iter_75_1.order2] = iter_75_1.id
		end
	end

	for iter_75_3, iter_75_4 in pairs(var_75_1) do
		for iter_75_5, iter_75_6 in pairs(iter_75_4) do
			local var_75_2 = self:getSkillDataById(iter_75_6)

			if var_75_2:isCanActive() and var_75_2:getLevel() < var_75_2:getMaxLevel() and var_75_0 >= var_75_2:getInfo().cost then
				return true
			end
		end
	end

	return false
end

function StormData:setFinishId(arg_76_1)
	self._finishStormId = arg_76_1
end

function StormData:getFinishId()
	if self._finishStormId then
		self._finishStormId = nil

		return self._finishStormId
	end
end

function StormData:isStormCityOpeningById(arg_78_1)
	if self:getCityState(g.core.config.storm_info.get(arg_78_1).preset_id) == 2 then
		return true
	end

	return false
end

function StormData:isStormCntEnough(arg_79_1)
	local var_79_0

	if not arg_79_1 then
		arg_79_1 = {}
		var_79_0 = g.core.model.User.resourceData:getRecoverCfg(g.core.common.Goods.RESOURCE.TYPE_TIRED).time_limit
	end

	if g.core.model.User.bagData:getCountById(1, 24) <= 5 then
		return false
	end

	if not arg_79_1.id then
		for iter_79_0, iter_79_1 in pairs(self._smallCityMap) do
			if iter_79_1.state == 1 then
				return true
			end
		end
	else
		return self._smallCityMap[arg_79_1.id].state == 1
	end

	return false
end

function StormData:setMapLandSelIndex(arg_80_1)
	self._mapLandIndex = arg_80_1
end

function StormData:getMapLandSelIndex()
	if self._mapLandIndex then
		self._mapLandIndex = nil

		return self._mapLandIndex
	end
end

function StormData:isArrowNeedShowRedPoint(arg_82_1)
	local var_82_0 = false
	local var_82_1 = false

	if not arg_82_1 then
		return var_82_0, var_82_1
	end

	var_82_0 = (g.core.model.User.stormCityData:isHasDailyReward() or g.core.model.User.stormCityData:canRevHegemonyReward() or g.core.model.User.stormCityData:hasLordAchieveAward()) and (g.core.model.User.stormCityData:chechCityIsOpen(arg_82_1.big) or true)

	if self:isStormCntEnough() and self:getCurFightingPage() ~= arg_82_1.chapterId then
		var_82_1 = true
	end

	for iter_82_0, iter_82_1 in pairs((self:getUnlockMiddleCityList())) do
		if self:isStormCenterEnough({
			id = iter_82_1.info.id
		}) then
			if arg_82_1.middle > iter_82_1.info.id then
				var_82_0 = true
			elseif arg_82_1.middle < iter_82_1.info.id then
				var_82_1 = true
			end
		end
	end

	return var_82_0, var_82_1
end

function StormData:isHaveNotEnter()
	return (g.core.common.Storage:load("isREnterStormCache.json", true) or {}).isEnter
end

function StormData:setIsEnter()
	g.core.common.Storage:save("isREnterStormCache.json", {
		isEnter = true
	}, true)
end

function StormData:setIsFirstEnter()
	self._isFirstEnter = true
end

function StormData:checkIsFirstEnter()
	self._isFirstEnter = false

	return self._isFirstEnter
end

function StormData:setSmallCitySkipBattleState(arg_87_1)
	self._isSmallCitySkipBattle = arg_87_1
end

function StormData:isSmallCitySkipBattle()
	return self._isSmallCitySkipBattle
end

function StormData:setMiddleCitySkipBattleState(arg_89_1)
	self._isMiddleCitySkipBattle = arg_89_1
end

function StormData:isMiddleCitySkipBattle()
	return self._isMiddleCitySkipBattle
end

function StormData:isStormCenterEnough(arg_91_1)
	if not self:isMiddleCityInOpenTime() then
		return false
	end

	local var_91_0 = g.core.model.User.shopData
	local var_91_1 = arg_91_1 and arg_91_1.id

	if arg_91_1 and arg_91_1.id and var_91_1 > 0 then
		if not self:isPresetUnlock(var_91_1) then
			return false
		end

		if var_91_0:getLeftCount((self:getMiddleCityPlayNumId(var_91_1))) > 0 then
			return true
		end
	else
		for iter_91_0, iter_91_1 in pairs((self:getUnlockMiddleCityList())) do
			if var_91_0:getLeftCount((self:getMiddleCityPlayNumId(iter_91_1.info.id))) > 0 then
				return true
			end
		end
	end

	return false
end

function StormData:isCanResetAndPass(arg_92_1)
	if not self:isMiddleCityInOpenTime() then
		return false
	end

	if arg_92_1 and arg_92_1.id then
		return self:isPresetUnlock(arg_92_1.id) and not self:isMiddleCityCleared(arg_92_1.id)
	else
		for iter_92_0, iter_92_1 in pairs((self:getUnlockMiddleCityList())) do
			if self:isPresetUnlock(iter_92_1.info.id) and not self:isMiddleCityCleared(iter_92_1.info.id) then
				return true
			end
		end
	end

	return false
end

function StormData:isStationOpenAndWeekFirstEnter()
	if g.core.model.User.stormCityData:isProcess() then
		local var_93_0 = g.core.common.Storage:load("week_storm_station_cache.json") or {}
		local var_93_1 = os.date("*t", (g.core.common.ServerTime:getTime()))

		if var_93_0[var_93_1.year .. "_" .. var_93_1.month .. "_" .. var_93_1.day] then
			return false
		end

		var_93_0[var_93_1.year .. "_" .. var_93_1.month .. "_" .. var_93_1.day] = true

		g.core.common.Storage:save("week_storm_station_cache.json", var_93_0)

		return true
	end

	return false
end

function StormData:isStormRequested(arg_94_1)
	if self._requestStormIds[arg_94_1] then
		return true
	end

	self._requestStormIds[arg_94_1] = true

	return false
end

function StormData:setSmallCityClueEventId(arg_95_1)
	self._clueEventId = arg_95_1
end

function StormData:getSmallCityClueEventId()
	return self._clueEventId
end

return StormData
