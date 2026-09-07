local ApartmentProxy = class("ApartmentProxy", import(".NetProxy"))

ApartmentProxy.UPDATE_APARTMENT = "ApartmentProxy.UPDATE_APARTMENT"
ApartmentProxy.UPDATE_ROOM = "ApartmentProxy.UPDATE_ROOM"
ApartmentProxy.UPDATE_GIFT_COUNT = "ApartmentProxy.UPDATE_GIFT_COUNT"
ApartmentProxy.ZERO_HOUR_REFRESH = "ApartmentProxy.ZERO_HOUR_REFRESH"
ApartmentProxy.UPDATE_ROOM_INVITE_LIST = "ApartmentProxy.UPDATE_ROOM_INVITE_LIST"
ApartmentProxy.UPDATE_SLIDE_INVITE_LIST = "ApartmentProxy.UPDATE_SLIDE_INVITE_LIST"

function ApartmentProxy:register()
	self.data = {}
	self.roomData = {}
	self.giftBag = setDefaultZeroMetatable({})
	self.giftGiveCount = setDefaultZeroMetatable({})
	self.stamina = 0
	self.shopCount = {
		dailyGift = {},
		permanentGift = {},
		dailyFurniture = {},
		permanentFurniture = {}
	}

	self:on(28000, function(arg_2_0)
		self.stamina = getDorm3dGameset("daily_vigor_max")[1] - arg_2_0.daily_vigor_max

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.gifts) do
			self.giftBag[iter_2_1.gift_id] = iter_2_1.number
			self.giftGiveCount[iter_2_1.gift_id] = iter_2_1.used_number
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.ships) do
			local var_2_0 = Apartment.New(iter_2_3)

			self.data[var_2_0:GetConfigID()] = var_2_0
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.rooms) do
			local var_2_1 = ApartmentRoom.New(iter_2_5)

			self.roomData[var_2_1:GetConfigID()] = var_2_1
		end

		local function var_2_2(arg_3_0, arg_3_1)
			_.each(arg_3_0 or {}, function(arg_4_0)
				arg_3_1[arg_4_0.gift_id] = arg_4_0.count

				return
			end)

			return
		end

		var_2_2(arg_2_0.gift_daily, self.shopCount.dailyGift)
		var_2_2(arg_2_0.gift_permanent, self.shopCount.permanentGift)
		var_2_2(arg_2_0.furniture_daily, self.shopCount.dailyFurniture)
		var_2_2(arg_2_0.furniture_permanent, self.shopCount.permanentFurniture)

		return
	end)

	return
end

function ApartmentProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_6_0, arg_6_1)
			if pg.TimeMgr.GetInstance():GetServerWeek() ~= 1 then
				return
			end

			self:ResetDailyShopCount()

			self.stamina = getDorm3dGameset("daily_vigor_max")[1]

			self:sendNotification(ApartmentProxy.ZERO_HOUR_REFRESH)
			self:InitGiftDaily()
			ApartmentProxy.RefreshGiftDailyTip()

			return
		end
	}
end

function ApartmentProxy:InitGiftDaily()
	pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
		callback = function()
			for iter_8_0, iter_8_1 in ipairs(pg.dorm3d_gift.all) do
				if #pg.dorm3d_gift[iter_8_1].shop_id > 0 then
					if pg.shop_template[pg.dorm3d_gift[iter_8_1].shop_id[1]].group ~= 0 then
						self.shopCount.dailyGift[pg.dorm3d_gift[iter_8_1].id] = getProxy(ShopsProxy):GetGroupPayCount(pg.shop_template[pg.dorm3d_gift[iter_8_1].shop_id[1]].group)
					end
				end
			end

			return
		end
	})

	return
end

function ApartmentProxy:updateApartment(arg_9_1)
	self.data[arg_9_1.configId] = arg_9_1:clone()

	self:sendNotification(ApartmentProxy.UPDATE_APARTMENT, arg_9_1)

	return
end

function ApartmentProxy:updateRoom(arg_10_1)
	self.roomData[arg_10_1.configId] = arg_10_1:clone()

	self:sendNotification(ApartmentProxy.UPDATE_ROOM, arg_10_1)

	return
end

function ApartmentProxy:ModifyApartment(arg_11_1, arg_11_2)
	local var_11_0 = self.data[arg_11_1]

	assert(self.data[arg_11_1], "apartment not exist")

	if type(arg_11_2) == "function" then
		arg_11_2(var_11_0)
	elseif type(arg_11_2) == "table" then
		for iter_11_0, iter_11_1 in pairs(arg_11_2) do
			var_11_0[iter_11_0] = iter_11_1
		end
	end

	self:sendNotification(ApartmentProxy.UPDATE_APARTMENT, var_11_0:clone())

	return
end

function ApartmentProxy:ModifyRoom(arg_12_1, arg_12_2)
	local var_12_0 = self.roomData[arg_12_1]

	assert(self.roomData[arg_12_1], "room not exist")

	if type(arg_12_2) == "function" then
		arg_12_2(var_12_0)
	elseif type(arg_12_2) == "table" then
		for iter_12_0, iter_12_1 in pairs(arg_12_2) do
			var_12_0[iter_12_0] = iter_12_1
		end
	end

	self:sendNotification(ApartmentProxy.UPDATE_ROOM, var_12_0:clone())

	return
end

function ApartmentProxy:triggerFavor(arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or 1

	local var_13_0 = self.data[arg_13_1]
	local var_13_1 = 0
	local var_13_2 = 0

	if self.stamina >= pg.dorm3d_favor_trigger[arg_13_2].is_daily_max and not var_13_0:isMaxFavor() then
		var_13_2 = pg.dorm3d_favor_trigger[arg_13_2].is_daily_max * arg_13_3
		var_13_1 = math.min(pg.dorm3d_favor_trigger[arg_13_2].num * arg_13_3, var_13_0:getMaxFavor() - var_13_0.favor)
	end

	self.stamina = self.stamina - var_13_2
	var_13_0.favor = var_13_0.favor + var_13_1
	var_13_0.triggerCountDic[arg_13_2] = var_13_0.triggerCountDic[arg_13_2] + 1

	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataFavor(arg_13_1, var_13_1, var_13_0.favor, pg.dorm3d_favor_trigger[arg_13_2].type, table.CastToString(pg.dorm3d_favor_trigger[arg_13_2].param)))
	self:updateApartment(var_13_0)

	return var_13_1, var_13_2
end

function ApartmentProxy:getStamina()
	return self.stamina, getDorm3dGameset("daily_vigor_max")[1]
end

function ApartmentProxy:RawGetApartment(arg_15_1)
	return self.data[arg_15_1]
end

function ApartmentProxy:getApartment(arg_16_1)
	return self.data[arg_16_1] and self.data[arg_16_1]:clone() or nil
end

function ApartmentProxy:getRoom(arg_17_1)
	return self.roomData[arg_17_1]
end

function ApartmentProxy:getGiftCount(arg_18_1)
	return self.giftBag[arg_18_1]
end

function ApartmentProxy:changeGiftCount(arg_19_1, arg_19_2)
	assert(arg_19_2 ~= 0)

	self.giftBag[arg_19_1] = self.giftBag[arg_19_1] + arg_19_2

	self:sendNotification(ApartmentProxy.UPDATE_GIFT_COUNT, arg_19_1)

	return
end

function ApartmentProxy:getApartmentGiftCount(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self.giftBag) do
		if iter_20_1 > 0 and pg.dorm3d_gift[iter_20_0].ship_group_id == arg_20_1 then
			return iter_20_0
		end
	end

	return nil
end

function ApartmentProxy:HasGiftExpireSoon()
	for iter_21_0, iter_21_1 in pairs(self.giftBag) do
		if iter_21_1 > 0 and Dorm3dGift.IsExpireSoon(iter_21_0) then
			return true
		end
	end

	return false
end

function ApartmentProxy:HasShipGroupGiftExpireSoon(arg_22_1)
	return _.any(pg.dorm3d_gift.get_id_list_by_ship_group_id[arg_22_1] or {}, function(arg_23_0)
		return self:getGiftCount(arg_23_0) > 0 and Dorm3dGift.IsExpireSoon(arg_23_0)
	end)
end

function ApartmentProxy:GetShipGroupGiftExpireSoonTipIds(arg_24_1)
	return _.filter(pg.dorm3d_gift.get_id_list_by_ship_group_id[arg_24_1] or {}, function(arg_25_0)
		return self:getGiftCount(arg_25_0) > 0 and Dorm3dGift.IsExpireSoon(arg_25_0) and Dorm3dGift.GetExpireSoonTipFlag(arg_25_0) == 0
	end)
end

function ApartmentProxy:addGiftGiveCount(arg_26_1, arg_26_2)
	self.giftGiveCount[arg_26_1] = self.giftGiveCount[arg_26_1] + arg_26_2

	return
end

function ApartmentProxy:isGiveGiftDone(arg_27_1)
	return self.giftGiveCount[arg_27_1] > 0
end

function ApartmentProxy:GetGiftShopCount(arg_28_1)
	return self.shopCount.dailyGift[arg_28_1] or self.shopCount.permanentGift[arg_28_1] or 0
end

function ApartmentProxy:AddDailyGiftShopCount(arg_29_1, arg_29_2)
	self.shopCount.dailyGift[arg_29_1] = (self.shopCount.dailyGift[arg_29_1] or 0) + arg_29_2

	return
end

function ApartmentProxy:AddPermanentGiftShopCount(arg_30_1, arg_30_2)
	self.shopCount.permanentGift[arg_30_1] = (self.shopCount.permanentGift[arg_30_1] or 0) + arg_30_2

	return
end

function ApartmentProxy:GetFurnitureShopCount(arg_31_1)
	return self.shopCount.dailyFurniture[arg_31_1] or self.shopCount.permanentFurniture[arg_31_1] or 0
end

function ApartmentProxy:AddDailyFurnitureShopCount(arg_32_1, arg_32_2)
	self.shopCount.dailyFurniture[arg_32_1] = (self.shopCount.dailyFurniture[arg_32_1] or 0) + arg_32_2

	return
end

function ApartmentProxy:AddPermanentFurnitureShopCount(arg_33_1, arg_33_2)
	self.shopCount.permanentFurniture[arg_33_1] = (self.shopCount.permanentFurniture[arg_33_1] or 0) + arg_33_2

	return
end

function ApartmentProxy:ResetDailyShopCount()
	table.clear(self.shopCount.dailyGift)
	table.clear(self.shopCount.dailyFurniture)

	return
end

function ApartmentProxy:RecordEnterTime()
	self.dormEnterTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function ApartmentProxy:GetEnterTime()
	return self.dormEnterTimeStamp
end

function ApartmentProxy:RecordAccompanyTime()
	self.dormAccompanyTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function ApartmentProxy:GetAccompanyTime()
	return self.dormAccompanyTimeStamp
end

function ApartmentProxy:GetRoomInviteList()
	return underscore.map(string.split(PlayerPrefs.GetString(string.format("room%d_invite_list", self), ""), "|"), function(arg_40_0)
		return tonumber(arg_40_0)
	end)
end

function ApartmentProxy:SetRoomInviteList(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0, var_41_1, var_41_2 = table.Diff(ApartmentProxy.GetRoomInviteList(arg_41_1), arg_41_2)

	PlayerPrefs.SetString(string.format("room%d_invite_list", arg_41_1), table.concat(arg_41_2, "|"))
	self:sendNotification(ApartmentProxy.UPDATE_ROOM_INVITE_LIST, {
		roomId = arg_41_1,
		groupIds = arg_41_2,
		addIds = var_41_1,
		removeIds = var_41_2,
		callback = arg_41_3
	})

	local var_41_3 = ApartmentProxy.GetSlideInviteList()
	local var_41_4 = underscore.filter(var_41_3, function(arg_42_0)
		return not table.contains(var_41_2, arg_42_0)
	end)

	if #var_41_4 ~= #var_41_3 then
		self:SetSlideInviteList(var_41_4)
	end

	return
end

function ApartmentProxy.GetSlideInviteList()
	return underscore.map(string.split(PlayerPrefs.GetString("slide_invite_list", ""), "|"), function(arg_44_0)
		return tonumber(arg_44_0)
	end) or {}
end

function ApartmentProxy:SetSlideInviteList(arg_45_1, arg_45_2)
	local var_45_0, var_45_1, var_45_2 = table.Diff(ApartmentProxy.GetSlideInviteList(), arg_45_1)

	PlayerPrefs.SetString("slide_invite_list", table.concat(arg_45_1, "|"))
	self:sendNotification(ApartmentProxy.UPDATE_SLIDE_INVITE_LIST, {
		groupIds = arg_45_1,
		addIds = var_45_1,
		removeIds = var_45_2,
		callback = arg_45_2
	})

	return
end

local var_0_1 = {
	6,
	18
}

function ApartmentProxy:GetTimeIndex()
	local var_46_0 = #var_0_1

	for iter_46_0, iter_46_1 in ipairs(var_0_1) do
		if self < iter_46_1 then
			break
		else
			var_46_0 = iter_46_0
		end
	end

	return var_46_0
end

function ApartmentProxy:GetTimePPName()
	return "DORM3D_SCENE_LOCK_TIME_IN_PLAYER:" .. getProxy(PlayerProxy):getRawData().id .. "_ROOM_" .. self
end

function ApartmentProxy:CheckUnlockConfig()
	if self == nil or self == "" or #self == 0 then
		return true
	end

	return switch(self[1], {
		function(arg_49_0, arg_49_1, arg_49_2)
			local var_49_0 = getProxy(ApartmentProxy):getApartment(arg_49_1)

			if var_49_0 and arg_49_2 <= var_49_0.level then
				return true
			else
				local var_49_2 = i18n("apartment_level_unenough", arg_49_2)

				return
			end

			return
		end,
		function(arg_50_0, arg_50_1)
			local var_50_0 = getProxy(ApartmentProxy):getRoom(pg.dorm3d_furniture_template[arg_50_1].room_id)

			if var_50_0 and underscore.any(var_50_0.furnitures, function(arg_51_0)
				return arg_51_0.configId == arg_50_1
			end) then
				return true
			else
				local var_50_2 = string.format("without dorm furniture:%d", arg_50_1)

				return
			end

			return
		end,
		function(arg_52_0, arg_52_1)
			if getProxy(ApartmentProxy):isGiveGiftDone(arg_52_1) then
				return true
			else
				local var_52_1 = string.format("gift:%d didn't had given", arg_52_1)

				return
			end

			return
		end,
		function(arg_53_0, arg_53_1)
			local var_53_0 = getProxy(CollectionProxy):getShipGroup(arg_53_1)

			if var_53_0 and var_53_0.married > 0 then
				return true
			else
				local var_53_2 = string.format("ship:%d was not married", arg_53_1)

				return
			end

			return
		end,
		function(arg_54_0, arg_54_1, arg_54_2)
			local var_54_0 = getProxy(ApartmentProxy):getRoom(arg_54_1)
			local var_54_2 = i18n("dorm3d_skin_locked")
		end,
		function(arg_55_0, arg_55_1, arg_55_2)
			local var_55_0 = getProxy(ApartmentProxy):getApartment(arg_55_2)
			local var_55_1 = var_55_0 and _.detect(var_55_0.skinList, function(arg_56_0)
				return arg_56_0 == arg_55_1
			end)
			local var_55_2 = i18n("dorm3d_skin_locked")
		end
	}, function(arg_57_0)
		local var_57_1 = string.format("without unlock type:%d", arg_57_0)
	end, unpack(self))
end

function ApartmentProxy:PendingRandom(arg_58_1)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_1 = underscore.detect(pg.dorm3d_rooms[self].character_welcome, function(arg_59_0)
			return arg_59_0[1] == iter_58_1
		end)

		if var_58_1 and var_58_1[2] > math.random() * 16 then
			var_58_0[iter_58_1] = {}
		end
	end

	for iter_58_2, iter_58_3 in ipairs(pg.dorm3d_welcome.get_id_list_by_room_id[self] or {}) do
		if var_58_0[pg.dorm3d_welcome[iter_58_3].ship_id] then
			table.insert(var_58_0[pg.dorm3d_welcome[iter_58_3].ship_id], iter_58_3)
		end
	end

	local var_58_2 = {}

	for iter_58_4, iter_58_5 in pairs(var_58_0) do
		local var_58_3 = 0
		local var_58_4 = 0

		for iter_58_6, iter_58_7 in ipairs(iter_58_5) do
			var_58_4 = var_58_4 + pg.dorm3d_welcome[iter_58_7].weight
		end

		local var_58_5 = math.random() * var_58_4

		for iter_58_8, iter_58_9 in ipairs(iter_58_5) do
			var_58_3 = var_58_3 + pg.dorm3d_welcome[iter_58_9].weight

			if var_58_5 < var_58_3 then
				var_58_2[iter_58_4] = iter_58_9

				break
			end
		end
	end

	return var_58_2
end

function ApartmentProxy.RefreshGiftDailyTip()
	for iter_60_0, iter_60_1 in ipairs(pg.dorm3d_shop_template.all) do
		if pg.shop_template[pg.dorm3d_shop_template[iter_60_1].shop_id[1]].group ~= 0 then
			local var_60_0 = getProxy(PlayerProxy):getRawData().id

			PlayerPrefs.SetInt(var_60_0 .. "_dorm3dGiftWeekViewed_" .. pg.dorm3d_shop_template[iter_60_1].item_id, 0)
			PlayerPrefs.SetInt(var_60_0 .. "_dorm3dGiftWeekRefreshTimeStamp", pg.TimeMgr.GetInstance():GetServerTime())
		end
	end

	return
end

function ApartmentProxy.CheckDeviceRAMEnough()
	return SystemInfo.systemMemorySize == 0 or getDorm3dGameset("drom3d_memory_limit")[1] < SystemInfo.systemMemorySize
end

function ApartmentProxy:CheckAllRoomInviteAll()
	for iter_62_0, iter_62_1 in ipairs(pg.dorm3d_rooms.all) do
		if iter_62_1 ~= 5 then
			if not self.roomData[iter_62_1] then
				return false
			end

			if not self.roomData[iter_62_1]:isPersonalRoom() and not self.roomData[iter_62_1]:unlockAllInvite() then
				return false
			end
		end
	end

	return true
end

return ApartmentProxy
