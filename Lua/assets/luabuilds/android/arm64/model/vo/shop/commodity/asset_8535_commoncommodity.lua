local CommonCommodity = class("CommonCommodity", import(".BaseCommodity"))

function CommonCommodity:InCommodityDiscountTime()
	if pg.shop_template[self].discount_time == "always" then
		return true
	end

	if type(pg.shop_template[self].discount_time) == "table" then
		return table.getCount(pg.shop_template[self].discount_time) == 0 or pg.TimeMgr.GetInstance():inTime(pg.shop_template[self].discount_time)
	end

	return false
end

function CommonCommodity:bindConfigTable()
	return pg.shop_template
end

function CommonCommodity:canPurchase()
	if self.type == Goods.TYPE_MILITARY then
		return self:getBuyCount() == 0
	elseif self.type == Goods.TYPE_GIFT_PACKAGE or self.type == Goods.TYPE_SKIN or self.type == Goods.TYPE_WORLD or self.type == Goods.TYPE_NEW_SERVER then
		local var_3_0 = self:getLimitCount()

		return var_3_0 <= 0 or var_3_0 > self:getBuyCount()
	elseif self.type == Goods.TYPE_CRUISE then
		return self:getLimitCount() - self:GetOwnedCnt() > 0
	else
		return CommonCommodity.super.canPurchase(self)
	end

	return
end

function CommonCommodity:isDisCount()
	if self:IsItemDiscountType() then
		return true
	else
		return self:getConfig("discount") ~= 0 and CommonCommodity.InCommodityDiscountTime(self.id)
	end

	return
end

function CommonCommodity:GetDiscountEndTime()
	local var_5_0, var_5_1 = unpack((self:getConfig("discount_time")))
	local var_5_2, var_5_3, var_5_4 = unpack(var_5_1[1])

	return (pg.TimeMgr.GetInstance():Table2ServerTime({
		year = var_5_2,
		month = var_5_3,
		day = var_5_4,
		hour = var_5_1[2][1],
		min = var_5_1[2][2],
		sec = var_5_1[2][3]
	}))
end

function CommonCommodity:IsGroupSale()
	return self.type == Goods.TYPE_MILITARY and self:getConfig("group") > 0 and self:getConfig("limit_args2")[1][1] == "purchase"
end

function CommonCommodity:IsShowWhenGroupSale(arg_7_1)
	if self:IsGroupSale() then
		local var_7_0 = self:getConfig("limit_args2")[1]
		local var_7_1 = var_7_0[2]
		local var_7_2 = var_7_0[3]

		if arg_7_1 == var_7_0[3] and var_7_2 == self:getConfig("group_limit") then
			return true
		end

		arg_7_1 = arg_7_1 + 1

		return var_7_1 <= arg_7_1 and arg_7_1 <= var_7_2
	end

	return true
end

function CommonCommodity:GetOwnedCnt()
	return self:getDropInfo():getOwnedCount()
end

function CommonCommodity:GetPrice()
	local var_9_0 = self:getConfig("resource_num")
	local var_9_1 = 0

	if self:isDisCount() then
		if self:IsItemDiscountType() then
			var_9_0 = SkinCouponActivity.GetBestReadySkinCouponAct(self.id):GetNewPrice(var_9_0)
			var_9_1 = (var_9_0 - var_9_0) * 100 / var_9_0
		else
			var_9_1 = self:getConfig("discount")
			var_9_0 = var_9_0 * (100 - var_9_1) / 100
		end
	end

	return var_9_0, var_9_1, var_9_0
end

function CommonCommodity:GetName()
	return self:getDropInfo():getName()
end

function CommonCommodity:GetResType()
	return self:getConfig("resource_type")
end

function CommonCommodity:GetResIcon()
	local var_12_0 = self:GetResType()

	if var_12_0 == 4 or var_12_0 == 14 then
		return "diamond"
	elseif var_12_0 == 1 then
		return "gold"
	end

	return
end

function CommonCommodity:GetConsume()
	return Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = self:GetResType(),
		count = self:GetPrice()
	})
end

function CommonCommodity:IsItemDiscountType()
	return self:getConfig("genre") == ShopArgs.SkinShop and SkinCouponActivity.StaticExistActivityAndCoupon(self.id)
end

function CommonCommodity:CanUseVoucherType()
	return self:StaticCanUseVoucherType((getProxy(BagProxy):GetSkinShopDiscountItemList()))
end

function CommonCommodity:ExistExclusiveDiscountItem()
	return #getProxy(BagProxy):GetExclusiveDiscountItem4Shop(self.id) > 0
end

function CommonCommodity:StaticCanUseVoucherType(arg_17_1)
	if #arg_17_1 <= 0 then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if iter_17_1:CanUseForShop(self.id) then
			return true
		end
	end

	return false
end

function CommonCommodity:GetVoucherIdList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs((getProxy(BagProxy):GetSkinShopDiscountItemList())) do
		if iter_18_1:CanUseForShop(self.id) then
			table.insert(var_18_0, iter_18_1.id)
		end
	end

	return var_18_0
end

function CommonCommodity:getLimitCount()
	for iter_19_0, iter_19_1 in ipairs(self:getConfig("limit_args") or {}) do
		if iter_19_1[1] == "time" then
			return iter_19_1[2]
		end
	end

	return 0
end

function CommonCommodity:GetDiscountItem()
	if self:IsItemDiscountType() then
		return SkinCouponActivity.StaticGetItemConfig(self.id)
	end

	return nil
end

function CommonCommodity:isLevelLimit(arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = self:getLevelLimit()

	if arg_21_2 and var_21_1 then
		return false
	end

	return var_21_0 > 0 and arg_21_1 < var_21_0
end

function CommonCommodity:getLevelLimit()
	for iter_22_0, iter_22_1 in ipairs((self:getConfig("limit_args"))) do
		if type(iter_22_1) == "table" and iter_22_1[1] == "level" then
			return iter_22_1[2], iter_22_1[3]
		end
	end

	return 0
end

function CommonCommodity:getSkinId()
	if self.type == Goods.TYPE_SKIN then
		return self:getConfig("effect_args")[1]
	end

	assert(false)

	return
end

function CommonCommodity:getDropInfo()
	return Drop.New((switch(self:getConfig("effect_args"), {
		ship_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SHIP_BAG_SIZE_ITEM
			}
		end,
		equip_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.EQUIP_BAG_SIZE_ITEM
			}
		end,
		commander_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.COMMANDER_BAG_SIZE_ITEM
			}
		end,
		spweapon_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SPWEAPON_BAG_SIZE_ITEM
			}
		end,
		ship_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SHIP_BAG_SIZE_ITEM
			}
		end,
		ship_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SHIP_BAG_SIZE_ITEM
			}
		end
	}, function()
		if self:getConfig("genre") == ShopArgs.WorldCollection then
			return {
				type = DROP_TYPE_WORLD_ITEM,
				id = self:getConfig("effect_args")[1],
				count = self:getConfig("num")
			}
		elseif self:getConfig("genre") == ShopArgs.CruiseSkin then
			return {
				type = DROP_TYPE_SKIN,
				id = self:getConfig("effect_args")[1],
				count = self:getConfig("num")
			}
		elseif self:getConfig("genre") == ShopArgs.CruiseGearSkin then
			return {
				type = DROP_TYPE_EQUIPMENT_SKIN,
				id = self:getConfig("effect_args")[1],
				count = self:getConfig("num")
			}
		else
			return {
				type = self:getConfig("type"),
				id = self:getConfig("effect_args")[1],
				count = self:getConfig("num")
			}
		end

		return
	end)))
end

function CommonCommodity:GetDropList()
	local var_32_0 = {}
	local var_32_1 = Item.getConfigData(self:getConfig("effect_args")[1]).display_icon

	if type(var_32_1) == "table" then
		for iter_32_0, iter_32_1 in ipairs(var_32_1) do
			table.insert(var_32_0, {
				type = iter_32_1[1],
				id = iter_32_1[2],
				count = iter_32_1[3]
			})
		end
	end

	return var_32_0
end

function CommonCommodity:IsGroupLimit()
	if self:getConfig("group") <= 0 then
		return false
	end

	local var_33_0 = self:getConfig("group_limit")
	local var_33_2

	if var_33_0 > 0 then
		if var_33_0 > (self.groupCount or 0) then
			var_33_2 = false

			goto label_33_0
		end
	end

	::label_33_0::

	return true
end

function CommonCommodity:GetLimitDesc()
	local var_34_0 = self:getLimitCount()

	if var_34_0 > 0 then
		return i18n("charge_limit_all", var_34_0 - self:getBuyCount(), var_34_0)
	end

	local var_34_1 = self:getConfig("group_limit")

	if var_34_1 > 0 then
		local var_34_2 = self:getConfig("group_type") or 0

		if var_34_2 == 1 then
			return i18n("charge_limit_daily", var_34_1 - self.groupCount, var_34_1)
		elseif var_34_2 == 2 then
			return i18n("charge_limit_weekly", var_34_1 - self.groupCount, var_34_1)
		elseif var_34_2 == 3 then
			return i18n("charge_limit_monthly", var_34_1 - self.groupCount, var_34_1)
		end
	end

	return ""
end

function CommonCommodity:GetGiftList()
	if self:getConfig("genre") == ShopArgs.SkinShop then
		return ShipSkin.New({
			id = self:getSkinId()
		}):GetRewardList()
	else
		return CommonCommodity.super.GetGiftList(self)
	end

	return
end

function CommonCommodity:GetPackageTag()
	if self:getConfig("genre") ~= ShopArgs.GiftPackage or self:getConfig("package_tag_open") == 0 then
		return ""
	else
		return self:getConfig("package_tag")
	end

	return
end

function CommonCommodity:isTip()
	if self:isGiftPackage() or self:isActGiftPackage() then
		local var_37_0 = self:getConfig("akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"
		local var_37_1, var_37_2 = unpack(getGameset(var_37_0))

		if PlayerPrefs.GetInt(var_37_0, 0) ~= var_37_1 and table.contains(var_37_2[1], self.id) then
			return true
		end

		return self:isFree()
	end

	return
end

return CommonCommodity
