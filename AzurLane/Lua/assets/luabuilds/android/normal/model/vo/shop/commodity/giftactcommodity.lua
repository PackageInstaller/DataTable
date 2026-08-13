class = var_0_10000

local var_0_0 = "GiftActCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CommonCommodity"))

function var_0_1.canPurchase(arg_1_0)
	assert = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.getConfig(var_1_0, "genre")

	ShopArgs = var_1_0

	var_1_10001(var_1_1 == var_1_0.GiftActPackage)

	if not arg_1_0:getBindActivity() or var_1:isEnd() then
		return false
	end

	local var_1_2

	if not var_1.data1 then
		var_1_2 = 0
	end

	return var_1_2 < arg_1_0:getLimitCount()
end

function var_0_1.getBindActivity(arg_2_0)
	assert = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getConfig(var_2_0, "genre")

	ShopArgs = var_2_0

	var_1_10001(var_2_1 == var_2_0.GiftActPackage)

	local var_2_2 = arg_2_0:getDropInfo()
	local var_2_3 = var_1.getConfig(var_2_2, "link_id")

	getProxy = var_2_2
	ActivityProxy = var_3

	local var_2_4 = var_2_2(var_3)

	return var_2.getActivityById(var_2_4, var_2_3)
end

function var_0_1.GetPrice(arg_3_0)
	local var_3_0 = arg_3_0:getBindActivity()

	return var_0_1.CalcPrice(var_3_0)
end

function var_0_1.getLimitCount(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getBindActivity(var_4_0)

	switch = var_4_0

	local var_4_2 = var_4_1:getConfig("type")
	local var_4_3 = {}

	ActivityConst = var_5
	var_4_3[var_5.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
		return 1
	end
	ActivityConst = var_5
	var_4_3[var_5.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.activity_giftpackage
		local var_6_1 = var_4_1
		local var_6_2 = var_6_0[var_1.getConfig(var_6_1, "config_id")]

		assert = var_1

		var_1(var_6_2)

		local var_6_3

		if not var_4_1.data1 then
			var_6_3 = 0
		end

		getProxy = var_2
		ShipSkinProxy = var_3

		local var_6_4 = var_2(var_3)

		ipairs = var_3

		for iter_6_0, iter_6_1 in var_3(var_6_2.skin) do
			if not var_6_4:hasNonLimitSkin(iter_6_1) then
				var_6_3 = var_6_3 + 1
			end
		end

		math = var_3

		return var_3.min(var_6_3, var_6_2.limit_count)
	end

	return var_4_0(var_4_2, var_4_3, function()
		assert = var_2_10000

		var_2_10000(false)

		return
	end)
end

function var_0_1.getBuyCount(arg_8_0)
	local var_8_0

	if not arg_8_0:getBindActivity() or var_1:isEnd() or not var_1.data1 then
		var_8_0 = 0
	end

	return var_8_0
end

function var_0_1.isFree(arg_9_0)
	return arg_9_0:GetPrice() == 0
end

function var_0_1.CalcPrice(arg_10_0)
	switch = var_1_10001

	local var_10_0 = arg_10_0:getConfig("type")
	local var_10_1 = {}

	ActivityConst = var_4
	var_10_1[var_4.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
		local var_11_0 = 0
		local var_11_1 = 0

		ipairs = var_2_10002

		local var_11_2 = arg_10_0

		for iter_11_0, iter_11_1 in var_2_10002(var_3.getConfig(var_11_2, "config_data")[1]) do
			pg = var_2_10007
			var_2_10007 = var_2_10007.ship_skin_template[iter_11_1].shop_id
			assert = var_2_10008

			var_2_10008(var_2_10007 and var_2_10007 > 0)

			Goods = var_2_10008
			var_2_10008 = var_2_10008.Create

			local var_11_3 = {
				shop_id = var_2_10007
			}

			Goods = var_2_10010
			var_2_10010 = var_2_10008(var_11_3, var_2_10010.TYPE_SKIN)
			var_11_1 = var_11_1 + var_2_10008.getConfig(var_2_10010, "resource_num")
			getProxy = var_9
			ShipSkinProxy = var_2_10010
			var_2_10010 = var_9(var_2_10010)

			if not var_9.hasNonLimitSkin(var_2_10010, iter_11_1) then
				var_2_10010 = var_2_10008
				var_11_0 = var_11_0 + var_2_10008.getConfig(var_2_10010, "resource_num")
			end
		end

		local var_11_4 = (var_11_1 - var_11_0) * 100 / var_11_1

		return var_11_0, var_11_4, var_11_1
	end
	ActivityConst = var_4
	var_10_1[var_4.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.activity_giftpackage
		local var_12_1 = arg_10_0
		local var_12_2 = var_12_0[var_1.getConfig(var_12_1, "config_id")]

		assert = var_1

		var_1(var_12_2)

		return var_12_2.price, 0, var_1
	end

	return var_1_10001(var_10_0, var_10_1, function()
		assert = var_2_10000

		var_2_10000(false)

		return
	end)
end

return var_0_1
