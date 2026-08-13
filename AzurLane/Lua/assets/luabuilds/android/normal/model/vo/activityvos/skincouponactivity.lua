class = var_0_10000

local var_0_0 = "SkinCouponActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.dataConfig = var_2.activity_event_shop_discount[arg_1_0.configId]

	return
end

function var_0_1.GetDiscountPrice(arg_2_0)
	return arg_2_0.dataConfig.discount_price
end

function var_0_1.GetNewPrice(arg_3_0, arg_3_1)
	return arg_3_1 - arg_3_0:GetDiscountPrice()
end

function var_0_1.GetShopIdList(arg_4_0)
	return arg_4_0.dataConfig.shop_list
end

function var_0_1.Left3Day(arg_5_0)
	local var_5_0 = arg_5_0.stopTime

	pg = var_1_10002

	local var_5_1 = var_1_10002.TimeMgr.GetInstance()

	if var_5_0 - var_2.GetServerTime(var_5_1) < 0 then
		return true
	end

	return false
end

function var_0_1.ShouldTipUsage(arg_6_0)
	local function var_6_0()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)
		local var_7_1 = var_0.getRawData(var_7_0).id

		PlayerPrefs = var_7_0

		if var_7_0.GetInt(arg_6_0.id .. "_SkinCouponActivity_Tip" .. var_7_1, 0) <= 0 then
			return true
		end

		pg = var_2

		local var_7_2 = var_2.TimeMgr.GetInstance()
		local var_7_4

		if var_1 < var_2.GetServerTime(var_7_2) then
			pg = var_7_2

			local var_7_3 = var_7_2.TimeMgr.GetInstance()

			var_7_4 = not var_3.IsSameDay(var_7_3, var_2, var_1)
		else
			var_7_4 = false
		end

		if false then
			var_7_4 = true
		end

		return var_7_4
	end

	local var_6_1

	if arg_6_0:GetCanUsageCnt() > 0 then
		if arg_6_0:Left3Day() then
			var_6_1 = var_6_0()
		end
	else
		var_6_1 = false
	end

	if false then
		var_6_1 = true
	end

	return var_6_1
end

function var_0_1.SaveTipTime(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TimeMgr.GetInstance()
	local var_8_1 = var_1.GetServerTime(var_8_0)

	getProxy = var_8_0
	PlayerProxy = var_1_10003

	local var_8_2 = var_8_0(var_1_10003)
	local var_8_3 = var_2.getRawData(var_8_2).id

	PlayerPrefs = var_8_2

	var_8_2.SetInt(arg_8_0.id .. "_SkinCouponActivity_Tip" .. var_8_3, var_8_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.IncludeShop(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetShopIdList(var_9_0)

	table = var_9_0

	return var_9_0.contains(var_9_1, arg_9_1)
end

function var_0_1.GetCanUsageCnt(arg_10_0)
	return arg_10_0.data1 - arg_10_0.data2
end

function var_0_1.GetEquivalentRes(arg_11_0)
	if arg_11_0.dataConfig.change_resource_type == 0 or arg_11_0.dataConfig.change_resource_num == 0 then
		return nil
	end

	Drop = var_1

	local var_11_0 = var_1.New
	local var_11_1 = {}

	DROP_TYPE_RESOURCE = var_1_10003
	var_11_1.type = var_1_10003
	var_11_1.id = arg_11_0.dataConfig.change_resource_type
	var_11_1.count = arg_11_0.dataConfig.change_resource_num

	local var_11_2 = var_11_0(var_11_1)

	var_1.name = var_1.getName(var_11_2)

	return
end

function var_0_1.GetLimitCnt(arg_12_0)
	if arg_12_0.dataConfig.max_count == 0 then
		math = var_1

		return var_1.huge
	else
		return arg_12_0.dataConfig.max_count
	end

	return
end

function var_0_1.IsMaxCnt(arg_13_0)
	return arg_13_0.data1 > arg_13_0:GetLimitCnt()
end

function var_0_1.GetItemId(arg_14_0)
	return arg_14_0.dataConfig.item_id
end

function var_0_1.GetItemConfig(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetItemId(var_15_0)

	Item = var_15_0

	local var_15_2

	if not var_15_0.getConfigData(var_15_1) then
		var_15_2 = {}
	end

	return var_15_2
end

function var_0_1.GetItemName(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetItemId(var_16_0)

	Item = var_16_0

	local var_16_2

	if not var_16_0.getConfigData(var_16_1) or not var_2.name then
		var_16_2 = ""
	end

	return var_16_2
end

function var_0_1.ShopId2SkinId(arg_17_0, arg_17_1)
	pg = var_1_10002

	return var_1_10002.shop_template[arg_17_1].effect_args[1]
end

function var_0_1.GetOwnCount(arg_18_0)
	underscore = var_1_10001

	local var_18_0 = var_1_10001.map(arg_18_0:GetShopIdList(), function(arg_19_0)
		local var_19_0 = arg_18_0

		return var_1.ShopId2SkinId(var_19_0, arg_19_0)
	end)

	underscore = var_2

	return #var_2.filter(var_18_0, function(arg_20_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10002

		local var_20_0 = var_2_10001(var_2_10002)

		return var_1.hasNonLimitSkin(var_20_0, arg_20_0)
	end), #var_18_0
end

function var_0_1.OwnAllSkin(arg_21_0)
	local var_21_0, var_21_1 = arg_21_0:GetOwnCount()

	return var_21_0 == var_21_1
end

function var_0_1.GetSkinCouponActivities(arg_22_0)
	local var_22_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	local var_22_1 = var_1_10003.activity_template.get_id_list_by_type

	ActivityConst = var_1_10004

	local var_22_2

	if not var_22_1[var_1_10004.ACTIVITY_TYPE_SKIN_COUPON] then
		var_22_2 = {}
	end

	for iter_22_0, iter_22_1 in var_1_10002(var_22_2) do
		getProxy = var_1_10007
		ActivityProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if var_1_10007.RawGetActivityById(var_1_10008, iter_22_1) and not var_1_10007:isEnd() and (not arg_22_0 or var_1_10007:IncludeShop(arg_22_0)) then
			table = var_1_10008

			var_1_10008.insert(var_22_0, var_1_10007)
		end
	end

	return var_22_0
end

function var_0_1.GetBestReadySkinCouponAct(arg_23_0)
	local var_23_0 = 0
	local var_23_1

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(var_0_1.GetSkinCouponActivities(arg_23_0)) do
		if iter_23_1:GetCanUsageCnt() > 0 and var_23_0 < iter_23_1:GetDiscountPrice() then
			var_23_0 = iter_23_1:GetDiscountPrice()
			var_23_1 = iter_23_1
		end
	end

	return var_23_1
end

function var_0_1.StaticExistActivityAndCoupon(arg_24_0)
	underscore = var_1_10001

	return var_1_10001.any(var_0_1.GetSkinCouponActivities(arg_24_0), function(arg_25_0)
		return arg_25_0:GetCanUsageCnt() > 0
	end)
end

function var_0_1.GetSkinCouponActFromEncoreAct(arg_26_0)
	if not arg_26_0 then
		return
	end

	Drop = var_1_10001

	local var_26_0 = var_1_10001.New
	local var_26_1 = {}

	DROP_TYPE_VITEM = var_1_10003
	var_26_1.type = var_1_10003
	var_26_1.id = arg_26_0:GetConfigClientSetting("item_id")

	local var_26_2 = var_26_0(var_26_1)

	getProxy = var_26_1
	ActivityProxy = var_3

	local var_26_3 = var_26_1(var_3)

	if var_2.getActivityById(var_26_3, var_26_2:getConfig("link_id")) and not var_2:isEnd() then
		return var_2
	end

	return
end

function var_0_1.GetSkinCouponEncoreActivities(arg_27_0)
	local var_27_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	local var_27_1 = var_1_10003.activity_template.get_id_list_by_type

	ActivityConst = var_1_10004

	local var_27_2

	if not var_27_1[var_1_10004.ACTIVITY_TYPE_SKIN_COUPON_COUNTING] then
		var_27_2 = {}
	end

	for iter_27_0, iter_27_1 in var_1_10002(var_27_2) do
		getProxy = var_1_10007
		ActivityProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if var_1_10007.RawGetActivityById(var_1_10008, iter_27_1) and not var_1_10007:isEnd() then
			if arg_27_0 then
				table = var_1_10008

				if var_1_10008.contains(var_1_10007:getConfig("config_data")[2], arg_27_0) then
					table = var_1_10008

					var_1_10008.insert(var_27_0, var_1_10007)
				end
			end
		end
	end

	return var_27_0
end

function var_0_1.StaticEncoreActTip(arg_28_0)
	assert = var_1_10001

	var_1_10001(arg_28_0)

	ipairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(var_0_1.GetSkinCouponEncoreActivities()) do
		if var_0_1.GetSkinCouponActFromEncoreAct(iter_28_1) and not var_6:isEnd() and iter_28_1 and not iter_28_1:isEnd() and var_6:IncludeShop(arg_28_0) and var_6:GetCanUsageCnt() <= 0 and iter_28_1:getData1() > 0 then
			return iter_28_1
		end
	end

	return
end

function var_0_1.GetOvercountEncoreActs(arg_29_0)
	local var_29_0 = {}

	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(var_0_1.GetSkinCouponEncoreActivities(arg_29_0)) do
		SkinCouponActivity = var_1_10007

		if var_1_10007.GetSkinCouponActFromEncoreAct(iter_29_1) and not var_1_10007:isEnd() then
			local var_29_1, var_29_2 = var_1_10007:GetOwnCount()

			if var_1_10007:GetCanUsageCnt() + iter_29_1:getData1() + 1 > var_29_2 - var_29_1 - 1 then
				table = var_10

				var_10.insert(var_29_0, iter_29_1)
			end
		end
	end

	return var_29_0
end

function var_0_1.UseSkinCoupon(arg_30_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_30_0 = var_1_10001(var_1_10002)
	local var_30_1

	if not var_1.getActivityById(var_30_0, arg_30_0) then
		pg = var_30_0
		var_30_1 = var_30_0.TipsMgr.GetInstance()

		local var_30_2 = var_2.ShowTips

		i18n = var_1_10004

		var_30_2(var_30_1, var_1_10004("common_activity_end"))

		return
	end

	var_1.data2 = var_1.data2 + 1
	getProxy = var_2
	ActivityProxy = var_30_1

	local var_30_3 = var_2(var_30_1)

	var_2.updateActivity(var_30_3, var_1)

	return
end

return var_0_1
