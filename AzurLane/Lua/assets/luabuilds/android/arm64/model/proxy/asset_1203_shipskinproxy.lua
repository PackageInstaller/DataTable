class = var_0_10000

local var_0_0 = "ShipSkinProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.SHIP_SKINS_UPDATE = "ship skins update"
var_0_1.SHIP_SKIN_EXPIRED = "ship skin expired"
var_0_1.FORBIDDEN_TYPE_HIDE = 0
var_0_1.FORBIDDEN_TYPE_SHOW = 1
var_0_1.FORBIDDEN_OVERWRITE_TYPE_TIME = 1
var_0_1.FORBIDDEN_OVERWRITE_TYPE_STOP = 2

function var_0_1.timeCall(arg_1_0)
	local var_1_0 = {}

	ProxyRegister = var_1_10002
	var_1_0[var_1_10002.SecondCall] = function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.TimeMgr.GetInstance()
		local var_2_1 = var_1.GetServerTime(var_2_0)

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_1_0.forbiddenSkinOverwriteList) do
			local var_2_2 = arg_1_0

			var_7.CheckConfigOverwrite(var_2_2, var_2_1, iter_2_0, iter_2_1)
		end

		return
	end

	return var_1_0
end

function var_0_1.register(arg_3_0)
	arg_3_0.skins = {}
	arg_3_0.changeSkinGroupDic = {}
	arg_3_0.cacheSkins = {}
	arg_3_0.timers = {}
	arg_3_0.forbiddenSkinList = {}
	arg_3_0.forbiddenSkinOverwriteList = {}
	arg_3_0.overwriteFlag = {}

	arg_3_0:on(12201, function(arg_4_0)
		_ = var_2_10001

		var_2_10001.each(arg_4_0.skin_list, function(arg_5_0)
			ShipSkin = var_3_10001

			local var_5_0 = var_3_10001.New(arg_5_0)
			local var_5_1 = arg_3_0
			local var_5_2 = var_2.addSkin

			ShipSkin = var_3_10005

			var_5_2(var_5_1, var_3_10005.New(arg_5_0))

			return
		end)

		local var_4_0 = arg_3_0

		var_4_0.forbiddenSkinList = {}
		_ = var_4_0

		var_4_0.each(arg_4_0.forbidden_skin_list, function(arg_6_0)
			table = var_3_10001

			var_3_10001.insert(arg_3_0.forbiddenSkinList, {
				id = arg_6_0,
				type = var_0_1.FORBIDDEN_TYPE_HIDE
			})

			return
		end)

		ipairs = var_1

		for iter_4_0, iter_4_1 in var_1(arg_4_0.forbidden_skin_type) do
			arg_3_0.forbiddenSkinList[iter_4_0].type = iter_4_1
		end

		ipairs = var_1

		for iter_4_2, iter_4_3 in var_1(arg_3_0.forbiddenSkinOverwriteList) do
			local var_4_1 = arg_3_0

			var_6.RemoveConfigOverwrite(var_4_1, iter_4_2)
		end

		local var_4_2 = arg_3_0

		var_4_2.forbiddenSkinOverwriteList = {}
		pg = var_4_2

		local var_4_3 = var_4_2.TimeMgr.GetInstance()
		local var_4_4 = var_1.GetServerTime(var_4_3)

		ipairs = var_2

		for iter_4_4, iter_4_5 in var_2(arg_4_0.forbidden_list) do
			pg = var_2_10007

			if not var_2_10007.shop_template[iter_4_5.id] then
				warning = var_8

				var_8("without config in shop_template:" .. iter_4_5.id)
			elseif var_2_10007.genre ~= "skin_shop" then
				warning = var_8

				var_8("config genre error in shop_template:" .. iter_4_5.id)
			else
				warning = var_8

				local var_4_5 = iter_4_5.id
				local var_4_6 = iter_4_5.type

				pg = var_2_10012

				local var_4_7 = var_2_10012.TimeMgr.GetInstance()

				var_2_10012 = var_2_10012.STimeDescS(var_4_7, iter_4_5.start_time)
				pg = var_2_10013

				local var_4_8 = var_2_10013.TimeMgr.GetInstance()

				var_8(var_4_5, var_4_6, var_2_10012, var_2_10013.STimeDescS(var_4_8, iter_4_5.stop_time))

				arg_3_0.forbiddenSkinOverwriteList[iter_4_5.id] = {
					type = iter_4_5.type,
					range = {
						iter_4_5.start_time,
						iter_4_5.stop_time
					},
					order = iter_4_5.sort_order
				}

				local var_4_9 = arg_3_0

				var_8.CheckConfigOverwrite(var_4_9, var_4_4, iter_4_5.id, arg_3_0.forbiddenSkinOverwriteList[iter_4_5.id])
			end
		end

		return
	end)

	return
end

function var_0_1.CheckConfigOverwrite(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	math = var_1_10004

	local var_7_0 = var_1_10004.clamp
	local var_7_1 = arg_7_1

	unpack = var_1_10007

	local var_7_2 = arg_7_1 == var_7_0(var_7_1, var_1_10007(arg_7_3.range))

	tobool = var_1_10005

	if var_7_2 ~= var_1_10005(arg_7_0.overwriteFlag[arg_7_2]) then
		if var_7_2 then
			arg_7_0:AddConfigOverwrite(arg_7_2, arg_7_3)
		else
			arg_7_0:RemoveConfigOverwrite(arg_7_2)
		end
	end

	return
end

function var_0_1.AddConfigOverwrite(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.overwriteFlag[arg_8_1] then
		local var_8_0 = arg_8_0.overwriteFlag

		var_8_0[arg_8_1] = true
		pg = var_8_0

		local var_8_1 = var_8_0.shop_template[arg_8_1]

		switch = var_4
		var_8_1.time = var_4(arg_8_2.type, {
			[var_0_1.FORBIDDEN_OVERWRITE_TYPE_TIME] = function()
				local var_9_0 = {}

				ipairs = var_2_10001

				for iter_9_0, iter_9_1 in var_2_10001(arg_8_2.range) do
					underscore = var_2_10006
					var_2_10006 = var_2_10006.map
					string = var_2_10008
					var_2_10008 = var_2_10008.split
					pg = var_2_10010

					local var_9_1 = var_2_10010.TimeMgr.GetInstance()

					var_2_10006 = var_2_10006(var_2_10008(var_2_10010.STimeDescS(var_9_1, iter_9_1, "%Y/%m/%d/%H/%M/%S"), "/"), function(arg_10_0)
						tonumber = var_3_10001

						return var_3_10001(arg_10_0)
					end)

					local var_9_2 = {}

					underscore = var_2_10008
					var_9_2[1] = var_2_10008.first(var_2_10006, 3)
					underscore = var_2_10008
					var_9_2[2] = var_2_10008.rest(var_2_10006, 4)
					var_9_0[iter_9_0] = var_9_2
				end

				return var_9_0
			end,
			[var_0_1.FORBIDDEN_OVERWRITE_TYPE_STOP] = function()
				return "stop"
			end
		})

		if arg_8_2.order >= 0 then
			pg = var_3
			var_3.shop_template[arg_8_1].order = arg_8_2.order
		end
	end

	return
end

function var_0_1.RemoveConfigOverwrite(arg_12_0, arg_12_1)
	if arg_12_0.overwriteFlag[arg_12_1] then
		local var_12_0 = arg_12_0.overwriteFlag

		var_12_0[arg_12_1] = nil
		pg = var_12_0

		local var_12_1 = var_12_0.shop_template[arg_12_1]

		var_12_1.time = nil
		pg = var_12_1
		var_12_1.shop_template[arg_12_1].order = nil
	end

	return
end

function var_0_1.getOverDueSkins(arg_13_0)
	local var_13_0 = {}

	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.cacheSkins) do
		table = var_1_10007

		var_1_10007.insert(var_13_0, iter_13_1)
	end

	arg_13_0.cacheSkins = {}

	return var_13_0
end

function var_0_1.getRawData(arg_14_0)
	return arg_14_0.skins
end

function var_0_1.getSkinList(arg_15_0)
	_ = var_1_10001

	local var_15_0 = var_1_10001.map

	_ = var_1_10003

	return var_15_0(var_1_10003.values(arg_15_0.skins), function(arg_16_0)
		return arg_16_0.id
	end)
end

function var_0_1.addSkin(arg_17_0, arg_17_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_17_0 = arg_17_1

	ShipSkin = var_1_10007

	var_1_10002(var_1_10004(var_17_0, var_1_10007), "skin should be an instance of ShipSkin")

	local var_17_1 = arg_17_0.skins

	var_17_1[arg_17_1.id] = arg_17_1
	ShipSkin = var_17_1

	if var_17_1.IsChangeSkin(arg_17_1.id) then
		local var_17_2 = arg_17_0.changeSkinGroupDic

		ShipSkin = var_3
		var_17_2[var_3.GetChangeSkinGroupId(arg_17_1.id)] = true
	end

	arg_17_0:addExpireTimer(arg_17_1)

	local var_17_3 = arg_17_1:getConfig("skin_type")

	ShipSkin = var_3

	if var_17_3 == var_3.SKIN_TYPE_TB then
		NewEducateHelper = var_17_3

		var_17_3.UpdateUnlockBySkinId(arg_17_1.id)
	end

	local var_17_4 = arg_17_0.facade

	var_2.sendNotification(var_17_4, var_0_1.SHIP_SKINS_UPDATE)

	return
end

function var_0_1.getSkinById(arg_18_0, arg_18_1)
	return arg_18_0.skins[arg_18_1]
end

function var_0_1.addExpireTimer(arg_19_0, arg_19_1)
	arg_19_0:removeExpireTimer(arg_19_1.id)

	local var_19_0 = arg_19_1

	if not arg_19_1.isExpireType(var_19_0) then
		return
	end

	local function var_19_1()
		table = var_2_10000

		var_2_10000.insert(arg_19_0.cacheSkins, arg_19_1)

		local var_20_0 = arg_19_0

		var_0.removeSkinById(var_20_0, arg_19_1.id)

		getProxy = var_0
		BayProxy = var_20_0

		local var_20_1 = var_0(var_20_0)
		local var_20_2 = {}

		underscore = var_20_0

		var_20_0.each(var_20_1:CanUseShareSkinPhantoms(arg_19_1.id), function(arg_21_0)
			if arg_21_0:getSkinId() == arg_19_1.id then
				local var_21_0 = var_20_1

				var_1.updateShipSkin(var_21_0, arg_21_0.id, arg_21_0.phantomId, arg_21_0:getConfig("skin_id"))
			end

			return
		end)

		local var_20_3 = arg_19_0
		local var_20_4 = var_2.sendNotification

		GAME = var_5

		var_20_4(var_20_3, var_5.SHIP_SKIN_EXPIRED)

		return
	end

	local var_19_2 = arg_19_1:getExpireTime()

	pg = var_19_0

	local var_19_3 = var_19_0.TimeMgr.GetInstance()

	if var_19_2 - var_4.GetServerTime(var_19_3) <= 0 then
		var_19_1()
	else
		local var_19_4 = arg_19_0.timers
		local var_19_5 = arg_19_1.id

		Timer = var_19_3
		var_19_4[var_19_5] = var_19_3.New(var_19_1, var_3, 1)

		local var_19_6 = arg_19_0.timers[arg_19_1.id]

		var_4.Start(var_19_6)
	end

	return
end

function var_0_1.removeExpireTimer(arg_22_0, arg_22_1)
	if arg_22_0.timers[arg_22_1] then
		local var_22_0 = arg_22_0.timers[arg_22_1]

		var_2.Stop(var_22_0)

		arg_22_0.timers[arg_22_1] = nil
	end

	return
end

function var_0_1.removeSkinById(arg_23_0, arg_23_1)
	arg_23_0.skins[arg_23_1] = nil

	arg_23_0:removeExpireTimer(arg_23_1)

	local var_23_0 = arg_23_0.facade

	var_2.sendNotification(var_23_0, var_0_1.SHIP_SKINS_UPDATE)

	return
end

function var_0_1.hasSkin(arg_24_0, arg_24_1)
	ShipSkin = var_1_10002

	if var_1_10002.IsChangeSkin(arg_24_1) then
		ShipSkin = var_2

		local var_24_0 = var_2.GetChangeSkinGroupId(arg_24_1)

		return arg_24_0.changeSkinGroupDic[var_24_0]
	end

	return arg_24_0.skins[arg_24_1] ~= nil
end

function var_0_1.hasNonLimitSkin(arg_25_0, arg_25_1)
	return arg_25_0.skins[arg_25_1] ~= nil and not var_2:isExpireType()
end

function var_0_1.getSkinCountById(arg_26_0, arg_26_1)
	return arg_26_0:hasSkin(arg_26_1) and 1 or 0
end

function var_0_1.InForbiddenSkinListAndHide(arg_27_0, arg_27_1)
	_ = var_1_10002

	return var_1_10002.any(arg_27_0.forbiddenSkinList, function(arg_28_0)
		return arg_28_0.id == arg_27_1 and arg_28_0.type == var_0_1.FORBIDDEN_TYPE_HIDE
	end)
end

function var_0_1.InForbiddenSkinListAndShow(arg_29_0, arg_29_1)
	_ = var_1_10002

	return var_1_10002.any(arg_29_0.forbiddenSkinList, function(arg_30_0)
		return arg_30_0.id == arg_29_1 and arg_30_0.type == var_0_1.FORBIDDEN_TYPE_SHOW
	end)
end

function var_0_1.InForbiddenSkinList(arg_31_0, arg_31_1)
	_ = var_1_10002

	return var_1_10002.any(arg_31_0.forbiddenSkinList, function(arg_32_0)
		return arg_32_0.id == arg_31_1
	end)
end

function var_0_1.remove(arg_33_0)
	pairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0.timers) do
		iter_33_1:Stop()
	end

	arg_33_0.timers = nil

	return
end

function var_0_1.GetAllSkins(arg_34_0)
	local var_34_0 = {}

	local function var_34_1(arg_35_0)
		local var_35_0 = arg_35_0:getSkinId()

		getProxy = var_2_10002
		ShipSkinProxy = var_2_10004

		local var_35_1 = var_2_10002(var_2_10004)
		local var_35_2 = var_2.getSkinById(var_35_1, var_35_0) and not var_2:isExpireType() and 1 or 0

		arg_35_0:updateBuyCount(var_35_2)

		return
	end

	local function var_34_2(arg_36_0)
		Goods = var_2_10001

		local var_36_0 = var_2_10001.Create
		local var_36_1 = {
			shop_id = arg_36_0
		}

		Goods = var_2_10004

		local var_36_2 = var_36_0(var_36_1, var_2_10004.TYPE_SKIN)

		var_34_1(var_36_2)

		pg = var_2

		local var_36_3

		if var_2.shop_template[arg_36_0].collaboration_skin_time ~= "" then
			pg = var_36_1

			if var_2 ~= var_36_1.shop_template[arg_36_0].time then
				var_36_3 = false

				goto label_36_0
			end
		end

		var_36_3 = true

		::label_36_0::

		pg = var_4

		local var_36_4 = var_4.TimeMgr.GetInstance()
		local var_36_5 = var_4.inTime

		pg = var_2_10007

		local var_36_6, var_36_7 = var_36_5(var_36_4, var_2_10007.shop_template[arg_36_0].time)

		if var_36_3 and var_36_6 then
			table = var_36_4

			var_36_4.insert(var_34_0, var_36_2)
		end

		return
	end

	ipairs = var_1_10004
	pg = var_1_10006

	local var_34_3 = var_1_10006.shop_template.get_id_list_by_genre

	ShopArgs = var_1_10007

	for iter_34_0, iter_34_1 in var_1_10004(var_34_3[var_1_10007.SkinShop]) do
		var_34_2(iter_34_1)
	end

	ipairs = var_4
	pg = var_6

	local var_34_4 = var_6.shop_template.get_id_list_by_genre

	ShopArgs = iter_34_0

	for iter_34_2, iter_34_3 in var_4(var_34_4[iter_34_0.SkinShopTimeLimit]) do
		var_34_2(iter_34_3)
	end

	getProxy = var_4
	ActivityProxy = var_6

	local var_34_5 = var_4(var_6)

	pg = var_5

	local var_34_6 = var_5.activity_shop_extra.get_id_list_by_commodity_type

	DROP_TYPE_SKIN = var_6

	local var_34_7 = var_34_6[var_6]

	ipairs = var_6

	for iter_34_4, iter_34_5 in var_6(var_34_7) do
		pg = var_1_10011
		var_1_10011 = var_1_10011.activity_shop_extra[iter_34_5]
		var_1_10012 = var_34_5:getActivityById(var_1_10011.activity)

		if var_1_10011.activity == 0 then
			pg = var_13

			local var_34_8 = var_13.TimeMgr.GetInstance()

			if not var_13.inTime(var_34_8, var_1_10011.time) then
				if var_1_10012 and not var_1_10012:isEnd() then
					Goods = var_13

					local var_34_9 = var_13.Create
					local var_34_10 = {
						shop_id = iter_34_5
					}

					Goods = var_1_10016

					local var_34_11 = var_34_9(var_34_10, var_1_10016.TYPE_ACTIVITY_EXTRA)

					var_34_1(var_34_11)

					table = var_14

					var_14.insert(var_34_0, var_34_11)
				end
			end
		end
	end

	pg = var_6

	local var_34_12 = var_6.activity_shop_template.get_id_list_by_commodity_type

	DROP_TYPE_SKIN = var_7

	local var_34_13 = var_34_12[var_7]

	ipairs = var_7

	for iter_34_6, iter_34_7 in var_7(var_34_13) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.activity_shop_template[iter_34_7]

		if var_34_5:getActivityById(var_1_10012.activity) and not var_13:isEnd() then
			Goods = var_14

			local var_34_14 = var_14.Create
			local var_34_15 = {
				shop_id = iter_34_7
			}

			Goods = var_1_10017

			local var_34_16 = var_34_14(var_34_15, var_1_10017.TYPE_ACTIVITY)

			var_34_1(var_34_16)

			_ = var_15

			if not var_15.any(var_34_0, function(arg_37_0)
				local var_37_0 = arg_37_0:getSkinId()
				local var_37_1 = var_34_16

				return var_37_0 == var_2.getSkinId(var_37_1)
			end) then
				table = var_15

				var_15.insert(var_34_0, var_34_16)
			end
		end
	end

	for iter_34_8 = #var_34_0, 1, -1 do
		local var_34_17 = var_34_0[iter_34_8]
		local var_34_18 = var_11.getSkinId(var_34_17)

		if arg_34_0:InForbiddenSkinList(var_34_18) or not arg_34_0:InShowTime(var_34_18) then
			table = var_12

			var_12.remove(var_34_0, iter_34_8)
		end
	end

	return var_34_0
end

function var_0_1.GetShopShowingSkins(arg_38_0)
	local var_38_0 = {}

	local function var_38_1(arg_39_0)
		local var_39_0 = arg_39_0:getSkinId()

		getProxy = var_2_10002
		ShipSkinProxy = var_2_10004

		local var_39_1 = var_2_10002(var_2_10004)
		local var_39_2 = var_2.getSkinById(var_39_1, var_39_0) and not var_2:isExpireType() and 1 or 0

		arg_39_0:updateBuyCount(var_39_2)

		return
	end

	local function var_38_2(arg_40_0)
		Goods = var_2_10001

		local var_40_0 = var_2_10001.Create
		local var_40_1 = {
			shop_id = arg_40_0
		}

		Goods = var_2_10004

		local var_40_2 = var_40_0(var_40_1, var_2_10004.TYPE_SKIN)

		var_38_1(var_40_2)

		table = var_2

		var_2.insert(var_38_0, var_40_2)

		return
	end

	ipairs = var_1_10004
	pg = var_1_10006

	local var_38_3 = var_1_10006.shop_template.get_id_list_by_genre

	ShopArgs = var_1_10007

	for iter_38_0, iter_38_1 in var_1_10004(var_38_3[var_1_10007.SkinShop]) do
		var_38_2(iter_38_1)
	end

	ipairs = var_4
	pg = var_6

	local var_38_4 = var_6.shop_template.get_id_list_by_genre

	ShopArgs = iter_38_0

	for iter_38_2, iter_38_3 in var_4(var_38_4[iter_38_0.SkinShopTimeLimit]) do
		var_38_2(iter_38_3)
	end

	getProxy = var_4
	ActivityProxy = var_6

	local var_38_5 = var_4(var_6)

	pg = var_5

	local var_38_6 = var_5.activity_shop_extra.get_id_list_by_commodity_type

	DROP_TYPE_SKIN = var_6

	local var_38_7 = var_38_6[var_6]

	ipairs = var_6

	for iter_38_4, iter_38_5 in var_6(var_38_7) do
		Goods = var_1_10011
		var_1_10011 = var_1_10011.Create

		local var_38_8 = {
			shop_id = iter_38_5
		}

		Goods = var_1_10014
		var_1_10011 = var_1_10011(var_38_8, var_1_10014.TYPE_ACTIVITY_EXTRA)

		var_38_1(var_1_10011)

		table = var_1_10012

		var_1_10012.insert(var_38_0, var_1_10011)
	end

	pg = var_6

	local var_38_9 = var_6.activity_shop_template.get_id_list_by_commodity_type

	DROP_TYPE_SKIN = var_7

	local var_38_10 = var_38_9[var_7]

	ipairs = var_7

	for iter_38_6, iter_38_7 in var_7(var_38_10) do
		Goods = var_1_10012
		var_1_10012 = var_1_10012.Create

		local var_38_11 = {
			shop_id = iter_38_7
		}

		Goods = var_1_10015
		var_1_10012 = var_1_10012(var_38_11, var_1_10015.TYPE_ACTIVITY)

		var_38_1(var_1_10012)

		_ = var_13

		if not var_13.any(var_38_0, function(arg_41_0)
			local var_41_0 = arg_41_0:getSkinId()
			local var_41_1 = var_1_10012

			return var_41_0 == var_2.getSkinId(var_41_1)
		end) then
			table = var_13

			var_13.insert(var_38_0, var_1_10012)
		end
	end

	return var_38_0
end

function var_0_1.GetAllSkinForShip(arg_42_0, arg_42_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_42_0 = arg_42_1

	Ship = var_1_10007

	var_1_10002(var_1_10004(var_42_0, var_1_10007), "ship should be an instance of Ship")

	local var_42_1 = arg_42_1.groupId

	ShipGroup = var_1_10003

	for iter_42_0 = #var_1_10003.getSkinList(var_42_1), 1, -1 do
		var_1_10009 = var_3[iter_42_0].skin_type
		ShipSkin = var_1_10010

		if var_1_10009 == var_1_10010.SKIN_TYPE_NOT_HAVE_HIDE then
			var_1_10011 = arg_42_0

			if not arg_42_0.hasSkin(var_1_10011, var_8.id) then
				table = var_1_10009

				var_1_10009.remove(var_3, iter_42_0)

				goto label_42_0
			end
		end

		var_1_10011 = arg_42_0

		if not arg_42_0.InShowTime(var_1_10011, var_8.id) then
			table = var_1_10009

			var_1_10009.remove(var_3, iter_42_0)
		end

		::label_42_0::
	end

	pg = var_4

	if var_4.ship_data_trans[var_42_1] and not arg_42_1:isRemoulded() then
		ShipGroup = var_4

		local var_42_2 = var_4.GetGroupConfig(var_42_1).trans_skin

		for iter_42_1 = #var_3, 1, -1 do
			if var_3[iter_42_1].id == var_42_2 then
				table = var_1_10009

				var_1_10009.remove(var_3, iter_42_1)

				break
			end
		end
	end

	for iter_42_2 = #var_3, 1, -1 do
		if var_3[iter_42_2].show_time then
			type = var_1_10009

			if var_1_10009(var_8.show_time) ~= "string" or var_8.show_time ~= "stop" then
				type = var_1_10009

				if var_1_10009(var_8.show_time) == "table" then
					pg = var_1_10009
					var_1_10011 = var_1_10009.TimeMgr.GetInstance()

					if not var_1_10009.inTime(var_1_10011, var_8.show_time) then
						table = var_1_10009

						var_1_10009.remove(var_3, iter_42_2)
					end
				end

				if var_8.no_showing == "1" then
					table = var_1_10009

					var_1_10009.remove(var_3, iter_42_2)
				else
					PLATFORM = var_1_10009
					PLATFORM_KR = var_1_10010

					if var_1_10009 == var_1_10010 then
						pg = var_1_10009

						if var_1_10009.ship_skin_template[var_8.id].isHX == 1 then
							table = var_1_10009

							var_1_10009.remove(var_3, iter_42_2)
						end
					end
				end
			end
		end
	end

	PLATFORM_CODE = var_4
	PLATFORM_CH = var_5

	if var_4 == var_5 then
		pg = var_4

		local var_42_3 = var_4.gameset.big_seven_old_skin_timestamp.key_value

		for iter_42_3 = #var_3, 1, -1 do
			var_1_10010 = var_3[iter_42_3].skin_type
			ShipSkin = var_1_10011

			if var_1_10010 == var_1_10011.SKIN_TYPE_OLD and var_42_3 < arg_42_1.createTime then
				table = var_1_10010

				var_1_10010.remove(var_3, iter_42_3)
			end
		end
	end

	if #arg_42_0.forbiddenSkinList > 0 then
		for iter_42_4 = #var_3, 1, -1 do
			local var_42_4 = var_3[iter_42_4].id

			if not arg_42_0:hasSkin(var_42_4) and arg_42_0:InForbiddenSkinListAndHide(var_42_4) then
				table = var_1_10009

				var_1_10009.remove(var_3, iter_42_4)
			end
		end
	end

	for iter_42_5 = #var_3, 1, -1 do
		local var_42_5 = var_3[iter_42_5]

		ShipSkin = var_1_10009

		if var_1_10009.GetChangeSkinGroupId(var_42_5.id) then
			ShipSkin = var_1_10010

			if not var_1_10010.GetStoreChangeSkinId(var_1_10009, arg_42_1:GetShipPhantomMark()) then
				if var_42_5.change_skin.index ~= 1 then
					print = var_11

					var_11("没有缓存的id ，" .. "移除了id" .. var_42_5.id)

					table = var_11

					var_11.remove(var_3, iter_42_5)
				end
			elseif var_1_10010 ~= var_42_5.id then
				print = var_11

				var_11("有缓存的id = " .. var_1_10010 .. "移除了id" .. var_42_5.id)

				table = var_11

				var_11.remove(var_3, iter_42_5)
			end
		end
	end

	return var_3
end

function var_0_1.GetShareSkinsForShipGroup(arg_43_0, arg_43_1)
	pg = var_1_10002

	local var_43_0 = var_1_10002.ship_data_group.get_id_list_by_group_type[arg_43_1][1]

	pg = var_1_10003

	if not var_1_10003.ship_data_group[var_43_0].share_group_id or #var_3.share_group_id <= 0 then
		return {}
	end

	local var_43_1 = {}

	ipairs = var_1_10005

	for iter_43_0, iter_43_1 in var_1_10005(var_3.share_group_id) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.ship_skin_template.get_id_list_by_ship_group[iter_43_1]
		ipairs = var_1_10011

		for iter_43_2, iter_43_3 in var_1_10011(var_1_10010) do
			ShipSkin = var_1_10016

			local var_43_2 = var_1_10016.New({
				id = iter_43_3
			})

			if var_1_10016.CanShare(var_43_2) then
				table = var_17

				var_17.insert(var_43_1, var_1_10016)
			end
		end
	end

	return var_43_1
end

function var_0_1.GetShareSkinsForShip(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.groupId

	for iter_44_0 = #arg_44_0:GetShareSkinsForShipGroup(var_44_0), 1, -1 do
		local var_44_1 = var_3[iter_44_0]

		ShipSkin = var_1_10009

		if var_1_10009.GetChangeSkinGroupId(var_44_1.id) then
			ShipSkin = var_1_10010
			var_1_10010 = var_1_10010.GetStoreChangeSkinId(var_1_10009, arg_44_1:GetShipPhantomMark())

			local var_44_2 = var_44_1:getConfig("change_skin")

			if not var_1_10010 then
				if var_44_2 and var_44_2 ~= "" and var_44_2.index ~= 1 then
					table = var_12

					var_12.remove(var_3, iter_44_0)
				end
			elseif not arg_44_0:hasSkin(var_44_1.id) then
				if var_44_2 and var_44_2 ~= "" and var_44_2.index ~= 1 then
					table = var_12

					var_12.remove(var_3, iter_44_0)
				end
			elseif var_1_10010 ~= var_44_1.id then
				table = var_12

				var_12.remove(var_3, iter_44_0)
			end
		end
	end

	return var_3
end

function var_0_1.GetAllSkinForARCamera(arg_45_0, arg_45_1)
	ShipGroup = var_1_10002

	for iter_45_0 = #var_1_10002.getSkinList(arg_45_1), 1, -1 do
		var_1_10007 = var_2[iter_45_0].skin_type
		ShipSkin = var_1_10008

		if var_1_10007 == var_1_10008.SKIN_TYPE_OLD then
			table = var_1_10007

			var_1_10007.remove(var_2, iter_45_0)
		end
	end

	ShipGroup = var_3

	if var_3.GetGroupConfig(arg_45_1).trans_skin ~= 0 then
		local var_45_0 = false

		getProxy = var_5
		CollectionProxy = var_1_10007

		local var_45_1 = var_5(var_1_10007)

		if var_5.getShipGroup(var_45_1, arg_45_1) then
			ipairs = iter_45_0

			for iter_45_1, iter_45_2 in iter_45_0(var_2) do
				local var_45_2 = iter_45_2.skin_type

				ShipSkin = var_1_10012

				if var_45_2 == var_1_10012.SKIN_TYPE_REMAKE and var_5.trans then
					var_45_0 = true

					break
				end
			end
		end

		if not var_45_0 then
			for iter_45_3 = #var_2, 1, -1 do
				if var_2[iter_45_3].id == var_3 then
					table = iter_45_2

					iter_45_2.remove(var_2, iter_45_3)

					break
				end
			end
		end
	end

	for iter_45_4 = #var_2, 1, -1 do
		local var_45_3 = var_2[iter_45_4].skin_type

		ShipSkin = iter_45_2

		if var_45_3 == iter_45_2.SKIN_TYPE_NOT_HAVE_HIDE and not arg_45_0:hasSkin(var_8.id) then
			table = var_9

			var_9.remove(var_2, iter_45_4)
		elseif var_8.no_showing == "1" then
			table = var_9

			var_9.remove(var_2, iter_45_4)
		else
			PLATFORM = var_9
			PLATFORM_KR = iter_45_2

			if var_9 == iter_45_2 then
				pg = var_9

				if var_9.ship_skin_template[var_8.id].isHX == 1 then
					table = var_9

					var_9.remove(var_2, iter_45_4)

					goto label_45_0
				end
			end

			if not arg_45_0:InShowTime(var_8.id) then
				table = var_9

				var_9.remove(var_2, iter_45_4)
			end
		end

		::label_45_0::
	end

	if #arg_45_0.forbiddenSkinList > 0 then
		for iter_45_5 = #var_2, 1, -1 do
			local var_45_4 = var_2[iter_45_5].id

			if not arg_45_0:hasSkin(var_45_4) and arg_45_0:InForbiddenSkinListAndHide(var_45_4) then
				table = var_9

				var_9.remove(var_2, iter_45_5)
			end
		end
	end

	for iter_45_6 = #var_2, 1, -1 do
		if var_2[iter_45_6] and var_8.change_skin and var_8.change_skin.index and var_8.change_skin.index ~= 1 then
			table = var_9

			var_9.remove(var_2, iter_45_6)
		end
	end

	return var_2
end

function var_0_1.InShowTime(arg_46_0, arg_46_1)
	pg = var_1_10002

	if var_1_10002.ship_skin_template_column_time[arg_46_1] and var_2.time ~= "" then
		type = var_3

		if var_3(var_2.time) == "table" and #var_2.time > 0 then
			pg = var_3

			local var_46_0 = var_3.TimeMgr.GetInstance()

			return var_3.passTime(var_46_0, var_2.time)
		end
	end

	return true
end

function var_0_1.HasFashion(arg_47_0, arg_47_1)
	if #arg_47_0:GetShareSkinsForShip(arg_47_1) > 0 then
		return true
	end

	local var_47_0 = arg_47_0

	if #arg_47_0.GetAllSkinForShip(var_47_0, arg_47_1) == 1 then
		local var_47_1 = var_3[1]

		checkABExist = var_47_0

		return (var_47_0("painting/" .. var_47_1.painting .. "_n"))
	end

	return #var_3 > 1
end

function var_0_1.GetEncoreSkins(arg_48_0)
	local var_48_0 = {}

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_48_1 = var_1_10002(var_1_10004)
	local var_48_2 = var_2.getActivitiesByType

	ActivityConst = var_1_10005

	local var_48_3 = var_48_2(var_48_1, var_1_10005.ACTIVITY_TYPE_PT_BUFF)

	local function var_48_4(arg_49_0)
		local var_49_0 = arg_49_0

		if arg_49_0.getConfig(var_49_0, "config_client") and var_1[1] then
			type = var_2

			if var_2(var_1[1]) == "table" then
				pg = var_2

				local var_49_1 = var_2.TimeMgr.GetInstance()
				local var_49_2 = var_2.parseTimeFromConfig(var_49_1, var_1[1])

				pg = var_49_0

				local var_49_3 = var_49_0.TimeMgr.GetInstance()

				do return var_49_2 <= var_3.GetServerTime(var_49_3) end

				goto label_49_0
			end
		end

		do return arg_49_0:isEnd() end

		::label_49_0::

		return
	end

	ipairs = var_48_1

	for iter_48_0, iter_48_1 in var_48_1(var_48_3) do
		if iter_48_1:getDataConfig("type") == 5 and not var_48_4(iter_48_1) then
			ipairs = var_9

			for iter_48_2, iter_48_3 in var_9(iter_48_1:getConfig("config_data")) do
				table = var_14

				var_14.insert(var_48_0, iter_48_3)
			end
		end
	end

	getProxy = var_4
	ActivityProxy = var_6

	local var_48_5 = var_4(var_6)
	local var_48_6 = var_4.getActivitiesByType

	ActivityConst = iter_48_0

	local var_48_7 = var_48_6(var_48_5, iter_48_0.ACTIVITY_TYPE_SKIN_COUPON_COUNTING)

	ipairs = var_5

	for iter_48_4, iter_48_5 in var_5(var_48_7) do
		if iter_48_5 and not iter_48_5:isEnd() then
			ipairs = var_10

			for iter_48_6, iter_48_7 in var_10(iter_48_5:getConfig("config_data")[2]) do
				table = var_15

				if not var_15.contains(var_48_0, iter_48_7) then
					table = var_15

					var_15.insert(var_48_0, iter_48_7)
				end
			end
		end
	end

	return var_48_0
end

function var_0_1.GetOwnSkins(arg_50_0)
	local var_50_0 = {}
	local var_50_1 = arg_50_0:getRawData()

	pairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(var_50_1) do
		table = var_1_10008

		var_1_10008.insert(var_50_0, iter_50_1)
	end

	getProxy = var_3
	CollectionProxy = var_5

	local var_50_2 = var_3(var_5).shipGroups

	pairs = var_4

	for iter_50_2, iter_50_3 in var_4(var_50_2) do
		if iter_50_3.married == 1 then
			ShipGroup = var_9

			if var_9.getProposeSkin(iter_50_3.id) then
				table = var_1_10010
				var_1_10010 = var_1_10010.insert

				local var_50_3 = var_50_0

				ShipSkin = var_1_10013

				var_1_10010(var_50_3, var_1_10013.New({
					id = var_9.id
				}))
			end
		end

		if iter_50_3.trans then
			pg = var_9

			local var_50_4 = var_9.ship_data_trans[iter_50_3.id].skin_id

			table = var_1_10010
			var_1_10010 = var_1_10010.insert

			local var_50_5 = var_50_0

			ShipSkin = var_1_10013

			var_1_10010(var_50_5, var_1_10013.New({
				id = var_50_4
			}))
		end
	end

	return var_50_0
end

function var_0_1.GetOwnAndShareSkins(arg_51_0)
	local var_51_0 = arg_51_0
	local var_51_1 = arg_51_0.GetOwnSkins(var_51_0)
	local var_51_2 = {}

	ipairs = var_51_0

	for iter_51_0, iter_51_1 in var_51_0(var_51_1) do
		var_51_2[iter_51_1.id] = iter_51_1
	end

	getProxy = var_3
	CollectionProxy = var_5

	local var_51_3 = var_3(var_5).shipGroups

	pairs = var_4

	for iter_51_2, iter_51_3 in var_4(var_51_3) do
		if iter_51_3.married == 1 then
			local var_51_4 = arg_51_0:GetShareSkinsForShipGroup(iter_51_3.id)

			ipairs = var_1_10010

			for iter_51_4, iter_51_5 in var_1_10010(var_51_4) do
				if not var_51_2[iter_51_5.id] then
					table = var_15

					var_15.insert(var_51_1, iter_51_5)
				end
			end
		end
	end

	return var_51_1
end

function var_0_1.GetProbabilitySkins(arg_52_0, arg_52_1)
	local var_52_0 = {}

	local function var_52_1(arg_53_0)
		local var_53_0 = arg_53_0:getSkinId()

		getProxy = var_2_10002
		ShipSkinProxy = var_2_10004

		local var_53_1 = var_2_10002(var_2_10004)
		local var_53_2 = var_2.getSkinById(var_53_1, var_53_0) and not var_2:isExpireType() and 1 or 0

		arg_53_0:updateBuyCount(var_53_2)

		return
	end

	local function var_52_2(arg_54_0)
		Goods = var_2_10001

		local var_54_0 = var_2_10001.Create
		local var_54_1 = {
			shop_id = arg_54_0
		}

		Goods = var_2_10004

		local var_54_2 = var_54_0(var_54_1, var_2_10004.TYPE_SKIN)

		var_52_1(var_54_2)

		pg = var_2

		local var_54_3 = var_2.TimeMgr.GetInstance()
		local var_54_4 = var_2.inTime

		pg = var_2_10005

		local var_54_5, var_54_6 = var_54_4(var_54_3, var_2_10005.shop_template[arg_54_0].time)

		if var_54_5 then
			table = var_54_3

			var_54_3.insert(var_52_0, var_54_2)
		end

		return
	end

	getProxy = var_1_10005
	ShipSkinProxy = var_1_10007

	local var_52_3 = var_1_10005(var_1_10007)
	local var_52_4 = var_5.GetAllSkins(var_52_3)
	local var_52_5 = {}

	ipairs = var_52_3

	for iter_52_0, iter_52_1 in var_52_3(var_52_4) do
		local var_52_6 = iter_52_1:getConfig("genre")

		ShopArgs = var_1_10013

		if var_52_6 ~= var_1_10013.SkinShopTimeLimit then
			var_52_5[iter_52_1:getSkinId()] = iter_52_1.id
		end
	end

	ipairs = var_7

	for iter_52_2, iter_52_3 in var_7(arg_52_1) do
		if var_52_5[iter_52_3[1]] then
			var_52_2(var_13)
		end
	end

	return var_52_0
end

function var_0_1.GetSkinProbabilitys(arg_55_0, arg_55_1)
	local var_55_0 = {}

	ipairs = var_1_10003

	for iter_55_0, iter_55_1 in var_1_10003(arg_55_1) do
		var_55_0[iter_55_1[1]] = iter_55_1[2]
	end

	return var_55_0
end

function var_0_1.GetInTimeSkins(arg_56_0)
	for iter_56_0 = #arg_56_0:GetAllSkins(), 1, -1 do
		local var_56_0 = var_1[iter_56_0].type

		Goods = var_1_10008

		if var_56_0 == var_1_10008.TYPE_SKIN then
			if var_6:getConfig("time") == "always" then
				table = var_7

				var_7.remove(var_1, iter_56_0)
			end
		else
			local var_56_1 = var_6.type

			Goods = var_1_10008

			if var_56_1 == var_1_10008.TYPE_ACTIVITY_EXTRA then
				pg = var_56_1

				if var_56_1.activity_shop_extra[var_6.id].shop_tag ~= 1 then
					table = var_1_10008

					var_1_10008.remove(var_1, iter_56_0)
				end
			end
		end
	end

	return var_1
end

function var_0_1.GetPermanentSkins(arg_57_0)
	for iter_57_0 = #arg_57_0:GetAllSkins(), 1, -1 do
		local var_57_0 = var_1[iter_57_0].type

		Goods = var_1_10008

		if var_57_0 == var_1_10008.TYPE_SKIN then
			if var_6:getConfig("time") ~= "always" then
				table = var_7

				var_7.remove(var_1, iter_57_0)
			end
		else
			local var_57_1 = var_6.type

			Goods = var_1_10008

			if var_57_1 == var_1_10008.TYPE_ACTIVITY_EXTRA then
				pg = var_57_1

				if var_57_1.activity_shop_extra[var_6.id].shop_tag ~= 2 then
					table = var_1_10008

					var_1_10008.remove(var_1, iter_57_0)
				end
			else
				local var_57_2 = var_6.type

				Goods = var_1_10008

				if var_57_2 == var_1_10008.TYPE_ACTIVITY then
					table = var_57_2

					var_57_2.remove(var_1, iter_57_0)
				end
			end
		end
	end

	return var_1
end

function var_0_1.GetShareSkinsForShipGroupInJuus(arg_58_0, arg_58_1)
	pg = var_1_10002

	local var_58_0 = var_1_10002.ship_data_group.get_id_list_by_group_type[arg_58_1][1]

	pg = var_1_10003

	if not var_1_10003.ship_data_group[var_58_0].share_group_id or #var_3.share_group_id <= 0 then
		return {}
	end

	local var_58_1 = {}

	ipairs = var_1_10005

	for iter_58_0, iter_58_1 in var_1_10005(var_3.share_group_id) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.ship_skin_template.get_id_list_by_ship_group[iter_58_1]
		ipairs = var_1_10011

		for iter_58_2, iter_58_3 in var_1_10011(var_1_10010) do
			ShipSkin = var_1_10016

			local var_58_2 = var_1_10016.New({
				id = iter_58_3
			})

			if var_1_10016.CanShareInJuus(var_58_2) then
				table = var_17

				var_17.insert(var_58_1, var_1_10016)
			end
		end
	end

	return var_58_1
end

return var_0_1
