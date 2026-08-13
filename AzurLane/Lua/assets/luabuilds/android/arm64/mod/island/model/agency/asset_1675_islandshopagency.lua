class = var_0_10000

local var_0_0 = "IslandShopAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

pg = var_0_10001

local var_0_2 = var_0_10001.island_shop_template

pg = var_0_0

local var_0_3 = var_0_0.island_shop_goods

pg = var_3

local var_0_4 = var_3.island_shop_normal_template

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.shop_list

	arg_1_0:SetShops(var_1_0)
	arg_1_0:SetSeasonShops()

	return
end

function var_0_1.SetShops(arg_2_0, arg_2_1)
	arg_2_0.shops = {}
	arg_2_0.shopIds = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1) do
		IslandShopp = var_1_10007
		var_1_10007 = var_1_10007.New(iter_2_1, arg_2_0:GetHost())
		table = var_1_10008

		var_1_10008.insert(arg_2_0.shops, var_1_10007)

		table = var_1_10008

		var_1_10008.insert(arg_2_0.shopIds, iter_2_1.id)
	end

	return
end

function var_0_1.IsShowShop(arg_3_0, arg_3_1)
	table = var_1_10002

	return var_1_10002.contains(arg_3_0.shopIds, arg_3_1)
end

function var_0_1.GetShopById(arg_4_0, arg_4_1)
	if not arg_4_0:IsShowShop(arg_4_1) then
		return nil
	end

	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_0.shops) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return
end

function var_0_1.GetShopCommodity(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0:GetShopById(arg_5_1) then
		return var_3:GetCommodityById(arg_5_2)
	end

	return
end

function var_0_1.RefreshShopData(arg_6_0, arg_6_1)
	pg = var_1_10002

	local var_6_0 = var_1_10002.m02
	local var_6_1 = var_2.sendNotification

	GAME = var_1_10005

	local var_6_2 = var_1_10005.ISLAND_SHOP_OP
	local var_6_3 = {}

	IslandConst = var_1_10007
	var_6_3.operation = var_1_10007.SHOP_GET_DATA
	var_6_3.shopId = arg_6_1

	var_6_1(var_6_0, var_6_2, var_6_3)

	return
end

function var_0_1.UpdateShop(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0

	if arg_7_0.GetShopById(var_7_0, arg_7_1) then
		if arg_7_2 ~= nil then
			var_3:UpdateData(arg_7_2)
		else
			table = var_1_10004

			var_1_10004.removebyvalue(arg_7_0.shops, var_3)

			table = var_1_10004

			var_1_10004.removebyvalue(arg_7_0.shopIds, arg_7_1)
		end
	elseif arg_7_2 ~= nil then
		IslandShopp = var_1_10004

		local var_7_1 = var_1_10004.New(arg_7_2, arg_7_0:GetHost())

		table = var_7_0

		var_7_0.insert(arg_7_0.shops, var_7_1)

		table = var_5

		var_5.insert(arg_7_0.shopIds, arg_7_2.id)
	end

	return
end

function var_0_1.UpdateShopCommodity(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0:GetShopById(arg_8_1) then
		var_4:UpdateCommodity(arg_8_2, arg_8_3)
	end

	return
end

function var_0_1.GetSortedShopConfigs(arg_9_0, arg_9_1)
	table = var_1_10002

	var_1_10002.sort(arg_9_1, function(arg_10_0, arg_10_1)
		return arg_10_0.order < arg_10_1.order
	end)

	return arg_9_1
end

function var_0_1.ShouldShowFirstShop(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1.shop_type ~= 0 and arg_11_0:IsShowShop(arg_11_1.id) then
		table = var_3

		if var_3.contains(arg_11_2, arg_11_1.show_type) then
			return true
		end
	end

	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_0.shops) do
		if iter_11_1:GetFirstShopId() == arg_11_1.id then
			table = var_8

			if var_8.contains(arg_11_2, iter_11_1:GetShowType()) then
				return true
			end
		end
	end

	return false
end

function var_0_1.ShouldShowSecondShop(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1.shop_type ~= 0 and arg_12_0:IsShowShop(arg_12_1.id) then
		table = var_3

		if var_3.contains(arg_12_2, arg_12_1.show_type) then
			return true
		end
	end

	ipairs = var_3

	for iter_12_0, iter_12_1 in var_3(arg_12_0.shops) do
		if iter_12_1:GetSecondShopId() == arg_12_1.id then
			table = var_8

			if var_8.contains(arg_12_2, iter_12_1:GetShowType()) then
				return true
			end
		end
	end

	return false
end

function var_0_1.GetFirstShopConfigs(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(var_0_2.all) do
		if var_0_2[iter_13_1].tag_type == 1 and arg_13_0:ShouldShowFirstShop(var_9, arg_13_1) then
			if arg_13_2 then
				table = var_10

				if var_10.contains(arg_13_2, iter_13_1) then
					table = var_10

					var_10.insert(var_13_0, var_9)
				end
			end
		end
	end

	return arg_13_0:GetSortedShopConfigs(var_13_0)
end

function var_0_1.GetSecondShopConfigs(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	if arg_14_2 == 0 then
		return var_14_0
	end

	ipairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(var_0_2.get_id_list_by_first_shop[arg_14_2]) do
		if var_0_2[iter_14_1].tag_type == 2 and arg_14_0:ShouldShowSecondShop(var_9, arg_14_1) then
			table = var_10

			var_10.insert(var_14_0, var_9)
		end
	end

	return arg_14_0:GetSortedShopConfigs(var_14_0)
end

function var_0_1.GetThirdShopConfigs(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	if arg_15_2 == 0 then
		return var_15_0
	end

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(var_0_2.get_id_list_by_second_shop[arg_15_2]) do
		if var_0_2[iter_15_1].tag_type == 3 and arg_15_0:IsShowShop(iter_15_1) then
			table = var_10

			if var_10.contains(arg_15_1, var_9.show_type) then
				table = var_10

				var_10.insert(var_15_0, var_9)
			end
		end
	end

	return arg_15_0:GetSortedShopConfigs(var_15_0)
end

function var_0_1.GetInitShowingShop(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_0:GetFirstShopConfigs(arg_16_1, arg_16_2)[1].shop_type == 0 then
		if arg_16_0:GetSecondShopConfigs(arg_16_1, var_5.id)[1].shop_type == 0 then
			var_16_0 = arg_16_0:GetThirdShopConfigs(arg_16_1, var_7.id)[1]
		else
			var_16_0 = var_7
		end
	else
		var_16_0 = var_5
	end

	if var_16_0 then
		return arg_16_0:GetShopById(var_16_0.id)
	else
		return nil
	end

	return
end

function var_0_1.GetNewOrOverdueShopIds(arg_17_0)
	local var_17_0 = {}

	IslandSeasonAgency = var_1_10002

	local var_17_1 = var_1_10002.GetCurrentSeason()

	pg = var_1_10003

	local var_17_2 = var_1_10003.island_season[var_17_1].shop_id

	ipairs = var_1_10004

	for iter_17_0, iter_17_1 in var_1_10004(var_0_4.all) do
		local var_17_3 = var_0_4[iter_17_1]

		pg = var_1_10010

		local var_17_4 = var_1_10010.TimeMgr.GetInstance()

		var_1_10010 = var_1_10010.inTime(var_17_4, var_17_3.exist_time)

		if arg_17_0:IsShowShop(iter_17_1) or not var_1_10010 then
			if arg_17_0:IsShowShop(iter_17_1) and not var_1_10010 then
				table = var_11

				if var_11.contains(var_17_2, iter_17_1) then
					table = var_11

					if var_11.contains(var_17_2, iter_17_1) and var_1_10010 then
						table = var_11

						var_11.insert(var_17_0, iter_17_1)
					end
				end
			end
		end
	end

	ipairs = var_4

	for iter_17_2, iter_17_3 in var_4(arg_17_0.shops) do
		if iter_17_3:IsTemporaryShop() then
			pg = var_9

			local var_17_5 = var_9.TimeMgr.GetInstance()

			if not (var_9.GetServerTime(var_17_5) < iter_17_3.existTime) then
				table = var_10

				var_10.insert(var_17_0, iter_17_3.id)
			end
		end
	end

	return var_17_0
end

function var_0_1.SetSeasonShops(arg_18_0)
	IslandSeasonAgency = var_1_10001

	local var_18_0 = var_1_10001.GetCurrentSeason()

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_18_0, iter_18_1 in var_1_10002(var_1_10004.island_season[var_18_0].shop_id) do
		local var_18_1 = arg_18_0

		if not arg_18_0.GetShopById(var_18_1, iter_18_1) then
			IslandShopp = var_1_10008
			var_1_10008 = var_1_10008.New({
				refresh_count = 0,
				refresh_time = 0,
				exist_time = 0,
				id = iter_18_1,
				goods_list = {}
			}, arg_18_0:GetHost())
			table = var_18_1

			var_18_1.insert(arg_18_0.shops, var_1_10008)

			table = var_9

			var_9.insert(arg_18_0.shopIds, iter_18_1)
		end
	end

	return
end

function var_0_1.GetSeasonShops(arg_19_0)
	IslandSeasonAgency = var_1_10001

	local var_19_0 = var_1_10001.GetCurrentSeason()
	local var_19_1 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_19_0, iter_19_1 in var_1_10003(var_1_10005.island_season[var_19_0].shop_id) do
		var_19_1[iter_19_1] = arg_19_0:GetShopById(iter_19_1)
	end

	return var_19_1
end

return var_0_1
