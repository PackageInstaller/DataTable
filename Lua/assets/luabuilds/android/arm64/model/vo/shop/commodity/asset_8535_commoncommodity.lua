local CommonCommodity = class("CommonCommodity", import(".BaseCommodity"))

function CommonCommodity:InCommodityDiscountTime()
	local var_1_0 = ShopConst.GetShopConfig(self).discount_time

	if var_1_0 == "always" then
		return true
	end

	if type(var_1_0) == "table" then
		return table.getCount(var_1_0) == 0 or pg.TimeMgr.GetInstance():inTime(var_1_0)
	end

	return false
end

function CommonCommodity:bindConfigTable()
	return setmetatable({}, {
		__index = function(self, arg_3_1)
			self[arg_3_1] = ShopConst.GetShopConfig(arg_3_1)

			return self[arg_3_1]
		end
	})
end

function CommonCommodity:canPurchase()
	if self.type == Goods.TYPE_MILITARY then
		return self:getBuyCount() == 0
	elseif self.type == Goods.TYPE_GIFT_PACKAGE or self.type == Goods.TYPE_SKIN or self.type == Goods.TYPE_WORLD or self.type == Goods.TYPE_NEW_SERVER then
		local var_4_0 = self:getLimitCount()

		return var_4_0 <= 0 or var_4_0 > self:getBuyCount()
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
	local var_6_0, var_6_1 = unpack((self:getConfig("discount_time")))
	local var_6_2, var_6_3, var_6_4 = unpack(var_6_1[1])

	return (pg.TimeMgr.GetInstance():Table2ServerTime({
		year = var_6_2,
		month = var_6_3,
		day = var_6_4,
		hour = var_6_1[2][1],
		min = var_6_1[2][2],
		sec = var_6_1[2][3]
	}))
end

function CommonCommodity:IsGroupSale()
	return self.type == Goods.TYPE_MILITARY and self:getConfig("group") > 0 and self:getConfig("limit_args2")[1][1] == "purchase"
end

function CommonCommodity:IsShowWhenGroupSale(arg_8_1)
	if self:IsGroupSale() then
		local var_8_0 = self:getConfig("limit_args2")[1]
		local var_8_1 = var_8_0[2]
		local var_8_2 = var_8_0[3]

		if arg_8_1 == var_8_0[3] and var_8_2 == self:getConfig("group_limit") then
			return true
		end

		arg_8_1 = arg_8_1 + 1

		return var_8_1 <= arg_8_1 and arg_8_1 <= var_8_2
	end

	return true
end

function CommonCommodity:GetOwnedCnt()
	return self:getDropInfo():getOwnedCount()
end

function CommonCommodity:GetPrice()
	local var_10_0 = self:getConfig("resource_num")
	local var_10_1 = 0

	if self:isDisCount() then
		if self:IsItemDiscountType() then
			var_10_0 = SkinCouponActivity.GetBestReadySkinCouponAct(self.id):GetNewPrice(var_10_0)
			var_10_1 = (var_10_0 - var_10_0) * 100 / var_10_0
		else
			var_10_1 = self:getConfig("discount")
			var_10_0 = var_10_0 * (100 - var_10_1) / 100
		end
	end

	return var_10_0, var_10_1, var_10_0
end

function CommonCommodity:GetName()
	return self:getDropInfo():getName()
end

function CommonCommodity:GetResType()
	return self:getConfig("resource_type")
end

function CommonCommodity:GetResIcon()
	local var_13_0 = self:GetResType()

	if var_13_0 == 4 or var_13_0 == 14 then
		return "diamond"
	elseif var_13_0 == 1 then
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

function CommonCommodity:StaticCanUseVoucherType(arg_18_1)
	if #arg_18_1 <= 0 then
		return false
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1:CanUseForShop(self.id) then
			return true
		end
	end

	return false
end

function CommonCommodity:GetVoucherIdList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs((getProxy(BagProxy):GetSkinShopDiscountItemList())) do
		if iter_19_1:CanUseForShop(self.id) then
			table.insert(var_19_0, iter_19_1.id)
		end
	end

	return var_19_0
end

function CommonCommodity:getLimitCount()
	for iter_20_0, iter_20_1 in ipairs(self:getConfig("limit_args") or {}) do
		if iter_20_1[1] == "time" then
			return iter_20_1[2]
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

function CommonCommodity:isLevelLimit(arg_22_1, arg_22_2)
	local var_22_0, var_22_1 = self:getLevelLimit()

	if arg_22_2 and var_22_1 then
		return false
	end

	return var_22_0 > 0 and arg_22_1 < var_22_0
end

function CommonCommodity:getLevelLimit()
	for iter_23_0, iter_23_1 in ipairs((self:getConfig("limit_args"))) do
		if type(iter_23_1) == "table" and iter_23_1[1] == "level" then
			return iter_23_1[2], iter_23_1[3]
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
	local var_33_0 = {}
	local var_33_1 = Item.getConfigData(self:getConfig("effect_args")[1]).display_icon

	if type(var_33_1) == "table" then
		for iter_33_0, iter_33_1 in ipairs(var_33_1) do
			table.insert(var_33_0, {
				type = iter_33_1[1],
				id = iter_33_1[2],
				count = iter_33_1[3]
			})
		end
	end

	return var_33_0
end

function CommonCommodity:IsGroupLimit()
	if self:getConfig("group") <= 0 then
		return false
	end

	local var_34_0 = self:getConfig("group_limit")
	local var_34_2

	if var_34_0 > 0 then
		if var_34_0 > (self.groupCount or 0) then
			var_34_2 = false

			goto label_34_0
		end
	end

	::label_34_0::

	return true
end

function CommonCommodity:GetLimitDesc()
	local var_35_0 = self:getLimitCount()

	if var_35_0 > 0 then
		return i18n("charge_limit_all", var_35_0 - self:getBuyCount(), var_35_0)
	end

	local var_35_1 = self:getConfig("group_limit")

	if var_35_1 > 0 then
		local var_35_2 = self:getConfig("group_type") or 0

		if var_35_2 == 1 then
			return i18n("charge_limit_daily", var_35_1 - self.groupCount, var_35_1)
		elseif var_35_2 == 2 then
			return i18n("charge_limit_weekly", var_35_1 - self.groupCount, var_35_1)
		elseif var_35_2 == 3 then
			return i18n("charge_limit_monthly", var_35_1 - self.groupCount, var_35_1)
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
		local var_38_0 = self:getConfig("akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"
		local var_38_1, var_38_2 = unpack(getGameset(var_38_0))

		if PlayerPrefs.GetInt(var_38_0, 0) ~= var_38_1 and table.contains(var_38_2[1], self.id) then
			return true
		end

		return self:isFree()
	end

	return
end

return CommonCommodity
