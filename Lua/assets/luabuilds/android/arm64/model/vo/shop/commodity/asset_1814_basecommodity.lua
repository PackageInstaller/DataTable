local BaseCommodity = class("BaseCommodity", import("...BaseVO"))

function BaseCommodity:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.goods_id or arg_1_1.shop_id or arg_1_1.id
	self.configId = self.id
	self.discount = arg_1_1.discount or 100
	self.buyCount = arg_1_1.buy_count or arg_1_1.count or arg_1_1.pay_count or 0

	assert(arg_1_2, "type should exist")

	self.type = arg_1_2
	self.groupCount = arg_1_1.groupCount or 0

	return
end

function BaseCommodity:bindConfigTable()
	assert(false, "overwrite!!!")

	return
end

function BaseCommodity:GetPrice()
	assert(false, "overwrite!!!")

	return
end

function BaseCommodity:GetPurchasableCnt()
	assert(false, "overwrite!!!")

	return
end

function BaseCommodity:GetName()
	assert(false, "overwrite!!!")

	return
end

function BaseCommodity:GetDropList()
	assert(false, "overwrite!!!")

	return
end

function BaseCommodity:GetResType()
	assert(false, "overwrite!!!")

	return
end

function BaseCommodity:reduceBuyCount()
	self.buyCount = self.buyCount - 1

	return
end

function BaseCommodity:increaseBuyCount()
	self.buyCount = self.buyCount or 0
	self.buyCount = self.buyCount + 1

	return
end

function BaseCommodity:addBuyCount(arg_10_1)
	self.buyCount = self.buyCount + arg_10_1

	return
end

function BaseCommodity:canPurchase()
	return self.buyCount > 0
end

function BaseCommodity:hasDiscount()
	return self.discount < 100
end

function BaseCommodity:isFree()
	return self:getConfig("discount") == 100
end

function BaseCommodity:isTip()
	return false
end

function BaseCommodity:isDisCount()
	return false
end

function BaseCommodity:isChargeType()
	return false
end

function BaseCommodity:isGiftPackage()
	return self.type == Goods.TYPE_GIFT_PACKAGE
end

function BaseCommodity:isActGiftPackage()
	return self.type == Goods.TYPE_GIFT_PACKAGE_ACT
end

function BaseCommodity:isSham()
	return self.type == Goods.TYPE_SHAM_BATTLE
end

function BaseCommodity:IsActivityExtra()
	return self.type == Goods.TYPE_ACTIVITY_EXTRA
end

function BaseCommodity:getKey()
	return self.id .. "_" .. self.type
end

function BaseCommodity:getBuyCount()
	return self.buyCount or 0
end

function BaseCommodity:updateBuyCount(arg_23_1)
	self.buyCount = arg_23_1

	return
end

function BaseCommodity:updateGroupCount(arg_24_1)
	self.groupCount = arg_24_1

	return
end

function BaseCommodity:firstPayDouble()
	return false
end

function BaseCommodity:inTime()
	if self.type == Goods.TYPE_NEW_SERVER then
		local var_26_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)

		if var_26_0 and not var_26_0:isEnd() then
			return true, var_26_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime()
		else
			return false
		end
	end

	local var_26_1 = self:getConfig("time")

	if not var_26_1 then
		return true
	end

	if type(var_26_1) == "string" then
		return var_26_1 == "always"
	else
		local var_26_2, var_26_3 = self:getTimeStamp()

		if var_26_2 and var_26_3 then
			local var_26_4 = pg.TimeMgr.GetInstance():GetServerTime()

			return var_26_2 <= var_26_4 and var_26_4 <= var_26_3, var_26_3 - var_26_4
		else
			return true
		end
	end

	return
end

function BaseCommodity:getTimeStamp()
	local var_27_0 = self:getConfig("time")

	if var_27_0 and type(var_27_0) == "table" then
		local var_27_1
		local var_27_2

		if #var_27_0 > 0 then
			var_27_1 = pg.TimeMgr.GetInstance():ParseTimeEx(var_27_0[1][1][1] .. "-" .. var_27_0[1][1][2] .. "-" .. var_27_0[1][1][3] .. " " .. var_27_0[1][2][1] .. ":" .. var_27_0[1][2][2] .. ":" .. var_27_0[1][2][3], nil, true)
		end

		if #var_27_0 > 1 then
			var_27_2 = pg.TimeMgr.GetInstance():ParseTimeEx(var_27_0[2][1][1] .. "-" .. var_27_0[2][1][2] .. "-" .. var_27_0[2][1][3] .. " " .. var_27_0[2][2][1] .. ":" .. var_27_0[2][2][2] .. ":" .. var_27_0[2][2][3], nil, true)
		end

		if var_27_1 and var_27_2 then
			return var_27_1, var_27_2
		end
	end

	return
end

function BaseCommodity:calDayLeft()
	local var_28_0, var_28_1 = self:inTime()

	if var_28_0 and var_28_1 and var_28_1 > 0 then
		return var_28_0, pg.TimeMgr.GetInstance():parseTimeFrom(var_28_1) + 1
	end

	return
end

function BaseCommodity:GetGiftList()
	return {}
end

function BaseCommodity:GetName()
	assert(false, "overwrite me !!!!")

	return
end

function BaseCommodity:IsGroupLimit()
	assert(false, "overwrite me !!!!")

	return
end

function BaseCommodity:CanUseVoucherType()
	return false
end

function BaseCommodity:ExistExclusiveDiscountItem()
	return false
end

function BaseCommodity:StaticCanUseVoucherType(arg_34_1)
	return false
end

return BaseCommodity
