local var_0_0 = class("ApartmentProxy", import(".NetProxy"))

var_0_0.UPDATE_APARTMENT = "ApartmentProxy.UPDATE_APARTMENT"
var_0_0.UPDATE_ROOM = "ApartmentProxy.UPDATE_ROOM"
var_0_0.UPDATE_GIFT_COUNT = "ApartmentProxy.UPDATE_GIFT_COUNT"
var_0_0.ZERO_HOUR_REFRESH = "ApartmentProxy.ZERO_HOUR_REFRESH"
var_0_0.UPDATE_ROOM_INVITE_LIST = "ApartmentProxy.UPDATE_ROOM_INVITE_LIST"
var_0_0.UPDATE_SLIDE_INVITE_LIST = "ApartmentProxy.UPDATE_SLIDE_INVITE_LIST"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.roomData = {}
	arg_1_0.giftBag = setDefaultZeroMetatable({})
	arg_1_0.giftGiveCount = setDefaultZeroMetatable({})
	arg_1_0.stamina = 0
	arg_1_0.shopCount = {
		dailyGift = {},
		permanentGift = {},
		dailyFurniture = {},
		permanentFurniture = {}
	}

	arg_1_0:on(28000, function(arg_2_0)
		arg_1_0.stamina = getDorm3dGameset("daily_vigor_max")[1] - arg_2_0.daily_vigor_max

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.gifts) do
			arg_1_0.giftBag[iter_2_1.gift_id] = iter_2_1.number
			arg_1_0.giftGiveCount[iter_2_1.gift_id] = iter_2_1.used_number
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.ships) do
			local var_2_0 = Apartment.New(iter_2_3)
			local var_2_1 = var_2_0:GetConfigID()

			arg_1_0.data[var_2_1] = var_2_0
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.rooms) do
			local var_2_2 = ApartmentRoom.New(iter_2_5)
			local var_2_3 = var_2_2:GetConfigID()

			arg_1_0.roomData[var_2_3] = var_2_2
		end

		;(function(arg_3_0, arg_3_1)
			_.each(arg_3_0 or {}, function(arg_4_0)
				arg_3_1[arg_4_0.gift_id] = arg_4_0.count

				return
			end)

			return
		end)(arg_2_0.gift_daily, arg_1_0.shopCount.dailyGift)
		;(function(arg_3_0, arg_3_1)
			_.each(arg_3_0 or {}, function(arg_4_0)
				arg_3_1[arg_4_0.gift_id] = arg_4_0.count

				return
			end)

			return
		end)(arg_2_0.gift_permanent, arg_1_0.shopCount.permanentGift)
		;(function(arg_3_0, arg_3_1)
			_.each(arg_3_0 or {}, function(arg_4_0)
				arg_3_1[arg_4_0.gift_id] = arg_4_0.count

				return
			end)

			return
		end)(arg_2_0.furniture_daily, arg_1_0.shopCount.dailyFurniture)
		;(function(arg_3_0, arg_3_1)
			_.each(arg_3_0 or {}, function(arg_4_0)
				arg_3_1[arg_4_0.gift_id] = arg_4_0.count

				return
			end)

			return
		end)(arg_2_0.furniture_permanent, arg_1_0.shopCount.permanentFurniture)

		return
	end)

	return
end

function var_0_0.timeCall(arg_5_0)
	return {
		[ProxyRegister.DayCall] = function(arg_6_0, arg_6_1)
			if pg.TimeMgr.GetInstance():GetServerWeek() ~= 1 then
				return
			end

			arg_5_0:ResetDailyShopCount()

			arg_5_0.stamina = getDorm3dGameset("daily_vigor_max")[1]

			arg_5_0:sendNotification(var_0_0.ZERO_HOUR_REFRESH)
			arg_5_0:InitGiftDaily()
			var_0_0.RefreshGiftDailyTip()

			return
		end
	}
end

function var_0_0.InitGiftDaily(arg_7_0)
	pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
		callback = function()
			for iter_8_0, iter_8_1 in ipairs(pg.dorm3d_gift.all) do
				if #pg.dorm3d_gift[iter_8_1].shop_id > 0 then
					if pg.shop_template[pg.dorm3d_gift[iter_8_1].shop_id[1]].group ~= 0 then
						arg_7_0.shopCount.dailyGift[pg.dorm3d_gift[iter_8_1].id] = getProxy(ShopsProxy):GetGroupPayCount(pg.shop_template[pg.dorm3d_gift[iter_8_1].shop_id[1]].group)
					end
				end
			end

			return
		end
	})

	return
end

function var_0_0.updateApartment(arg_9_0, arg_9_1)
	arg_9_0.data[arg_9_1.configId] = arg_9_1:clone()

	arg_9_0:sendNotification(var_0_0.UPDATE_APARTMENT, arg_9_1)

	return
end

function var_0_0.updateRoom(arg_10_0, arg_10_1)
	arg_10_0.roomData[arg_10_1.configId] = arg_10_1:clone()

	arg_10_0:sendNotification(var_0_0.UPDATE_ROOM, arg_10_1)

	return
end

function var_0_0.ModifyApartment(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.data[arg_11_1]

	assert(arg_11_0.data[arg_11_1], "apartment not exist")

	if type(arg_11_2) == "function" then
		arg_11_2(var_11_0)
	elseif type(arg_11_2) == "table" then
		for iter_11_0, iter_11_1 in pairs(arg_11_2) do
			var_11_0[iter_11_0] = iter_11_1
		end
	end

	arg_11_0:sendNotification(var_0_0.UPDATE_APARTMENT, var_11_0:clone())

	return
end

function var_0_0.ModifyRoom(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.roomData[arg_12_1]

	assert(arg_12_0.roomData[arg_12_1], "room not exist")

	if type(arg_12_2) == "function" then
		arg_12_2(var_12_0)
	elseif type(arg_12_2) == "table" then
		for iter_12_0, iter_12_1 in pairs(arg_12_2) do
			var_12_0[iter_12_0] = iter_12_1
		end
	end

	arg_12_0:sendNotification(var_0_0.UPDATE_ROOM, var_12_0:clone())

	return
end

function var_0_0.triggerFavor(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or 1

	local var_13_0 = arg_13_0.data[arg_13_1]
	local var_13_1 = 0
	local var_13_2 = 0

	if arg_13_0.stamina >= pg.dorm3d_favor_trigger[arg_13_2].is_daily_max and not var_13_0:isMaxFavor() then
		var_13_2 = pg.dorm3d_favor_trigger[arg_13_2].is_daily_max * arg_13_3
		var_13_1 = math.min(pg.dorm3d_favor_trigger[arg_13_2].num * arg_13_3, var_13_0:getMaxFavor() - var_13_0.favor)
	end

	arg_13_0.stamina = arg_13_0.stamina - var_13_2
	var_13_0.favor = var_13_0.favor + var_13_1
	var_13_0.triggerCountDic[arg_13_2] = var_13_0.triggerCountDic[arg_13_2] + 1

	pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataFavor(arg_13_1, var_13_1, var_13_0.favor, pg.dorm3d_favor_trigger[arg_13_2].type, table.CastToString(pg.dorm3d_favor_trigger[arg_13_2].param)))
	arg_13_0:updateApartment(var_13_0)

	return var_13_1, var_13_2
end

function var_0_0.getStamina(arg_14_0)
	return arg_14_0.stamina, getDorm3dGameset("daily_vigor_max")[1]
end

function var_0_0.RawGetApartment(arg_15_0, arg_15_1)
	return arg_15_0.data[arg_15_1]
end

function var_0_0.getApartment(arg_16_0, arg_16_1)
	return arg_16_0.data[arg_16_1] and arg_16_0.data[arg_16_1]:clone() or nil
end

function var_0_0.getRoom(arg_17_0, arg_17_1)
	return arg_17_0.roomData[arg_17_1]
end

function var_0_0.getGiftCount(arg_18_0, arg_18_1)
	return arg_18_0.giftBag[arg_18_1]
end

function var_0_0.changeGiftCount(arg_19_0, arg_19_1, arg_19_2)
	assert(arg_19_2 ~= 0)

	arg_19_0.giftBag[arg_19_1] = arg_19_0.giftBag[arg_19_1] + arg_19_2

	arg_19_0:sendNotification(var_0_0.UPDATE_GIFT_COUNT, arg_19_1)

	return
end

function var_0_0.getApartmentGiftCount(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.giftBag) do
		if iter_20_1 > 0 and pg.dorm3d_gift[iter_20_0].ship_group_id == arg_20_1 then
			return iter_20_0
		end
	end

	return nil
end

function var_0_0.HasGiftExpireSoon(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.giftBag) do
		if iter_21_1 > 0 and Dorm3dGift.IsExpireSoon(iter_21_0) then
			return true
		end
	end

	return false
end

function var_0_0.HasShipGroupGiftExpireSoon(arg_22_0, arg_22_1)
	local var_22_0 = pg.dorm3d_gift.get_id_list_by_ship_group_id[arg_22_1] or {}

	return _.any(var_22_0, function(arg_23_0)
		return arg_22_0:getGiftCount(arg_23_0) > 0 and Dorm3dGift.IsExpireSoon(arg_23_0)
	end)
end

function var_0_0.GetShipGroupGiftExpireSoonTipIds(arg_24_0, arg_24_1)
	local var_24_0 = pg.dorm3d_gift.get_id_list_by_ship_group_id[arg_24_1] or {}

	return _.filter(var_24_0, function(arg_25_0)
		return arg_24_0:getGiftCount(arg_25_0) > 0 and Dorm3dGift.IsExpireSoon(arg_25_0) and Dorm3dGift.GetExpireSoonTipFlag(arg_25_0) == 0
	end)
end

function var_0_0.addGiftGiveCount(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.giftGiveCount[arg_26_1] = arg_26_0.giftGiveCount[arg_26_1] + arg_26_2

	return
end

function var_0_0.isGiveGiftDone(arg_27_0, arg_27_1)
	return arg_27_0.giftGiveCount[arg_27_1] > 0
end

function var_0_0.GetGiftShopCount(arg_28_0, arg_28_1)
	return arg_28_0.shopCount.dailyGift[arg_28_1] or arg_28_0.shopCount.permanentGift[arg_28_1] or 0
end

function var_0_0.AddDailyGiftShopCount(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.shopCount.dailyGift[arg_29_1] or 0

	arg_29_0.shopCount.dailyGift[arg_29_1] = var_29_0 + arg_29_2

	return
end

function var_0_0.AddPermanentGiftShopCount(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.shopCount.permanentGift[arg_30_1] or 0

	arg_30_0.shopCount.permanentGift[arg_30_1] = var_30_0 + arg_30_2

	return
end

function var_0_0.GetFurnitureShopCount(arg_31_0, arg_31_1)
	return arg_31_0.shopCount.dailyFurniture[arg_31_1] or arg_31_0.shopCount.permanentFurniture[arg_31_1] or 0
end

function var_0_0.AddDailyFurnitureShopCount(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.shopCount.dailyFurniture[arg_32_1] or 0

	arg_32_0.shopCount.dailyFurniture[arg_32_1] = var_32_0 + arg_32_2

	return
end

function var_0_0.AddPermanentFurnitureShopCount(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.shopCount.permanentFurniture[arg_33_1] or 0

	arg_33_0.shopCount.permanentFurniture[arg_33_1] = var_33_0 + arg_33_2

	return
end

function var_0_0.ResetDailyShopCount(arg_34_0)
	table.clear(arg_34_0.shopCount.dailyGift)
	table.clear(arg_34_0.shopCount.dailyFurniture)

	return
end

function var_0_0.RecordEnterTime(arg_35_0)
	arg_35_0.dormEnterTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.GetEnterTime(arg_36_0)
	return arg_36_0.dormEnterTimeStamp
end

function var_0_0.RecordAccompanyTime(arg_37_0)
	arg_37_0.dormAccompanyTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.GetAccompanyTime(arg_38_0)
	return arg_38_0.dormAccompanyTimeStamp
end

function var_0_0.GetRoomInviteList(arg_39_0)
	return underscore.map(string.split(PlayerPrefs.GetString(string.format("room%d_invite_list", arg_39_0), ""), "|"), function(arg_40_0)
		return tonumber(arg_40_0)
	end)
end

function var_0_0.SetRoomInviteList(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0, var_41_1, var_41_2 = table.Diff(var_0_0.GetRoomInviteList(arg_41_1), arg_41_2)

	PlayerPrefs.SetString(string.format("room%d_invite_list", arg_41_1), table.concat(arg_41_2, "|"))
	arg_41_0:sendNotification(var_0_0.UPDATE_ROOM_INVITE_LIST, {
		roomId = arg_41_1,
		groupIds = arg_41_2,
		addIds = var_41_1,
		removeIds = var_41_2,
		callback = arg_41_3
	})

	local var_41_3 = var_0_0.GetSlideInviteList()
	local var_41_4 = underscore.filter(var_41_3, function(arg_42_0)
		return not table.contains(var_41_2, arg_42_0)
	end)

	if #var_41_4 ~= #var_41_3 then
		arg_41_0:SetSlideInviteList(var_41_4)
	end

	return
end

function var_0_0.GetSlideInviteList()
	return underscore.map(string.split(PlayerPrefs.GetString("slide_invite_list", ""), "|"), function(arg_44_0)
		return tonumber(arg_44_0)
	end) or {}
end

function var_0_0.SetSlideInviteList(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0, var_45_1, var_45_2 = table.Diff(var_0_0.GetSlideInviteList(), arg_45_1)

	PlayerPrefs.SetString("slide_invite_list", table.concat(arg_45_1, "|"))
	arg_45_0:sendNotification(var_0_0.UPDATE_SLIDE_INVITE_LIST, {
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

function var_0_0.GetTimeIndex(arg_46_0)
	local var_46_0 = #var_0_1

	for iter_46_0, iter_46_1 in ipairs(var_0_1) do
		if arg_46_0 < iter_46_1 then
			break
		else
			var_46_0 = iter_46_0
		end
	end

	return var_46_0
end

function var_0_0.GetTimePPName(arg_47_0)
	return "DORM3D_SCENE_LOCK_TIME_IN_PLAYER:" .. getProxy(PlayerProxy):getRawData().id .. "_ROOM_" .. arg_47_0
end

function var_0_0.CheckUnlockConfig(arg_48_0)
	if arg_48_0 == nil or arg_48_0 == "" or #arg_48_0 == 0 then
		return true
	end

	return switch(arg_48_0[1], {
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
	end, unpack(arg_48_0))
end

function var_0_0.PendingRandom(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_0 = underscore.detect(pg.dorm3d_rooms[arg_58_0].character_welcome, function(arg_59_0)
			return arg_59_0[1] == iter_58_1
		end)

		if var_58_0 and var_58_0[2] > math.random() * 16 then
			({})[iter_58_1] = {}
		end
	end

	local var_58_1 = pg.dorm3d_welcome.get_id_list_by_room_id[arg_58_0] or {}

	for iter_58_2, iter_58_3 in ipairs(var_58_1) do
		if ({})[pg.dorm3d_welcome[iter_58_3].ship_id] then
			table.insert(({})[pg.dorm3d_welcome[iter_58_3].ship_id], iter_58_3)
		end
	end

	for iter_58_4, iter_58_5 in pairs({}) do
		local var_58_2 = 0
		local var_58_3 = 0

		for iter_58_6, iter_58_7 in ipairs(iter_58_5) do
			var_58_3 = var_58_3 + pg.dorm3d_welcome[iter_58_7].weight
		end

		local var_58_4 = math.random() * var_58_3

		for iter_58_8, iter_58_9 in ipairs(iter_58_5) do
			var_58_2 = var_58_2 + pg.dorm3d_welcome[iter_58_9].weight

			if var_58_4 < var_58_2 then
				({})[iter_58_4] = iter_58_9

				break
			end
		end
	end

	return {}
end

function var_0_0.RefreshGiftDailyTip()
	for iter_60_0, iter_60_1 in ipairs(pg.dorm3d_shop_template.all) do
		if pg.shop_template[pg.dorm3d_shop_template[iter_60_1].shop_id[1]].group ~= 0 then
			local var_60_0 = getProxy(PlayerProxy)
			local var_60_1 = var_60_0:getRawData().id

			PlayerPrefs.SetInt(var_60_1 .. "_dorm3dGiftWeekViewed_" .. pg.dorm3d_shop_template[iter_60_1].item_id, 0)

			local var_60_2 = pg.TimeMgr.GetInstance()

			PlayerPrefs.SetInt(var_60_1 .. "_dorm3dGiftWeekRefreshTimeStamp", var_60_2:GetServerTime())
		end
	end

	return
end

function var_0_0.CheckDeviceRAMEnough()
	local var_61_0 = SystemInfo.systemMemorySize
	local var_61_1 = getDorm3dGameset("drom3d_memory_limit")[1]

	return SystemInfo.systemMemorySize == 0 or var_61_1 < var_61_0
end

function var_0_0.CheckAllRoomInviteAll(arg_62_0)
	for iter_62_0, iter_62_1 in ipairs(pg.dorm3d_rooms.all) do
		if iter_62_1 ~= 5 then
			if not arg_62_0.roomData[iter_62_1] then
				return false
			end

			if not arg_62_0.roomData[iter_62_1]:isPersonalRoom() and not arg_62_0.roomData[iter_62_1]:unlockAllInvite() then
				return false
			end
		end
	end

	return true
end

return var_0_0
