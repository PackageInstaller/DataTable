class = var_0_10000

local var_0_0 = "ApartmentProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.UPDATE_APARTMENT = "ApartmentProxy.UPDATE_APARTMENT"
var_0_1.UPDATE_ROOM = "ApartmentProxy.UPDATE_ROOM"
var_0_1.UPDATE_GIFT_COUNT = "ApartmentProxy.UPDATE_GIFT_COUNT"
var_0_1.ZERO_HOUR_REFRESH = "ApartmentProxy.ZERO_HOUR_REFRESH"
var_0_1.UPDATE_ROOM_INVITE_LIST = "ApartmentProxy.UPDATE_ROOM_INVITE_LIST"
var_0_1.UPDATE_SLIDE_INVITE_LIST = "ApartmentProxy.UPDATE_SLIDE_INVITE_LIST"

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.roomData = {}
	setDefaultZeroMetatable = var_1
	arg_1_0.giftBag = var_1({})
	setDefaultZeroMetatable = var_1
	arg_1_0.giftGiveCount = var_1({})
	arg_1_0.stamina = 0
	arg_1_0.shopCount = {
		dailyGift = {},
		permanentGift = {},
		dailyFurniture = {},
		permanentFurniture = {}
	}

	arg_1_0:on(28000, function(arg_2_0)
		local var_2_0 = arg_1_0

		getDorm3dGameset = var_2_10002
		var_2_0.stamina = var_2_10002("daily_vigor_max")[1] - arg_2_0.daily_vigor_max
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.gifts) do
			var_2_10006 = arg_1_0.giftBag
			var_2_10006[iter_2_1.gift_id] = iter_2_1.number
			var_2_10006 = arg_1_0.giftGiveCount
			var_2_10006[iter_2_1.gift_id] = iter_2_1.used_number
		end

		ipairs = var_1

		for iter_2_2, iter_2_3 in var_1(arg_2_0.ships) do
			Apartment = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_3)
			arg_1_0.data[var_2_10006:GetConfigID()] = var_2_10006
		end

		ipairs = var_1

		for iter_2_4, iter_2_5 in var_1(arg_2_0.rooms) do
			ApartmentRoom = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_5)
			arg_1_0.roomData[var_2_10006:GetConfigID()] = var_2_10006
		end

		;(function(arg_3_0, arg_3_1)
			_ = var_3_10002

			var_3_10002.each(arg_3_0 or {}, function(arg_4_0)
				arg_3_1[arg_4_0.gift_id] = arg_4_0.count

				return
			end)

			return
		end)(arg_2_0.gift_daily, arg_1_0.shopCount.dailyGift)
		var_1(arg_2_0.gift_permanent, arg_1_0.shopCount.permanentGift)
		var_1(arg_2_0.furniture_daily, arg_1_0.shopCount.dailyFurniture)
		var_1(arg_2_0.furniture_permanent, arg_1_0.shopCount.permanentFurniture)

		return
	end)

	return
end

function var_0_1.timeCall(arg_5_0)
	local var_5_0 = {}

	ProxyRegister = var_1_10002
	var_5_0[var_1_10002.DayCall] = function(arg_6_0, arg_6_1)
		pg = var_2_10002

		local var_6_0 = var_2_10002.TimeMgr.GetInstance()

		if var_2.GetServerWeek(var_6_0) ~= 1 then
			return
		end

		local var_6_1 = arg_5_0

		var_2.ResetDailyShopCount(var_6_1)

		local var_6_2 = arg_5_0

		getDorm3dGameset = var_6_1
		var_6_2.stamina = var_6_1("daily_vigor_max")[1]

		local var_6_3 = arg_5_0

		var_2.sendNotification(var_6_3, var_0_1.ZERO_HOUR_REFRESH)

		local var_6_4 = arg_5_0

		var_2.InitGiftDaily(var_6_4)
		var_0_1.RefreshGiftDailyTip()

		return
	end

	return var_5_0
end

function var_0_1.InitGiftDaily(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.m02
	local var_7_1 = var_1.sendNotification

	GAME = var_1_10003

	var_7_1(var_7_0, var_1_10003.GET_CHARGE_LIST, {
		callback = function()
			ipairs = var_2_10000
			pg = var_2_10001

			for iter_8_0, iter_8_1 in var_2_10000(var_2_10001.dorm3d_gift.all) do
				pg = var_2_10005

				if #var_2_10005.dorm3d_gift[iter_8_1].shop_id > 0 then
					pg = var_6

					if var_6.shop_template[var_2_10005.shop_id[1]].group ~= 0 then
						local var_8_0 = arg_7_0.shopCount.dailyGift
						local var_8_1 = var_2_10005.id

						getProxy = var_2_10009
						ShopsProxy = var_2_10010
						var_2_10010 = var_2_10009(var_2_10010)
						var_8_0[var_8_1] = var_2_10009.GetGroupPayCount(var_2_10010, var_6)
					end
				end
			end

			return
		end
	})

	return
end

function var_0_1.updateApartment(arg_9_0, arg_9_1)
	arg_9_0.data[arg_9_1.configId] = arg_9_1:clone()

	arg_9_0:sendNotification(var_0_1.UPDATE_APARTMENT, arg_9_1)

	return
end

function var_0_1.updateRoom(arg_10_0, arg_10_1)
	arg_10_0.roomData[arg_10_1.configId] = arg_10_1:clone()

	arg_10_0:sendNotification(var_0_1.UPDATE_ROOM, arg_10_1)

	return
end

function var_0_1.ModifyApartment(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.data[arg_11_1]

	assert = var_1_10004

	var_1_10004(var_11_0, "apartment not exist")

	type = var_1_10004

	if var_1_10004(arg_11_2) == "function" then
		arg_11_2(var_11_0)
	else
		type = var_4

		if var_4(arg_11_2) == "table" then
			pairs = var_4

			for iter_11_0, iter_11_1 in var_4(arg_11_2) do
				var_11_0[iter_11_0] = iter_11_1
			end
		end
	end

	arg_11_0:sendNotification(var_0_1.UPDATE_APARTMENT, var_11_0:clone())

	return
end

function var_0_1.ModifyRoom(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.roomData[arg_12_1]

	assert = var_1_10004

	var_1_10004(var_12_0, "room not exist")

	type = var_1_10004

	if var_1_10004(arg_12_2) == "function" then
		arg_12_2(var_12_0)
	else
		type = var_4

		if var_4(arg_12_2) == "table" then
			pairs = var_4

			for iter_12_0, iter_12_1 in var_4(arg_12_2) do
				var_12_0[iter_12_0] = iter_12_1
			end
		end
	end

	arg_12_0:sendNotification(var_0_1.UPDATE_ROOM, var_12_0:clone())

	return
end

function var_0_1.triggerFavor(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or 1

	local var_13_0 = arg_13_0.data[arg_13_1]

	pg = var_1_10005

	local var_13_1 = var_1_10005.dorm3d_favor_trigger[arg_13_2]
	local var_13_2 = 0
	local var_13_3 = 0

	if arg_13_0.stamina >= var_13_1.is_daily_max and not var_13_0:isMaxFavor() then
		var_13_3 = var_13_1.is_daily_max * arg_13_3
		math = var_8

		local var_13_4 = var_8.min
		local var_13_5 = var_13_1.num * arg_13_3

		var_1_10011 = var_13_0
		var_13_2 = var_13_4(var_13_5, var_13_0.getMaxFavor(var_1_10011) - var_13_0.favor)
	end

	arg_13_0.stamina = arg_13_0.stamina - var_13_3
	var_13_0.favor = var_13_0.favor + var_13_2

	local var_13_6 = var_13_0.triggerCountDic

	var_13_6[arg_13_2] = var_13_0.triggerCountDic[arg_13_2] + 1
	pg = var_13_6

	local var_13_7 = var_13_6.m02
	local var_13_8 = var_8.sendNotification

	GAME = var_1_10010

	local var_13_9 = var_1_10010.APARTMENT_TRACK

	Dorm3dTrackCommand = var_1_10011

	local var_13_10 = var_1_10011.BuildDataFavor
	local var_13_11 = arg_13_1
	local var_13_12 = var_13_2
	local var_13_13 = var_13_0.favor
	local var_13_14 = var_13_1.type

	table = var_1_10016

	var_13_8(var_13_7, var_13_9, var_13_10(var_13_11, var_13_12, var_13_13, var_13_14, var_1_10016.CastToString(var_13_1.param)))
	arg_13_0:updateApartment(var_13_0)

	return var_13_2, var_13_3
end

function var_0_1.getStamina(arg_14_0)
	local var_14_0 = arg_14_0.stamina

	getDorm3dGameset = var_1_10002

	return var_14_0, var_1_10002("daily_vigor_max")[1]
end

function var_0_1.RawGetApartment(arg_15_0, arg_15_1)
	return arg_15_0.data[arg_15_1]
end

function var_0_1.getApartment(arg_16_0, arg_16_1)
	if arg_16_0.data[arg_16_1] then
		local var_16_0 = arg_16_0.data[arg_16_1]
		local var_16_1

		if not var_2.clone(var_16_0) then
			var_16_1 = nil
		end

		return var_16_1
	end
end

function var_0_1.getRoom(arg_17_0, arg_17_1)
	return arg_17_0.roomData[arg_17_1]
end

function var_0_1.getGiftCount(arg_18_0, arg_18_1)
	return arg_18_0.giftBag[arg_18_1]
end

function var_0_1.changeGiftCount(arg_19_0, arg_19_1, arg_19_2)
	assert = var_1_10003

	var_1_10003(arg_19_2 ~= 0)

	arg_19_0.giftBag[arg_19_1] = arg_19_0.giftBag[arg_19_1] + arg_19_2

	arg_19_0:sendNotification(var_0_1.UPDATE_GIFT_COUNT, arg_19_1)

	return
end

function var_0_1.getApartmentGiftCount(arg_20_0, arg_20_1)
	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.giftBag) do
		if 0 < iter_20_1 then
			pg = var_7

			if var_7.dorm3d_gift[iter_20_0].ship_group_id == arg_20_1 then
				return iter_20_0
			end
		end
	end

	return nil
end

function var_0_1.HasGiftExpireSoon(arg_21_0)
	pairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.giftBag) do
		if 0 < iter_21_1 then
			Dorm3dGift = var_6

			if var_6.IsExpireSoon(iter_21_0) then
				return true
			end
		end
	end

	return false
end

function var_0_1.HasShipGroupGiftExpireSoon(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0

	if not var_1_10002.dorm3d_gift.get_id_list_by_ship_group_id[arg_22_1] then
		var_22_0 = {}
	end

	_ = var_1_10003

	return var_1_10003.any(var_22_0, function(arg_23_0)
		local var_23_0 = arg_22_0
		local var_23_1

		if var_1.getGiftCount(var_23_0, arg_23_0) > 0 then
			Dorm3dGift = var_1
			var_23_1 = var_1.IsExpireSoon(arg_23_0)
		else
			var_23_1 = false
		end

		if false then
			var_23_1 = true
		end

		return var_23_1
	end)
end

function var_0_1.GetShipGroupGiftExpireSoonTipIds(arg_24_0, arg_24_1)
	pg = var_1_10002

	local var_24_0

	if not var_1_10002.dorm3d_gift.get_id_list_by_ship_group_id[arg_24_1] then
		var_24_0 = {}
	end

	_ = var_1_10003

	return var_1_10003.filter(var_24_0, function(arg_25_0)
		local var_25_0 = arg_24_0

		if var_1.getGiftCount(var_25_0, arg_25_0) > 0 then
			Dorm3dGift = var_25_1

			local var_25_1

			if var_25_1.IsExpireSoon(arg_25_0) then
				Dorm3dGift = var_25_1

				if var_25_1.GetExpireSoonTipFlag(arg_25_0) ~= 0 then
					var_25_1 = false
				else
					var_25_1 = true
				end
			end

			return var_25_1
		end
	end)
end

function var_0_1.addGiftGiveCount(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.giftGiveCount[arg_26_1] = arg_26_0.giftGiveCount[arg_26_1] + arg_26_2

	return
end

function var_0_1.isGiveGiftDone(arg_27_0, arg_27_1)
	return arg_27_0.giftGiveCount[arg_27_1] > 0
end

function var_0_1.GetGiftShopCount(arg_28_0, arg_28_1)
	local var_28_0

	if not arg_28_0.shopCount.dailyGift[arg_28_1] and not arg_28_0.shopCount.permanentGift[arg_28_1] then
		var_28_0 = 0
	end

	return var_28_0
end

function var_0_1.AddDailyGiftShopCount(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.shopCount.dailyGift
	local var_29_1

	if not arg_29_0.shopCount.dailyGift[arg_29_1] then
		var_29_1 = 0
	end

	var_29_0[arg_29_1] = var_29_1 + arg_29_2

	return
end

function var_0_1.AddPermanentGiftShopCount(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.shopCount.permanentGift
	local var_30_1

	if not arg_30_0.shopCount.permanentGift[arg_30_1] then
		var_30_1 = 0
	end

	var_30_0[arg_30_1] = var_30_1 + arg_30_2

	return
end

function var_0_1.GetFurnitureShopCount(arg_31_0, arg_31_1)
	local var_31_0

	if not arg_31_0.shopCount.dailyFurniture[arg_31_1] and not arg_31_0.shopCount.permanentFurniture[arg_31_1] then
		var_31_0 = 0
	end

	return var_31_0
end

function var_0_1.AddDailyFurnitureShopCount(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.shopCount.dailyFurniture
	local var_32_1

	if not arg_32_0.shopCount.dailyFurniture[arg_32_1] then
		var_32_1 = 0
	end

	var_32_0[arg_32_1] = var_32_1 + arg_32_2

	return
end

function var_0_1.AddPermanentFurnitureShopCount(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.shopCount.permanentFurniture
	local var_33_1

	if not arg_33_0.shopCount.permanentFurniture[arg_33_1] then
		var_33_1 = 0
	end

	var_33_0[arg_33_1] = var_33_1 + arg_33_2

	return
end

function var_0_1.ResetDailyShopCount(arg_34_0)
	table = var_1_10001

	var_1_10001.clear(arg_34_0.shopCount.dailyGift)

	table = var_1

	var_1.clear(arg_34_0.shopCount.dailyFurniture)

	return
end

function var_0_1.RecordEnterTime(arg_35_0)
	pg = var_1_10001

	local var_35_0 = var_1_10001.TimeMgr.GetInstance()

	arg_35_0.dormEnterTimeStamp = var_1.GetServerTime(var_35_0)

	return
end

function var_0_1.GetEnterTime(arg_36_0)
	return arg_36_0.dormEnterTimeStamp
end

function var_0_1.RecordAccompanyTime(arg_37_0)
	pg = var_1_10001

	local var_37_0 = var_1_10001.TimeMgr.GetInstance()

	arg_37_0.dormAccompanyTimeStamp = var_1.GetServerTime(var_37_0)

	return
end

function var_0_1.GetAccompanyTime(arg_38_0)
	return arg_38_0.dormAccompanyTimeStamp
end

function var_0_1.GetRoomInviteList(arg_39_0)
	underscore = var_1_10001

	local var_39_0 = var_1_10001.map

	string = var_1_10002

	local var_39_1 = var_1_10002.split

	PlayerPrefs = var_1_10003

	local var_39_2 = var_1_10003.GetString

	string = var_1_10004

	return var_39_0(var_39_1(var_39_2(var_1_10004.format("room%d_invite_list", arg_39_0), ""), "|"), function(arg_40_0)
		tonumber = var_2_10001

		return var_2_10001(arg_40_0)
	end)
end

function var_0_1.SetRoomInviteList(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	table = var_1_10004

	local var_41_0, var_41_1, var_41_2 = var_1_10004.Diff(var_0_1.GetRoomInviteList(arg_41_1), arg_41_2)

	PlayerPrefs = var_1_10007

	local var_41_3 = var_1_10007.SetString

	string = var_1_10008

	local var_41_4 = var_1_10008.format("room%d_invite_list", arg_41_1)

	table = var_9

	var_41_3(var_41_4, var_9.concat(arg_41_2, "|"))

	local var_41_5 = arg_41_0

	arg_41_0.sendNotification(var_41_5, var_0_1.UPDATE_ROOM_INVITE_LIST, {
		roomId = arg_41_1,
		groupIds = arg_41_2,
		addIds = var_41_1,
		removeIds = var_41_2,
		callback = arg_41_3
	})

	local var_41_6 = var_0_1.GetSlideInviteList()

	underscore = var_41_5

	if #var_41_5.filter(var_41_6, function(arg_42_0)
		table = var_2_10001

		return not var_2_10001.contains(var_41_2, arg_42_0)
	end) ~= #var_41_6 then
		arg_41_0:SetSlideInviteList(var_8)
	end

	return
end

function var_0_1.GetSlideInviteList()
	underscore = var_1_10000

	local var_43_0 = var_1_10000.map

	string = var_1_10001

	local var_43_1 = var_1_10001.split

	PlayerPrefs = var_1_10002

	local var_43_2

	if not var_43_0(var_43_1(var_1_10002.GetString("slide_invite_list", ""), "|"), function(arg_44_0)
		tonumber = var_2_10001

		return var_2_10001(arg_44_0)
	end) then
		var_43_2 = {}
	end

	return var_43_2
end

function var_0_1.SetSlideInviteList(arg_45_0, arg_45_1, arg_45_2)
	table = var_1_10003

	local var_45_0, var_45_1, var_45_2 = var_1_10003.Diff(var_0_1.GetSlideInviteList(), arg_45_1)

	PlayerPrefs = var_1_10006

	local var_45_3 = var_1_10006.SetString
	local var_45_4 = "slide_invite_list"

	table = var_1_10008

	var_45_3(var_45_4, var_1_10008.concat(arg_45_1, "|"))
	arg_45_0:sendNotification(var_0_1.UPDATE_SLIDE_INVITE_LIST, {
		groupIds = arg_45_1,
		addIds = var_45_1,
		removeIds = var_45_2,
		callback = arg_45_2
	})

	return
end

local var_0_2 = {
	6,
	18
}

function var_0_1.GetTimeIndex(arg_46_0)
	local var_46_0 = #var_0_2

	ipairs = var_1_10002

	for iter_46_0, iter_46_1 in var_1_10002(var_0_2) do
		if arg_46_0 < iter_46_1 then
			break
		else
			var_46_0 = iter_46_0
		end
	end

	return var_46_0
end

function var_0_1.GetTimePPName(arg_47_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_47_0 = var_1_10001(var_1_10002)
	local var_47_1 = var_1.getRawData(var_47_0)

	return "DORM3D_SCENE_LOCK_TIME_IN_PLAYER:" .. var_47_1.id .. "_ROOM_" .. arg_47_0
end

function var_0_1.CheckUnlockConfig(arg_48_0)
	if arg_48_0 == nil or arg_48_0 == "" or #arg_48_0 == 0 then
		return true
	end

	switch = var_1_10001

	local var_48_0 = arg_48_0[1]
	local var_48_1 = {
		function(arg_49_0, arg_49_1, arg_49_2)
			getProxy = var_2_10003
			ApartmentProxy = var_2_10004

			local var_49_0 = var_2_10003(var_2_10004)

			if var_3.getApartment(var_49_0, arg_49_1) and arg_49_2 <= var_3.level then
				return true
			else
				local var_49_1 = false

				i18n = var_5

				local var_49_2 = var_5("apartment_level_unenough", arg_49_2)

				return
			end

			return
		end,
		function(arg_50_0, arg_50_1)
			getProxy = var_2_10002
			ApartmentProxy = var_2_10003

			local var_50_0 = var_2_10002(var_2_10003)
			local var_50_1 = var_2.getRoom

			pg = var_2_10004

			if var_50_1(var_50_0, var_2_10004.dorm3d_furniture_template[arg_50_1].room_id) then
				underscore = var_50_0

				if var_50_0.any(var_2.furnitures, function(arg_51_0)
					return arg_51_0.configId == arg_50_1
				end) then
					do return true end

					goto label_50_0
				end
			end

			do
				local var_50_2 = false

				string = var_4

				local var_50_3 = var_4.format("without dorm furniture:%d", arg_50_1)

				return
			end

			::label_50_0::

			return
		end,
		function(arg_52_0, arg_52_1)
			getProxy = var_2_10002
			ApartmentProxy = var_2_10003

			local var_52_0 = var_2_10002(var_2_10003)

			if var_2.isGiveGiftDone(var_52_0, arg_52_1) then
				return true
			else
				local var_52_1 = false

				string = var_52_0

				local var_52_2 = var_52_0.format("gift:%d didn't had given", arg_52_1)

				return
			end

			return
		end,
		function(arg_53_0, arg_53_1)
			getProxy = var_2_10002
			CollectionProxy = var_2_10003

			local var_53_0 = var_2_10002(var_2_10003)

			if var_2.getShipGroup(var_53_0, arg_53_1) then
				local var_53_1 = var_2.married

				if 0 < var_53_1 then
					do return true end

					goto label_53_0
				end
			end

			do
				local var_53_2 = false

				string = var_4

				local var_53_3 = var_4.format("ship:%d was not married", arg_53_1)

				return
			end

			::label_53_0::

			return
		end,
		function(arg_54_0, arg_54_1, arg_54_2)
			getProxy = var_2_10003
			ApartmentProxy = var_2_10004

			local var_54_0 = var_2_10003(var_2_10004)
			local var_54_1

			var_54_1 = var_3.getRoom(var_54_0, arg_54_1) and var_3.unlockCharacter[arg_54_2]
			i18n = var_5

			local var_54_2 = var_5("dorm3d_skin_locked")
		end,
		function(arg_55_0, arg_55_1, arg_55_2)
			getProxy = var_2_10003
			ApartmentProxy = var_2_10004

			local var_55_0 = var_2_10003(var_2_10004)

			if var_3.getApartment(var_55_0, arg_55_2) then
				::label_55_0::

				_ = var_55_0

				local var_55_1 = var_55_0.detect(var_3.skinList, function(arg_56_0)
					return arg_56_0 == arg_55_1
				end)
			end

			i18n = var_5

			local var_55_2 = var_5("dorm3d_skin_locked")
		end
	}

	local function var_48_2(arg_57_0)
		local var_57_0 = false

		string = var_2_10002

		local var_57_1 = var_2_10002.format("without unlock type:%d", arg_57_0)
	end

	unpack = var_1_10005

	return var_1_10001(var_48_0, var_48_1, var_48_2, var_1_10005(arg_48_0))
end

function var_0_1.PendingRandom(arg_58_0, arg_58_1)
	local var_58_0 = {}

	ipairs = var_1_10003

	for iter_58_0, iter_58_1 in var_1_10003(arg_58_1) do
		underscore = var_1_10008
		var_1_10008 = var_1_10008.detect
		pg = var_1_10009

		if var_1_10008(var_1_10009.dorm3d_rooms[arg_58_0].character_welcome, function(arg_59_0)
			return arg_59_0[1] == iter_58_1
		end) then
			var_1_10009 = var_1_10008[2]
			math = var_10

			if var_1_10009 > var_10.random() * 16 then
				var_58_0[iter_58_1] = {}
			end
		end
	end

	ipairs = var_3
	pg = var_4

	local var_58_1

	if not var_4.dorm3d_welcome.get_id_list_by_room_id[arg_58_0] then
		var_58_1 = {}
	end

	for iter_58_2, iter_58_3 in var_3(var_58_1) do
		pg = var_1_10008

		if var_58_0[var_1_10008.dorm3d_welcome[iter_58_3].ship_id] then
			table = var_9

			var_9.insert(var_58_0[var_1_10008.ship_id], iter_58_3)
		end
	end

	local var_58_2 = {}

	pairs = var_4

	for iter_58_4, iter_58_5 in var_4(var_58_0) do
		local var_58_3 = 0
		local var_58_4 = 0

		ipairs = var_1_10011

		for iter_58_6, iter_58_7 in var_1_10011(iter_58_5) do
			pg = iter_58_9
			var_58_4 = var_58_4 + iter_58_9.dorm3d_welcome[iter_58_7].weight
		end

		math = var_1_10011
		var_1_10011 = var_1_10011.random() * var_58_4
		ipairs = var_12

		for iter_58_8, iter_58_9 in var_12(iter_58_5) do
			pg = var_1_10017

			if var_1_10011 < var_58_3 + var_1_10017.dorm3d_welcome[iter_58_9].weight then
				var_58_2[iter_58_4] = iter_58_9

				break
			end
		end
	end

	return var_58_2
end

function var_0_1.RefreshGiftDailyTip()
	ipairs = var_1_10000
	pg = var_1_10001

	for iter_60_0, iter_60_1 in var_1_10000(var_1_10001.dorm3d_shop_template.all) do
		pg = var_1_10005
		var_1_10005 = var_1_10005.dorm3d_shop_template[iter_60_1]
		pg = var_1_10006

		if var_1_10006.shop_template[var_1_10005.shop_id[1]].group ~= 0 then
			getProxy = var_7
			PlayerProxy = var_1_10008
			var_1_10008 = var_7(var_1_10008)

			local var_60_0 = var_7.getRawData(var_1_10008).id

			PlayerPrefs = var_1_10008

			var_1_10008.SetInt(var_60_0 .. "_dorm3dGiftWeekViewed_" .. var_1_10005.item_id, 0)

			PlayerPrefs = var_1_10008
			var_1_10008 = var_1_10008.SetInt

			local var_60_1 = var_60_0 .. "_dorm3dGiftWeekRefreshTimeStamp"

			pg = var_10

			local var_60_2 = var_10.TimeMgr.GetInstance()

			var_1_10008(var_60_1, var_10.GetServerTime(var_60_2))
		end
	end

	return
end

function var_0_1.CheckDeviceRAMEnough()
	SystemInfo = var_1_10000

	local var_61_0 = var_1_10000.systemMemorySize

	getDorm3dGameset = var_1_10001

	local var_61_1 = var_1_10001("drom3d_memory_limit")[1]

	return var_61_0 == 0 or var_61_1 < var_61_0
end

function var_0_1.CheckAllRoomInviteAll(arg_62_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_62_0, iter_62_1 in var_1_10001(var_1_10002.dorm3d_rooms.all) do
		if iter_62_1 ~= 5 then
			if not arg_62_0.roomData[iter_62_1] then
				return false
			end

			local var_62_0 = arg_62_0.roomData[iter_62_1]

			if not var_6.isPersonalRoom(var_62_0) then
				local var_62_1 = arg_62_0.roomData[iter_62_1]

				if not var_6.unlockAllInvite(var_62_1) then
					return false
				end
			end
		end
	end

	return true
end

return var_0_1
