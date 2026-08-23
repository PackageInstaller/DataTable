local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.const.ConstMgr.RechargeConst
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.common.ModuleUnlock
local GiftData = class("GiftData")
local var_0_5 = g.core.config.recharge_gift_info

function GiftData:ctor()
	self:initData()
end

function GiftData:initData()
	self._isRefreshTime = false
	self._giftDataList = {}
	self._giftDataIdList = {}
	self._needReCalcWithSvrOpenTime = false
	self._giftNextIdDict = {}
	self._themeActiveDict = {}
	self._activeTimeGiftDataDict = {}
	self._showNewGiftIdList = {}
	self._needAddNewList = {}
	self._specialGiftDataDict = {}

	self:_initNewGiftJsonData()
	self:_initBaseInfo()
end

function GiftData:_initNewGiftJsonData()
	self._showNewGiftIdList = g.core.common.Storage:load("rechargeGiftNewIds.json", true) or {}
end

function GiftData:_initBaseInfo()
	local var_4_0 = g.core.platform.PlatformProxy:getOpId()

	for iter_4_0 = 1, var_0_5.getLength() do
		local var_4_1 = var_0_5.indexOf(iter_4_0)
		local var_4_2 = self:_packGiftCfg(var_4_1)

		if not self._giftDataIdList[var_4_2.id] and (var_4_1.app_id ~= 0 or nil) and var_4_1.app_id == tonumber(var_4_0) then
			self._giftDataIdList[var_4_2.id] = var_4_2

			if var_4_2.activity_type > 0 then
				self:_initThemeActiveOne(var_4_2.activity_type, var_4_2.activity_id)
			end

			if var_4_2.prefix == 0 then
				var_4_2.curGiftId = var_4_2.id
			else
				self._giftNextIdDict[var_4_2.prefix] = var_4_2.id
			end

			if var_4_2.special and var_4_2.special == 1 then
				local var_4_4 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_4_2.recharge_type, var_4_2.recharge_money, var_4_2.special)

				if var_4_4 then
					self:_addSpecialGift(var_4_4.product_id, var_4_2)
				end
			end
		end
	end
end

function GiftData:_addSpecialGift(arg_5_1, arg_5_2)
	self._specialGiftDataDict[arg_5_1] = self._specialGiftDataDict[arg_5_1] or {}

	table.insert(self._specialGiftDataDict[arg_5_1], arg_5_2)
end

function GiftData:addValidSpecialGift(arg_6_1)
	self._specialGiftDataDict[arg_6_1] = nil
end

function GiftData:removeAllInvalidSpecial(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self._specialGiftDataDict) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			self._giftDataIdList[iter_7_3.id] = nil

			if self._giftNextIdDict[iter_7_3.prefix] and self._giftNextIdDict[iter_7_3.prefix] == iter_7_3.id then
				self._giftNextIdDict[iter_7_3.prefix] = nil
			end
		end
	end

	if arg_7_1 then
		self:refreshInTime()
	end
end

function GiftData:getGroupGiftRoot(arg_8_1)
	while arg_8_1.prefix > 0 do
		arg_8_1 = self:getGiftDataById(arg_8_1.prefix)
	end

	return arg_8_1
end

function GiftData:receiveGift(arg_9_1)
	if arg_9_1.update then
		self._giftDataIdList[arg_9_1.update.id].buyTimes = arg_9_1.update.buy_times

		self:refreshCurGift(self._giftDataIdList[arg_9_1.update.id])
	end
end

function GiftData:updateServerInfo(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		(self._giftDataIdList[iter_10_1.id] or {}).buyTimes = iter_10_1.buy_times or 0
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_1) do
		if self._giftDataIdList[iter_10_3.id] then
			self:refreshCurGift(self._giftDataIdList[iter_10_3.id])
		end
	end
end

function GiftData:refreshCurGift(arg_11_1)
	if arg_11_1.buyTimes < arg_11_1.times or arg_11_1.limit_type == 0 or not self._giftNextIdDict[arg_11_1.id] then
		arg_11_1.curGiftId = arg_11_1.id

		return
	else
		local var_11_0 = self:getGroupGiftRoot(arg_11_1)
		local var_11_1 = arg_11_1.id

		while self._giftNextIdDict[var_11_1] do
			var_11_1 = self._giftNextIdDict[var_11_1]

			if self._giftDataIdList[var_11_1].time_limited ~= 0 then
				self:calcLimitTime(self._giftDataIdList[var_11_1], g.core.common.ServerTime:getTime())
			end

			if self._giftDataIdList[var_11_1].buyTimes < self._giftDataIdList[var_11_1].times and self._giftDataIdList[var_11_1].isInTime then
				var_11_0.curGiftId = var_11_1

				return
			end
		end

		var_11_0.curGiftId = var_11_1
	end
end

function GiftData:isLimitStartGiftShow()
	local var_12_0 = self:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.RECHARGE_HOT_VALUE.HOT_KNIGHT) or {}

	if #var_12_0 == 0 then
		return false
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = iter_12_1.id == iter_12_1.curGiftId and iter_12_1 or g.core.model.User.giftData:getGiftDataById(iter_12_1.curGiftId)

		if var_12_1.times - var_12_1.buyTimes > 0 then
			if var_12_1.time_limited ~= 0 then
				self:calcLimitTime(var_12_1, g.core.common.ServerTime:getTime())

				if not var_12_1.isInTime then
					return false
				end
			end

			return true
		end
	end

	return false
end

function GiftData:reCalcSvrOpenGift()
	for iter_13_0, iter_13_1 in pairs(self._giftDataIdList) do
		if iter_13_1.time_limited == 2 then
			local var_13_0 = g.core.common.ServerTime:getOpenTime()

			if var_13_0 == 0 then
				self._needReCalcWithSvrOpenTime = true
			end

			iter_13_1.startDate = os.date("*t", (iter_13_1.start_time - 1) * 86400 + var_13_0)
			iter_13_1.endDate = os.date("*t", (iter_13_1.end_time - 1) * 86400 + var_13_0)

			self:calcLimitTime(iter_13_1, (g.core.common.ServerTime:getTime()))
		end
	end
end

function GiftData:refreshInTime()
	if self._needReCalcWithSvrOpenTime then
		self._needReCalcWithSvrOpenTime = false

		self:reCalcSvrOpenGift()
	end

	self._isRefreshTime = true

	self:_refreshActiveGiftTimes()
	self:_checkThemeActiveOpenState()

	self._giftDataList = {}

	local var_14_0 = {}
	local var_14_1 = g.core.common.ServerTime:getTime()

	for iter_14_0, iter_14_1 in pairs(self._giftDataIdList) do
		if iter_14_1.time_limited ~= 0 then
			self:calcLimitTime(iter_14_1, var_14_1)
		end

		if iter_14_1.isInTime and iter_14_1.prefix == 0 then
			if iter_14_1.shop_type == 25 then
				-- block empty
			end

			local var_14_4 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, iter_14_1.shop_first)]

			if not var_14_4 then
				var_14_4 = {}
				self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, iter_14_1.shop_first)] = var_14_4
			end

			if self:_checkThemeGiftOpen(iter_14_1) then
				table.insert(var_14_4, iter_14_1)

				if iter_14_1.hot_sale == 1 then
					table.insert(var_14_0, iter_14_1)
				end
			end
		end
	end

	self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.HOT_SALE, var_0_0.RECHARGE_HOT_VALUE.HOT_GIFT)] = var_14_0
end

function GiftData:_getListKey(arg_15_1, arg_15_2)
	return table.concat({
		arg_15_1,
		"_",
		arg_15_2
	})
end

function GiftData:calcLimitTime(arg_16_1, arg_16_2)
	local var_16_0 = os.time(arg_16_1.startDate)
	local var_16_1 = os.time(arg_16_1.endDate)

	if not var_16_1 or not var_16_0 then
		return
	end

	arg_16_1.isInTime = var_16_0 < arg_16_2 and arg_16_2 < var_16_1
	arg_16_1.remainingTime = math.ceil((var_16_1 - arg_16_2) / 86400)
	arg_16_1.endBuyTime = var_16_1

	if arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.COMMANDER_WORLD or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.CULTIVATE or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ACTIVITY_RETURN or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUCCUBA_LAUNCH or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ANNIVERSARY or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RELEASE_ACTIVITY or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ANCIENTS_ACTIVITY or arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RETRO then
		if arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.CULTIVATE then
			arg_16_1.endBuyTime = g.core.model.User.cultivateDataMgr:getActEndTime(arg_16_1.activity_id)
		elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ACTIVITY_RETURN then
			arg_16_1.endBuyTime = g.core.model.User.activityReturnData:getActEndTime(arg_16_1.activity_id)
		elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RETRO then
			arg_16_1.endBuyTime = g.core.model.User.retroData:getActEndTime(arg_16_1.activity_id)
		elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUCCUBA_LAUNCH then
			arg_16_1.endBuyTime = g.core.model.User.succubaLaunchData:getActivityEndTime(arg_16_1.activity_id)
		elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ANNIVERSARY then
			arg_16_1.endBuyTime = g.core.model.User.anniversaryData:getActivityShowTime(arg_16_1.activity_id)
		elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RELEASE_ACTIVITY then
			arg_16_1.endBuyTime = g.core.model.User.releaseActivityData:getActivityShowTime(arg_16_1.activity_id)
		elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ANCIENTS_ACTIVITY then
			arg_16_1.endBuyTime = g.core.model.User.ancientsData:getActivityShowTime(arg_16_1.activity_id)
		end

		arg_16_1.isInTime = true
	end

	if arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEEKLY_COMPETITION then
		local var_16_2, var_16_3 = g.core.model.User.weeklyCompetitionMgrData:hasWeeklyCompetitionActivityByBaseId(arg_16_1.activity_id)

		arg_16_1.isInTime = var_16_2

		if not arg_16_1.isInTime then
			arg_16_1.endBuyTime = 0
		end
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.WEDDING_ACTIVITY then
		arg_16_1.isInTime = g.core.model.User.weddingActivityData:isOpen(arg_16_1.activity_id)

		local var_16_4 = 0

		if arg_16_1.isInTime then
			local var_16_5 = g.core.model.User.weddingActivityData:getFrontActData()

			var_16_4 = var_16_5.openTime + var_16_5.holdTime
		end

		arg_16_1.endBuyTime = var_16_4
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.BOUNTY_GIFT then
		local var_16_6 = g.core.model.User.bountyData:getActivityTimeInfo().endTime or 0

		arg_16_1.isInTime = g.core.model.User.bountyData:isActivityInOpenTime(arg_16_1.activity_id)

		if not arg_16_1.isInTime then
			arg_16_1.endBuyTime = 0
		end
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT then
		local var_16_7, var_16_8 = g.core.model.User.recruitData:checkPreciousActIsOpen(arg_16_1.activity_id)

		arg_16_1.isInTime = var_16_7
		arg_16_1.endBuyTime = var_16_8
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.CULTIVATE_GIFT then
		local var_16_9, var_16_10 = g.core.model.User.cultivateDataMgr:checkPreciousActIsOpen(arg_16_1.activity_id)

		arg_16_1.isInTime = var_16_9
		arg_16_1.endBuyTime = var_16_10
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT then
		local var_16_11, var_16_12 = g.core.model.User.cultivateDataMgr:checkPreciousActIsOpen(arg_16_1.activity_id)

		arg_16_1.isInTime = var_16_11
		arg_16_1.endBuyTime = var_16_12
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ACTIVITY_RETURN then
		local var_16_13, var_16_14 = g.core.model.User.activityReturnData:checkPreciousActIsOpen(arg_16_1.activity_id)

		arg_16_1.isInTime = var_16_13
		arg_16_1.endBuyTime = var_16_14
	elseif arg_16_1.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RETRO_GIFT then
		local var_16_15, var_16_16 = g.core.model.User.retroData:checkRetroActIsOpen(arg_16_1.activity_id)

		arg_16_1.isInTime = var_16_15
		arg_16_1.endBuyTime = var_16_16
	end

	if arg_16_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RECRUIT_SPRING then
		local var_16_17 = false
		local var_16_18 = 0
		local var_16_19 = g.core.model.User.recruitData:getSpringRecruitData(arg_16_1.activity_id)

		if var_16_19 then
			var_16_17 = var_16_19:isOpen()
			var_16_18 = var_16_19:getFinishTime()
		end

		arg_16_1.isInTime = var_16_17
		arg_16_1.endBuyTime = var_16_18
	end
end

function GiftData:_packGiftCfg(arg_17_1)
	local var_17_0 = clone(arg_17_1).toObject()

	var_17_0.buyTimes = 0
	var_17_0.isInTime = true

	if var_17_0.time_limited ~= 0 then
		self:_packGiftTime(var_17_0)
	end

	return var_17_0
end

function GiftData:_packGiftTime(arg_18_1)
	if arg_18_1.time_limited == 1 then
		arg_18_1.startDate = self:_numberToDate(arg_18_1.start_time)
		arg_18_1.endDate = self:_numberToDate(arg_18_1.end_time)
	elseif arg_18_1.time_limited == 2 then
		local var_18_0 = g.core.common.ServerTime:getOpenTime()

		if var_18_0 == 0 then
			self._needReCalcWithSvrOpenTime = true
		end

		arg_18_1.startDate = os.date("*t", (arg_18_1.start_time - 1) * 86400 + var_18_0)
		arg_18_1.endDate = os.date("*t", (arg_18_1.end_time - 1) * 86400 + var_18_0)
	elseif arg_18_1.time_limited == 3 then
		local var_18_1 = g.core.model.User:getCreateTime()

		arg_18_1.startDate = os.date("*t", (arg_18_1.start_time - 1) * 86400 + var_18_1)
		arg_18_1.endDate = os.date("*t", (arg_18_1.end_time - 1) * 86400 + var_18_1)
	elseif arg_18_1.time_limited == 4 then
		self._activeTimeGiftDataDict[arg_18_1.id] = arg_18_1

		self:_initActiveGiftTime(arg_18_1)
	end
end

function GiftData:_initActiveGiftTime(arg_19_1)
	if arg_19_1.time_limited == 4 then
		local var_19_0 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(arg_19_1.activity_type, arg_19_1.activity_id)

		if var_19_0 and var_19_0:isOpen() then
			arg_19_1.startDate = os.date("*t", var_19_0:getStartTime())
			arg_19_1.endDate = os.date("*t", var_19_0:getFinishTime())
		else
			arg_19_1.startDate = nil
			arg_19_1.endDate = nil
		end
	end
end

function GiftData:_refreshActiveGiftTimes()
	for iter_20_0, iter_20_1 in pairs(self._activeTimeGiftDataDict) do
		self:_initActiveGiftTime(iter_20_1)
	end
end

function GiftData:_numberToDate(arg_21_1)
	local var_21_0 = {
		year = math.floor(arg_21_1 / 10000)
	}

	var_21_0.month = math.floor((arg_21_1 - 10000 * var_21_0.year) / 100)
	var_21_0.day = arg_21_1 % 100
	var_21_0.hour = 0

	return var_21_0
end

function GiftData:_isGiftCanBuy(arg_22_1)
	if arg_22_1.limit_type == var_0_1.GIFT_LIMIT_TYPE.NORMAL then
		return true
	else
		return arg_22_1.times - arg_22_1.buyTimes > 0
	end
end

function GiftData:getGiftListByShopTypeValue(arg_23_1, arg_23_2, arg_23_3)
	if not self._isRefreshTime then
		self:refreshInTime()
	end

	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(self._giftDataList[self:_getListKey(arg_23_1, arg_23_2)] or {}) do
		if var_23_1[iter_23_1.shop_first] == nil then
			var_23_1[iter_23_1.shop_first] = iter_23_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.WEDDING_ACTIVITY and true or var_0_3:isModuleUnlock(var_0_2:getShopInfoByScoreInfo({
				shop_second = 0,
				shop_type = var_0_0.SHOP_TYPE.GIFT,
				shop_first = iter_23_1.shop_first
			}):toObject().function_id)
		end

		local var_23_3 = iter_23_1.time_limited == 0 or iter_23_1.time_limited ~= 0 and g.core.common.ServerTime:getLeftSeconds(iter_23_1.endBuyTime) > 0

		self:refreshCurGift(iter_23_1)

		if iter_23_1.shop_first == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.COMMANDER_WORLD then
			if self:isCommanderWorldOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.CULTIVATE_GIFT then
			if g.core.model.User.cultivateDataMgr:isActOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.SUCCUBA_LAUNCH then
			if g.core.model.User.succubaLaunchData:isActOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ANNIVERSARY_GIFT then
			if g.core.model.User.anniversaryData:isInActivityGameTime(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT then
			if g.core.model.User.cultivateDataMgr:isActOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ACTIVITY_RETURN then
			if g.core.model.User.activityReturnData:isActivityOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RETRO_GIFT then
			if g.core.model.User.retroData:isActOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RELEASE_ACTIVITY then
			if g.core.model.User.releaseActivityData:isActivityOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ANCIENTS_ACTIVITY then
			if g.core.model.User.ancientsData:isActivityOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEEKLY_COMPETITION and var_23_3 then
			if g.core.model.User.weeklyCompetitionMgrData:hasWeeklyCompetitionActivityByBaseId(iter_23_1.activity_id) then
				if arg_23_3 then
					if arg_23_3(iter_23_1) then
						table.insert(var_23_0, iter_23_1)
					end
				else
					table.insert(var_23_0, iter_23_1)
				end
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEDDING_ACTIVITY and var_23_3 then
			if g.core.model.User.weddingActivityData:isOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.BOUNTY_GIFT and var_23_3 then
			if g.core.model.User.bountyData:isActivityInOpenTime(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT and var_23_3 then
			if g.core.model.User.recruitData:checkPreciousActIsOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif iter_23_1.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RECRUIT_SPRING and var_23_3 then
			if g.core.model.User.recruitData:isSpringOpen(iter_23_1.activity_id) then
				table.insert(var_23_0, iter_23_1)
			end
		elseif var_23_1[iter_23_1.shop_first] and var_0_3:isModuleUnlock(iter_23_1.function_id) and var_23_3 then
			if arg_23_3 then
				if arg_23_3(iter_23_1) then
					table.insert(var_23_0, iter_23_1)
				end
			else
				table.insert(var_23_0, iter_23_1)
			end
		end
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		local var_24_0 = self:getGiftDataById(arg_24_0.curGiftId)
		local var_24_1 = self:getGiftDataById(arg_24_1.curGiftId)
		local var_24_2 = self:_isGiftCanBuy(var_24_0)

		if var_24_2 ~= self:_isGiftCanBuy(var_24_1) then
			return var_24_2
		end

		if var_24_0.sort ~= var_24_1.sort then
			return var_24_0.sort > var_24_1.sort
		end

		return var_24_0.id > var_24_1.id
	end)

	return var_23_0
end

function GiftData:getGiftDataById(arg_25_1)
	return self._giftDataIdList[arg_25_1]
end

function GiftData:_checkThemeGiftOpen(arg_26_1)
	if arg_26_1.activity_type > 0 then
		if arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.GACHA_GIFT then
			return self:_checkMonthGachaGiftOpen(arg_26_1)
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.COMMANDER_GIFT then
			return self:isCommanderWorldOpen(arg_26_1.activity_id)
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.CULTIVATE_GIFT then
			return self:isCultivateGiftOpen(arg_26_1.activity_id)
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT then
			return self:isCultivateGiftOpen(arg_26_1.activity_id)
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.RETRO_GIFT then
			return self:isRetroGiftOpen(arg_26_1.activity_id)
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.WEEKLY_COMPETITION then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.WEDDING_ACTIVITY then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.BOUNTY_GIFT then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.RECRUIT_SPRING then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.SUCCUBA_LAUNCH then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.ANNIVERSARY_GIFT then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.RELEASE_ACTIVITY then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.ANCIENTS_ACTIVITY then
			return true
		elseif arg_26_1.shop_first == var_0_0.SHOP_GIFT_VALUE.ACTIVITY_RETURN then
			return self:isActivityReturnGiftOpen(arg_26_1.activity_id)
		end

		return self:isThemeActiveOpen(arg_26_1.activity_type, arg_26_1.activity_id)
	end

	return true
end

function GiftData:isActivityReturnGiftOpen(arg_27_1)
	return g.core.model.User.activityReturnData:isActivityOpen(arg_27_1)
end

function GiftData:isCultivateGiftOpen(arg_28_1)
	return g.core.model.User.cultivateDataMgr:isActOpen(arg_28_1)
end

function GiftData:isRetroGiftOpen(arg_29_1)
	return g.core.model.User.retroData:isActOpen(arg_29_1)
end

function GiftData:_checkMonthGachaGiftOpen(arg_30_1)
	return self:isGachaActiveOpen(arg_30_1.activity_type, arg_30_1.activity_id)
end

function GiftData:isGachaActiveOpen(arg_31_1, arg_31_2)
	return g.core.model.User.activityMonthGachaData:isActOpen(arg_31_2)
end

function GiftData:isCommanderWorldOpen(arg_32_1)
	return g.core.model.User.commanderWorldData:checkActivityOpen(arg_32_1)
end

function GiftData:_initThemeActiveOne(arg_33_1, arg_33_2)
	local var_33_0 = self._themeActiveDict[arg_33_1]

	if not self._themeActiveDict[arg_33_1] then
		var_33_0 = {}
		self._themeActiveDict[arg_33_1] = var_33_0
	end

	var_33_0[arg_33_2] = false
end

function GiftData:_checkThemeActiveOpenState()
	for iter_34_0, iter_34_1 in pairs(self._themeActiveDict) do
		for iter_34_2, iter_34_3 in pairs(iter_34_1) do
			local var_34_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(iter_34_0, iter_34_2)

			if var_34_1 and var_34_1:isOpen() then
				self._themeActiveDict[iter_34_0][iter_34_2] = true
			end
		end
	end
end

function GiftData:haveThemeActiveOpen(arg_35_1)
	if self._themeActiveDict[arg_35_1] then
		for iter_35_0, iter_35_1 in pairs(self._themeActiveDict[arg_35_1]) do
			if iter_35_1 then
				return true
			end
		end
	end

	return false
end

function GiftData:isThemeActiveOpen(arg_36_1, arg_36_2)
	if self._themeActiveDict[arg_36_1] then
		return self._themeActiveDict[arg_36_1][arg_36_2]
	else
		return false
	end
end

function GiftData:isCanReceiveFreeGift(arg_37_1)
	if arg_37_1 and arg_37_1.id then
		if self._giftDataIdList[arg_37_1.id].buy_level and self._giftDataIdList[arg_37_1.id].buy_level > 0 and g.core.model.User:getLevel() < self._giftDataIdList[arg_37_1.id].buy_level then
			return false
		end

		return self:_checkGiftIsFree(self._giftDataIdList[arg_37_1.id])
	else
		local var_37_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.GIFT)]

		if var_37_0 then
			local var_37_1 = g.core.model.User:getLevel()

			for iter_37_0, iter_37_1 in pairs(var_37_0) do
				local var_37_2 = iter_37_1

				if iter_37_1.curGiftId and iter_37_1.curGiftId > 0 then
					var_37_2 = self._giftDataIdList[iter_37_1.curGiftId]
				end

				if not (var_37_2.buy_level and var_37_2.buy_level > 0 and var_37_1 < var_37_2.buy_level) and self:_checkGiftIsFree(var_37_2) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:_checkGiftIsFree(arg_38_1)
	return arg_38_1 and arg_38_1.recharge_money == 0 and var_0_3:isModuleUnlock(arg_38_1.function_id) and (arg_38_1.limit_type == var_0_1.GIFT_LIMIT_TYPE.NORMAL or arg_38_1.buyTimes < arg_38_1.times) and (not arg_38_1.diamond_price or arg_38_1.diamond_price == 0) and (not arg_38_1.free_diamond or arg_38_1.free_diamond == 0)
end

function GiftData:_checkGiftIsFreeDiamond(arg_39_1)
	return arg_39_1 and arg_39_1.recharge_money == 0 and var_0_3:isModuleUnlock(arg_39_1.function_id) and arg_39_1.buyTimes < arg_39_1.times and (not arg_39_1.diamond_price or arg_39_1.diamond_price == 0) and (not arg_39_1.free_diamond or arg_39_1.free_diamond > 0)
end

function GiftData:isCanReceiveLimitFreeGift(arg_40_1)
	if arg_40_1 and arg_40_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_40_1.id])
	else
		local var_40_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.LIMIT_GIFT)]

		if var_40_0 then
			for iter_40_0, iter_40_1 in pairs(var_40_0) do
				if self:_checkGiftIsFree(iter_40_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveMonthlyFreeGift(arg_41_1)
	if arg_41_1 and arg_41_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_41_1.id])
	else
		local var_41_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.MONTH_GIFT)]

		if var_41_0 then
			for iter_41_0, iter_41_1 in pairs(var_41_0) do
				if self:_checkGiftIsFree(iter_41_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveHotFreeGift(arg_42_1)
	if arg_42_1 and arg_42_1.id then
		local var_42_0 = false

		if self._giftDataIdList[arg_42_1.id] then
			var_42_0 = var_0_3:isModuleUnlock(var_0_2:getShopInfoByScoreInfo({
				shop_second = 0,
				shop_type = var_0_0.SHOP_TYPE.GIFT,
				shop_first = self._giftDataIdList[arg_42_1.id].shop_first
			}).function_id)
		end

		if self._giftDataIdList[arg_42_1.id].buy_level and self._giftDataIdList[arg_42_1.id].buy_level > 0 and g.core.model.User:getLevel() < self._giftDataIdList[arg_42_1.id].buy_level then
			return false
		end

		return var_42_0 and self:_checkGiftIsFree(self._giftDataIdList[arg_42_1.id])
	else
		local var_42_1 = self:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.HOT_SALE, var_0_0.RECHARGE_HOT_VALUE.HOT_GIFT)

		if var_42_1 then
			local var_42_2 = g.core.model.User:getLevel()

			for iter_42_0, iter_42_1 in pairs(var_42_1) do
				local var_42_3 = iter_42_1

				if iter_42_1.curGiftId and iter_42_1.curGiftId > 0 then
					var_42_3 = self._giftDataIdList[iter_42_1.curGiftId]
				end

				if not (var_42_3.buy_level and var_42_3.buy_level > 0 and var_42_2 < var_42_3.buy_level) and self:_checkGiftIsFree(var_42_3) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveThemeFreeGift(arg_43_1)
	if arg_43_1 and arg_43_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_43_1.id])
	else
		local var_43_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.THEME_GIFT)]

		if var_43_0 then
			for iter_43_0, iter_43_1 in pairs(var_43_0) do
				if iter_43_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_43_1.function_id) and (not iter_43_1.diamond_price or iter_43_1.diamond_price == 0) and iter_43_1.buyTimes < iter_43_1.times then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveReleaseFreeDiamondGfit(arg_44_1)
	if arg_44_1 and arg_44_1.id then
		return self:_checkGiftIsFreeDiamond(self._giftDataIdList[arg_44_1.id])
	else
		local var_44_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RELEASE_ACTIVITY)]

		if var_44_0 then
			for iter_44_0, iter_44_1 in pairs(var_44_0) do
				if self:_checkGiftIsFreeDiamond(iter_44_1) and g.core.model.User.releaseActivityData:isActivityOpen(iter_44_1.activity_id) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isHaveNewThemeGift()
	return false
end

function GiftData:isCanReceiveCultivateFreeGift(arg_46_1)
	if not g.core.model.User.cultivateDataMgr:hasActivityHasFreeGift() then
		return false
	end

	if not arg_46_1.actValue then
		local var_46_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.CULTIVATE_GIFT)]

		if var_46_0 then
			for iter_46_0, iter_46_1 in pairs(var_46_0) do
				if iter_46_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_46_1.function_id) and (not iter_46_1.diamond_price or iter_46_1.diamond_price == 0) and iter_46_1.buyTimes < iter_46_1.times then
					return true
				end
			end
		end

		return false
	end

	if not g.core.model.User.cultivateDataMgr:isActivityOpen(arg_46_1.actValue) then
		return false
	end

	if arg_46_1 and arg_46_1.id then
		if self._giftDataIdList[arg_46_1.id].activity_id == arg_46_1.actValue then
			return self:_checkGiftIsFree(self._giftDataIdList[arg_46_1.id])
		else
			return false
		end
	else
		local var_46_1 = g.core.model.User.cultivateDataMgr:getCultivateData(arg_46_1.actValue)
		local var_46_2 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.CULTIVATE_GIFT)]

		if var_46_1:isWitchActivity() then
			var_46_2 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT)]
		end

		if var_46_2 then
			for iter_46_2, iter_46_3 in pairs(var_46_2) do
				if iter_46_3.recharge_money == 0 and var_0_3:isModuleUnlock(iter_46_3.function_id) and (not iter_46_3.diamond_price or iter_46_3.diamond_price == 0) and iter_46_3.buyTimes < iter_46_3.times and iter_46_3.activity_id == arg_46_1.actValue then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveWitchCultivateFreeGift(arg_47_1)
	if not g.core.model.User.cultivateDataMgr:hasActivityHasFreeGift() then
		return false
	end

	if not arg_47_1.actValue then
		local var_47_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT)]

		if var_47_0 then
			for iter_47_0, iter_47_1 in pairs(var_47_0) do
				if iter_47_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_47_1.function_id) and (not iter_47_1.diamond_price or iter_47_1.diamond_price == 0) and iter_47_1.buyTimes < iter_47_1.times then
					return true
				end
			end
		end

		return false
	end

	if not g.core.model.User.cultivateDataMgr:isActivityOpen(arg_47_1.actValue) then
		return false
	end

	if arg_47_1 and arg_47_1.id then
		if self._giftDataIdList[arg_47_1.id].activity_id == arg_47_1.actValue then
			return self:_checkGiftIsFree(self._giftDataIdList[arg_47_1.id])
		else
			return false
		end
	else
		local var_47_1 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT)]

		if var_47_1 then
			for iter_47_2, iter_47_3 in pairs(var_47_1) do
				if iter_47_3.recharge_money == 0 and var_0_3:isModuleUnlock(iter_47_3.function_id) and (not iter_47_3.diamond_price or iter_47_3.diamond_price == 0) and iter_47_3.buyTimes < iter_47_3.times and iter_47_3.activity_id == arg_47_1.actValue then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceivePreciousFreeGift(arg_48_1)
	if arg_48_1 and arg_48_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_48_1.id])
	else
		local var_48_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT)]

		if var_48_0 then
			for iter_48_0, iter_48_1 in pairs(var_48_0) do
				if iter_48_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_48_1.function_id) and (not iter_48_1.diamond_price or iter_48_1.diamond_price == 0) and iter_48_1.buyTimes < iter_48_1.times then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveActivityReturnFreeGift(arg_49_1)
	if arg_49_1 and arg_49_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_49_1.id])
	else
		local var_49_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.ACTIVITY_RETURN)]

		if var_49_0 then
			for iter_49_0, iter_49_1 in pairs(var_49_0) do
				if iter_49_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_49_1.function_id) and (not iter_49_1.diamond_price or iter_49_1.diamond_price == 0) and (not iter_49_1.free_diamond or iter_49_1.free_diamond == 0) and iter_49_1.buyTimes < iter_49_1.times then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveRetroFreeGift(arg_50_1)
	if arg_50_1 and arg_50_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_50_1.id])
	else
		local var_50_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RETRO_GIFT)]

		if var_50_0 then
			for iter_50_0, iter_50_1 in pairs(var_50_0) do
				if iter_50_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_50_1.function_id) and (not iter_50_1.diamond_price or iter_50_1.diamond_price == 0) and iter_50_1.buyTimes < iter_50_1.times then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isHaveNewThemeGift()
	return false
end

function GiftData:isCanReceiveMonthFreeGift(arg_52_1)
	if arg_52_1 and arg_52_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_52_1.id])
	else
		local var_52_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.MONTH_GIFT)]

		if var_52_0 then
			for iter_52_0, iter_52_1 in pairs(var_52_0) do
				if iter_52_1.recharge_money == 0 and var_0_3:isModuleUnlock(iter_52_1.function_id) and iter_52_1.buyTimes < iter_52_1.times then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveLevelFreeGift(arg_53_1)
	local var_53_0 = g.core.model.User:getLevel()

	if arg_53_1 and arg_53_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_53_1.id]) and var_53_0 >= self._giftDataIdList[arg_53_1.id].buy_level
	else
		local var_53_1 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.LEVEL_GIFT)]

		if var_53_1 then
			for iter_53_0, iter_53_1 in pairs(var_53_1) do
				local var_53_2 = iter_53_1

				if iter_53_1.curGiftId and iter_53_1.curGiftId > 0 then
					var_53_2 = self._giftDataIdList[iter_53_1.curGiftId]
				end

				if self:_checkGiftIsFree(var_53_2) and var_53_0 >= var_53_2.buy_level then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveGachaFreeGift(arg_54_1)
	if arg_54_1 and arg_54_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_54_1.id])
	else
		local var_54_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.GACHA_GIFT)]

		if var_54_0 then
			for iter_54_0, iter_54_1 in pairs(var_54_0) do
				if self:_checkGiftIsFree((iter_54_1.curGiftId and iter_54_1.curGiftId > 0 or nil) and self._giftDataIdList[iter_54_1.curGiftId]) and var_0_3:isModuleUnlock(iter_54_1.function_id) and self:_checkMonthGachaGiftOpen(iter_54_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveNewPlayerFreeGift(arg_55_1)
	if arg_55_1 and arg_55_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_55_1.id])
	else
		local var_55_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.NEO_GIFT)]

		if var_55_0 then
			for iter_55_0, iter_55_1 in pairs(var_55_0) do
				if self:_checkGiftIsFree(iter_55_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveScuccubaLaunchFreeGift(arg_56_1)
	if arg_56_1 and arg_56_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_56_1.id])
	else
		local var_56_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.SUCCUBA_LAUNCH)]

		if var_56_0 then
			for iter_56_0, iter_56_1 in pairs(var_56_0) do
				if g.core.model.User.succubaLaunchData:isActOpen(iter_56_1.activity_id) and self:_checkGiftIsFree(iter_56_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveWeddingFreeGift(arg_57_1)
	if arg_57_1 and arg_57_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_57_1.id])
	else
		local var_57_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.WEDDING)]

		if var_57_0 then
			for iter_57_0, iter_57_1 in pairs(var_57_0) do
				if self:_checkGiftIsFree(iter_57_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:isCanReceiveRecruitSpringFreeGift(arg_58_1)
	if not g.core.model.User.recruitData:isSpringOpen() then
		return false
	end

	if arg_58_1 and arg_58_1.id then
		return self:_checkGiftIsFree(self._giftDataIdList[arg_58_1.id])
	else
		local var_58_0 = self._giftDataList[self:_getListKey(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RECRUIT_SPRING)]

		if var_58_0 then
			for iter_58_0, iter_58_1 in pairs(var_58_0) do
				if self:_checkGiftIsFree(iter_58_1) then
					return true
				end
			end
		end

		return false
	end
end

function GiftData:addNewLevelGiftId(arg_59_1)
	local var_59_0 = tostring(arg_59_1)

	if not self._showNewGiftIdList[var_59_0] then
		self._needAddNewList[var_59_0] = arg_59_1
	end
end

function GiftData:saveNewGiftIds()
	if not next(self._needAddNewList) then
		return false
	end

	local var_60_0 = table.nums(self._showNewGiftIdList)

	for iter_60_0, iter_60_1 in pairs(self._needAddNewList) do
		self._showNewGiftIdList[iter_60_0] = iter_60_1
	end

	self._needAddNewList = {}

	if var_60_0 ~= table.nums(self._showNewGiftIdList) then
		g.core.common.Storage:save("rechargeGiftNewIds.json", self._showNewGiftIdList)

		return true
	end

	return false
end

function GiftData:isHaveNewLevelGift(arg_61_1)
	if not arg_61_1 then
		return false
	end

	local var_61_0 = g.core.model.User:getLevel()

	if arg_61_1.id then
		local var_61_1 = arg_61_1.id
		local var_61_2 = self._giftDataIdList[arg_61_1.id]

		if not self._giftDataIdList[arg_61_1.id] then
			return false
		end

		return (var_61_2.buy_level or 0) <= var_61_0 and self._showNewGiftIdList[tostring(var_61_1)] == nil and var_61_2.buyTimes < var_61_2.times
	elseif arg_61_1.shopType and arg_61_1.shopType == var_0_0.SHOP_TYPE.HOT_SALE then
		for iter_61_0, iter_61_1 in pairs((self:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.HOT_SALE, var_0_0.RECHARGE_HOT_VALUE.HOT_GIFT))) do
			if self:_checkIsNewLevelGift(iter_61_1, var_61_0) then
				return true
			end
		end
	else
		for iter_61_2, iter_61_3 in pairs((self:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.LEVEL_GIFT))) do
			if self:_checkIsNewLevelGift(iter_61_3, var_61_0) then
				return true
			end
		end
	end

	return false
end

function GiftData:_checkIsNewLevelGift(arg_62_1, arg_62_2)
	if not next(self._showNewGiftIdList) then
		self:_initNewGiftJsonData()
	end

	local var_62_0 = arg_62_1

	if arg_62_1.curGiftId and arg_62_1.curGiftId > 0 then
		var_62_0 = self._giftDataIdList[arg_62_1.curGiftId]
	end

	if arg_62_2 >= var_62_0.buy_level and self._showNewGiftIdList[tostring(var_62_0.curGiftId)] == nil and var_62_0.shop_first == var_0_0.SHOP_GIFT_VALUE.LEVEL_GIFT and var_62_0.buyTimes < var_62_0.times then
		return true
	end

	return false
end

return GiftData
