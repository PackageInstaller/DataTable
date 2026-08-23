local StormCityData = class("StormCityData", require("app.core.model.BaseData"))
local var_0_1 = table.insert
local var_0_2 = table.remove
local var_0_3 = table.sort

function StormCityData:ctor()
	self:initData()
end

function StormCityData:initData()
	StormCityData.super.ctor(self)

	self._id = 0
	self._rank = 0
	self._preRank = 0
	self._ownCity = 0
	self._ownRank = 0
	self._myIndex = 1
	self._lastGetAwardTime = 0
	self._lordAchievePoint = 0
	self._rankData = {}
	self._allBubbleInfo = {}
	self._cityIdList = {}
	self._lordAchieveSortDirty = false
	self._overLordUser = nil
	self._isSameServer = false
	self._selfLordRecord = {}
	self._lastLordServerAwardTs = 0
	self._rcvLordAchieve = false
	self._rcvGetLordTs = 0
	self._rcvRedPointTs = 0
	self._newOverLordTs = 0
	self._hasOverLordAwardRed = false

	self:_initBubbleInfo()
	self:_initCityIndex()

	self._challengeList = {
		_list = {},
		add = function(self, arg_3_1)
			var_0_1(self._list, arg_3_1)

			if arg_3_1.isMySelf then
				self._selfRank = arg_3_1.rank
			end
		end,
		clear = function(arg_4_0)
			arg_4_0._list = {}
			arg_4_0._selfRank = nil
		end,
		remove = function(self, arg_5_1)
			var_0_2(self._list, arg_5_1)
		end,
		getLength = function(self)
			return #self._list
		end,
		sort = function(self, arg_7_1)
			var_0_3(self._list, arg_7_1)
		end,
		at = function(self, arg_8_1)
			return self._list[arg_8_1]
		end,
		getMyRank = function(self)
			return self._selfRank
		end,
		getIdx = function(self, arg_10_1)
			for iter_10_0, iter_10_1 in ipairs(self._list) do
				if arg_10_1(iter_10_1) then
					return #self._list + 1 - iter_10_0
				end
			end
		end,
		getMyRankData = function(self)
			for iter_11_0, iter_11_1 in ipairs(self._list) do
				if iter_11_1.user.id == g.core.model.User:getId() then
					return iter_11_1
				end
			end
		end,
		slice = function(self, arg_12_1, arg_12_2)
			local var_12_0 = {}

			for iter_12_0 = arg_12_1, arg_12_2 do
				var_12_0[#var_12_0 + 1] = self._list[iter_12_0]
			end

			return var_12_0
		end
	}
end

function StormCityData:_initCityIndex()
	self._cityIdList = {}

	for iter_13_0, iter_13_1 in g.core.config.storm_info.ipairs() do
		if iter_13_1.city_type == 3 then
			table.insert(self._cityIdList, iter_13_1.id)
		end
	end

	table.sort(self._cityIdList, function(arg_14_0, arg_14_1)
		if arg_14_0 ~= arg_14_1 then
			return arg_14_0 < arg_14_1
		end
	end)
end

function StormCityData:updateInfo(arg_15_1)
	self._id = arg_15_1.city
	self._rank = arg_15_1.rank
	self._lastGetAwardTime = arg_15_1.lord_awarded or 0

	self:updateSelfData(arg_15_1.current_city, arg_15_1.current_rank)
	self:_updateChallengeData(arg_15_1.units)
end

function StormCityData:updateChallengeFinish(arg_16_1)
	if arg_16_1.ret ~= g.core.network.proto.RET_OK then
		return
	end

	if arg_16_1.is_win then
		self._id = arg_16_1.city
		self._rank = arg_16_1.rank
		self._preRank = arg_16_1.pre_rank
		self._ownRank = arg_16_1.rank
		self._ownCity = arg_16_1.city

		self:_updateChallengeData(arg_16_1.units)
	end
end

function StormCityData:updateCityRankData(arg_17_1)
	local var_17_0 = arg_17_1.units or {}

	for iter_17_0 = 1, #var_17_0 do
		local var_17_1 = 0

		var_17_1 = var_17_0[iter_17_0] and var_17_0[iter_17_0].city and var_17_0[iter_17_0].city or arg_17_1.city
		self._rankData[var_17_1] = self._rankData[var_17_1] or {}
		self._rankData[var_17_1][var_17_0[iter_17_0].rank] = var_17_0[iter_17_0]
	end

	if not next(var_17_0) and arg_17_1.index == 1 then
		self._rankData[arg_17_1.city] = {}
	end
end

function StormCityData:clearRankData()
	self._rankData = {}
end

function StormCityData:onS2CFlushRedPoint(arg_19_1)
	if arg_19_1.storm_hint then
		self:updateLordReceiveTime(arg_19_1.storm_hint.lord_awarded)
	end
end

function StormCityData:updateLordReceiveTime(arg_20_1)
	self._lastGetAwardTime = arg_20_1 or 0
end

function StormCityData:updateSelfData(arg_21_1, arg_21_2)
	if arg_21_1 then
		self._ownCity = arg_21_1
	end

	if arg_21_2 then
		self._ownRank = arg_21_2
	end

	if not self:isProcess() then
		g.core.model.User:setStormCityLordId((self:calculateMyLordId()))
	end
end

function StormCityData:_updateChallengeData(arg_22_1)
	self._challengeList:clear()

	if arg_22_1 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
			local var_22_0 = self:_createChallengeUnit(iter_22_1)
			local var_22_1

			if var_22_0.isMySelf then
				var_22_1 = true
			end

			if var_22_0.rank and var_22_0.rank > 0 then
				self._challengeList:add(var_22_0)
			end
		end

		if self._rank > 0 and not false then
			self._challengeList:add(self:_createSelfUnit())
		end

		self._challengeList:sort(function(arg_23_0, arg_23_1)
			return arg_23_0.rank > arg_23_1.rank
		end)
	end

	self._myIndex = self._challengeList:getIdx(function(arg_24_0)
		return arg_24_0.isMySelf
	end)
end

function StormCityData:_createChallengeUnit(arg_25_1)
	return {
		id = arg_25_1.id,
		rank = arg_25_1.rank,
		user = arg_25_1.user,
		isMySelf = g.core.model.User:getId() == arg_25_1.id,
		canChallenge = arg_25_1.can_challenge,
		robotId = arg_25_1.robot_id,
		isTop7 = arg_25_1.rank <= 7,
		isTop3 = arg_25_1.rank <= 3
	}
end

function StormCityData:_createSelfUnit()
	local var_26_0 = g.core.model.User:packUser()

	var_26_0.storm_city_lord = self:calculateMyLordId()

	return {
		isMySelf = true,
		canChallenge = false,
		robotId = 0,
		id = g.core.model.User:getId(),
		rank = self._rank,
		user = var_26_0,
		isTop7 = self._rank <= 7,
		isTop3 = self._rank <= 3
	}
end

function StormCityData:getMyOfficialInfo()
	return self:getOfficialInfoByOfficialId((self:getMyCityOfficialId()))
end

function StormCityData:getOfficialInfoByRank(arg_28_1, arg_28_2)
	return self:getOfficialInfoByOfficialId((self:_getOfficialIdByRank(arg_28_1, arg_28_2)))
end

function StormCityData:getOfficialInfoByOfficialId(arg_29_1)
	return (g.core.config.storm_city_lord_info.fetch(arg_29_1))
end

function StormCityData:getDailyAwardState()
	if self:isActivityEndDay() then
		return 0
	end

	if self:isProcess() then
		return 0
	end

	if g.core.model.User:getStormCityLordId() <= 0 then
		return 0
	end

	if g.core.common.ServerTime:secondsFromToday(self._lastGetAwardTime) < 0 then
		return 1
	else
		return 2
	end
end

function StormCityData:isActivityEndDay()
	return math.floor(g.core.config.time_event_info.get(8, 0).end_time / 86400) == math.floor(g.core.common.ServerTime:secondsFromMonday() / 86400)
end

function StormCityData:chechCityIsOpen(arg_32_1)
	local var_32_0 = g.core.config.storm_info.get(arg_32_1).preset_id

	if g.core.model.User.stormData:getCityState(var_32_0) == 2 then
		return true, var_32_0
	end

	return false, var_32_0
end

function StormCityData:_getOfficialIdByRank(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1 or self._rank
	local var_33_1 = arg_33_2 or self._id
	local var_33_2 = 0

	for iter_33_0 = 1, g.core.config.storm_city_rank_info.getLength() do
		local var_33_3 = g.core.config.storm_city_rank_info.indexOf(iter_33_0)

		if var_33_3.rank_type == var_33_1 and var_33_0 >= var_33_3.min_rank and var_33_0 <= var_33_3.max_rank then
			var_33_2 = var_33_3.lord_id

			break
		end
	end

	return var_33_2
end

function StormCityData:getRankInfo()
	for iter_34_0 = 1, g.core.config.storm_city_rank_info.getLength() do
		local var_34_0 = g.core.config.storm_city_rank_info.indexOf(iter_34_0)

		if var_34_0.rank_type == self._ownCity and self._ownRank >= var_34_0.min_rank and self._ownRank <= var_34_0.max_rank then
			return var_34_0
		end
	end
end

function StormCityData:getMyCityOfficialId()
	return (g.core.model.User:getStormCityLordId())
end

function StormCityData:calculateMyLordId()
	return (self:_getOfficialIdByRank(self._ownRank, self._ownCity))
end

function StormCityData:isProcess(arg_37_1)
	arg_37_1 = arg_37_1 or g.core.common.ServerTime:getTime()

	local var_37_0 = g.core.config.time_event_info.get(8, 0)
	local var_37_1 = var_37_0.end_time
	local var_37_2 = g.core.common.ServerTime:secondsFromCurMonday(arg_37_1)

	return var_37_0.open_time <= var_37_2 and var_37_2 < var_37_1
end

function StormCityData:getFinishTime()
	local var_38_0 = g.core.common.ServerTime:getTime()

	return var_38_0 + g.core.config.time_event_info.get(8, 0).end_time - g.core.common.ServerTime:secondsFromCurMonday(var_38_0)
end

function StormCityData:isNotOpen()
	return g.core.config.time_event_info.get(8, 0).open_time > g.core.common.ServerTime:secondsFromCurMonday(g.core.common.ServerTime:getTime())
end

function StormCityData:isClose()
	return g.core.config.time_event_info.get(8, 0).end_time <= g.core.common.ServerTime:secondsFromCurMonday(g.core.common.ServerTime:getTime())
end

function StormCityData:hasInAward(arg_41_1)
	arg_41_1 = arg_41_1 or g.core.common.ServerTime:getTime()

	local var_41_0 = g.core.config.time_event_info.get(8, 0).open_time
	local var_41_1 = var_41_0 + 86400
	local var_41_2 = g.core.common.ServerTime:secondsFromCurMonday(arg_41_1)

	return var_41_2 < var_41_0 or var_41_1 < var_41_2
end

function StormCityData:getCoolTimeTxt()
	local var_42_0 = g.core.config.time_event_info.get(8, 0)
	local var_42_1 = g.core.common.ServerTime:secondsFromCurMonday(g.core.common.ServerTime:getTime())

	if self:isNotOpen() then
		return g.core.lang:get(304606, {
			time = self:_formatCoolTime(var_42_0.open_time - var_42_1)
		})
	elseif self:isProcess() then
		return g.core.lang:get(304607, {
			time = self:_formatCoolTime(var_42_0.end_time - var_42_1)
		})
	else
		return g.core.lang:get(1199)
	end
end

function StormCityData:_formatCoolTime(arg_43_1)
	local var_43_0 = math.floor(arg_43_1 / 86400)

	arg_43_1 = arg_43_1 % 86400

	if var_43_0 >= 1 then
		return g.core.lang:get(1051, {
			day = var_43_0,
			hour = math.floor(arg_43_1 / 3600)
		})
	else
		return g.core.common.ServerTime:secondToHMSString(arg_43_1)
	end
end

function StormCityData:getIconCountDown()
	local var_44_0

	if not self:isProcess() then
		do return "activityEnd" end

		var_44_0 = g.core.common.ServerTime:secondsFromCurMonday()
	end

	local var_44_1 = g.core.config.time_event_info.get(8, 0).end_time

	if var_44_0 <= var_44_1 then
		if var_44_1 - var_44_0 < 86400 then
			return (g.core.common.ServerTime:getActivityLeftTime(var_44_1 - var_44_0))
		else
			return ""
		end
	end

	return "activityEnd"
end

function StormCityData:getMyMapIndex()
	if not self._myIndex then
		return 0
	end

	return (self._myIndex > 3 or nil) and math.ceil((self._myIndex - 3) / 6) + 1
end

function StormCityData:_initBubbleInfo()
	for iter_46_0 = 1, g.core.config.bubble_chat_npc_info.getLength() do
		local var_46_0 = g.core.config.bubble_chat_npc_info.indexOf(iter_46_0)

		if var_46_0.type == 2 then
			table.insert(self._allBubbleInfo, var_46_0)
		end
	end
end

function StormCityData:getBubbleText(arg_47_1, arg_47_2)
	local var_47_0 = {}
	local var_47_2 = arg_47_2 ~= self._ownCity or arg_47_1 < self._ownRank and true

	for iter_47_0, iter_47_1 in pairs(self._allBubbleInfo) do
		if arg_47_1 >= iter_47_1.rank_min and arg_47_1 <= iter_47_1.rank_max then
			if var_47_2 then
				if iter_47_1.bubble_type == 1 or iter_47_1.bubble_type == 3 then
					table.insert(var_47_0, iter_47_1)
				end
			elseif iter_47_1.bubble_type == 2 or iter_47_1.bubble_type == 3 then
				table.insert(var_47_0, iter_47_1)
			end
		end
	end

	return (#var_47_0 > 0 or nil) and var_47_0[math.random(1, #var_47_0)].chat
end

function StormCityData:getCityIndexById(arg_48_1)
	for iter_48_0 = 1, #self._cityIdList do
		if self._cityIdList[iter_48_0] == arg_48_1 then
			return iter_48_0
		end
	end
end

function StormCityData:getUnlockBigCityList()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(self._cityIdList) do
		if g.core.model.User.stormData:isPresetUnlock(iter_49_1) then
			table.insert(var_49_0, iter_49_1)
		end
	end

	return var_49_0
end

function StormCityData:getLastUnlockCityId()
	for iter_50_0 = #self._cityIdList, 1, -1 do
		if self:chechCityIsOpen(self._cityIdList[iter_50_0]) then
			return self._cityIdList[iter_50_0]
		end
	end

	return self._cityIdList[1]
end

function StormCityData:getAuctionAwards()
	local var_51_0 = g.core.common.ServerTime:getOpenDays()
	local var_51_1

	for iter_51_0, iter_51_1 in g.core.config.auction_info.ipairs() do
		if iter_51_1.type == "1" then
			var_51_1 = iter_51_1

			break
		end
	end

	if not var_51_1 then
		return
	end

	local var_51_2 = var_51_1.item_pool
	local var_51_3 = {}

	for iter_51_2, iter_51_3 in g.core.config.auction_item_info.ipairs() do
		if iter_51_3.pool == var_51_2 and var_51_0 >= iter_51_3.service_time_min and var_51_0 <= iter_51_3.service_time_max and iter_51_3.if_show == 1 then
			table.insert(var_51_3, {
				type = iter_51_3.type,
				value = iter_51_3.value,
				size = iter_51_3.size
			})
		end
	end

	return var_51_3
end

function StormCityData:_initAchieveList()
	self._lordAchieveList = {}

	for iter_52_0, iter_52_1 in g.core.config.storm_achievement_info.ipairs() do
		local var_52_0 = {}

		while iter_52_1["reward_type_" .. 1] > 0 do
			table.insert(var_52_0, {
				type = iter_52_1["reward_type_" .. 1],
				value = iter_52_1["reward_value_" .. 1],
				size = iter_52_1["reward_size_" .. 1]
			})
		end

		table.insert(self._lordAchieveList, {
			isReceived = false,
			info = iter_52_1,
			awards = var_52_0
		})
	end
end

function StormCityData:getLordAchieveList()
	if not self._lordAchieveList then
		self:_initAchieveList()
	end

	if self._lordAchieveSortDirty then
		local var_53_0 = self:getLordAchievePoint()

		table.sort(self._lordAchieveList, function(arg_54_0, arg_54_1)
			if arg_54_0.isReceived ~= arg_54_1.isReceived then
				return arg_54_1.isReceived
			end

			if var_53_0 >= arg_54_0.info.num ~= (var_53_0 >= arg_54_1.info.num) then
				return var_53_0 >= arg_54_0.info.num
			end

			return arg_54_0.info.id < arg_54_1.info.id
		end)

		self._lordAchieveSortDirty = false
	end

	return self._lordAchieveList
end

function StormCityData:updateGetLord(arg_55_1)
	self._overLordUser = arg_55_1.user
	self._isSameServer = arg_55_1.same_server or false
	self._lastLordServerAwardTs = arg_55_1.last_award_time or 0
	self._rcvGetLordTs = g.core.common.ServerTime:getTime()
end

function StormCityData:updateLordHistory(arg_56_1)
	self._lordHistorys = arg_56_1.historys or {}
end

function StormCityData:updateLordAchievePoint(arg_57_1)
	self._lordAchievePoint = arg_57_1
	self._lordAchieveSortDirty = true
	self._rcvLordAchieve = true
end

function StormCityData:updateLordAchieve(arg_58_1)
	self._lordAchievePoint = arg_58_1.point

	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1.ids or {}) do
		var_58_0[iter_58_1] = true
	end

	for iter_58_2, iter_58_3 in ipairs((self:getLordAchieveList())) do
		iter_58_3.isReceived = checkbool(var_58_0[iter_58_3.info.id])
	end

	self._lordAchieveSortDirty = true
	self._selfLordRecord = arg_58_1.lords or {}
	self._rcvLordAchieve = true
end

function StormCityData:updateGetLordAchieveAward(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs((self:getLordAchieveList())) do
		if iter_59_1.info.id == arg_59_1.id then
			iter_59_1.isReceived = true
			self._lordAchieveSortDirty = true

			return
		end
	end
end

function StormCityData:updateMaxLordAward()
	self._lastLordServerAwardTs = g.core.common.ServerTime:getTime()
end

function StormCityData:getLordRankInfoList()
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in g.core.config.storm_city_rank_info.ipairs() do
		if iter_61_1.min_rank <= 1 and iter_61_1.max_rank >= 1 then
			table.insert(var_61_0, iter_61_1)
		end
	end

	return var_61_0
end

function StormCityData:canRcvOverLordAward()
	if self:isLordTsExpired(self._rcvGetLordTs) then
		return false, 0
	end

	if not self._overLordUser then
		return false, 0
	end

	local var_62_0 = g.core.model.User:getUserData()

	if not self._isSameServer then
		return false, 0
	end

	if self:isLordTsExpired(self._lastLordServerAwardTs) then
		return true, 1
	else
		return false, 2
	end
end

function StormCityData:checkOverLordAwardRed(arg_63_1)
	if #self:getUnlockBigCityList() == 0 then
		return false
	end

	if arg_63_1 and arg_63_1.id and not g.core.model.User.stormData:isPresetUnlock(arg_63_1.id) then
		return false
	end

	if self:isOverLordExpired() then
		return false
	end

	if self._rcvGetLordTs == 0 then
		return self._hasOverLordAwardRed
	else
		return self:canRcvOverLordAward()
	end
end

function StormCityData:isShowLordAtHome()
	if self:isOverLordExpired() then
		return false
	end

	local var_64_0 = g.core.config.time_event_info.get(8, 0).end_time
	local var_64_1 = g.core.common.ServerTime:secondsFromMonday()
	local var_64_2 = g.core.common.ServerTime:getTime()

	if (var_64_0 < var_64_1 and var_64_1 < var_64_0 + g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.STORM_LORD_SHOW_TIME).parameter or nil) and true then
		return self:hasOverLord()
	end

	return false
end

function StormCityData:updateRedPoint(arg_65_1)
	self._hasNewLord = arg_65_1.has_new_lord or false
	self._hasLordAchieveAward = arg_65_1.has_achive_award or false
	self._hasOverLordAwardRed = arg_65_1.has_max_lord_award or false
	self._rcvRedPointTs = g.core.common.ServerTime:getTime()
	self._lordAchievePoint = arg_65_1.point or 0
end

function StormCityData:hasLordAchieveAward()
	if self._rcvLordAchieve then
		local var_66_0 = self:getLordAchievePoint()

		for iter_66_0, iter_66_1 in ipairs((self:getLordAchieveList())) do
			if not iter_66_1.isReceived and var_66_0 >= iter_66_1.info.num then
				return true
			end
		end
	else
		return self._hasLordAchieveAward
	end
end

function StormCityData:isOverLordExpired()
	if self._rcvGetLordTs == 0 then
		self._rcvRedPointTs = self._rcvRedPointTs == 0 and g.core.common.ServerTime:getTime() or self._rcvRedPointTs

		return self:isLordTsExpired(self._rcvRedPointTs)
	else
		return self:isLordTsExpired(self._rcvGetLordTs)
	end
end

function StormCityData:resetOverLordTs()
	self._rcvGetLordTs = g.core.common.ServerTime:getTime()
end

function StormCityData:hasOverLord()
	if self._rcvGetLordTs == 0 then
		return self._hasNewLord
	else
		return checkbool(self._overLordUser)
	end
end

function StormCityData:isLordTsExpired(arg_70_1)
	local var_70_0 = g.core.config.time_event_info.get(8, 0).end_time

	if var_70_0 < g.core.common.ServerTime:secondsFromMonday(arg_70_1) then
		var_70_0 = var_70_0 + 604800
	end

	return g.core.common.ServerTime:getMondayTime(arg_70_1) + var_70_0 + 30 < g.core.common.ServerTime:getTime()
end

function StormCityData:getOverLordTs()
	return (g.core.common.Storage:load("over_lord_ts.json") or {}).ts or 0
end

function StormCityData:updateOverLordTs()
	g.core.common.Storage:save("over_lord_ts.json", {
		ts = g.core.common.ServerTime:getTime()
	})
end

function StormCityData:canRevHegemonyReward(arg_73_1)
	if #self:getUnlockBigCityList() == 0 then
		return false
	end

	if arg_73_1 and arg_73_1.id and not g.core.model.User.stormData:isPresetUnlock(arg_73_1.id) then
		return false
	end

	local var_73_0 = g.core.model.User.taskData:getTaskInfoByModuleId(g.core.const.ConstMgr.TaskConst.MODULE_ID.STORMCITY)
	local var_73_1 = 0

	for iter_73_0, iter_73_1 in pairs(var_73_0.dailyTasks) do
		var_73_1 = var_73_1 + iter_73_1
	end

	for iter_73_2, iter_73_3 in ipairs((g.core.config.action_task_info.match(function(arg_74_0)
		return arg_74_0.module == g.core.const.ConstMgr.TaskConst.MODULE_ID.STORMCITY
	end))) do
		if iter_73_3.tab == 1 and var_73_1 >= iter_73_3.require_value and not var_73_0.receiveIdList[iter_73_3.id] then
			return true
		end
	end

	return false
end

function StormCityData:isShowStationRedPoint(arg_75_1)
	if not self:isProcess() then
		return false
	end

	local var_75_0 = g.core.model.User.shopData
	local var_75_1 = arg_75_1 and arg_75_1.id

	if arg_75_1 and arg_75_1.id and var_75_1 > 0 then
		if not g.core.model.User.stormData:isPresetUnlock(var_75_1) then
			return false
		end

		return var_75_0:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY) > 0
	elseif var_75_0:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY) > 0 then
		for iter_75_0, iter_75_1 in pairs((self:getUnlockBigCityList())) do
			if g.core.model.User.stormData:isPresetUnlock(iter_75_1) then
				return true
			end
		end
	end

	return false
end

function StormCityData:isHasDailyReward(arg_76_1)
	if #self:getUnlockBigCityList() == 0 then
		return false
	end

	if arg_76_1 and arg_76_1.id and not g.core.model.User.stormData:isPresetUnlock(arg_76_1.id) then
		return false
	end

	return self:getDailyAwardState() == 1
end

function StormCityData:getStormCityChallengeList()
	return self._challengeList
end

function StormCityData:getStormCityId()
	return self._id
end

function StormCityData:getStormCityRank()
	return self._rank
end

function StormCityData:getPreRank()
	return self._preRank
end

function StormCityData:getRankData()
	return self._rankData
end

function StormCityData:getOwnCityId()
	return self._ownCity
end

function StormCityData:getOwnRank()
	return self._ownRank
end

function StormCityData:getCityIdByIndex(arg_84_1)
	return self._cityIdList[arg_84_1]
end

function StormCityData:getCityIdList()
	return self._cityIdList
end

function StormCityData:getLordAchievePoint()
	return self._lordAchievePoint
end

function StormCityData:getOverLordUser()
	return self._overLordUser
end

function StormCityData:getLastLordServerAwardTs()
	return self._lastLordServerAwardTs
end

function StormCityData:getLordHistorys()
	return self._lordHistorys
end

function StormCityData:getLordAchievePoint()
	return self._lordAchievePoint
end

function StormCityData:getSelfLordRecord()
	return self._selfLordRecord
end

return StormCityData
