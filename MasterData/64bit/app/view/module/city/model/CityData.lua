local CityData = class("CityData")
local CityStruct = import(".CityStruct")
local var_0_2 = g.core.config.city_info

function CityData:ctor()
	self:initData()
end

function CityData:initData()
	self._cityMap = {}
	self._cityList = {}
	self._cityData = {}
	self._cityKnight = {}
	self._spList = {}
	self._knightList = {}
	self._numCity = 0
	self._patrolKnight = {}
	self._friendData = {}
	self._newCityCache = {}
	self._isEnterAni = false
	self._hasTrouble = false
	self._isResponse = false
	self._patrolCfg = {}
	self._originalPatrolCfg = {}
	self._cityBaseInfo = {}
	self._friendCityList = {}
	self._friendCityMap = {}
	self._patrolReadyKnightList = {}

	self:_initCityList()
	self:_initNewCityCache()
end

function CityData:_initCityList()
	for iter_3_0 = 1, var_0_2.getLength() do
		local var_3_0 = var_0_2.indexOf(iter_3_0)

		if var_3_0.level == 1 then
			local var_3_1 = CityStruct.new(var_3_0.advance_id)

			self._cityMap[var_3_0.advance_id] = var_3_1
			self._cityList[#self._cityList + 1] = var_3_1
		end
	end

	self._numCity = self:updateCityTotalNum()
end

function CityData:_initNewCityCache()
	self._newCityCache = g.core.common.Storage:load("newCity.json") or {}
end

function CityData:isNewCity(arg_5_1)
	local var_5_0 = self._newCityCache[tostring(arg_5_1)]

	if var_5_0 == nil then
		var_5_0 = true
	end

	return var_5_0
end

function CityData:clearNewCity()
	for iter_6_0, iter_6_1 in pairs((var_0_2.match(function(arg_7_0)
		return arg_7_0.level == 1
	end))) do
		if g.core.model.User.dungeonData:isStagePassed(iter_6_1.stage_id) then
			self._newCityCache[tostring(iter_6_1.advance_id)] = false
		end
	end

	g.core.common.Storage:save("newCity.json", self._newCityCache)
end

function CityData:setEnterAniFlag()
	self._isEnterAni = true
end

function CityData:getEnterAniFlag()
	return self._isEnterAni
end

function CityData:getPatrolCost()
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(self._patrolCfg) do
		local var_10_2 = self:getOneKeyPatrolKnight(iter_10_1.city_id)

		if var_10_2 and var_10_2 > 0 then
			local var_10_3 = g.core.config.city_process_model_info.get(iter_10_1.model_id)

			if var_10_3.cost_type_1 == 1 and var_10_3.cost_value_1 == 4 then
				var_10_0 = var_10_0 + var_10_3.cost_size_1
			end

			if var_10_3.cost_type_1 == 999 and var_10_3.cost_value_1 == 0 then
				var_10_1 = var_10_1 + var_10_3.cost_size_1
			end
		end
	end

	return var_10_0, var_10_1
end

function CityData:setOneKeyPatrolCfg()
	local var_11_0 = g.core.common.Storage:load("city_patrol_onekey.json")

	if var_11_0 then
		self._patrolCfg = clone(var_11_0)
		self._originalPatrolCfg = clone(var_11_0)
	else
		self._patrolCfg = {}

		for iter_11_0 = 1, self._numCity do
			table.insert(self._patrolCfg, {
				model_id = 1,
				city_id = self._cityList[iter_11_0]:getCfg().advance_id
			})
		end

		g.core.common.Storage:save("city_patrol_onekey.json", self._patrolCfg)
	end
end

function CityData:saveOneKeyPatrolCfg()
	g.core.common.Storage:save("city_patrol_onekey.json", self._patrolCfg)

	self._originalPatrolCfg = clone(self._patrolCfg)
end

function CityData:isSamePatrolCfg()
	if #self._originalPatrolCfg ~= #self._patrolCfg then
		return false
	end

	for iter_13_0, iter_13_1 in ipairs(self._patrolCfg) do
		for iter_13_2, iter_13_3 in ipairs(self._originalPatrolCfg) do
			if iter_13_1.city_id == iter_13_3.city_id and iter_13_1.model_id ~= iter_13_3.model_id then
				return false
			end
		end
	end

	return true
end

function CityData:updateOneKeyPatrolCfg(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(self._patrolCfg) do
		if iter_14_1.city_id == arg_14_1 then
			iter_14_1.model_id = arg_14_2
		end
	end
end

function CityData:updateCityData(arg_15_1)
	self._isResponse = true
	self._cityData = arg_15_1.cities or {}
	self._cityKnight = arg_15_1.knights or {}
	self._patrolKnight = {}

	self:setOneKeyPatrolCfg()
	table.sort(self._cityData, function(arg_16_0, arg_16_1)
		if arg_16_0.id ~= arg_16_1.id then
			return arg_16_0.id < arg_16_1.id
		end
	end)

	for iter_15_0 = 1, #self._cityList do
		if not self._cityData[iter_15_0] then
			self._cityData[iter_15_0] = {}
			self._cityData[iter_15_0].id = iter_15_0 * 10
			self._cityData[iter_15_0].knight_id = 0
			self._cityData[iter_15_0].level = 1
			self._cityData[iter_15_0].model_id = 0
			self._cityData[iter_15_0].start_time = 0
			self._cityData[iter_15_0].isUnlock = false
		end

		self:updateCityServerData(self._cityData[iter_15_0])

		if self._cityData[iter_15_0].knight_id > 0 then
			table.insert(self._patrolKnight, self._cityData[iter_15_0].knight_id)
		end
	end

	for iter_15_1 = 1, #self._cityKnight do
		self._cityMap[self._cityKnight[iter_15_1].city_id]:updateSpKnightAdvId(self._cityKnight[iter_15_1].knight_id)
	end
end

function CityData:updateCityServerData(arg_17_1)
	self._cityMap[arg_17_1.id]:setServerData(arg_17_1)
end

function CityData:addPatrolKnight(arg_18_1)
	table.insert(self._patrolKnight, arg_18_1)
end

function CityData:startOneKeyPatrol(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1.patrol_configs) do
		if iter_19_1.city then
			self:updateCityServerData(iter_19_1.city)
			self:addPatrolKnight(iter_19_1.city.knight_id)
		end
	end

	self:initOneKeyPatrolKnightList()
end

function CityData:updateFriendData(arg_20_1)
	self._friendData = arg_20_1.friends or {}

	if not next(self._friendData) then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(self._friendData) do
		local var_20_0 = g.core.model.User.friendData:getFriendInfoById(iter_20_1.id)

		iter_20_1.intimate = var_20_0 and var_20_0:getFriendIntimateLv() or 0
	end

	table.sort(self._friendData, function(arg_21_0, arg_21_1)
		if arg_21_0.trouble_city_num and arg_21_1.trouble_city_num and arg_21_0.trouble_city_num ~= arg_21_1.trouble_city_num then
			return arg_21_0.trouble_city_num > arg_21_1.trouble_city_num
		end

		if arg_21_0.intimate ~= arg_21_1.intimate then
			return arg_21_0.intimate > arg_21_1.intimate
		end

		if arg_21_0.level ~= arg_21_1.level then
			return arg_21_0.level > arg_21_1.level
		end

		return arg_21_0.id > arg_21_1.id
	end)
end

function CityData:updateFriendTrouble(arg_22_1)
	if arg_22_1.trouble_friends and next(arg_22_1.trouble_friends) then
		self._hasTrouble = true
	end
end

function CityData:checkIsCanGetReward()
	for iter_23_0 = 1, self._numCity do
		if self._cityList[iter_23_0] and self._cityList[iter_23_0]:getCityStateCtrlIndex() == 2 then
			return true
		end
	end

	return false
end

function CityData:checkIsCanPatrol()
	for iter_24_0 = 1, self._numCity do
		if self._cityList[iter_24_0] and self._cityList[iter_24_0]:getCityStateCtrlIndex() == 3 then
			return true
		end
	end

	return false
end

function CityData:CheckPatrolReward()
	local var_25_0 = false
	local var_25_1 = 0

	for iter_25_0 = 1, self._numCity do
		if self._cityList[iter_25_0] and (self._cityList[iter_25_0]:getCityStateCtrlIndex() == 0 or self._cityList[iter_25_0]:getCityStateCtrlIndex() == 2) then
			var_25_0 = true

			if var_25_1 == 0 or var_25_1 > self._cityList[iter_25_0]:getDeadLine() then
				var_25_1 = self._cityList[iter_25_0]:getDeadLine()
			end
		end
	end

	return var_25_0, var_25_1
end

function CityData:updateFriendCityData(arg_26_1)
	self._friendCityList = {}
	self._friendCityMap = {}

	local var_26_0 = arg_26_1.citys or {}

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		if arg_27_0.id ~= arg_27_1.id then
			return arg_27_0.id < arg_27_1.id
		end
	end)

	for iter_26_0 = 1, self._numCity do
		if var_26_0[iter_26_0] then
			var_26_0[iter_26_0].isUnlock = true
		else
			var_26_0[iter_26_0] = self:_getInitCityServerData(iter_26_0)
		end

		local var_26_1 = CityStruct.new(var_26_0[iter_26_0].id)

		var_26_1:setServerData(var_26_0[iter_26_0])

		self._friendCityList[iter_26_0] = var_26_1
		self._friendCityMap[var_26_0[iter_26_0].id] = var_26_1
	end
end

function CityData:updateEventAndAwardData(arg_28_1, arg_28_2)
	local var_28_0 = self:_getCityStruct(arg_28_1.city_id, arg_28_2)

	if var_28_0 then
		var_28_0:updateEventAndAwardData()
	end
end

function CityData:getCityInfoById(arg_29_1)
	return self._cityMap[arg_29_1]:getCfg()
end

function CityData:getCityDeadLineById(arg_30_1, arg_30_2)
	return self:_getCityStruct(arg_30_1, arg_30_2):getDeadLine()
end

function CityData:getSpKnightByCityId(arg_31_1)
	return self._cityMap[arg_31_1]:getSpKnightAdvId()
end

function CityData:updateCityTotalNum()
	local var_32_0 = 0

	for iter_32_0 = 1, var_0_2.getLength() do
		if var_0_2.indexOf(iter_32_0).level == 1 then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function CityData:isNoteSpKnight(arg_33_1, arg_33_2)
	local var_33_0 = self._cityMap[arg_33_1]:getSpKnightAdvId()
	local var_33_1 = 0

	local function var_33_2(arg_34_0)
		for iter_34_0 = 1, #self._patrolKnight do
			if arg_34_0 == self._patrolKnight[iter_34_0] then
				return true
			end
		end

		return false
	end

	for iter_33_0 = 1, #var_33_0 do
		if not var_33_2(var_33_0[iter_33_0].advId) then
			local var_33_3 = g.core.model.User.knightsData:hasKnightByAdvanceId(var_33_0[iter_33_0].advId)

			if var_33_0[iter_33_0].advId == arg_33_2 then
				return false
			end

			if var_33_3 then
				var_33_1 = var_33_1 + 1
			end
		end
	end

	if var_33_1 > 0 then
		return true
	end

	return false
end

function CityData:updateAllSpecialKnight(arg_35_1)
	self._spList = {}

	for iter_35_0 = 1, self._numCity do
		if self._cityList[iter_35_0]:isCityUnlock() then
			local var_35_0 = self._cityList[iter_35_0]:getCfg()
			local var_35_2 = self._cityList[iter_35_0]:getSpKnightAdvId()

			for iter_35_1 = 1, #var_35_2 do
				self._spList[#self._spList + 1] = {
					advId = var_35_2[iter_35_1].advId,
					cityName = var_35_0.name,
					cityId = var_35_0.advance_id
				}
			end
		end
	end

	self:_updateKnightList(arg_35_1)
end

function CityData:_updateKnightList(arg_36_1)
	local var_36_0 = g.core.model.User.knightsData:getOwnerList()

	self._knightList = {}

	local function var_36_1(arg_37_0)
		for iter_37_0 = 1, #self._patrolKnight do
			if arg_37_0 == self._patrolKnight[iter_37_0] then
				return true
			end
		end

		return false
	end

	local function var_36_2(arg_38_0)
		if arg_36_1 then
			for iter_38_0, iter_38_1 in pairs(self._patrolReadyKnightList) do
				if arg_38_0 == iter_38_1 then
					return true
				end
			end
		end

		return false
	end

	for iter_36_0 = 1, #var_36_0 do
		local var_36_3 = var_36_0[iter_36_0]:getBaseInfo().advance_id

		if not var_36_1(var_36_3) and not var_36_2(var_36_3) then
			local var_36_4 = {}

			for iter_36_1 = 1, #self._spList do
				if var_36_3 == self._spList[iter_36_1].advId then
					var_36_4 = self._spList[iter_36_1]
				end
			end

			self._knightList[#self._knightList + 1] = {
				data = var_36_0[iter_36_0],
				cityData = var_36_4
			}
		end
	end
end

function CityData:getKnightList(arg_39_1, arg_39_2)
	self:updateAllSpecialKnight(arg_39_2)
	table.sort(self._knightList, function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_1.cityData
		local var_40_1 = arg_40_0.data:getBaseInfo()
		local var_40_2 = arg_40_1.data:getBaseInfo()

		if next(arg_40_0.cityData) ~= next(arg_40_1.cityData) then
			return next(arg_40_0.cityData)
		end

		if next(arg_40_0.cityData) and next(var_40_0) then
			if arg_40_0.cityData.cityId ~= var_40_0.cityId then
				if arg_40_0.cityData.cityId == arg_39_1 then
					return true
				elseif var_40_0.cityId == arg_39_1 then
					return false
				else
					return arg_40_0.cityData.cityId < var_40_0.cityId
				end
			else
				return var_40_1.quality > var_40_2.quality
			end
		end

		if var_40_1.quality ~= var_40_2.quality then
			return var_40_1.quality > var_40_2.quality
		end

		return var_40_1.advance_id < var_40_2.advance_id
	end)

	return self._knightList
end

function CityData:isNeedSchedule(arg_41_1)
	local var_41_0 = g.core.common.ServerTime:getTime()

	for iter_41_0, iter_41_1 in ipairs(arg_41_1 and self._friendCityList or self._cityList) do
		if var_41_0 < iter_41_1:getDeadLine() then
			return true
		end
	end

	return false
end

function CityData:getNextAwardTimeById(arg_42_1, arg_42_2)
	local var_42_0 = self:_getCityStruct(arg_42_1, arg_42_2)

	return (var_42_0 or nil) and var_42_0:getNextAwardTime()
end

function CityData:getCurEventAndAwardData(arg_43_1, arg_43_2)
	local var_43_0 = self:_getCityStruct(arg_43_1, arg_43_2)
	local var_43_1 = {}
	local var_43_2 = {}

	if var_43_0 then
		var_43_1, var_43_2 = var_43_0:getCurEventAndAwardData()
	end

	return var_43_1, var_43_2
end

function CityData:getSpCityKnightId(arg_44_1, arg_44_2)
	return (self:_getCityStruct(arg_44_1, arg_44_2):getSpCityKnightId())
end

function CityData:getAllSpKnightInfo(arg_45_1, arg_45_2)
	local var_45_0 = self:_getCityStruct(arg_45_1, arg_45_2)

	return (var_45_0 or nil) and var_45_0:getAllSpKnightInfo()
end

function CityData:getCurModelId(arg_46_1, arg_46_2)
	return self:_getCityStruct(arg_46_1, arg_46_2):getServerData().model_id
end

function CityData:isPatrol(arg_47_1, arg_47_2)
	local var_47_0 = self:_getCityStruct(arg_47_1, arg_47_2):getServerData().start_time

	if var_47_0 then
		return var_47_0 > 0
	else
		return false
	end
end

function CityData:updateCityFinish(arg_48_1)
	if self._cityMap[arg_48_1] then
		self._cityMap[arg_48_1]:setFinish()
	end
end

function CityData:updateCityOneKeyFinish(arg_49_1)
	for iter_49_0, iter_49_1 in ipairs(arg_49_1 or {}) do
		self:updateCityFinish(iter_49_1)
	end
end

function CityData:getPatrolKnightId(arg_50_1, arg_50_2)
	return self:_getCityStruct(arg_50_1, arg_50_2):getServerData().knight_id
end

function CityData:isPatrolFinish(arg_51_1, arg_51_2)
	return (self:_getCityStruct(arg_51_1, arg_51_2):isPatrolFinish())
end

function CityData:getAllAwardData(arg_52_1, arg_52_2)
	return (self:_getCityStruct(arg_52_1, arg_52_2):getAllAwardData())
end

function CityData:getNormalAwardData(arg_53_1, arg_53_2)
	return (self:_getCityStruct(arg_53_1, arg_53_2):getNormalAwardData())
end

function CityData:getSurpAwardData(arg_54_1, arg_54_2)
	return (self:_getCityStruct(arg_54_1, arg_54_2):getSurpAwardData())
end

function CityData:getCityStateCtrlIndex(arg_55_1, arg_55_2)
	return (self:_getCityStruct(arg_55_1, arg_55_2):getCityStateCtrlIndex())
end

function CityData:isTrouble(arg_56_1, arg_56_2)
	return (self:_getCityStruct(arg_56_1, arg_56_2):isTrouble())
end

function CityData:resetPatrolKnight(arg_57_1)
	local var_57_0 = self._cityMap[arg_57_1]:getServerData().knight_id

	for iter_57_0 = 1, #self._patrolKnight do
		if self._patrolKnight[iter_57_0] == var_57_0 then
			table.remove(self._patrolKnight, iter_57_0)

			return
		end
	end
end

function CityData:getDialogArr(arg_58_1)
	return (self._cityMap[arg_58_1]:getDialogArr())
end

function CityData:getNpcSingleDialog(arg_59_1)
	return (self._cityMap[arg_59_1]:getNpcSingleDialog())
end

function CityData:getNpcResId(arg_60_1)
	return (self._cityMap[arg_60_1]:getNpcResId())
end

function CityData:getTroubleId(arg_61_1, arg_61_2)
	return (self:_getCityStruct(arg_61_1, arg_61_2):getTroubleId())
end

function CityData:getTroubleData(arg_62_1, arg_62_2)
	return (self:_getCityStruct(arg_62_1, arg_62_2):getTroubleData())
end

function CityData:getMaxUnlockCityId()
	local var_63_0 = 0

	for iter_63_0 = 1, self._numCity do
		if self._cityList[iter_63_0]:isCityUnlock() then
			var_63_0 = self._cityList[iter_63_0]:getCfg().advance_id
		end
	end

	return var_63_0
end

function CityData:getIntervalTime(arg_64_1)
	for iter_64_0 = 1, g.core.config.city_process_model_info.getLength() do
		local var_64_0 = g.core.config.city_process_model_info.indexOf(iter_64_0)

		if var_64_0.type == arg_64_1 then
			return var_64_0.time_interval
		end
	end

	return 0
end

function CityData:isUnlock(arg_65_1)
	return self._cityMap[arg_65_1]:isCityUnlock()
end

function CityData:_getInitCityServerData(arg_66_1)
	return {
		model_id = 0,
		isUnlock = false,
		start_time = 0,
		knight_id = 0,
		level = 1,
		id = arg_66_1 * 10
	}
end

function CityData:_getCityStruct(arg_67_1, arg_67_2)
	local var_67_0 = arg_67_2 and self._friendCityMap[arg_67_1] or self._cityMap[arg_67_1]

	if not var_67_0 then
		return self:_getInitCityServerData(arg_67_1 / 10)
	end

	return var_67_0
end

function CityData:isHaveTroubleFriend()
	local var_68_0 = g.core.model.User.cityData:getFriendData()

	if not next(var_68_0) then
		return (g.core.model.User.cityData:getInitFriendTrouble())
	else
		for iter_68_0 = 1, #var_68_0 do
			if var_68_0[iter_68_0].trouble_city_num > 0 then
				return true
			end
		end
	end
end

function CityData:isShowOneKeyPatrol()
	for iter_69_0 = 1, self._numCity do
		if not self._cityList[iter_69_0]:isCityUnlock() then
			return false
		end
	end

	return (g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.CITY_ONEKEY_PATROL))
end

function CityData:isShowOneKeyGet()
	return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.CITY_ONEKEY_GET) and g.core.model.User.cityData:checkIsCanGetReward()
end

function CityData:updataOneKeyPatrolKnightList(arg_71_1, arg_71_2)
	self._patrolReadyKnightList[arg_71_1] = arg_71_2
end

function CityData:initOneKeyPatrolKnightList()
	for iter_72_0, iter_72_1 in ipairs(self._cityList) do
		local var_72_0 = iter_72_1:getCfg()

		self:updataOneKeyPatrolKnightList(var_72_0.advance_id, 0)

		if iter_72_1:getCityStateCtrlIndex() == 3 then
			for iter_72_2, iter_72_3 in ipairs((self:getRecommendKnight(var_72_0.advance_id))) do
				if g.core.model.User.knightsData:hasKnightByAdvanceId(iter_72_3) then
					self:updataOneKeyPatrolKnightList(var_72_0.advance_id, iter_72_3)

					break
				end
			end
		end
	end
end

function CityData:getRecommendKnight(arg_73_1)
	local var_73_0 = self:getSpCityKnightId(arg_73_1)

	return {
		g.core.config.city_knight_info.get(var_73_0[1].id).advance_id,
		g.core.config.city_knight_info.get(var_73_0[2].id).advance_id
	}
end

function CityData:getCityModelId(arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(self._patrolCfg) do
		if iter_74_1.city_id == arg_74_1 then
			return iter_74_1.model_id
		end
	end
end

function CityData:getStartOneKeyPatrolCfg()
	local var_75_0 = {}

	for iter_75_0, iter_75_1 in ipairs(self._patrolCfg) do
		local var_75_1 = self:getOneKeyPatrolKnight(iter_75_1.city_id)

		if var_75_1 and var_75_1 > 0 then
			local var_75_2 = g.core.model.User.knightsData:getKnightByAdvanceId(var_75_1)

			table.insert(var_75_0, {
				city_id = iter_75_1.city_id,
				model_id = iter_75_1.model_id,
				knight_id = var_75_2:getServerId()
			})
		end
	end

	return var_75_0
end

function CityData:getIsHaveKnightOneKeyPatrol()
	for iter_76_0, iter_76_1 in pairs(self._patrolReadyKnightList) do
		if iter_76_1 and iter_76_1 > 0 then
			return true
		end
	end

	return false
end

function CityData:getOneKeyPatrolCfg()
	return self._patrolCfg
end

function CityData:getOneKeyPatrolKnight(arg_78_1)
	return self._patrolReadyKnightList[arg_78_1]
end

function CityData:getOneKeyPatrolKnightList()
	return self._patrolReadyKnightList
end

function CityData:getCityTotalNum()
	return self._numCity
end

function CityData:getCityMap()
	return self._cityMap
end

function CityData:getCityList()
	return self._cityList
end

function CityData:getFriendData()
	return self._friendData
end

function CityData:getInitFriendTrouble()
	return self._hasTrouble
end

function CityData:isResponse()
	return self._isResponse
end

function CityData:getFriendCityList()
	return self._friendCityList
end

return CityData
