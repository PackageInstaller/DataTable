local RecommendCommodity = class("RecommendCommodity", import("model.vo.BaseVO"))
local var_0_1 = 1
local var_0_2 = 2

RecommendCommodity.PRICE_TYPE_RMB = 1
RecommendCommodity.PRICE_TYPE_RES = 2

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

function RecommendCommodity:Ctor(arg_4_1)
	self.id = arg_4_1.id
	self.configId = self.id
	self.commodity = self:GenCommodity(arg_4_1.chargedList, arg_4_1.normalList, arg_4_1.normalGroupList)

	return
end

function RecommendCommodity:GenCommodity(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self:getConfig("shop_type")
	local var_5_1 = Goods.Create({
		id = self:getConfig("shop_id")
	}, (var_0_3(var_5_0)))

	var_5_1:updateBuyCount((var_0_4(var_5_0, self:getConfig("shop_id"), arg_5_1, arg_5_2)))

	if not var_5_1:isChargeType() then
		var_5_1:updateGroupCount((var_0_5(var_5_0, var_5_1:getConfig("group"), arg_5_3)))
	end

	return var_5_1
end

function RecommendCommodity:bindConfigTable()
	return pg.recommend_shop
end

function RecommendCommodity:GetName()
	return self.commodity:GetName() or ""
end

function RecommendCommodity:GetDesc()
	if self.commodity:isChargeType() then
		if self.commodity:isMonthCard() then
			return i18n("monthly_card_tip")
		else
			return self.commodity:getConfig("descrip")
		end
	else
		return self.commodity:getDropInfo():getConfig("display")
	end

	return
end

function RecommendCommodity:GetDropList()
	if self.commodity:isChargeType() and self.commodity:isMonthCard() then
		return self.commodity:GetDropList()
	else
		return {}
	end

	return
end

function RecommendCommodity:GetGem()
	if self.commodity:isChargeType() then
		return self.commodity:GetGemCnt()
	else
		return 0
	end

	return
end

function RecommendCommodity:GetPrice()
	if self.commodity:isChargeType() then
		return RecommendCommodity.PRICE_TYPE_RMB, (self.commodity:getConfig("money"))
	else
		return RecommendCommodity.PRICE_TYPE_RES, self.commodity:GetPrice(), (self.commodity:GetResType())
	end

	return
end

function RecommendCommodity:GetIcon()
	local var_12_0 = self:getConfig("pic")

	if var_12_0 and var_12_0 ~= "" then
		return var_12_0
	elseif self.commodity:isChargeType() then
		return "ChargeIcon/" .. self.commodity:getConfig("picture")
	else
		return self.commodity:getDropInfo():getIcon() or ""
	end

	return
end

function RecommendCommodity:InTime()
	return pg.TimeMgr.GetInstance():inTime((self:getConfig("time")))
end

function RecommendCommodity:GetOrder()
	return self:getConfig("order")
end

function RecommendCommodity:CanPurchase()
	return self:InTime() and self.commodity:canPurchase() and self.commodity:inTime() and not (function(arg_16_0)
		if arg_16_0:isChargeType() then
			return false
		end

		return self.commodity:IsGroupLimit()
	end)(self.commodity)
end

function RecommendCommodity:CanShow()
	if self:IsMonthCard() then
		return true
	else
		return self:CanPurchase()
	end

	return
end

function RecommendCommodity:IsMonthCard()
	return self.commodity:isChargeType() and self.commodity:isMonthCard()
end

function RecommendCommodity:IsMonthCardAndCantPurchase()
	if self:IsMonthCard() then
		local var_19_0 = getProxy(PlayerProxy):getRawData():getCardById(VipCard.MONTH)

		if var_19_0 then
			if var_19_0:GetLeftDay() > (self.commodity:getConfig("limit_arg") or 0) then
				do return true, (i18n("charge_menu_month_tip", var_19_0:GetLeftDay())) end

				goto label_19_0
			end
		end

		return false
	end

	::label_19_0::

	return false
end

function RecommendCommodity:GetRealCommodity()
	return self.commodity
end

return RecommendCommodity
