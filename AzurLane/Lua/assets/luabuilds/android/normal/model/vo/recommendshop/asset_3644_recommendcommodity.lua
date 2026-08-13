class = var_0_10000

local var_0_0 = "RecommendCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))
local var_0_2 = 1
local var_0_3 = 2

var_0_1.PRICE_TYPE_RMB = 1
var_0_1.PRICE_TYPE_RES = 2

local function var_0_4(arg_1_0)
	local var_1_0

	if arg_1_0 == var_0_2 then
		Goods = var_2
		var_1_0 = var_2.TYPE_CHARGE
	elseif arg_1_0 == var_0_3 then
		Goods = var_2
		var_1_0 = var_2.TYPE_GIFT_PACKAGE
	end

	assert = var_2

	var_2(var_1_0)

	return var_1_0
end

local function var_0_5(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	if arg_2_0 == var_0_2 then
		var_2_0 = arg_2_2
	elseif arg_2_0 == var_0_3 then
		var_2_0 = arg_2_3
	end

	ChargeConst = var_5

	return (var_5.getBuyCount(var_2_0, arg_2_1))
end

local function var_0_6(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0 == var_0_2 then
		return 0
	elseif arg_3_0 == var_0_3 then
		ChargeConst = var_3

		return (var_3.getGroupLimit(arg_3_2, arg_3_1 or 0))
	end

	return
end

function var_0_1.Ctor(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1.id
	arg_4_0.configId = arg_4_0.id
	arg_4_0.commodity = arg_4_0:GenCommodity(arg_4_1.chargedList, arg_4_1.normalList, arg_4_1.normalGroupList)

	return
end

function var_0_1.GenCommodity(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:getConfig("shop_type")
	local var_5_1 = arg_5_0:getConfig("shop_id")
	local var_5_2 = var_0_4(var_5_0)

	Goods = var_7

	local var_5_3 = var_7.Create({
		id = var_5_1
	}, var_5_2)
	local var_5_4 = var_0_5(var_5_0, arg_5_0:getConfig("shop_id"), arg_5_1, arg_5_2)

	var_5_3:updateBuyCount(var_5_4)

	if not var_5_3:isChargeType() then
		local var_5_5 = var_0_6(var_5_0, var_5_3:getConfig("group"), arg_5_3)

		var_5_3:updateGroupCount(var_5_5)
	end

	return var_5_3
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.recommend_shop
end

function var_0_1.GetName(arg_7_0)
	local var_7_0 = arg_7_0.commodity
	local var_7_1

	if not var_1.GetName(var_7_0) then
		var_7_1 = ""
	end

	return var_7_1
end

function var_0_1.GetDesc(arg_8_0)
	local var_8_0 = arg_8_0.commodity

	if var_1.isChargeType(var_8_0) then
		local var_8_1 = arg_8_0.commodity

		if var_1.isMonthCard(var_8_1) then
			i18n = var_1

			return var_1("monthly_card_tip")
		else
			local var_8_2 = arg_8_0.commodity

			return var_1.getConfig(var_8_2, "descrip")
		end
	else
		local var_8_3 = arg_8_0.commodity
		local var_8_4 = var_1.getDropInfo(var_8_3)

		return var_1.getConfig(var_8_4, "display")
	end

	return
end

function var_0_1.GetDropList(arg_9_0)
	local var_9_0 = arg_9_0.commodity

	if var_1.isChargeType(var_9_0) then
		local var_9_1 = arg_9_0.commodity

		if var_1.isMonthCard(var_9_1) then
			local var_9_2 = arg_9_0.commodity

			do return var_1.GetDropList(var_9_2) end

			goto label_9_0
		end
	end

	do return {} end

	::label_9_0::

	return
end

function var_0_1.GetGem(arg_10_0)
	local var_10_0 = arg_10_0.commodity

	if var_1.isChargeType(var_10_0) then
		local var_10_1 = arg_10_0.commodity

		return var_1.GetGemCnt(var_10_1)
	else
		return 0
	end

	return
end

function var_0_1.GetPrice(arg_11_0)
	local var_11_0 = arg_11_0.commodity

	if var_1.isChargeType(var_11_0) then
		local var_11_1 = arg_11_0.commodity
		local var_11_2 = var_1.getConfig(var_11_1, "money")

		return var_0_1.PRICE_TYPE_RMB, var_11_2
	else
		local var_11_3 = arg_11_0.commodity
		local var_11_4 = var_1.GetPrice(var_11_3)
		local var_11_5 = arg_11_0.commodity
		local var_11_6 = var_2.GetResType(var_11_5)

		return var_0_1.PRICE_TYPE_RES, var_11_4, var_11_6
	end

	return
end

function var_0_1.GetIcon(arg_12_0)
	if arg_12_0:getConfig("pic") and var_1 ~= "" then
		return var_1
	else
		local var_12_0 = arg_12_0.commodity

		if var_2.isChargeType(var_12_0) then
			local var_12_1 = arg_12_0.commodity
			local var_12_2 = var_2.getConfig(var_12_1, "picture")

			return "ChargeIcon/" .. var_12_2
		else
			local var_12_3 = arg_12_0.commodity
			local var_12_4 = var_2.getDropInfo(var_12_3)
			local var_12_5

			if not var_2.getIcon(var_12_4) then
				var_12_5 = ""
			end

			return var_12_5
		end
	end

	return
end

function var_0_1.InTime(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.getConfig(var_13_0, "time")

	pg = var_13_0

	local var_13_2 = var_13_0.TimeMgr.GetInstance()

	return var_2.inTime(var_13_2, var_13_1)
end

function var_0_1.GetOrder(arg_14_0)
	return arg_14_0:getConfig("order")
end

function var_0_1.CanPurchase(arg_15_0)
	local function var_15_0(arg_16_0)
		if arg_16_0:isChargeType() then
			return false
		end

		local var_16_0 = arg_15_0.commodity

		return var_1.IsGroupLimit(var_16_0)
	end

	local var_15_3

	if arg_15_0:InTime() then
		local var_15_1 = arg_15_0.commodity

		if var_2.canPurchase(var_15_1) then
			local var_15_2 = arg_15_0.commodity

			if var_2.inTime(var_15_2) then
				var_15_3 = not var_15_0(arg_15_0.commodity)
			end
		end
	end

	return var_15_3
end

function var_0_1.CanShow(arg_17_0)
	if arg_17_0:IsMonthCard() then
		return true
	else
		return arg_17_0:CanPurchase()
	end

	return
end

function var_0_1.IsMonthCard(arg_18_0)
	local var_18_0 = arg_18_0.commodity
	local var_18_2

	if var_1.isChargeType(var_18_0) then
		local var_18_1 = arg_18_0.commodity

		var_18_2 = var_1.isMonthCard(var_18_1)
	end

	return var_18_2
end

function var_0_1.IsMonthCardAndCantPurchase(arg_19_0)
	local var_19_0 = arg_19_0

	if arg_19_0.IsMonthCard(var_19_0) then
		getProxy = var_1
		PlayerProxy = var_19_0

		local var_19_1 = var_1(var_19_0)
		local var_19_2 = var_1.getRawData(var_19_1)
		local var_19_3 = var_1.getCardById

		VipCard = var_1_10004

		if var_19_3(var_19_2, var_1_10004.MONTH) then
			local var_19_4 = var_2:GetLeftDay()
			local var_19_5 = arg_19_0.commodity
			local var_19_6

			if not var_4.getConfig(var_19_5, "limit_arg") then
				var_19_6 = 0
			end

			if var_19_6 < var_19_4 then
				i18n = var_19_4

				local var_19_7 = var_19_4("charge_menu_month_tip", var_2:GetLeftDay())

				do return true, var_19_7 end

				goto label_19_0
			end
		end

		return false
	end

	::label_19_0::

	return false
end

function var_0_1.GetRealCommodity(arg_20_0)
	return arg_20_0.commodity
end

return var_0_1
