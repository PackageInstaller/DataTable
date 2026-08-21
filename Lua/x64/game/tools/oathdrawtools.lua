local var_0_0 = {}
local var_0_1 = ItemConst.OATH_RING_COUPON

function var_0_0.GetCouponID()
	return var_0_1
end

function var_0_0.GetSkinDrawCfg(arg_2_0)
	local var_2_0 = WeddingSkinDrawCfg[arg_2_0]

	if var_2_0 == nil then
		-- block empty
	end

	return var_2_0
end

function var_0_0.GetPoolIdList(arg_3_0)
	return var_0_0.GetSkinDrawCfg(arg_3_0).poolList
end

function var_0_0.GetMainUIName(arg_4_0)
	return var_0_0.GetSkinDrawCfg(arg_4_0).mainUI
end

function var_0_0.GetDrawInfoUIName(arg_5_0)
	return var_0_0.GetSkinDrawCfg(arg_5_0).drawInfoUI
end

function var_0_0.GetDrawGameUIName(arg_6_0)
	return var_0_0.GetSkinDrawCfg(arg_6_0).drawStartUI
end

function var_0_0.GetPopUIName(arg_7_0)
	return var_0_0.GetSkinDrawCfg(arg_7_0).exchangeUI
end

function var_0_0.GetDrawGiftItem(arg_8_0)
	return var_0_0.GetSkinDrawCfg(arg_8_0).drawGiftItem
end

function var_0_0.GetDrawCost(arg_9_0)
	return ActivityLimitedDrawPoolListCfg[arg_9_0].cost_once[1]
end

function var_0_0.GetAllReward(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2
	local var_10_3

	for iter_10_0, iter_10_1 in ipairs(var_0_0.GetPoolIdList(arg_10_0)) do
		local var_10_4 = ActivityLimitedDrawPoolListCfg[iter_10_1]
		local var_10_5 = var_10_4.main_icon_info

		for iter_10_2, iter_10_3 in ipairs(var_10_5) do
			local var_10_6 = iter_10_3[2]
			local var_10_7 = ItemCfg[var_10_6]

			if var_10_7.type == ItemConst.ITEM_TYPE.GIFT then
				var_10_2 = var_10_6
				var_10_3 = iter_10_3[1]
			elseif var_10_7.type == ItemConst.ITEM_TYPE.SCENE then
				var_10_0[var_10_4.activity_id[1]] = var_10_6
				var_10_1[var_10_4.activity_id[1]] = iter_10_3[1]
			end
		end
	end

	return var_10_0, var_10_1, var_10_2, var_10_3
end

function var_0_0.GetGiftReward(arg_11_0)
	local var_11_0
	local var_11_1 = ItemCfg[arg_11_0].param

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_2 = iter_11_1[1]

		if ItemCfg[var_11_2].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			var_11_0 = var_11_2
		end
	end

	return var_11_0
end

function var_0_0.GetDiscountItemID(arg_12_0)
	local var_12_0 = var_0_0.GetPoolIdList(arg_12_0)
	local var_12_1

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = ActivityLimitedDrawPoolListCfg[iter_12_1].main_icon_info

		for iter_12_2, iter_12_3 in ipairs(var_12_2) do
			local var_12_3 = iter_12_3[2]
			local var_12_4 = ItemCfg[var_12_3]

			if ItemCfg[var_12_3].type == ItemConst.ITEM_TYPE.GIFT then
				local var_12_5 = ItemCfg[var_12_3].param

				for iter_12_4, iter_12_5 in pairs(var_12_5) do
					local var_12_6 = iter_12_5[1]

					if ItemCfg[var_12_6].type == ItemConst.ITEM_TYPE.MATERIAL then
						var_12_1 = var_12_6
					end
				end
			end
		end
	end

	return var_12_1
end

function var_0_0.CheckIsCanBuyOathSkin(arg_13_0, arg_13_1)
	if arg_13_1 == 128402 then
		return false
	end

	local var_13_0 = WeddingCfg[arg_13_0]

	if var_13_0 and var_13_0.skin_id == arg_13_1 then
		return true
	end

	return false
end

function var_0_0.GetDrawMaxDropCount(arg_14_0)
	local var_14_0 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_14_0]
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = ActivityLimitedDrawPoolCfg[iter_14_1]
		local var_14_3 = ActivitySkinDrawData:GetDrawInfo(poolActivityId, iter_14_1)

		var_14_1 = var_14_1 + var_14_2.total
	end

	return var_14_1
end

function var_0_0.GetPoolBestRewardName(arg_15_0)
	local var_15_0 = ActivityLimitedDrawPoolListCfg[arg_15_0].main_icon_info[1]

	return (GetI18NText(ItemCfg[var_15_0[2]].name))
end

return var_0_0
