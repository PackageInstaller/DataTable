local IslandShopp = class("IslandShopp", import("model.vo.BaseVO"))
local var_0_1 = pg.island_shop_banner
local var_0_2 = pg.island_shop_normal_template
local var_0_3 = pg.island_shop_goods

function IslandShopp:Ctor(arg_1_1, arg_1_2)
	self.configId = arg_1_1.id
	self.id = arg_1_1.id
	self.island = arg_1_2

	self:UpdateData(arg_1_1)

	return
end

function IslandShopp:bindConfigTable()
	return pg.island_shop_template
end

function IslandShopp:GetTagType()
	return self:getConfig("tag_type")
end

function IslandShopp:GetShopIcon()
	return self:getConfig("shop_icon")
end

function IslandShopp:GetTagIcon()
	return self:getConfig("tag_icon")
end

function IslandShopp:GetFirstShopId()
	return self:getConfig("first_shop")
end

function IslandShopp:GetSecondShopId()
	return self:getConfig("second_shop")
end

function IslandShopp:GetShowType()
	return self:getConfig("show_type")
end

function IslandShopp:GetTopResources()
	return self:getConfig("top_resource")
end

function IslandShopp:GetCameraSet()
	return self:getConfig("camera_set")
end

function IslandShopp:GetOrder()
	return self:getConfig("order")
end

function IslandShopp:GetGoodIds()
	return type(self:getConfig("goods_id")) == "table" and self:getConfig("goods_id") or {}
end

function IslandShopp:IsNormalShop()
	return self:getConfig("shop_type") == 1
end

function IslandShopp:IsTemporaryShop()
	return self:getConfig("shop_type") == 2
end

function IslandShopp:GetCommanderOrCharaType()
	return self:getConfig("dress_type")
end

function IslandShopp:GetExistTime()
	if self:IsNormalShop() then
		return var_0_2[self.id].exist_time
	end

	return nil
end

function IslandShopp:GetPlayerRefreshResource()
	if type(var_0_2[self.id].refresh_player) == "table" then
		return var_0_2[self.id].refresh_player
	end

	return nil
end

function IslandShopp:GetMaxRefreshCount()
	if self:IsNormalShop() then
		return var_0_2[self.id].refresh_set
	end

	return 0
end

function IslandShopp:GetFirstRefreshFree()
	return var_0_2[self.id].refresh_free == 1
end

function IslandShopp:UpdateData(arg_20_1)
	self.existTime = arg_20_1.exist_time
	self.refreshTime = arg_20_1.refresh_time
	self.refreshCount = arg_20_1.refresh_count

	self:SetCommodities(arg_20_1.goods_list)
	self:SortCommodities()

	return
end

function IslandShopp:SetCommodities(arg_21_1)
	self.commodities = {}
	self.commodityIds = {}

	if self:IsTemporaryShop() then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			table.insert(self.commodities, (IslandCommodity.New(iter_21_1, self.id)))
			table.insert(self.commodityIds, iter_21_1.id)
		end
	else
		for iter_21_2, iter_21_3 in ipairs(self:GetGoodIds()) do
			if self:ShouldShowCommodity(iter_21_3) then
				table.insert(self.commodities, (IslandCommodity.New({
					num = 0,
					id = iter_21_3
				}, self.id)))
				table.insert(self.commodityIds, iter_21_3)
			end
		end

		for iter_21_4, iter_21_5 in ipairs(arg_21_1) do
			local var_21_0 = self:GetCommodityById(iter_21_5.id)

			if var_21_0 then
				var_21_0:UpdateNum(iter_21_5.num)

				if var_21_0:GetMaxNum() ~= 0 and var_21_0.purchasedNum == var_21_0:GetMaxNum() and not var_21_0:IsShowSellOut() then
					table.removebyvalue(self.commodities, var_21_0)
					table.removebyvalue(self.commodityIds, var_21_0.id)
				end
			end
		end
	end

	return
end

function IslandShopp:ShouldShowCommodity(arg_22_1)
	local var_22_0 = self.island:GetAblityAgency()
	local var_22_1 = true

	if type(var_0_3[arg_22_1].unlock) == "table" and #var_0_3[arg_22_1].unlock > 0 then
		for iter_22_0, iter_22_1 in ipairs(var_0_3[arg_22_1].unlock) do
			if not var_22_0:HasAbility(iter_22_1) then
				var_22_1 = false

				break
			end
		end
	end

	return var_22_1 and pg.TimeMgr.GetInstance():inTime(var_0_3[arg_22_1].time)
end

function IslandShopp:SortCommodities()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(self:GetGoodIds()) do
		local var_23_1 = self:GetCommodityById(iter_23_1)

		if var_23_1 then
			var_23_1:SetCfgSortIdx(iter_23_0)
			table.insert(var_23_0, var_23_1)
		end
	end

	self.commodities = var_23_0

	return
end

function IslandShopp:GetCommodities()
	return self.commodities
end

function IslandShopp:GetCommodityById(arg_25_1)
	if not table.contains(self.commodityIds, arg_25_1) then
		return nil
	end

	for iter_25_0, iter_25_1 in ipairs(self.commodities) do
		if iter_25_1.id == arg_25_1 then
			return iter_25_1
		end
	end

	return
end

function IslandShopp:UpdateCommodity(arg_26_1, arg_26_2)
	local var_26_0 = self:GetCommodityById(arg_26_1)

	if var_26_0 then
		var_26_0:AddNum(arg_26_2)
	end

	return
end

function IslandShopp:GetBanners()
	if self:GetShowType() ~= IslandConst.SHOP_TYPE_RECOMMENDATION_5 and self:GetShowType() ~= IslandConst.SHOP_TYPE_RECOMMENDATION_1 then
		return nil
	end

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(var_0_1.get_id_list_by_shop_page_id[self.id] or {}) do
		if pg.TimeMgr.GetInstance():inTime(var_0_1[iter_27_1].time) then
			table.insert(var_27_0, var_0_1[iter_27_1])
		end
	end

	return var_27_0
end

function IslandShopp:IsInTime()
	if self:IsNormalShop() then
		return pg.TimeMgr.GetInstance():inTime(self:GetExistTime())
	elseif self:IsTemporaryShop() then
		return pg.TimeMgr.GetInstance():GetServerTime() < self.existTime
	end

	return
end

return IslandShopp
