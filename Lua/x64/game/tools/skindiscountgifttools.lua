local var_0_0 = {
	GetActivityList = function()
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_DISCOUNT_GIFT]) do
			if ActivityData:GetActivityIsOpen(iter_1_1) then
				table.insert(var_1_0, iter_1_1)
			end
		end

		return var_1_0
	end,
	HasGiftActivityID = function()
		local var_2_0 = SkinDiscountGiftTools.GetActivityList()

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			for iter_2_2, iter_2_3 in ipairs(ActivitySkinDiscountCfg.get_id_list_by_activity_id[iter_2_1]) do
				if ActivitySkinDiscountCfg[iter_2_3].limit_num > SkinDiscountGiftData:GetUsedTimes(iter_2_3) then
					return iter_2_1
				end
			end
		end
	end,
	HasDiscountGoodsID = function(arg_3_0)
		local var_3_0 = SkinDiscountGiftTools.GetActivityList()

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			for iter_3_2, iter_3_3 in ipairs(ActivitySkinDiscountCfg.get_id_list_by_activity_id[iter_3_1]) do
				local var_3_1 = ActivitySkinDiscountCfg[iter_3_3]

				if var_3_1.limit_num > SkinDiscountGiftData:GetUsedTimes(iter_3_3) then
					for iter_3_4, iter_3_5 in ipairs(var_3_1.goods_id) do
						if iter_3_5[1] == arg_3_0 then
							return iter_3_1
						end
					end
				end
			end
		end

		return nil
	end,
	IsShowMain = function(arg_4_0)
		local var_4_0 = ActivitySkinDiscountCfg.get_id_list_by_activity_id[arg_4_0]

		return ActivitySkinDiscountCfg[var_4_0[1]].entrance == 1
	end
}

function var_0_0.HasCheapGoodsList(arg_5_0)
	local var_5_0 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if var_0_0.HasCheapGoods(arg_5_0, iter_5_1.skinGoodsID) then
			return true
		end
	end

	return false
end

function var_0_0.HasCheapGoods(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.GetItemIDByGoodsID(arg_6_1)
	local var_6_1 = SkinCfg[var_6_0].hero
	local var_6_2 = ShopTools.GetPrice(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(ActivitySkinDiscountCfg[arg_6_0].goods_id) do
		if not var_0_0.HasSkin(iter_6_1[1]) then
			local var_6_3 = var_0_0.GetItemIDByGoodsID(iter_6_1[1])

			if var_6_2 < ShopTools.GetPrice(iter_6_1[1]) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetDiscountActivityID(arg_7_0)
	local var_7_0 = SkinDiscountGiftTools.GetActivityList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		for iter_7_2, iter_7_3 in ipairs(ActivitySkinDiscountCfg.get_id_list_by_activity_id[iter_7_1]) do
			local var_7_1 = ActivitySkinDiscountCfg[iter_7_3]

			if var_7_1.limit_num > SkinDiscountGiftData:GetUsedTimes(iter_7_3) then
				for iter_7_4, iter_7_5 in ipairs(var_7_1.goods_id) do
					if iter_7_5[1] == arg_7_0 or iter_7_5[2] == arg_7_0 then
						return iter_7_1
					end
				end
			end
		end
	end
end

function var_0_0.GetEntramceItemPrefabPath(arg_8_0)
	return "Widget/System/Recharge/RechargeSkinEventUI_main"
end

function var_0_0.GetSignActivityID(arg_9_0)
	local var_9_0 = ActivityCfg[arg_9_0]

	for iter_9_0, iter_9_1 in ipairs(var_9_0.sub_activity_list) do
		if ActivityCfg[iter_9_1].activity_template == ActivityTemplateConst.SKIN_DISCOUNT_GIFT_SIGN then
			return iter_9_1
		end
	end
end

function var_0_0.GetSignState(arg_10_0, arg_10_1)
	return SignTools.GetSevenDaySignState2(arg_10_0, arg_10_1)
end

function var_0_0.GetRemainCount(arg_11_0)
	return ActivitySkinDiscountCfg[arg_11_0].limit_num - SkinDiscountGiftData:GetUsedTimes(arg_11_0)
end

function var_0_0.HasAllGoodsSkin(arg_12_0)
	local var_12_0 = ActivitySkinDiscountCfg[arg_12_0].goods_id

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not var_0_0.HasSkin(iter_12_1[1]) or not var_0_0.HasScene(iter_12_1[2]) then
			return false
		end
	end

	return true
end

function var_0_0.GetGoodsList(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = ActivitySkinDiscountCfg[arg_13_0].goods_id

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		local var_13_5 = iter_13_1[1]
		local var_13_6 = iter_13_1[2]

		if var_0_0.HasSkin(var_13_5) then
			table.insert(var_13_1, iter_13_0)
		else
			table.insert(var_13_0, iter_13_0)
		end

		local var_13_7, var_13_8 = var_0_0.GetGoodsPrice(var_13_5, var_13_6)

		var_13_2[iter_13_0] = var_13_7

		if var_13_7 ~= var_13_8 then
			table.insert(var_13_3, iter_13_0)
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = table.keyof(var_13_3, arg_14_0)
		local var_14_1 = table.keyof(var_13_3, arg_14_1)

		if var_14_0 and not var_14_1 then
			return true
		elseif not var_14_0 and var_14_1 then
			return false
		end

		if var_13_2[arg_14_0] == var_13_2[arg_14_1] then
			return var_13_4[arg_14_0][1] > var_13_4[arg_14_1][1]
		elseif var_13_2[arg_14_0] > var_13_2[arg_14_1] then
			return true
		end

		return false
	end)
	table.sort(var_13_1, function(arg_15_0, arg_15_1)
		local var_15_0 = table.keyof(var_13_3, arg_15_0)
		local var_15_1 = table.keyof(var_13_3, arg_15_1)

		if var_15_0 and not var_15_1 then
			return true
		elseif not var_15_0 and var_15_1 then
			return false
		end

		if var_13_2[arg_15_0] == var_13_2[arg_15_1] then
			return var_13_4[arg_15_0][1] > var_13_4[arg_15_1][1]
		elseif var_13_2[arg_15_0] > var_13_2[arg_15_1] then
			return true
		end

		return false
	end)
	table.insertto(var_13_0, var_13_1)

	local var_13_9 = {}

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		table.insert(var_13_9, var_13_4[iter_13_3])
	end

	return var_13_9
end

function var_0_0.HasSkin(arg_16_0)
	local var_16_0 = getShopCfg(arg_16_0).description
	local var_16_1 = RechargeShopDescriptionCfg[var_16_0].param[1]

	if ShopTools.HaveSkin(var_16_1) or HeroTools.CanChangeSkin(var_16_1) then
		return true
	end

	return false
end

function var_0_0.HasScene(arg_17_0)
	if arg_17_0 == nil then
		return true
	end

	return ShopTools.CheckDlcPurchased(arg_17_0)
end

function var_0_0.GetItemIDByGoodsID(arg_18_0)
	local var_18_0 = getShopCfg(arg_18_0)

	if var_18_0.shop_refresh == 3 then
		local var_18_1 = var_18_0.description

		return RechargeShopDescriptionCfg[var_18_1].param[1]
	else
		return var_18_0.give_id
	end
end

function var_0_0.IsSelectSkinGoodsID(arg_19_0)
	local var_19_0 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.skinGoodsID == arg_19_0 then
			return true
		end
	end

	return false
end

function var_0_0.IsSelectSceneGoodsID(arg_20_0)
	local var_20_0 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.sceneGoodsID == arg_20_0 then
			return iter_20_1.isSelectSceneID
		end
	end

	return false
end

function var_0_0.IsFullSkinGoodsID(arg_21_0)
	return arg_21_0 <= #SkinDiscountGiftData:GetGoodsIDList()
end

function var_0_0.GetGoodsPrice(arg_22_0, arg_22_1)
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = 0
	local var_22_3 = 0

	if not SkinDiscountGiftTools.HasSkin(arg_22_0) then
		var_22_0, var_22_1 = ShopTools.GetPrice(arg_22_0)
	end

	if arg_22_1 and not SkinDiscountGiftTools.HasScene(arg_22_1) then
		var_22_2, var_22_3 = ShopTools.GetPrice(arg_22_1)
	end

	return var_22_0 + var_22_2, var_22_1 + var_22_3
end

function var_0_0.GetTotalDiscountPrice(arg_23_0)
	local var_23_0 = SkinDiscountGiftData:GetGoodsIDList()
	local var_23_1 = 0

	for iter_23_0 = 1, 2 do
		local var_23_2 = var_23_0[iter_23_0]

		if var_23_2 then
			local var_23_3, var_23_4 = ShopTools.GetPrice(var_23_2.skinGoodsID)

			var_23_1 = var_23_1 + math.floor(var_23_3 * arg_23_0)

			if var_23_2.isSelectSceneID and var_23_2.sceneGoodsID then
				local var_23_5, var_23_6 = ShopTools.GetPrice(var_23_2.sceneGoodsID)

				var_23_1 = var_23_1 + math.floor(var_23_5 * arg_23_0)
			end
		end
	end

	return var_23_1
end

function var_0_0.GetReturePrice()
	local var_24_0 = 0
	local var_24_1 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_2 = iter_24_1.skinGoodsID
		local var_24_3 = getShopCfg(var_24_2)

		if not SkinDiscountGiftTools.HasSkin(var_24_2) and var_24_3.give_back_list and #var_24_3.give_back_list > 0 then
			var_24_0 = var_24_0 + var_24_3.give_back_list[1].num
		end
	end

	return var_24_0
end

return var_0_0
