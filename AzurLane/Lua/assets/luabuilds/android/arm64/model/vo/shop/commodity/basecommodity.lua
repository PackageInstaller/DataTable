class = var_0_10000

local var_0_0 = "BaseCommodity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_1.goods_id and not arg_1_1.shop_id then
		var_1_0 = arg_1_1.id
	end

	arg_1_0.id = var_1_0
	arg_1_0.configId = arg_1_0.id

	local var_1_1

	if not arg_1_1.discount then
		var_1_1 = 100
	end

	arg_1_0.discount = var_1_1

	local var_1_2

	if not arg_1_1.buy_count and not arg_1_1.count and not arg_1_1.pay_count then
		var_1_2 = 0
	end

	arg_1_0.buyCount = var_1_2
	assert = var_1_2

	var_1_2(arg_1_2, "type should exist")

	arg_1_0.type = arg_1_2

	local var_1_3

	if not arg_1_1.groupCount then
		var_1_3 = 0
	end

	arg_1_0.groupCount = var_1_3

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_1.GetPrice(arg_3_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_1.GetPurchasableCnt(arg_4_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_1.GetName(arg_5_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_1.GetDropList(arg_6_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_1.GetResType(arg_7_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_1.reduceBuyCount(arg_8_0)
	arg_8_0.buyCount = arg_8_0.buyCount - 1

	return
end

function var_0_1.increaseBuyCount(arg_9_0)
	if not arg_9_0.buyCount then
		arg_9_0.buyCount = 0
	end

	arg_9_0.buyCount = arg_9_0.buyCount + 1

	return
end

function var_0_1.addBuyCount(arg_10_0, arg_10_1)
	arg_10_0.buyCount = arg_10_0.buyCount + arg_10_1

	return
end

function var_0_1.canPurchase(arg_11_0)
	return arg_11_0.buyCount > 0
end

function var_0_1.hasDiscount(arg_12_0)
	return arg_12_0.discount < 100
end

function var_0_1.isFree(arg_13_0)
	return arg_13_0:getConfig("discount") == 100
end

function var_0_1.isTip(arg_14_0)
	return false
end

function var_0_1.isDisCount(arg_15_0)
	return false
end

function var_0_1.isChargeType(arg_16_0)
	return false
end

function var_0_1.isGiftPackage(arg_17_0)
	local var_17_0 = arg_17_0.type

	Goods = var_1_10002

	return var_17_0 == var_1_10002.TYPE_GIFT_PACKAGE
end

function var_0_1.isActGiftPackage(arg_18_0)
	local var_18_0 = arg_18_0.type

	Goods = var_1_10002

	return var_18_0 == var_1_10002.TYPE_GIFT_PACKAGE_ACT
end

function var_0_1.isSham(arg_19_0)
	local var_19_0 = arg_19_0.type

	Goods = var_1_10002

	return var_19_0 == var_1_10002.TYPE_SHAM_BATTLE
end

function var_0_1.IsActivityExtra(arg_20_0)
	local var_20_0 = arg_20_0.type

	Goods = var_1_10002

	return var_20_0 == var_1_10002.TYPE_ACTIVITY_EXTRA
end

function var_0_1.getKey(arg_21_0)
	return arg_21_0.id .. "_" .. arg_21_0.type
end

function var_0_1.getBuyCount(arg_22_0)
	local var_22_0

	if not arg_22_0.buyCount then
		var_22_0 = 0
	end

	return var_22_0
end

function var_0_1.updateBuyCount(arg_23_0, arg_23_1)
	arg_23_0.buyCount = arg_23_1

	return
end

function var_0_1.updateGroupCount(arg_24_0, arg_24_1)
	arg_24_0.groupCount = arg_24_1

	return
end

function var_0_1.firstPayDouble(arg_25_0)
	return false
end

function var_0_1.inTime(arg_26_0)
	local var_26_0 = arg_26_0.type

	Goods = var_1_10002

	local var_26_4

	if var_26_0 == var_1_10002.TYPE_NEW_SERVER then
		getProxy = var_26_0
		ActivityProxy = var_1_10003

		local var_26_1 = var_26_0(var_1_10003)
		local var_26_2 = var_1.getActivityByType

		ActivityConst = var_1_10004

		if var_26_2(var_26_1, var_1_10004.ACTIVITY_TYPE_NEWSERVER_GIFT) then
			local var_26_3 = var_1

			if not var_1.isEnd(var_26_3) then
				var_26_4 = true

				local var_26_5 = var_1.stopTime

				pg = var_26_3

				local var_26_6 = var_26_3.TimeMgr.GetInstance()

				do return var_26_4, var_26_5 - var_4.GetServerTime(var_26_6) end

				goto label_26_0
			end
		end

		return false
	end

	::label_26_0::

	if not arg_26_0:getConfig("time") then
		return true
	end

	type = var_26_4

	if var_26_4(var_1) == "string" then
		return var_1 == "always"
	else
		local var_26_7 = arg_26_0
		local var_26_8, var_26_9 = arg_26_0.getTimeStamp(var_26_7)

		if var_26_8 and var_26_9 then
			pg = var_26_7

			local var_26_10 = var_26_7.TimeMgr.GetInstance()

			return var_26_8 <= var_4.GetServerTime(var_26_10) and var_4 <= var_26_9, var_26_9 - var_4
		else
			return true
		end
	end

	return
end

function var_0_1.getTimeStamp(arg_27_0)
	if arg_27_0:getConfig("time") then
		type = var_1_10002

		if var_1_10002(var_1) == "table" then
			local var_27_0
			local var_27_1

			if #var_1 > 0 then
				local var_27_2 = var_1[1][1][1] .. "-" .. var_1[1][1][2] .. "-" .. var_1[1][1][3] .. " " .. var_1[1][2][1] .. ":" .. var_1[1][2][2] .. ":" .. var_1[1][2][3]

				pg = var_5

				local var_27_3 = var_5.TimeMgr.GetInstance()

				var_27_0 = var_5.ParseTimeEx(var_27_3, var_27_2, nil, true)
			end

			if #var_1 > 1 then
				local var_27_4 = var_1[2][1][1] .. "-" .. var_1[2][1][2] .. "-" .. var_1[2][1][3] .. " " .. var_1[2][2][1] .. ":" .. var_1[2][2][2] .. ":" .. var_1[2][2][3]

				pg = var_5

				local var_27_5 = var_5.TimeMgr.GetInstance()

				var_27_1 = var_5.ParseTimeEx(var_27_5, var_27_4, nil, true)
			end

			if var_27_0 and var_27_1 then
				return var_27_0, var_27_1
			end
		end
	end

	return
end

function var_0_1.calDayLeft(arg_28_0)
	local var_28_0, var_28_1 = arg_28_0:inTime()

	if var_28_0 and var_28_1 and 0 < var_28_1 then
		pg = var_3

		local var_28_2 = var_3.TimeMgr.GetInstance()
		local var_28_3 = var_3.parseTimeFrom(var_28_2, var_28_1)

		return var_28_0, var_28_3 + 1
	end

	return
end

function var_0_1.GetGiftList(arg_29_0)
	return {}
end

function var_0_1.GetName(arg_30_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!!")

	return
end

function var_0_1.IsGroupLimit(arg_31_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!!")

	return
end

function var_0_1.CanUseVoucherType(arg_32_0)
	return false
end

function var_0_1.ExistExclusiveDiscountItem(arg_33_0)
	return false
end

function var_0_1.StaticCanUseVoucherType(arg_34_0, arg_34_1)
	return false
end

return var_0_1
