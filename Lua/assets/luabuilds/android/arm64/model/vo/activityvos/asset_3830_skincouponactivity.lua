local SkinCouponActivity = class("SkinCouponActivity", import("model.vo.Activity"))

function SkinCouponActivity:Ctor(arg_1_1)
	SkinCouponActivity.super.Ctor(self, arg_1_1)

	self.dataConfig = pg.activity_event_shop_discount[self.configId]

	return
end

function SkinCouponActivity:GetDiscountPrice()
	return self.dataConfig.discount_price
end

function SkinCouponActivity:GetNewPrice(arg_3_1)
	return arg_3_1 - self:GetDiscountPrice()
end

function SkinCouponActivity:GetShopIdList()
	return self.dataConfig.shop_list
end

function SkinCouponActivity:Left3Day()
	if self.stopTime - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
		return true
	end

	return false
end

function SkinCouponActivity:ShouldTipUsage()
	return self:GetCanUsageCnt() > 0 and self:Left3Day() and (function()
		local var_7_0 = PlayerPrefs.GetInt(self.id .. "_SkinCouponActivity_Tip" .. getProxy(PlayerProxy):getRawData().id, 0)

		if var_7_0 <= 0 then
			return true
		end

		local var_7_1 = pg.TimeMgr.GetInstance():GetServerTime()
		local var_7_2 = var_7_0 < var_7_1 and not pg.TimeMgr.GetInstance():IsSameDay(var_7_1, var_7_0) or false

		return (false or nil) and true
	end)()
end

function SkinCouponActivity:SaveTipTime()
	PlayerPrefs.SetInt(self.id .. "_SkinCouponActivity_Tip" .. getProxy(PlayerProxy):getRawData().id, (pg.TimeMgr.GetInstance():GetServerTime()))
	PlayerPrefs.Save()

	return
end

function SkinCouponActivity:IncludeShop(arg_9_1)
	return table.contains(self:GetShopIdList(), arg_9_1)
end

function SkinCouponActivity:GetCanUsageCnt()
	return self.data1 - self.data2
end

function SkinCouponActivity:GetEquivalentRes()
	if self.dataConfig.change_resource_type == 0 or self.dataConfig.change_resource_num == 0 then
		return nil
	end

	local var_11_0 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = self.dataConfig.change_resource_type,
		count = self.dataConfig.change_resource_num
	})

	var_11_0.name = var_11_0:getName()

	return
end

function SkinCouponActivity:GetLimitCnt()
	if self.dataConfig.max_count == 0 then
		return math.huge
	else
		return self.dataConfig.max_count
	end

	return
end

function SkinCouponActivity:IsMaxCnt()
	return self.data1 > self:GetLimitCnt()
end

function SkinCouponActivity:GetItemId()
	return self.dataConfig.item_id
end

function SkinCouponActivity:GetItemConfig()
	return Item.getConfigData((self:GetItemId())) or {}
end

function SkinCouponActivity:GetItemName()
	local var_16_0 = Item.getConfigData((self:GetItemId()))

	return (var_16_0 or nil) and (var_16_0.name or "")
end

function SkinCouponActivity:ShopId2SkinId(arg_17_1)
	return pg.shop_template[arg_17_1].effect_args[1]
end

function SkinCouponActivity:GetOwnCount()
	local var_18_0 = underscore.map(self:GetShopIdList(), function(arg_19_0)
		return self:ShopId2SkinId(arg_19_0)
	end)

	return #underscore.filter(var_18_0, function(arg_20_0)
		return getProxy(ShipSkinProxy):hasNonLimitSkin(arg_20_0)
	end), #var_18_0
end

function SkinCouponActivity:OwnAllSkin()
	local var_21_0, var_21_1 = self:GetOwnCount()

	return var_21_0 == var_21_1
end

function SkinCouponActivity:GetSkinCouponActivities()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(pg.activity_template.get_id_list_by_type[ActivityConst.ACTIVITY_TYPE_SKIN_COUPON] or {}) do
		local var_22_1 = getProxy(ActivityProxy):RawGetActivityById(iter_22_1)

		if var_22_1 and not var_22_1:isEnd() and (not self or var_22_1:IncludeShop(self)) then
			table.insert(var_22_0, var_22_1)
		end
	end

	return var_22_0
end

function SkinCouponActivity:GetBestReadySkinCouponAct()
	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(SkinCouponActivity.GetSkinCouponActivities(self)) do
		if iter_23_1:GetCanUsageCnt() > 0 and 0 < iter_23_1:GetDiscountPrice() then
			local var_23_1 = iter_23_1:GetDiscountPrice()

			var_23_0 = iter_23_1
		end
	end

	return var_23_0
end

function SkinCouponActivity:StaticExistActivityAndCoupon()
	return underscore.any(SkinCouponActivity.GetSkinCouponActivities(self), function(arg_25_0)
		return arg_25_0:GetCanUsageCnt() > 0
	end)
end

function SkinCouponActivity:GetSkinCouponActFromEncoreAct()
	if not self then
		return
	end

	local var_26_0 = getProxy(ActivityProxy):getActivityById(Drop.New({
		type = DROP_TYPE_VITEM,
		id = self:GetConfigClientSetting("item_id")
	}):getConfig("link_id"))

	if var_26_0 and not var_26_0:isEnd() then
		return var_26_0
	end

	return
end

function SkinCouponActivity:GetSkinCouponEncoreActivities()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(pg.activity_template.get_id_list_by_type[ActivityConst.ACTIVITY_TYPE_SKIN_COUPON_COUNTING] or {}) do
		local var_27_1 = getProxy(ActivityProxy):RawGetActivityById(iter_27_1)

		if var_27_1 and not var_27_1:isEnd() and (not self or table.contains(var_27_1:getConfig("config_data")[2], self)) then
			table.insert(var_27_0, var_27_1)
		end
	end

	return var_27_0
end

function SkinCouponActivity:StaticEncoreActTip()
	assert(self)

	for iter_28_0, iter_28_1 in ipairs(SkinCouponActivity.GetSkinCouponEncoreActivities()) do
		local var_28_0 = SkinCouponActivity.GetSkinCouponActFromEncoreAct(iter_28_1)

		if var_28_0 and not var_28_0:isEnd() and iter_28_1 and not iter_28_1:isEnd() and var_28_0:IncludeShop(self) and var_28_0:GetCanUsageCnt() <= 0 and iter_28_1:getData1() > 0 then
			return iter_28_1
		end
	end

	return
end

function SkinCouponActivity:GetOvercountEncoreActs()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(SkinCouponActivity.GetSkinCouponEncoreActivities(self)) do
		local var_29_1 = SkinCouponActivity.GetSkinCouponActFromEncoreAct(iter_29_1)

		if var_29_1 and not var_29_1:isEnd() then
			local var_29_2, var_29_3 = var_29_1:GetOwnCount()

			if var_29_1:GetCanUsageCnt() + iter_29_1:getData1() + 1 > var_29_3 - var_29_2 - 1 then
				table.insert(var_29_0, iter_29_1)
			end
		end
	end

	return var_29_0
end

function SkinCouponActivity:UseSkinCoupon()
	local var_30_0 = getProxy(ActivityProxy):getActivityById(self)

	if not var_30_0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	var_30_0.data2 = var_30_0.data2 + 1

	getProxy(ActivityProxy):updateActivity(var_30_0)

	return
end

return SkinCouponActivity
