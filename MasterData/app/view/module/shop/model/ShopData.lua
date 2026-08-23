local ShopData = class("ShopData", require("app.core.model.BaseData"))
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.model.User
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE

function ShopData:ctor()
	self:initData()
end

function ShopData:initData()
	ShopData.super.ctor(self)

	self._isShopInfoExpired = false
	self._isPlayInfoExpired = false
	self._needUpdateWeekShopInfo = false
	self._needUpdateMonthShopInfo = false
	self._needUpdateWeekPlayInfo = false
	self._needUpdateChiefArenaShopInfo = false
	self._needUpdateTeamBattleShopInfo = false
	self._needUpdateActivityInfo = false
	self._lastUpdateShopTime = g.core.common.ServerTime:getTime()
	self._lastUpdatePlayTime = g.core.common.ServerTime:getTime()
	self._shopInfo = {}
	self._tasksInfo = {}
	self._playInfo = {}
	self._attentionsItems = {}

	self:_initShopInfo()
	self:initInfo()
	self:initVipInfo()
	self:initPriceInfo()
end

function ShopData:_initShopInfo()
	self._shopInfoGroup = {}

	for iter_3_0 = 1, g.core.config.shop_info.getLength() do
		local var_3_0 = g.core.config.shop_info.indexOf(iter_3_0)

		if var_3_0.tab_type ~= 0 then
			self._shopInfoGroup[var_3_0.tab_type] = self._shopInfoGroup[var_3_0.tab_type] or {}
			self._shopInfoGroup[var_3_0.tab_type][var_3_0.shop_type] = self._shopInfoGroup[var_3_0.tab_type][var_3_0.shop_type] or {}
			self._shopInfoGroup[var_3_0.tab_type][var_3_0.shop_type][#self._shopInfoGroup[var_3_0.tab_type][var_3_0.shop_type] + 1] = var_3_0
		end
	end
end

function ShopData:isSeasonOpen(arg_4_1)
	if arg_4_1 == var_0_3.PEAK_ARENA then
		return g.core.model.User.peakArenaData:isShowEntrance()
	elseif arg_4_1 == var_0_3.MINE then
		return g.core.model.User.mineData:isInShopSeason()
	elseif arg_4_1 == var_0_3.CROSS_SERVER_ARENA then
		return g.core.model.User.crossServerArenaData:isInSeason()
	elseif arg_4_1 == var_0_3.GUILD_WAR then
		return g.core.model.User.guildWarData:isShowEntrance()
	elseif arg_4_1 == var_0_3.TEAM_PVP then
		return g.core.model.User.teamPvpData:isActivityOpen()
	elseif arg_4_1 == var_0_3.RED_CLIFF then
		return g.core.model.User.redCliffData:isActivityOpen()
	elseif arg_4_1 == var_0_3.BOUNTY then
		return g.core.model.User.bountyData:isActivityOpen()
	elseif arg_4_1 == var_0_3.TEAM_BATTLE then
		return g.core.model.User.teamBattleData:isActivityOpen()
	elseif arg_4_1 == var_0_3.NEW_SLG then
		return g.core.model.User.newSlgData:isOpen()
	elseif arg_4_1 == var_0_3.PUBG then
		return g.core.model.User.pubgData:isActivityOpen()
	elseif arg_4_1 == var_0_3.BLAZING_ARENA then
		return g.core.model.User.blazingArenaData:isShowEntrance()
	elseif arg_4_1 == var_0_3.SPIRE then
		return g.core.model.User.spireData:isActivityInSeason()
	elseif arg_4_1 == var_0_3.ANCIENTS then
		return g.core.model.User.ancientsData:isTimeToOpen()
	end

	return false
end

function ShopData:getSeasonEndTime(arg_5_1)
	if arg_5_1 == var_0_3.PEAK_ARENA then
		return g.core.model.User.peakArenaData:getFinishTime()
	elseif arg_5_1 == var_0_3.MINE then
		return g.core.model.User.mineData:getCloseTime()
	elseif arg_5_1 == var_0_3.CROSS_SERVER_ARENA then
		return g.core.model.User.crossServerArenaData:getExpireTime()
	elseif arg_5_1 == var_0_3.GUILD_WAR then
		local var_5_0, var_5_1 = g.core.model.User.guildWarData:getStartEndTime(g.core.const.ConstMgr.GuildWarConst.StageType.SEASON_RESULT)

		return var_5_1
	elseif arg_5_1 == var_0_3.TEAM_PVP then
		return g.core.model.User.teamPvpData:getActivityExpireTime()
	elseif arg_5_1 == var_0_3.RED_CLIFF then
		return g.core.model.User.redCliffData:getActExpireTime()
	elseif arg_5_1 == var_0_3.BOUNTY then
		return g.core.model.User.bountyData:getActivityExpireTime()
	elseif arg_5_1 == var_0_3.TEAM_BATTLE then
		return g.core.model.User.teamBattleData:getActivityExpireTime()
	elseif arg_5_1 == var_0_3.NEW_SLG then
		return g.core.model.User.newSlgData:getActShowEndTime()
	elseif arg_5_1 == var_0_3.PUBG then
		return g.core.model.User.pubgData:getActivityExpireTime()
	elseif arg_5_1 == var_0_3.BLAZING_ARENA then
		return g.core.model.User.blazingArenaData:getActivityExpireTime()
	elseif arg_5_1 == var_0_3.SPIRE then
		return g.core.model.User.spireData:getActivityEndTime()
	elseif arg_5_1 == var_0_3.ANCIENTS then
		return g.core.model.User.ancientsData:getActivityShowTime()
	end

	return 0
end

function ShopData:getShopInfoByScoreInfo(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self._shopInfoGroup) do
		if iter_6_1[arg_6_1.shop_type] then
			var_6_0 = iter_6_1[arg_6_1.shop_type]

			break
		end
	end

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		if iter_6_3.shop_first == arg_6_1.shop_first and iter_6_3.shop_second == arg_6_1.shop_second then
			return iter_6_3
		end
	end

	return nil
end

function ShopData:initInfo()
	self._info = {}

	for iter_7_0 = 1, g.core.config.shop_score_info.getLength() do
		local var_7_0 = g.core.config.shop_score_info.indexOf(iter_7_0)

		self._info[var_7_0.shop_type] = self._info[var_7_0.shop_type] or {}
		self._info[var_7_0.shop_type][var_7_0.shop_first] = self._info[var_7_0.shop_type][var_7_0.shop_first] or {}

		local var_7_1 = self._info[var_7_0.shop_type][var_7_0.shop_first]

		if var_7_0.shop_type == 1 and var_7_0.shop_value == 1 then
			var_7_1 = self._info[var_7_0.shop_type][0]
		end

		var_7_1[#var_7_1 + 1] = var_7_0

		if checkbool(var_7_0.default_purchasing == 1) then
			self._attentionsItems[var_7_0.id] = self._attentionsItems[var_7_0.id] or {}
			self._attentionsItems[var_7_0.id] = var_7_0
		end
	end
end

function ShopData:numberToDate(arg_8_1)
	local var_8_0 = {
		year = math.floor(arg_8_1 / 10000)
	}

	var_8_0.month = math.floor((arg_8_1 - 10000 * var_8_0.year) / 100)
	var_8_0.day = arg_8_1 % 100
	var_8_0.hour = 0

	return var_8_0
end

function ShopData:isScoreInTime(arg_9_1, arg_9_2)
	return (arg_9_1.start_times ~= 0 and arg_9_1.end_times ~= 0 or nil) and os.time((self:numberToDate(arg_9_1.start_times))) < arg_9_2 and arg_9_2 < os.time((self:numberToDate(arg_9_1.end_times)))
end

function ShopData:isScoreInSeverTime(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or g.core.common.ServerTime:getOpenDays()

	return (arg_10_1.server_time ~= 0 or nil) and arg_10_2 >= arg_10_1.server_time
end

function ShopData:initVipInfo()
	self._vipInfo = {}

	for iter_11_0 = 1, g.core.config.buy_vipnum_info.getLength() do
		local var_11_0 = g.core.config.buy_vipnum_info.indexOf(iter_11_0)

		self._vipInfo[var_11_0.id] = self._vipInfo[var_11_0.id] or {}
		self._vipInfo[var_11_0.id][#self._vipInfo[var_11_0.id] + 1] = var_11_0
	end
end

function ShopData:initPriceInfo()
	self._priceInfo = {}

	for iter_12_0 = 1, g.core.config.buy_price_info.getLength() do
		local var_12_0 = g.core.config.buy_price_info.indexOf(iter_12_0)

		self._priceInfo[var_12_0.id] = self._priceInfo[var_12_0.id] or {}
		self._priceInfo[var_12_0.id][#self._priceInfo[var_12_0.id] + 1] = var_12_0
	end
end

function ShopData:initShopInfo(arg_13_1)
	self._shopInfo = {}

	if arg_13_1.infos then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1.infos) do
			self._shopInfo[iter_13_1.id] = iter_13_1.num
		end
	end

	self._tasksInfo = {}

	if arg_13_1.tasks then
		for iter_13_2, iter_13_3 in ipairs(arg_13_1.tasks) do
			self._tasksInfo[self:getShopTaskBanKey(iter_13_3.type, iter_13_3.key)] = iter_13_3.value
		end
	end

	self._lastUpdateShopTime = g.core.common.ServerTime:getTime()

	self:setNeedUpdateInfo(false)
end

function ShopData:getShopTaskBanKey(arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or 0

	return arg_14_2 * 10000000 + arg_14_1
end

function ShopData:updateShopInfo(arg_15_1)
	if not arg_15_1 then
		return
	end

	if self:isExpired() then
		self:resetExpired()
	end

	self._shopInfo[arg_15_1.id] = (self._shopInfo[arg_15_1.id] or 0) + arg_15_1.num
end

function ShopData:isExpired()
	local var_16_0 = g.core.common.ServerTime
	local var_16_1 = g.core.common.ServerTime:getTime()

	if var_16_1 > self._lastUpdateShopTime then
		local var_16_2 = self._lastUpdateShopTime

		self._needUpdateChiefArenaShopInfo = g.core.model.User.crossServerArenaData:needUpdateShopInfo()

		if var_16_0:isDifferentMonth(var_16_2) and var_16_2 < var_16_1 then
			self._needUpdateMonthShopInfo = true
			self._isShopInfoExpired = true
		end

		local var_16_3 = var_16_0:secondsFromCurMonday(var_16_2)

		if var_16_3 > 0 then
			if var_16_1 >= var_16_2 - var_16_3 + (ShopData.SECONDS_ONE_DAY * 7 or 0) then
				self._needUpdateWeekShopInfo = true
				self._isShopInfoExpired = true
			end
		end

		local var_16_5 = var_16_0:secondsFromToday(var_16_2)

		self._isShopInfoExpired = self._needUpdateMonthShopInfo or self._needUpdateWeekShopInfo or var_16_2 - var_16_5 + ((var_16_5 > 0 or nil) and (ShopData.SECONDS_ONE_DAY or 0)) <= var_16_1
	end

	if var_16_1 > self._lastUpdatePlayTime then
		local var_16_6 = self._lastUpdatePlayTime
		local var_16_7 = var_16_0:secondsFromCurMonday(self._lastUpdatePlayTime)

		if var_16_7 > 0 then
			if var_16_1 >= self._lastUpdatePlayTime - var_16_7 + (ShopData.SECONDS_ONE_DAY * 7 or 0) then
				self._needUpdateWeekPlayInfo = true
				self._isPlayInfoExpired = true
			end
		end

		local var_16_9 = var_16_0:secondsFromToday(var_16_6)

		self._isPlayInfoExpired = self._needUpdateWeekPlayInfo or var_16_6 - var_16_9 + ((var_16_9 > 0 or nil) and (ShopData.SECONDS_ONE_DAY or 0)) <= var_16_1
	end

	return self._isShopInfoExpired or self._isPlayInfoExpired
end

function ShopData:resetExpired()
	if self._isShopInfoExpired then
		for iter_17_0, iter_17_1 in g.core.config.shop_score_info.ipairs() do
			if iter_17_1.num_ban_type == 2 then
				self._shopInfo[iter_17_1.id] = 0
			elseif iter_17_1.num_ban_type == 3 then
				if self._needUpdateWeekShopInfo then
					self._shopInfo[iter_17_1.id] = 0
				end
			elseif iter_17_1.num_ban_type == 4 then
				if self._needUpdateMonthShopInfo then
					self._shopInfo[iter_17_1.id] = 0
				end
			elseif iter_17_1.num_ban_type == var_0_1.NUM_BAN_TYPE.TEAM_BATTLE then
				if self._needUpdateChiefArenaShopInfo then
					self._shopInfo[iter_17_1.id] = 0
				end
			elseif iter_17_1.num_ban_type == var_0_1.NUM_BAN_TYPE.CHIEF_ARENA_SEASON and self._needUpdateTeamBattleShopInfo then
				self._shopInfo[iter_17_1.id] = 0
			end
		end

		if self._needUpdateWeekShopInfo then
			self:setResetTaskInfo(var_0_1.TASK_TYPE.TEAM_PVP_HONOR)

			self._needUpdateWeekShopInfo = false
		end

		if self._needUpdateMonthShopInfo then
			self._needUpdateMonthShopInfo = false
		end

		self._isShopInfoExpired = false
		self._lastUpdateShopTime = g.core.common.ServerTime:getTime()
	end

	if self._isPlayInfoExpired then
		for iter_17_2, iter_17_3 in g.core.config.play_num_info.ipairs() do
			if iter_17_3.reset > 0 then
				if iter_17_3.reset_type == 2 then
					self._playInfo[iter_17_3.id] = {
						buy_count = 0,
						id = iter_17_3.id,
						left_count = iter_17_3.reset
					}
				elseif iter_17_3.reset_type == 3 and self._needUpdateWeekPlayInfo then
					self._playInfo[iter_17_3.id] = {
						buy_count = 0,
						id = iter_17_3.id,
						left_count = iter_17_3.reset
					}
				end
			end
		end

		if self._needUpdateWeekPlayInfo then
			self._needUpdateWeekPlayInfo = false
		end

		self._isPlayInfoExpired = false
		self._lastUpdatePlayTime = g.core.common.ServerTime:getTime()
	end
end

function ShopData:getShopInfoGroup()
	return self._shopInfoGroup
end

function ShopData:updateRedPoint(arg_19_1)
	local var_19_0 = arg_19_1 and arg_19_1.shop_hint

	if not (arg_19_1 and arg_19_1.shop_hint) then
		return
	end

	self._shopInfo = {}

	local var_19_1 = var_19_0.infos or {}

	if var_19_1 then
		for iter_19_0, iter_19_1 in ipairs(var_19_1) do
			self._shopInfo[iter_19_1.id] = iter_19_1.num
		end
	end
end

function ShopData:getInfo(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = self:getUnSortInfo(arg_20_1, arg_20_2, arg_20_3)

	if not var_20_0 then
		return
	end

	local var_20_1 = {}
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		var_20_1[iter_20_1.id] = self:getBuyLimitLeft(iter_20_1)
		var_20_2[iter_20_1.id] = self:checkBuyBan(iter_20_1)
	end

	return (g.core.common.ActivitySort:listSort(g.core.common.ActivitySort:getSortTp(), var_20_0, {
		"id"
	}, function(arg_21_0, arg_21_1)
		local var_21_0 = var_20_1[arg_21_1.id]

		if (var_20_1[arg_21_0.id] and var_20_1[arg_21_0.id] == 0 or false) ~= (var_20_1[arg_21_1.id] and var_21_0 == 0 or false) then
			return var_20_1[arg_21_1.id] and var_21_0 == 0 or false
		end

		if var_20_2[arg_21_0.id] ~= var_20_2[arg_21_1.id] then
			return var_20_2[arg_21_1.id]
		end

		local var_21_1 = arg_21_0.if_new or 0
		local var_21_2 = arg_21_1.if_new or 0

		if var_21_1 ~= var_21_2 then
			return var_21_2 < var_21_1
		end

		if arg_21_0.order ~= arg_21_1.order then
			return arg_21_0.order < arg_21_1.order
		end

		return arg_21_0.id < arg_21_1.id
	end))
end

function ShopData:getUnSortCarInfo()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(self._attentionsItems) do
		var_22_0[#var_22_0 + 1] = iter_22_1
	end

	return var_22_0
end

function ShopData:getShopCarInfo()
	local var_23_0 = self:getUnSortCarInfo()

	if not var_23_0 then
		return
	end

	local var_23_1 = {}
	local var_23_2 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		var_23_1[iter_23_1.id] = self:getBuyLimitLeft(iter_23_1)
		var_23_2[iter_23_1.id] = self:checkBuyBan(iter_23_1)
	end

	return (g.core.common.ActivitySort:listSort(g.core.common.ActivitySort:getSortTp(), var_23_0, {
		"id"
	}, function(arg_24_0, arg_24_1)
		local var_24_0 = var_23_1[arg_24_1.id]

		if (var_23_1[arg_24_0.id] and var_23_1[arg_24_0.id] == 0 or false) ~= (var_23_1[arg_24_1.id] and var_24_0 == 0 or false) then
			return var_23_1[arg_24_1.id] and var_24_0 == 0 or false
		end

		if var_23_2[arg_24_0.id] ~= var_23_2[arg_24_1.id] then
			return var_23_2[arg_24_1.id]
		end

		if arg_24_0.shop_type ~= arg_24_1.shop_type then
			return arg_24_0.shop_type < arg_24_1.shop_type
		end

		return arg_24_0.id < arg_24_1.id
	end))
end

function ShopData:getThemeInfo(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = self:getUnSortInfo(arg_25_1, arg_25_2, arg_25_3)

	if not var_25_0 then
		return
	end

	local var_25_1 = {}
	local var_25_2 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		var_25_1[iter_25_1.id] = self:getBuyLimitLeft(iter_25_1)
		var_25_2[iter_25_1.id] = self:checkBuyBan(iter_25_1)
	end

	return (g.core.common.ActivitySort:listSort(g.core.common.ActivitySort:getSortTp(), var_25_0, {
		"id"
	}, function(arg_26_0, arg_26_1)
		local var_26_0 = var_25_1[arg_26_1.id]

		if (var_25_1[arg_26_0.id] and var_25_1[arg_26_0.id] == 0 or false) ~= (var_25_1[arg_26_1.id] and var_26_0 == 0 or false) then
			return var_25_1[arg_26_1.id] and var_26_0 == 0 or false
		end

		if var_25_2[arg_26_0.id] ~= var_25_2[arg_26_1.id] then
			return var_25_2[arg_26_0.id]
		end

		local var_26_1 = arg_26_0.if_new or 0
		local var_26_2 = arg_26_1.if_new or 0

		if var_26_1 ~= var_26_2 then
			return var_26_2 < var_26_1
		end

		if arg_26_0.order ~= arg_26_1.order then
			return arg_26_0.order < arg_26_1.order
		end

		return arg_26_0.id < arg_26_1.id
	end))
end

function ShopData:getUnSortInfo(arg_27_1, arg_27_2, arg_27_3)
	if not self._info[arg_27_1] or not self._info[arg_27_1][arg_27_2] then
		return {}
	end

	local var_27_0 = self._info[arg_27_1][arg_27_2]

	if not self._info[arg_27_1][arg_27_2] then
		return
	end

	local var_27_1 = {}
	local var_27_2 = g.core.common.ServerTime:getTime()
	local var_27_3 = g.core.common.ServerTime:getOpenDays()

	for iter_27_0 = 1, #var_27_0 do
		local var_27_4 = self:getBuyLimitLeft(var_27_0[iter_27_0])

		if self:isShopItemShow(var_27_0[iter_27_0]) and (arg_27_3 or var_27_0[iter_27_0].num_ban_type ~= 1 or not (var_27_4 and var_27_4 == 0)) and self:isScoreInTime(var_27_0[iter_27_0], var_27_2) and self:isScoreInSeverTime(var_27_0[iter_27_0], var_27_3) then
			var_27_1[#var_27_1 + 1] = var_27_0[iter_27_0]
		end
	end

	return var_27_1
end

function ShopData:isShopItemShow(arg_28_1)
	if not self:_checkSpActivityItem(arg_28_1) then
		return false
	end

	if not self:checkSpecialActivityItemShow(arg_28_1) then
		return false
	end

	local var_28_0 = arg_28_1.show_type
	local var_28_1 = arg_28_1.show_level
	local var_28_2 = self._tasksInfo[arg_28_1.show_type] or 0

	if var_28_0 == 6 then
		var_28_2 = g.core.model.User.guildData:getGuildLevel() or 0

		if arg_28_1.type == 13 then
			local var_28_3 = g.core.config.skin_info.get(arg_28_1.value)

			if var_28_3.sex < 2 and var_28_3.sex ~= g.core.model.User.knightsData:getMainKnight():getBaseInfo().sex then
				return false
			end
		end
	elseif var_28_0 == 3 then
		if var_28_2 == 0 then
			var_28_2 = g.core.model.User.arenaData:getRank() or 0
		end

		return var_28_2 <= var_28_1
	elseif var_28_0 == 7 then
		local var_28_4 = g.core.config.role_skin_info.get(g.core.config.role_skin_module_info.get(arg_28_1.value).id).gender

		return var_28_4 == 2 or var_28_4 == (g.core.model.User:getUserUniqueAdvanceId() == 210000 and 1 or 0)
	end

	return var_28_1 <= var_28_2
end

function ShopData:_checkSpActivityItem(arg_29_1)
	if arg_29_1.shop_first == 1 and arg_29_1.activity_type ~= 0 and arg_29_1.activity_id ~= 0 then
		return #g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_30_0)
			if arg_30_0:getActivityType() == arg_29_1.activity_type then
				return (arg_30_0:getInfo().sub_activity_id or arg_30_0:getActivityValue()) == arg_29_1.activity_id and arg_30_0:isShow()
			end
		end) > 0
	end

	return true
end

function ShopData:checkSpecialActivityItemShow(arg_31_1)
	if arg_31_1.shop_type == var_0_1.SHOP_TYPE.SPIRE then
		return arg_31_1.activity_id == g.core.model.User.spireData:getShopActivityId()
	elseif arg_31_1.shop_type == var_0_1.SHOP_TYPE.SUCCUBA_LAUNCH then
		return arg_31_1.activity_id == g.core.model.User.succubaLaunchData:getActivityId()
	end

	return true
end

function ShopData:updateShopTask(arg_32_1)
	if not arg_32_1 then
		return
	end

	self._tasksInfo[self:getShopTaskBanKey(arg_32_1.id, arg_32_1.key)] = arg_32_1.status
end

function ShopData:initPlayInfo(arg_33_1)
	self._playInfo = {}

	if not arg_33_1 then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		self._playInfo[iter_33_1.id] = iter_33_1
	end

	self._lastUpdatePlayTime = g.core.common.ServerTime:getTime()
end

function ShopData:updatePlayInfo(arg_34_1)
	if not arg_34_1 then
		return
	end

	self._playInfo[arg_34_1.id] = arg_34_1
end

function ShopData:getLeftCount(arg_35_1)
	if self:isExpired() then
		self:resetExpired()
	end

	if self._playInfo[arg_35_1] then
		return self._playInfo[arg_35_1].left_count
	end

	return 0
end

function ShopData:getPlayBuyCount(arg_36_1)
	if self:isExpired() then
		self:resetExpired()
	end

	if self._playInfo[arg_36_1] then
		return self._playInfo[arg_36_1].buy_count
	end

	return 0
end

function ShopData:getResetCost(arg_37_1)
	local var_37_0 = g.core.config.play_num_info.get(arg_37_1)
	local var_37_1 = {
		type = var_37_0.price_type,
		value = var_37_0.price_value
	}

	if self:getLeftCount(arg_37_1) > 0 then
		var_37_1.size = 0

		return var_37_1
	end

	if self:getBuyNum(var_37_0.buy_vip_num) <= self:getPlayBuyCount(arg_37_1) then
		return
	end

	var_37_1.size = self:getBuyPrice(var_37_0.price_add_id, 1)

	return var_37_1
end

function ShopData:getBuyNum(arg_38_1, arg_38_2)
	arg_38_2 = arg_38_2 or g.core.model.User:getVipLevel()

	local var_38_0 = self._vipInfo[arg_38_1]
	local var_38_1 = self._vipInfo[arg_38_1][1]

	for iter_38_0 = 1, #self._vipInfo[arg_38_1] do
		if arg_38_2 <= var_38_0[iter_38_0].vip then
			return var_38_0[iter_38_0].max_buy_num
		end

		var_38_1 = var_38_0[iter_38_0]
	end

	return var_38_1.max_buy_num
end

function ShopData:getBuyNextVip(arg_39_1, arg_39_2)
	if arg_39_1 == 0 then
		return
	end

	arg_39_2 = arg_39_2 or g.core.model.User:getVipLevel()

	local var_39_0 = self:getBuyNum(arg_39_1, arg_39_2)

	for iter_39_0 = 1, #self._vipInfo[arg_39_1] do
		if var_39_0 < self._vipInfo[arg_39_1][iter_39_0].max_buy_num and iter_39_0 > 1 then
			return self._vipInfo[arg_39_1][iter_39_0 - 1].vip + 1, self._vipInfo[arg_39_1][iter_39_0].max_buy_num, self._vipInfo[arg_39_1][iter_39_0].max_buy_num - var_39_0
		end
	end
end

function ShopData:getBuyPrice(arg_40_1, arg_40_2)
	local var_40_0 = self._priceInfo[arg_40_1][1]

	for iter_40_0 = 1, #self._priceInfo[arg_40_1] do
		var_40_0 = self._priceInfo[arg_40_1][iter_40_0]

		if arg_40_2 <= self._priceInfo[arg_40_1][iter_40_0].num then
			break
		end
	end

	return var_40_0.price, var_40_0.discount
end

function ShopData:getBuyLimit(arg_41_1)
	if arg_41_1.buy_num and arg_41_1.buy_num == 0 then
		return
	end

	if arg_41_1.buy_vip_num == 0 then
		if g.core.model.User.activityMonthCardData:isPrivilegeActivatedByIndex(2) and arg_41_1.id == 101 then
			return arg_41_1.buy_num + 2
		end

		return arg_41_1.buy_num
	end

	return self:getBuyNum(arg_41_1.buy_vip_num)
end

function ShopData:getBuyLimitLeft(arg_42_1)
	if self:isExpired() then
		self:resetExpired()
	end

	if arg_42_1.toObject then
		arg_42_1 = arg_42_1.toObject()
	end

	local var_42_0 = self:getBuyLimit(arg_42_1)

	if not var_42_0 then
		return
	end

	return (math.max(var_42_0 - (arg_42_1.num_get_type and (not arg_42_1.shopId or arg_42_1.shopId == 0) and self:getPlayBuyCount(arg_42_1.id) or self._shopInfo[arg_42_1.id] or 0), 0))
end

function ShopData:getBuyItemPrice(arg_43_1, arg_43_2, arg_43_3)
	if self:isExpired() then
		self:resetExpired()
	end

	arg_43_2 = arg_43_2 or 1
	arg_43_3 = arg_43_3 or 1

	if arg_43_1["price_add_id_" .. arg_43_3] == 0 then
		return arg_43_1["price_size_" .. arg_43_3] * arg_43_2, arg_43_1.discount, arg_43_1.pre_price
	end

	local var_43_0 = 0

	if arg_43_1.toObject then
		arg_43_1 = arg_43_1.toObject()
	end

	var_43_0 = arg_43_1.num_get_type and (not arg_43_1.shopId or arg_43_1.shopId == 0) and self:getPlayBuyCount(arg_43_1.id) or self._shopInfo[arg_43_1.id] or 0

	local var_43_1 = 0
	local var_43_2 = 0
	local var_43_3 = 0

	for iter_43_0 = 1, arg_43_2 do
		local var_43_4, var_43_5 = self:getBuyPrice(arg_43_1["price_add_id_" .. arg_43_3], var_43_0 + iter_43_0)

		var_43_1 = var_43_1 + var_43_4
		var_43_2 = var_43_5
		var_43_3 = var_43_3 + (arg_43_1.pre_price or 0)
	end

	return var_43_1, var_43_2, var_43_3
end

function ShopData:getBuyItemNum(arg_44_1, arg_44_2)
	if self:isExpired() then
		self:resetExpired()
	end

	arg_44_2 = arg_44_2 or 1

	local var_44_0 = g.core.model.User.bagData:getOwnNum(arg_44_1["price_type_" .. arg_44_2], arg_44_1["price_value_" .. arg_44_2])

	if arg_44_1["price_add_id_" .. arg_44_2] == 0 then
		return math.floor(var_44_0 / arg_44_1["price_size_" .. arg_44_2])
	end

	if arg_44_1.toObject then
		arg_44_1 = arg_44_1.toObject()
	end

	local var_44_2 = arg_44_1.num_get_type and (not arg_44_1.shopId or arg_44_1.shopId == 0) and self:getPlayBuyCount(arg_44_1.id) or self._shopInfo[arg_44_1.id] or 0
	local var_44_3 = self._priceInfo[arg_44_1["price_add_id_" .. arg_44_2]]
	local var_44_4 = 0
	local var_44_5 = 0

	repeat
		if var_44_3[1] == nil then
			break
		end

		local var_44_8 = var_44_3[1].discount
		local var_44_9 = math.floor((var_44_0 - var_44_5) / var_44_3[1].price)

		if var_44_9 > 0 then
			if var_44_8 < 100 and var_44_3[1 + 1] ~= nil then
				var_44_9 = var_44_9 < var_44_3[1 + 1].num - var_44_3[1].num and var_44_9 or var_44_3[1 + 1].num - var_44_3[1].num
			end

			var_44_5 = var_44_5 + var_44_9 * var_44_3[1].price
			var_44_4 = var_44_4 + var_44_9
		end
	until var_44_0 < var_44_5 + var_44_3[1].price or var_44_8 == 100

	return var_44_4
end

function ShopData:checkBuyBan(arg_45_1)
	local var_45_0 = arg_45_1.buy_ban_value

	if not arg_45_1.buy_ban_type or arg_45_1.buy_ban_type == 0 then
		return false
	end

	local var_45_1 = self._tasksInfo[self:getShopTaskBanKey(arg_45_1.buy_ban_type, arg_45_1.buy_ban_key)] or 0

	if arg_45_1.buy_ban_type == 6 then
		var_45_1 = g.core.model.User.guildData:getGuildLevel() or 0
	end

	if arg_45_1.buy_ban_type == 3 then
		if var_45_1 == 0 then
			return true
		end

		return var_45_0 < var_45_1
	end

	if arg_45_1.buy_ban_type == 225 then
		if var_45_1 == 0 then
			return true
		end

		return var_45_0 < var_45_1
	end

	if arg_45_1.buy_ban_type == var_0_1.TASK_TYPE.BLAZING_ARENA_RANK then
		if var_45_1 == 0 then
			return true
		end

		return var_45_0 < var_45_1
	end

	return var_45_1 < var_45_0
end

function ShopData:getBanTask(arg_46_1)
	if not arg_46_1.buy_ban_type or arg_46_1.buy_ban_type == 0 then
		return 0
	end

	return self._tasksInfo[self:getShopTaskBanKey(arg_46_1.buy_ban_type, arg_46_1.buy_ban_key)] or 0
end

function ShopData:getInitTimes(arg_47_1)
	return g.core.config.play_num_info.get(arg_47_1).reset
end

function ShopData:getShopInfoByType(arg_48_1)
	return self._info[arg_48_1]
end

function ShopData:getTaskValue(arg_49_1)
	return self:getTaskValueByType(arg_49_1.buy_ban_type, arg_49_1.buy_ban_key)
end

function ShopData:getTaskValueByType(arg_50_1, arg_50_2)
	local var_50_0 = self._tasksInfo[self:getShopTaskBanKey(arg_50_1, arg_50_2)] or 0

	if arg_50_1 == var_0_1.TASK_TYPE.GUILD_LEVEL then
		var_50_0 = g.core.model.User.guildData:getGuildLevel() or 0
	elseif arg_50_1 == var_0_1.TASK_TYPE.ARENA_RANK then
		if var_50_0 == 0 then
			var_50_0 = g.core.model.User.arenaData:getRank() or 0
		end
	elseif arg_50_1 == var_0_1.TASK_TYPE.CROSS_SERVER_ARENA_RANK then
		if var_50_0 == 0 then
			var_50_0 = g.core.model.User.crossServerArenaData:getMaxRank() or 0
		end
	elseif arg_50_1 == var_0_1.TASK_TYPE.ALLIANCE_LEVEL then
		if var_50_0 == 0 then
			var_50_0 = g.core.model.User.allianceData:getLeaderGuildId() or 0
		end
	elseif arg_50_1 == var_0_1.TASK_TYPE.NEW_SLG_OCCUPY then
		if var_50_0 == 0 then
			var_50_0 = g.core.model.User.newSlgData:getCurrentOccupiedCityLevel() or 0
		end
	elseif arg_50_1 == var_0_1.TASK_TYPE.BLAZING_ARENA_RANK and var_50_0 == 0 then
		var_50_0 = g.core.model.User.blazingArenaData:getHistoryRank() or 0
	end

	return var_50_0
end

function ShopData:isRankTask(arg_51_1)
	return arg_51_1.buy_ban_type == 3 or arg_51_1.buy_ban_type == 225
end

function ShopData:getFragNumInfo(arg_52_1)
	if not arg_52_1 then
		return false
	end

	if arg_52_1.type == g.core.common.Goods.TYPE_FRAGMENT then
		local var_52_0 = g.core.config.fragment_info.get(arg_52_1.value)

		if not var_52_0 then
			return false
		end

		local var_52_1 = g.core.model.User.fragmentsData:getFragmentNumById(arg_52_1.value)
		local var_52_2 = 0

		if var_52_0.fragment_type == g.core.common.Goods.TYPE_EQUIP then
			var_52_2 = var_52_0.combine_num
		elseif var_52_0.fragment_type == g.core.common.Goods.TYPE_UNITETOKEN then
			local var_52_3 = g.core.model.User.uniteTokenData:getTokenByAdvId(var_52_0.fragment_value)

			if var_52_3:isOwn() then
				var_52_1, var_52_2 = var_52_3:getStarUpFragmentNum()
			else
				var_52_2 = var_52_0.combine_num
			end
		elseif var_52_0.fragment_type == g.core.common.Goods.TYPE_KNIGHT then
			local var_52_4 = g.core.model.User.knightsData:getKnightByAdvanceId(var_52_0.fragment_value)

			if var_52_4:isOwn() then
				local var_52_5 = var_52_4:getBaseInfo()

				var_52_2 = var_52_5.next_star_id ~= 0 and (var_52_5.next_star_num or 0) or 0
			else
				var_52_2 = var_52_0.combine_num
			end
		elseif var_52_0.fragment_type == g.core.common.Goods.TYPE_ARTIFACT then
			local var_52_6 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_52_0.fragment_value)

			if var_52_6:isOwn() then
				local var_52_7 = var_52_6:getCfg()

				var_52_2 = var_52_7.next_star_num ~= 0 and var_52_7.next_star_num or 0
			else
				var_52_2 = var_52_0.combine_num
			end
		elseif var_52_0.fragment_type == g.core.common.Goods.TYPE_PET then
			local var_52_8 = g.core.model.User.petsData:getPetByAdvanceId(var_52_0.fragment_value)

			var_52_2 = var_52_8:isOwn() and (var_52_8:isMaxStar() and 0 or var_52_8:getCfg().pet_num or 0) or var_52_0.combine_num
		elseif var_52_0.fragment_type == g.core.common.Goods.TYPE_TREASURE then
			var_52_2 = var_52_0.combine_num
		end

		return true, var_52_1, var_52_2
	end

	return false
end

function ShopData:isBigTypeItemAlreadyHave(arg_53_1)
	if not arg_53_1 then
		return false
	end

	local var_53_0 = arg_53_1.value

	if arg_53_1.type == g.core.common.Goods.TYPE_KNIGHT then
		return (g.core.model.User.knightsData:hasKnightByAdvanceId(g.core.config.knight_info.get(var_53_0).advance_id))
	elseif arg_53_1.type == g.core.common.Goods.TYPE_UNITETOKEN then
		return (g.core.model.User.uniteTokenData:hasTokenByAdvId(g.core.config.unite_token_info.get(var_53_0).advance_id))
	elseif arg_53_1.type == g.core.common.Goods.TYPE_ARTIFACT then
		local var_53_1, var_53_2 = g.core.model.User.artifactData:hasArtifactByAdvanceId(g.core.config.artifact_info.get(var_53_0).advance_code)

		return var_53_1
	elseif arg_53_1.type == g.core.common.Goods.TYPE_PET then
		local var_53_3 = g.core.model.User.petsData:getPetByAdvanceId(g.core.config.pet_info.get(var_53_0).advance_id)

		return var_53_3 and var_53_3:isOwn()
	elseif arg_53_1.type == g.core.common.Goods.TYPE_KNIGHT_SOUL then
		return (g.core.model.User.knightSoulData:hasKnightSoulById(var_53_0))
	elseif arg_53_1.type == g.core.common.Goods.TYPE_PRECIOUS then
		local var_53_4 = g.core.model.User.preciousData:getPreciousByAdvId(g.core.config.precious_info.get(var_53_0).advance_id)

		return var_53_4 and var_53_4:isOwn()
	end

	return false
end

function ShopData:isBigTypeItemAlreadyMaxStar(arg_54_1)
	if not arg_54_1 then
		return false
	end

	local var_54_0 = arg_54_1.value

	if arg_54_1.type == g.core.common.Goods.TYPE_KNIGHT then
		local var_54_1 = g.core.model.User.knightsData:getKnightByAdvanceId(g.core.config.knight_info.get(var_54_0).advance_id)

		if var_54_1 and var_54_1:isOwn() then
			return var_54_1:isMaxStar()
		end
	elseif arg_54_1.type == g.core.common.Goods.TYPE_UNITETOKEN then
		local var_54_2 = g.core.model.User.uniteTokenData:getTokenByAdvId(g.core.config.unite_token_info.get(var_54_0).advance_id)

		if var_54_2 and var_54_2:isOwn() then
			return var_54_2:isMaxStarLevel()
		end
	elseif arg_54_1.type == g.core.common.Goods.TYPE_ARTIFACT then
		local var_54_3 = g.core.model.User.artifactData:getArtifactByAdvacnceId(g.core.config.artifact_info.get(var_54_0).advance_code)

		if var_54_3 and var_54_3:isOwn() then
			return var_54_3:isMaxStar()
		end
	elseif arg_54_1.type == g.core.common.Goods.TYPE_PET then
		local var_54_4 = g.core.model.User.petsData:getPetByAdvanceId(g.core.config.pet_info.get(var_54_0).advance_id)

		if var_54_4 and var_54_4:isOwn() then
			return var_54_4:isMaxStar()
		end
	elseif arg_54_1.type == g.core.common.Goods.TYPE_PET then
		local var_54_5 = g.core.model.User.petsData:getPetByAdvanceId(g.core.config.pet_info.get(var_54_0).advance_id)

		if var_54_5 and var_54_5:isOwn() then
			return var_54_5:isMaxStar()
		end
	elseif arg_54_1.type == g.core.common.Goods.TYPE_KNIGHT_SOUL then
		if g.core.model.User.knightSoulData:hasKnightSoulById(var_54_0) then
			local var_54_6 = g.core.model.User.knightSoulData:getBookById(var_54_0)

			if var_54_6 and var_54_6.isMaxStar then
				return var_54_6:isMaxStar()
			end
		end
	elseif arg_54_1.type == g.core.common.Goods.TYPE_PRECIOUS then
		local var_54_7 = g.core.model.User.preciousData:getPreciousByAdvId(g.core.config.precious_info.get(var_54_0).advance_id)

		if var_54_7 and var_54_7:isOwn() then
			return var_54_7:isMaxStar()
		end
	end

	return false
end

function ShopData:getBuyNumById(arg_55_1)
	if arg_55_1 then
		return self._shopInfo[arg_55_1] or 0
	end
end

function ShopData:getBuyNumByInfo(arg_56_1)
	if arg_56_1.name then
		return self._shopInfo[arg_56_1.id] or 0
	else
		return self:getPlayBuyCount(arg_56_1.id)
	end
end

function ShopData:getBuyPriceInfo(arg_57_1)
	return self._priceInfo[arg_57_1]
end

function ShopData:getActivityShopByGroup(arg_58_1)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in g.core.config.activity_shop_info.ipairs() do
		if iter_58_1.shop_group == arg_58_1 then
			if not var_58_0[iter_58_1.sign_1] then
				var_58_0[iter_58_1.sign_1] = {}
				var_58_0[iter_58_1.sign_1].name = iter_58_1.sign_1_name
				var_58_0[iter_58_1.sign_1].shopType = iter_58_1.shop_type
			end

			var_58_0[iter_58_1.sign_1].tabList = var_58_0[iter_58_1.sign_1].tabList or {}

			local var_58_1 = var_58_0[iter_58_1.sign_1].tabList

			if not var_58_0[iter_58_1.sign_1].tabList[iter_58_1.sign_2] then
				var_58_1[iter_58_1.sign_2] = {}
				var_58_1[iter_58_1.sign_2].name = iter_58_1.sign_2_name
			end

			var_58_1[iter_58_1.sign_2].shopData = {
				shopType = iter_58_1.shop_type,
				shopValue = iter_58_1.shop_first
			}
		end
	end

	return var_58_0
end

function ShopData:setResetTaskInfo(arg_59_1)
	if not arg_59_1 then
		return
	end

	if self._tasksInfo and self._tasksInfo[arg_59_1] then
		self._tasksInfo[arg_59_1] = 0
	end
end

function ShopData:getShopBuyBanText(arg_60_1, arg_60_2, arg_60_3)
	local var_60_1 = self:_getShopBuyBanTextParam(arg_60_1, arg_60_2, arg_60_3)

	if arg_60_3 ~= 0 then
		if arg_60_1 == var_0_1.TASK_TYPE.CULTIVATE_ITEM then
			var_60_1.name = g.core.config.item_info.get(arg_60_3).name
		elseif arg_60_1 == var_0_1.TASK_TYPE.CULTIVATE_RESOURCE then
			var_60_1.name = g.core.config.resource_info.get(arg_60_3).name
		elseif arg_60_1 == var_0_1.TASK_TYPE.BOUNTY or arg_60_1 == var_0_1.TASK_TYPE.BOUNTY2 then
			var_60_1.name = g.core.config.resource_info.get(arg_60_3).name
		end
	elseif arg_60_2 ~= 0 and arg_60_1 == var_0_1.TASK_TYPE.NEW_SLG_OCCUPY then
		var_60_1.level = arg_60_2
	end

	return (g.core.lang:get(self:_getShopBuyBanTextByType(arg_60_1), var_60_1))
end

function ShopData:_getShopBuyBanTextParam(arg_61_1, arg_61_2)
	local var_61_0 = {
		num = arg_61_2
	}

	if arg_61_1 == var_0_1.TASK_TYPE.RED_CLIFF then
		var_61_0.own = self._tasksInfo[arg_61_1] or 0
	end

	return var_61_0
end

function ShopData:getShopNeedNumBuyBanType(arg_62_1, arg_62_2)
	return self._tasksInfo[self:getShopTaskBanKey(arg_62_1, arg_62_2)] or 0
end

function ShopData:_getShopBuyBanTextByType(arg_63_1)
	if arg_63_1 == var_0_1.TASK_TYPE.LEVEL then
		return 107005
	elseif arg_63_1 == var_0_1.TASK_TYPE.VIP_LEVEL then
		return 107006
	elseif arg_63_1 == var_0_1.TASK_TYPE.ARENA_RANK then
		return 107007
	elseif arg_63_1 == var_0_1.TASK_TYPE.WUSH_STAR then
		return 107008
	elseif arg_63_1 == var_0_1.TASK_TYPE.WUSH_TOWER_STAR then
		return 408424
	elseif arg_63_1 == var_0_1.TASK_TYPE.REBEL_LEVEL then
		return 107009
	elseif arg_63_1 == var_0_1.TASK_TYPE.GUILD_LEVEL then
		return 107010
	elseif arg_63_1 == var_0_1.TASK_TYPE.TEAM_PVP_HONOR then
		return 107011
	elseif arg_63_1 == var_0_1.TASK_TYPE.TREASURE_COMPOSE_NUM then
		return 107012
	elseif arg_63_1 == var_0_1.TASK_TYPE.STORM_SMALL_CITY then
		return 107057
	elseif arg_63_1 == var_0_1.TASK_TYPE.GUILD_CONT then
		return 107068
	elseif arg_63_1 == var_0_1.TASK_TYPE.COMFORT_LEVEL then
		return 107069
	elseif arg_63_1 == var_0_1.TASK_TYPE.WUSH_LEVEL then
		return 107070
	elseif arg_63_1 == var_0_1.TASK_TYPE.TOWER_LEVEL or arg_63_1 == var_0_1.TASK_TYPE.TOWER_HARD_LEVEL then
		return 107106
	elseif arg_63_1 == var_0_1.TASK_TYPE.CROSS_SERVER_ARENA_RANK then
		return 107104
	elseif arg_63_1 == var_0_1.TASK_TYPE.EXPLORATION then
		return 107117
	elseif arg_63_1 == var_0_1.TASK_TYPE.RED_CLIFF then
		return 107121
	elseif arg_63_1 == var_0_1.TASK_TYPE.BOUNTY or arg_63_1 == var_0_1.TASK_TYPE.BOUNTY2 then
		return 107128
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SUMMER then
		return 107075
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_GRYPH then
		return 107076
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_HORUS then
		return 107077
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MOLLY then
		return 107080
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NEWYEAR then
		return 107083
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MAHATMA then
		return 107084
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LEVIA then
		return 107085
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CHIRAHA then
		return 107086
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NILE then
		return 107087
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LUMIN then
		return 107088
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_AKIRA then
		return 107089
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_YORA then
		return 107090
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_IFURITO then
		return 107091
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_OVERLOAD then
		return 107093
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_GOLDENDANCE then
		return 107094
	elseif arg_63_1 == var_0_1.TASK_TYPE.GVE_TASK then
		return 107095
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NUE then
		return 107096
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_BROWN then
		return 107097
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_FANTASY then
		return 107098
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CERBERUS then
		return 107099
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_THOTH then
		return 107119
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_VEDFOLNIR then
		return 107123
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_BRIGHT then
		return 107124
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CAROLINE then
		return 107125
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_FIRE then
		return 107126
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LINEDELL then
		return 107114
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LILITH then
		return 107127
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_HERA then
		return 107133
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_RIE then
		return 107136
	elseif arg_63_1 == var_0_1.TASK_TYPE.CULTIVATE_ITEM or arg_63_1 == var_0_1.TASK_TYPE.CULTIVATE_RESOURCE then
		return 107122
	elseif arg_63_1 == var_0_1.TASK_TYPE.MYSTERY then
		return 107134
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ANUBIS then
		return 107135
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_DIESS then
		return 107137
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LIUDMILA then
		return 107138
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_BANSHEE then
		return 107139
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_WIND then
		return 107140
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_RHAINA then
		return 107141
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LERAPUS then
		return 107142
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_KNOX then
		return 107143
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NOTE then
		return 107144
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_METEOR then
		return 107145
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NVSHE then
		return 107146
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_DAIMONIKA then
		return 107147
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SHUANGDAN then
		return 107148
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SPHINX then
		return 107149
	elseif arg_63_1 == var_0_1.TASK_TYPE.ALLIANCE_LEVEL then
		return 107150
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_TASTE then
		return 107151
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_KLITA then
		return 107152
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_HATTOR then
		return 107153
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SHEETS then
		return 107154
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_PRAY then
		return 107155
	elseif arg_63_1 == var_0_1.TASK_TYPE.NEW_SLG_OCCUPY then
		return 107156
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LINK then
		return 107157
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SPRING then
		return 107159
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LING then
		return 107158
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ITUNG then
		return 107160
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NARWAL then
		return 107161
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CHARLOTTE then
		return 107162
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CHRISTIE then
		return 107163
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_PLINY then
		return 107164
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SAMORIVA then
		return 107165
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_VV_UR then
		return 107166
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ISIS then
		return 107167
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CLOUDS then
		return 107168
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LUJIU then
		return 107169
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_VICAT then
		return 107170
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ALINA then
		return 107171
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NOREN then
		return 107172
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MYRIADS then
		return 107173
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ANNA then
		return 107174
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_PEARLDOG then
		return 107175
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MAKOTO then
		return 107176
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_FEIFEI then
		return 107177
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NATALIA then
		return 107178
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LYDIA then
		return 107179
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MIRA then
		return 107180
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MEL then
		return 107181
	elseif arg_63_1 == var_0_1.TASK_TYPE.BLAZING_ARENA_RANK then
		return 107104
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_KALINKA then
		return 107182
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CLEONA then
		return 107183
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_QILUO then
		return 107184
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SHIRLEY then
		return 107185
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_CARLA then
		return 107186
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_BLADE then
		return 107187
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_NANA then
		return 107188
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MARTHA then
		return 107189
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_SHU then
		return 107190
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_YUANDAN then
		return 107191
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ROSA then
		return 107192
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ASLI then
		return 107193
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LEOLA then
		return 107194
	elseif arg_63_1 == var_0_1.TASK_TYPE.OUTPOST_CITY_LEVEL then
		return 107195
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_PENGPENG then
		return 107196
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_JULIET then
		return 107197
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ZOYA then
		return 107198
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LI then
		return 107199
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_MIRAGE then
		return 107200
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_YU then
		return 107201
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_BAIYU then
		return 107202
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_WEIYANG then
		return 107203
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_LILIAN then
		return 107204
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ILIYI then
		return 107205
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_JOSEPHINE then
		return 107206
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_ELISA then
		return 107207
	elseif arg_63_1 == var_0_1.TASK_TYPE.THEME_RESOURCE then
		return 107208
	end
end

function ShopData:getShopUnlockText(arg_64_1, arg_64_2)
	return (g.core.lang:get(self:_getShopUnlockTextByType(arg_64_1), {
		num = arg_64_2
	}))
end

function ShopData:_getShopUnlockTextByType(arg_65_1)
	if arg_65_1 == var_0_1.TASK_TYPE.STORM_SMALL_CITY then
		return 107071
	end
end

function ShopData:checkShopOpen(arg_66_1, arg_66_2, arg_66_3)
	if arg_66_1 == var_0_1.SHOP_TYPE.UNITE_TOKEN_NORMAL and arg_66_3 == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_LIMIT then
		return var_0_2.recruitData:isLimitUniteTokenRecruitOpen()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.UNITE_TOKEN_OPENSERVER then
		return var_0_2.recruitData:isOpenServerUniteTokenRecruitOpen()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.GUILD then
		return var_0_2.guildData:hasGuild()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.ALLIANCE then
		return var_0_2.allianceData:hasAlliance()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.GIFT then
		if arg_66_2 == var_0_1.RECHARGE_HOT_VALUE.HOT_THEME then
			return var_0_2.giftData:haveThemeActiveOpen(arg_66_2)
		elseif arg_66_2 == var_0_1.RECHARGE_HOT_VALUE.HOT_KNIGHT then
			return var_0_2.giftData:isLimitStartGiftShow()
		elseif arg_66_2 == var_0_1.RECHARGE_HOT_VALUE.HOT_GACHA then
			return g.core.model.User.activityMonthGachaData:isActOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.COMMANDER_GIFT then
			return false
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.WEEKLY_COMPETITION then
			return g.core.model.User.weeklyCompetitionMgrData:hasWeeklyCompetitionActivity()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.WEDDING_ACTIVITY then
			return g.core.model.User.weddingActivityData:isOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.BOUNTY_GIFT then
			return g.core.model.User.bountyData:isActivityInOpenTime()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT then
			return var_0_2.recruitData:checkPreciousGiftIsOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.RECRUIT_SPRING then
			return var_0_2.recruitData:isSpringOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.CULTIVATE_GIFT then
			return var_0_2.cultivateDataMgr:hasActivityOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT then
			return var_0_2.cultivateDataMgr:hasWitchActivityOpen()
		elseif arg_66_2 == var_0_1.SHOP_TYPE.ACTIVITY_RETURN then
			return var_0_2.activityReturnData:isHasActivityOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.RETRO_GIFT then
			return var_0_2.retroData:isActOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.SUCCUBA_LAUNCH then
			return var_0_2.succubaLaunchData:isActOpen()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.ANNIVERSARY_GIFT then
			return var_0_2.anniversaryData:isInActivityGameTime()
		elseif arg_66_2 == var_0_1.SHOP_GIFT_VALUE.ANCIENTS_ACTIVITY then
			return var_0_2.ancientsData:isTimeToOpen()
		end
	elseif arg_66_1 == var_0_1.SHOP_TYPE.THEME then
		-- block empty
	elseif arg_66_1 == var_0_1.SHOP_TYPE.HOT_SALE then
		if arg_66_2 == var_0_1.RECHARGE_HOT_VALUE.HOT_KNIGHT then
			return var_0_2.hotSaleData:getShowHotKnightInfo() ~= nil
		elseif arg_66_2 == var_0_1.RECHARGE_HOT_VALUE.HOT_THEME then
			return true
		elseif arg_66_2 == var_0_1.RECHARGE_HOT_VALUE.HOT_SKIN then
			return var_0_2.hotSaleData:getShowHotSkinInfo() ~= nil
		end
	elseif arg_66_1 == var_0_1.SHOP_TYPE.PRECIOUS then
		return g.core.common.ModuleUnlock:isModuleUnlock(arg_66_3)
	elseif arg_66_1 == var_0_1.SHOP_TYPE.BOUNTY then
		return g.core.model.User.bountyData:isActivityInTime()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.SUCCUBA_LAUNCH then
		return false
	elseif arg_66_1 == var_0_1.SHOP_TYPE.NEW_SLG then
		return var_0_2.newSlgData:isOpen() and not var_0_2.newSlgData:isForecasting()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.ANNIVERSARY then
		return var_0_2.anniversaryData:isActivityOpen()
	elseif arg_66_1 == var_0_1.SHOP_TYPE.DOMAIN_SHOP then
		return var_0_2.domainData:isShowEntrance()
	end

	return true
end

function ShopData:_isShopHasFreeItem(arg_67_1)
	if not self._info[arg_67_1] or not self._info[arg_67_1][var_0_1.SHOP_PLAY_VALUE.FREE] then
		return false
	end

	local var_67_0 = self._info[arg_67_1][var_0_1.SHOP_PLAY_VALUE.FREE]

	if arg_67_1 == var_0_1.SHOP_TYPE.WUSH then
		var_67_0 = self._info[arg_67_1][var_0_1.SHOP_PLAY_VALUE.WUSH_FREE]
	elseif arg_67_1 == var_0_1.SHOP_TYPE.MYSTERY then
		var_67_0 = self._info[arg_67_1][var_0_1.SHOP_PLAY_VALUE.MYSTERY_FREE]
	end

	if next(var_67_0) then
		local var_67_1 = g.core.common.ServerTime:getTime()
		local var_67_2 = g.core.common.ServerTime:getOpenDays()

		for iter_67_0, iter_67_1 in pairs(var_67_0) do
			if iter_67_1.price_type_1 <= 0 and self:isShopItemShow(iter_67_1) then
				local var_67_3 = self:getBuyLimitLeft(iter_67_1)

				if (iter_67_1.num_ban_type ~= 1 or not (var_67_3 and var_67_3 == 0)) and not self:checkBuyBan(iter_67_1) and self:isScoreInTime(iter_67_1, var_67_1) and self:isScoreInSeverTime(iter_67_1, var_67_2) then
					return true
				end
			end
		end

		return false
	else
		return false
	end
end

function ShopData:_isGuildShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.GUILD)
end

function ShopData:_isArenaShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.ARENA)
end

function ShopData:_isRebelShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.REBEL)
end

function ShopData:_isWushShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.WUSH)
end

function ShopData:_isWushTowerShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.WUSH_TOWER)
end

function ShopData:_isOutpostShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.OUTPOST_SHOP)
end

function ShopData:_isCrossServerArenaShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.CROSS_SERVER_ARENA)
end

function ShopData:isTowerShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.TOWER)
end

function ShopData:isTowerHardShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.TOWER_HARD)
end

function ShopData:isMysteryShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.MYSTERY)
end

function ShopData:_isNewSlgShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.NEW_SLG)
end

function ShopData:isBlazingArenaShopHasFreeItem()
	return self:_isShopHasFreeItem(var_0_1.SHOP_TYPE.BLAZING_ARENA)
end

function ShopData:checkShopActivityIsOpen(arg_80_1)
	local var_80_0 = g.core.model.User.activityDataManager:getActivityDataListByFunctionId(g.core.config.shop_info.get(arg_80_1).function_id)[1]

	if var_80_0 then
		return var_80_0:isOpen()
	end

	return false
end

function ShopData:isNeedUpdateInfo()
	return self._needUpdateActivityInfo
end

function ShopData:setNeedUpdateInfo(arg_82_1)
	self._needUpdateActivityInfo = arg_82_1
end

function ShopData:onS2CShopCarInfo(arg_83_1)
	if arg_83_1.shop_car then
		if arg_83_1.shop_car.follow then
			for iter_83_0, iter_83_1 in ipairs(arg_83_1.shop_car.follow) do
				self._attentionsItems[iter_83_1] = self._attentionsItems[iter_83_1] or {}

				local var_83_0 = g.core.config.shop_score_info.get(iter_83_1)

				self._attentionsItems[iter_83_1] = self:isCanFollowShopItem(var_83_0) and var_83_0 or nil
			end
		end

		if arg_83_1.shop_car.unfollow then
			for iter_83_2, iter_83_3 in ipairs(arg_83_1.shop_car.unfollow) do
				if self._attentionsItems[iter_83_3] then
					self._attentionsItems[iter_83_3] = nil
				end
			end
		end
	end
end

function ShopData:onS2CShopCarFollow(arg_84_1)
	if arg_84_1.id then
		self._attentionsItems[arg_84_1.id] = self._attentionsItems[arg_84_1.id] or {}

		local var_84_0 = g.core.config.shop_score_info.get(arg_84_1.id)

		self._attentionsItems[arg_84_1.id] = self:isCanFollowShopItem(var_84_0) and var_84_0 or nil
	end
end

function ShopData:onS2CShopCarUnfollow(arg_85_1)
	if self._attentionsItems[arg_85_1.id] then
		self._attentionsItems[arg_85_1.id] = nil
	end
end

function ShopData:isCanFollowShopItem(arg_86_1)
	local var_86_0 = self:getShopInfoByScoreInfo({
		shop_type = arg_86_1.shop_type,
		shop_first = arg_86_1.shop_first,
		shop_second = arg_86_1.shop_second
	})

	if (var_86_0.function_id ~= 0 or nil) and g.core.common.ModuleUnlock:isModuleUnlock(var_86_0.function_id) and g.core.model.User.shopData:checkShopOpen(var_86_0.shop_type, var_86_0.shop_first, var_86_0.function_id) then
		local var_86_2 = self:getBuyLimitLeft(arg_86_1)

		if self:isShopItemShow(arg_86_1) and (arg_86_1.num_ban_type ~= 1 or not (var_86_2 and var_86_2 == 0)) and self:isScoreInTime(arg_86_1, (g.core.common.ServerTime:getTime())) and self:isScoreInSeverTime(arg_86_1, (g.core.common.ServerTime:getOpenDays())) then
			return true
		end
	end

	return false
end

function ShopData:isShopItemFollow(arg_87_1)
	if self._attentionsItems[arg_87_1] then
		return true
	else
		return false
	end
end

return ShopData
