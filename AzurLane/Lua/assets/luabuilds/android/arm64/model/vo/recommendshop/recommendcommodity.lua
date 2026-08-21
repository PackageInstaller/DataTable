local var_0_0 = class("RecommendCommodity", import("model.vo.BaseVO"))
local var_0_1 = 1
local var_0_2 = 2

var_0_0.PRICE_TYPE_RMB = 1
var_0_0.PRICE_TYPE_RES = 2

local function var_0_3(arg_1_0)
	local var_1_0

	if arg_1_0 == var_0_1 then
		var_1_0 = Goods.TYPE_CHARGE
	elseif arg_1_0 == var_0_2 then
		var_1_0 = Goods.TYPE_GIFT_PACKAGE
	end

	assert(var_1_0)

	return var_1_0
end

local function var_0_4(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	if arg_2_0 == var_0_1 then
		var_2_0 = arg_2_2
	elseif arg_2_0 == var_0_2 then
		var_2_0 = arg_2_3
	end

	return (ChargeConst.getBuyCount(var_2_0, arg_2_1))
end

local function var_0_5(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0 == var_0_1 then
		return 0
	elseif arg_3_0 == var_0_2 then
		return (ChargeConst.getGroupLimit(arg_3_2, arg_3_1 or 0))
	end

	return
end

function var_0_0.Ctor(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1.id
	arg_4_0.configId = arg_4_0.id
	arg_4_0.commodity = arg_4_0:GenCommodity(arg_4_1.chargedList, arg_4_1.normalList, arg_4_1.normalGroupList)

	return
end

function var_0_0.GenCommodity(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:getConfig("shop_type")
	local var_5_1 = Goods.Create({
		id = arg_5_0:getConfig("shop_id")
	}, (var_0_3(var_5_0)))

	var_5_1:updateBuyCount((var_0_4(var_5_0, arg_5_0:getConfig("shop_id"), arg_5_1, arg_5_2)))

	if not var_5_1:isChargeType() then
		var_5_1:updateGroupCount((var_0_5(var_5_0, var_5_1:getConfig("group"), arg_5_3)))
	end

	return var_5_1
end

function var_0_0.bindConfigTable(arg_6_0)
	return pg.recommend_shop
end

function var_0_0.GetName(arg_7_0)
	return arg_7_0.commodity:GetName() or ""
end

function var_0_0.GetDesc(arg_8_0)
	if arg_8_0.commodity:isChargeType() then
		if arg_8_0.commodity:isMonthCard() then
			return i18n("monthly_card_tip")
		else
			return arg_8_0.commodity:getConfig("descrip")
		end
	else
		return arg_8_0.commodity:getDropInfo():getConfig("display")
	end

	return
end

function var_0_0.GetDropList(arg_9_0)
	if arg_9_0.commodity:isChargeType() and arg_9_0.commodity:isMonthCard() then
		return arg_9_0.commodity:GetDropList()
	else
		return {}
	end

	return
end

function var_0_0.GetGem(arg_10_0)
	if arg_10_0.commodity:isChargeType() then
		return arg_10_0.commodity:GetGemCnt()
	else
		return 0
	end

	return
end

function var_0_0.GetPrice(arg_11_0)
	if arg_11_0.commodity:isChargeType() then
		return var_0_0.PRICE_TYPE_RMB, (arg_11_0.commodity:getConfig("money"))
	else
		return var_0_0.PRICE_TYPE_RES, arg_11_0.commodity:GetPrice(), (arg_11_0.commodity:GetResType())
	end

	return
end

function var_0_0.GetIcon(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("pic")

	if var_12_0 and var_12_0 ~= "" then
		return var_12_0
	elseif arg_12_0.commodity:isChargeType() then
		return "ChargeIcon/" .. arg_12_0.commodity:getConfig("picture")
	else
		local var_12_1 = arg_12_0.commodity:getDropInfo()

		return var_12_1:getIcon() or ""
	end

	return
end

function var_0_0.InTime(arg_13_0)
	return pg.TimeMgr.GetInstance():inTime((arg_13_0:getConfig("time")))
end

function var_0_0.GetOrder(arg_14_0)
	return arg_14_0:getConfig("order")
end

function var_0_0.CanPurchase(arg_15_0)
	return arg_15_0:InTime() and arg_15_0.commodity:canPurchase() and arg_15_0.commodity:inTime() and not (function(arg_16_0)
		if arg_16_0:isChargeType() then
			return false
		end

		return arg_15_0.commodity:IsGroupLimit()
	end)(arg_15_0.commodity)
end

function var_0_0.CanShow(arg_17_0)
	if arg_17_0:IsMonthCard() then
		return true
	else
		return arg_17_0:CanPurchase()
	end

	return
end

function var_0_0.IsMonthCard(arg_18_0)
	return arg_18_0.commodity:isChargeType() and arg_18_0.commodity:isMonthCard()
end

function var_0_0.IsMonthCardAndCantPurchase(arg_19_0)
	if arg_19_0:IsMonthCard() then
		local var_19_0 = getProxy(PlayerProxy):getRawData():getCardById(VipCard.MONTH)

		if var_19_0 then
			local var_19_1 = arg_19_0.commodity:getConfig("limit_arg") or 0

			if var_19_0:GetLeftDay() > var_19_1 then
				do return true, (i18n("charge_menu_month_tip", var_19_0:GetLeftDay())) end

				goto label_19_0
			end
		end

		return false
	end

	::label_19_0::

	return false
end

function var_0_0.GetRealCommodity(arg_20_0)
	return arg_20_0.commodity
end

return var_0_0
