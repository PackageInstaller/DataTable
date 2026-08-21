local var_0_0 = class("IslandShopp", import("model.vo.BaseVO"))
local var_0_1 = pg.island_shop_banner
local var_0_2 = pg.island_shop_normal_template
local var_0_3 = pg.island_shop_goods

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.island = arg_1_2

	arg_1_0:UpdateData(arg_1_1)

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_shop_template
end

function var_0_0.GetTagType(arg_3_0)
	return arg_3_0:getConfig("tag_type")
end

function var_0_0.GetShopIcon(arg_4_0)
	return arg_4_0:getConfig("shop_icon")
end

function var_0_0.GetTagIcon(arg_5_0)
	return arg_5_0:getConfig("tag_icon")
end

function var_0_0.GetFirstShopId(arg_6_0)
	return arg_6_0:getConfig("first_shop")
end

function var_0_0.GetSecondShopId(arg_7_0)
	return arg_7_0:getConfig("second_shop")
end

function var_0_0.GetShowType(arg_8_0)
	return arg_8_0:getConfig("show_type")
end

function var_0_0.GetTopResources(arg_9_0)
	return arg_9_0:getConfig("top_resource")
end

function var_0_0.GetCameraSet(arg_10_0)
	return arg_10_0:getConfig("camera_set")
end

function var_0_0.GetOrder(arg_11_0)
	return arg_11_0:getConfig("order")
end

function var_0_0.GetGoodIds(arg_12_0)
	return type(arg_12_0:getConfig("goods_id")) == "table" and arg_12_0:getConfig("goods_id") or {}
end

function var_0_0.IsNormalShop(arg_13_0)
	return arg_13_0:getConfig("shop_type") == 1
end

function var_0_0.IsTemporaryShop(arg_14_0)
	return arg_14_0:getConfig("shop_type") == 2
end

function var_0_0.GetCommanderOrCharaType(arg_15_0)
	return arg_15_0:getConfig("dress_type")
end

function var_0_0.GetExistTime(arg_16_0)
	if arg_16_0:IsNormalShop() then
		return var_0_2[arg_16_0.id].exist_time
	end

	return nil
end

function var_0_0.GetPlayerRefreshResource(arg_17_0)
	if type(var_0_2[arg_17_0.id].refresh_player) == "table" then
		return var_0_2[arg_17_0.id].refresh_player
	end

	return nil
end

function var_0_0.GetMaxRefreshCount(arg_18_0)
	if arg_18_0:IsNormalShop() then
		return var_0_2[arg_18_0.id].refresh_set
	end

	return 0
end

function var_0_0.GetFirstRefreshFree(arg_19_0)
	return var_0_2[arg_19_0.id].refresh_free == 1
end

function var_0_0.UpdateData(arg_20_0, arg_20_1)
	arg_20_0.existTime = arg_20_1.exist_time
	arg_20_0.refreshTime = arg_20_1.refresh_time
	arg_20_0.refreshCount = arg_20_1.refresh_count

	arg_20_0:SetCommodities(arg_20_1.goods_list)
	arg_20_0:SortCommodities()

	return
end

function var_0_0.SetCommodities(arg_21_0, arg_21_1)
	arg_21_0.commodities = {}
	arg_21_0.commodityIds = {}

	if arg_21_0:IsTemporaryShop() then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			table.insert(arg_21_0.commodities, (IslandCommodity.New(iter_21_1, arg_21_0.id)))
			table.insert(arg_21_0.commodityIds, iter_21_1.id)
		end
	else
		for iter_21_2, iter_21_3 in ipairs(arg_21_0:GetGoodIds()) do
			if arg_21_0:ShouldShowCommodity(iter_21_3) then
				table.insert(arg_21_0.commodities, (IslandCommodity.New({
					num = 0,
					id = iter_21_3
				}, arg_21_0.id)))
				table.insert(arg_21_0.commodityIds, iter_21_3)
			end
		end

		for iter_21_4, iter_21_5 in ipairs(arg_21_1) do
			local var_21_0 = arg_21_0:GetCommodityById(iter_21_5.id)

			if var_21_0 then
				var_21_0:UpdateNum(iter_21_5.num)

				if var_21_0:GetMaxNum() ~= 0 and var_21_0.purchasedNum == var_21_0:GetMaxNum() and not var_21_0:IsShowSellOut() then
					table.removebyvalue(arg_21_0.commodities, var_21_0)
					table.removebyvalue(arg_21_0.commodityIds, var_21_0.id)
				end
			end
		end
	end

	return
end

function var_0_0.ShouldShowCommodity(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.island:GetAblityAgency()
	local var_22_1 = true

	if type(var_0_3[arg_22_1].unlock) == "table" and #var_0_3[arg_22_1].unlock > 0 then
		for iter_22_0, iter_22_1 in ipairs(var_0_3[arg_22_1].unlock) do
			if not var_22_0:HasAbility(iter_22_1) then
				var_22_1 = false

				break
			end
		end
	end

	local var_22_2 = pg.TimeMgr.GetInstance():inTime(var_0_3[arg_22_1].time)

	return var_22_1 and var_22_2
end

function var_0_0.SortCommodities(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0:GetGoodIds()) do
		local var_23_0 = arg_23_0:GetCommodityById(iter_23_1)

		if var_23_0 then
			var_23_0:SetCfgSortIdx(iter_23_0)
			table.insert({}, var_23_0)
		end
	end

	arg_23_0.commodities = {}

	return
end

function var_0_0.GetCommodities(arg_24_0)
	return arg_24_0.commodities
end

function var_0_0.GetCommodityById(arg_25_0, arg_25_1)
	if not table.contains(arg_25_0.commodityIds, arg_25_1) then
		return nil
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.commodities) do
		if iter_25_1.id == arg_25_1 then
			return iter_25_1
		end
	end

	return
end

function var_0_0.UpdateCommodity(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:GetCommodityById(arg_26_1)

	if var_26_0 then
		var_26_0:AddNum(arg_26_2)
	end

	return
end

function var_0_0.GetBanners(arg_27_0)
	if arg_27_0:GetShowType() ~= IslandConst.SHOP_TYPE_RECOMMENDATION_5 and arg_27_0:GetShowType() ~= IslandConst.SHOP_TYPE_RECOMMENDATION_1 then
		return nil
	end

	local var_27_0 = {}
	local var_27_1 = var_0_1.get_id_list_by_shop_page_id[arg_27_0.id] or {}

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		local var_27_2 = pg.TimeMgr.GetInstance()

		if var_27_2:inTime(var_0_1[iter_27_1].time) then
			table.insert(var_27_0, var_0_1[iter_27_1])
		end
	end

	return var_27_0
end

function var_0_0.IsInTime(arg_28_0)
	if arg_28_0:IsNormalShop() then
		return pg.TimeMgr.GetInstance():inTime(arg_28_0:GetExistTime())
	elseif arg_28_0:IsTemporaryShop() then
		local var_28_0 = pg.TimeMgr.GetInstance()

		return var_28_0:GetServerTime() < arg_28_0.existTime
	end

	return
end

return var_0_0
