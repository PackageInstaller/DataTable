class = var_0_10000

local var_0_0 = "IslandShopp"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

pg = var_0_0

local var_0_2 = var_0_0.island_shop_banner

pg = var_2

local var_0_3 = var_2.island_shop_normal_template

pg = var_3

local var_0_4 = var_3.island_shop_goods

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.island = arg_1_2

	arg_1_0:UpdateData(arg_1_1)

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_shop_template
end

function var_0_1.GetTagType(arg_3_0)
	return arg_3_0:getConfig("tag_type")
end

function var_0_1.GetShopIcon(arg_4_0)
	return arg_4_0:getConfig("shop_icon")
end

function var_0_1.GetTagIcon(arg_5_0)
	return arg_5_0:getConfig("tag_icon")
end

function var_0_1.GetFirstShopId(arg_6_0)
	return arg_6_0:getConfig("first_shop")
end

function var_0_1.GetSecondShopId(arg_7_0)
	return arg_7_0:getConfig("second_shop")
end

function var_0_1.GetShowType(arg_8_0)
	return arg_8_0:getConfig("show_type")
end

function var_0_1.GetTopResources(arg_9_0)
	return arg_9_0:getConfig("top_resource")
end

function var_0_1.GetCameraSet(arg_10_0)
	return arg_10_0:getConfig("camera_set")
end

function var_0_1.GetOrder(arg_11_0)
	return arg_11_0:getConfig("order")
end

function var_0_1.GetGoodIds(arg_12_0)
	type = var_1_10001

	local var_12_0

	if var_1_10001(arg_12_0:getConfig("goods_id")) ~= "table" or not arg_12_0:getConfig("goods_id") then
		var_12_0 = {}
	end

	return var_12_0
end

function var_0_1.IsNormalShop(arg_13_0)
	return arg_13_0:getConfig("shop_type") == 1
end

function var_0_1.IsTemporaryShop(arg_14_0)
	return arg_14_0:getConfig("shop_type") == 2
end

function var_0_1.GetCommanderOrCharaType(arg_15_0)
	return arg_15_0:getConfig("dress_type")
end

function var_0_1.GetExistTime(arg_16_0)
	if arg_16_0:IsNormalShop() then
		return var_0_3[arg_16_0.id].exist_time
	end

	return nil
end

function var_0_1.GetPlayerRefreshResource(arg_17_0)
	local var_17_0 = var_0_3[arg_17_0.id].refresh_player

	type = var_2

	if var_2(var_17_0) == "table" then
		return var_17_0
	end

	return nil
end

function var_0_1.GetMaxRefreshCount(arg_18_0)
	if arg_18_0:IsNormalShop() then
		return var_0_3[arg_18_0.id].refresh_set
	end

	return 0
end

function var_0_1.GetFirstRefreshFree(arg_19_0)
	return var_0_3[arg_19_0.id].refresh_free == 1
end

function var_0_1.UpdateData(arg_20_0, arg_20_1)
	arg_20_0.existTime = arg_20_1.exist_time
	arg_20_0.refreshTime = arg_20_1.refresh_time
	arg_20_0.refreshCount = arg_20_1.refresh_count

	arg_20_0:SetCommodities(arg_20_1.goods_list)
	arg_20_0:SortCommodities()

	return
end

function var_0_1.SetCommodities(arg_21_0, arg_21_1)
	arg_21_0.commodities = {}
	arg_21_0.commodityIds = {}

	if arg_21_0:IsTemporaryShop() then
		ipairs = var_2

		for iter_21_0, iter_21_1 in var_2(arg_21_1) do
			IslandCommodity = var_1_10007
			var_1_10007 = var_1_10007.New(iter_21_1, arg_21_0.id)
			table = var_8

			var_8.insert(arg_21_0.commodities, var_1_10007)

			table = var_8

			var_8.insert(arg_21_0.commodityIds, iter_21_1.id)
		end
	else
		ipairs = var_2

		for iter_21_2, iter_21_3 in var_2(arg_21_0:GetGoodIds()) do
			if arg_21_0:ShouldShowCommodity(iter_21_3) then
				IslandCommodity = var_7

				local var_21_0 = var_7.New({
					num = 0,
					id = iter_21_3
				}, arg_21_0.id)

				table = var_8

				var_8.insert(arg_21_0.commodities, var_21_0)

				table = var_8

				var_8.insert(arg_21_0.commodityIds, iter_21_3)
			end
		end

		ipairs = var_2

		for iter_21_4, iter_21_5 in var_2(arg_21_1) do
			if arg_21_0:GetCommodityById(iter_21_5.id) then
				var_7:UpdateNum(iter_21_5.num)

				if var_7:GetMaxNum() ~= 0 and var_7.purchasedNum == var_7:GetMaxNum() and not var_7:IsShowSellOut() then
					table = var_8

					var_8.removebyvalue(arg_21_0.commodities, var_7)

					table = var_8

					var_8.removebyvalue(arg_21_0.commodityIds, var_7.id)
				end
			end
		end
	end

	return
end

function var_0_1.ShouldShowCommodity(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.island
	local var_22_1 = var_2.GetAblityAgency(var_22_0)
	local var_22_2 = var_0_4[arg_22_1].unlock
	local var_22_3 = true

	type = var_1_10005

	if var_1_10005(var_22_2) == "table" and #var_22_2 > 0 then
		ipairs = var_5

		for iter_22_0, iter_22_1 in var_5(var_22_2) do
			if not var_22_1:HasAbility(iter_22_1) then
				var_22_3 = false

				break
			end
		end
	end

	pg = var_5

	local var_22_4 = var_5.TimeMgr.GetInstance()
	local var_22_5 = var_5.inTime(var_22_4, var_0_4[arg_22_1].time)

	return var_22_3 and var_22_5
end

function var_0_1.SortCommodities(arg_23_0)
	local var_23_0 = {}

	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0:GetGoodIds()) do
		if arg_23_0:GetCommodityById(iter_23_1) then
			var_7:SetCfgSortIdx(iter_23_0)

			table = var_8

			var_8.insert(var_23_0, var_7)
		end
	end

	arg_23_0.commodities = var_23_0

	return
end

function var_0_1.GetCommodities(arg_24_0)
	return arg_24_0.commodities
end

function var_0_1.GetCommodityById(arg_25_0, arg_25_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_25_0.commodityIds, arg_25_1) then
		return nil
	end

	ipairs = var_2

	for iter_25_0, iter_25_1 in var_2(arg_25_0.commodities) do
		if iter_25_1.id == arg_25_1 then
			return iter_25_1
		end
	end

	return
end

function var_0_1.UpdateCommodity(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0:GetCommodityById(arg_26_1) then
		var_3:AddNum(arg_26_2)
	end

	return
end

function var_0_1.GetBanners(arg_27_0)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.GetShowType(var_27_0)

	IslandConst = var_27_0

	local var_27_2

	if var_27_1 ~= var_27_0.SHOP_TYPE_RECOMMENDATION_5 then
		var_27_2 = arg_27_0

		local var_27_3 = arg_27_0.GetShowType(var_27_2)

		IslandConst = var_27_2

		if var_27_3 ~= var_27_2.SHOP_TYPE_RECOMMENDATION_1 then
			return nil
		end
	end

	local var_27_4 = {}

	ipairs = var_27_2

	local var_27_5

	if not var_0_2.get_id_list_by_shop_page_id[arg_27_0.id] then
		var_27_5 = {}
	end

	for iter_27_0, iter_27_1 in var_27_2(var_27_5) do
		local var_27_6 = var_0_2[iter_27_1]

		pg = var_1_10008

		local var_27_7 = var_1_10008.TimeMgr.GetInstance()

		if var_1_10008.inTime(var_27_7, var_27_6.time) then
			table = var_1_10008

			var_1_10008.insert(var_27_4, var_27_6)
		end
	end

	return var_27_4
end

function var_0_1.IsInTime(arg_28_0)
	if arg_28_0:IsNormalShop() then
		pg = var_1

		local var_28_0 = var_1.TimeMgr.GetInstance()

		return var_1.inTime(var_28_0, arg_28_0:GetExistTime())
	elseif arg_28_0:IsTemporaryShop() then
		pg = var_1

		local var_28_1 = var_1.TimeMgr.GetInstance()

		return var_1.GetServerTime(var_28_1) < arg_28_0.existTime
	end

	return
end

return var_0_1
