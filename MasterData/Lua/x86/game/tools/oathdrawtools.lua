local var_0_0 = {}
local var_0_1 = ItemConst.OATH_RING_COUPON

function var_0_0.GetCouponID()
	return var_0_1
end

function var_0_0.GetSkinDrawCfg(arg_2_0)
	if WeddingSkinDrawCfg[arg_2_0] == nil then
		-- block empty
	end

	return WeddingSkinDrawCfg[arg_2_0]
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

	for iter_10_0, iter_10_1 in ipairs(var_0_0.GetPoolIdList(arg_10_0)) do
		for iter_10_2, iter_10_3 in ipairs(ActivityLimitedDrawPoolListCfg[iter_10_1].main_icon_info) do
			local var_10_3

			if ItemCfg[iter_10_3[2]].type == ItemConst.ITEM_TYPE.GIFT then
				var_10_2 = iter_10_3[2]
				var_10_3 = iter_10_3[1]
			elseif ItemCfg[iter_10_3[2]].type == ItemConst.ITEM_TYPE.SCENE then
				var_10_0[ActivityLimitedDrawPoolListCfg[iter_10_1].activity_id[1]] = iter_10_3[2]
				var_10_1[ActivityLimitedDrawPoolListCfg[iter_10_1].activity_id[1]] = iter_10_3[1]
			end
		end
	end

	return var_10_0, var_10_1, var_10_2, nil
end

function var_0_0.GetGiftReward(arg_11_0)
	local var_11_0

	for iter_11_0, iter_11_1 in pairs(ItemCfg[arg_11_0].param) do
		if ItemCfg[iter_11_1[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			var_11_0 = iter_11_1[1]
		end
	end

	return var_11_0
end

function var_0_0.GetDiscountItemID(arg_12_0)
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs((var_0_0.GetPoolIdList(arg_12_0))) do
		for iter_12_2, iter_12_3 in ipairs(ActivityLimitedDrawPoolListCfg[iter_12_1].main_icon_info) do
			if ItemCfg[iter_12_3[2]].type == ItemConst.ITEM_TYPE.GIFT then
				for iter_12_4, iter_12_5 in pairs(ItemCfg[iter_12_3[2]].param) do
					if ItemCfg[iter_12_5[1]].type == ItemConst.ITEM_TYPE.MATERIAL then
						var_12_0 = iter_12_5[1]
					end
				end
			end
		end
	end

	return var_12_0
end

function var_0_0.CheckIsCanBuyOathSkin(arg_13_0, arg_13_1)
	if arg_13_1 == 128402 then
		return false
	end

	if WeddingCfg[arg_13_0] and WeddingCfg[arg_13_0].skin_id == arg_13_1 then
		return true
	end

	return false
end

function var_0_0.GetDrawMaxDropCount(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_14_0]) do
		local var_14_1 = ActivitySkinDrawData:GetDrawInfo(poolActivityId, iter_14_1)

		var_14_0 = var_14_0 + ActivityLimitedDrawPoolCfg[iter_14_1].total
	end

	return var_14_0
end

function var_0_0.GetPoolBestRewardName(arg_15_0)
	return (GetI18NText(ItemCfg[ActivityLimitedDrawPoolListCfg[arg_15_0].main_icon_info[1][2]].name))
end

return var_0_0
