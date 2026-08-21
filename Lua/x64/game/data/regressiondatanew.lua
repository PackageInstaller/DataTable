local var_0_0 = singletonClass("RegressionDataNew")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = 0
local var_0_7 = 0
local var_0_8 = {}
local var_0_9 = 0
local var_0_10 = 0
local var_0_11 = false
local var_0_12 = false
local var_0_13 = false
local var_0_14 = false
local var_0_15 = 0
local var_0_16 = 0
local var_0_17 = 0
local var_0_18 = {}

function var_0_0.Init(arg_1_0)
	var_0_2 = 0
	var_0_3 = 0
	var_0_4 = 0
	var_0_5 = 0
	var_0_6 = 0
	var_0_7 = 0
	var_0_8 = {}
	var_0_9 = 0
	var_0_10 = 0
	var_0_11 = false
	var_0_12 = false
	var_0_15 = 0
	battlepass_activity_id = 0
	var_0_17 = 0
	var_0_18 = {}
	var_0_13 = false
	var_0_14 = false
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_6 = var_0_5
	var_0_2 = arg_2_1.end_timestamps
	var_0_3 = arg_2_1.return_vs_id
	var_0_4 = arg_2_1.return_level
	var_0_5 = arg_2_1.mul_times
	var_0_7 = arg_2_1.receive_sign_index
	var_0_9 = arg_2_1.left_day
	var_0_10 = arg_2_1.find_time
	var_0_11 = arg_2_1.open_draw_sign
	var_0_12 = arg_2_1.pic_sign
	var_0_8 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.received_sign_list) do
		table.insert(var_0_8, iter_2_1)
	end

	if var_0_2 > 0 then
		local var_2_0 = arg_2_0:GetRegressDurationDays()

		var_0_1 = var_0_2 - var_2_0 * 86400
	end
end

function var_0_0.InitDrawData(arg_3_0, arg_3_1)
	var_0_13 = arg_3_1.other_sign
	var_0_14 = arg_3_1.draw_over_sign
end

function var_0_0.UpdatePassData(arg_4_0, arg_4_1)
	var_0_15 = arg_4_1.discount_end_timestamps
	var_0_16 = arg_4_1.battlepass_end_timestamps
	var_0_17 = arg_4_1.vs
	var_0_18 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.good_list) do
		var_0_18[iter_4_1.good_id] = iter_4_1
	end
end

function var_0_0.GetRegressionSystemID(arg_5_0)
	return 3001
end

function var_0_0.GetRegressionVersion(arg_6_0)
	return var_0_3
end

function var_0_0.GetLastOfflineTime(arg_7_0)
	return var_0_9
end

function var_0_0.GetRegressionLoginTime(arg_8_0)
	return var_0_1
end

function var_0_0.GetRegressionEndTime(arg_9_0)
	return var_0_2
end

function var_0_0.GetRegressDurationDays(arg_10_0)
	return arg_10_0:GetReturnCfgData().trigger_time[3]
end

function var_0_0.GetRegressReturnLevel(arg_11_0)
	return var_0_4
end

function var_0_0.GetRegressFindTime(arg_12_0)
	return var_0_10
end

function var_0_0.GetMultipleValue(arg_13_0)
	local var_13_0 = arg_13_0:GetReturnCfgData().multiple_frequency
	local var_13_1 = var_13_0[2]
	local var_13_2 = var_13_1 - var_0_5
	local var_13_3 = var_13_0[1]

	return var_13_2, var_13_1, var_13_3
end

function var_0_0.GetMultipleUseTimes(arg_14_0)
	if not arg_14_0:IsRegressionOpen() then
		return 0
	end

	local var_14_0 = var_0_5 - var_0_6

	var_0_6 = var_0_5

	return var_14_0
end

function var_0_0.GetLastMultipleUseTimes(arg_15_0)
	return var_0_6
end

function var_0_0.GetReturnCfgData(arg_16_0)
	return ReturnCfg[arg_16_0:GetRegressionSystemID()]
end

function var_0_0.GetReturnRecommendCfgData(arg_17_0)
	return ReturnRecommendCfg[arg_17_0:GetRegressionVersion()]
end

function var_0_0.GetPassDiscountEndTimes(arg_18_0)
	return var_0_15
end

function var_0_0.GetShopGoodsList(arg_19_0)
	local var_19_0 = arg_19_0:GetReturnCfgData().gift_pack_shopid
	local var_19_1 = ShopTools.FilterShopDataList(var_19_0)
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		local var_19_3 = getShopCfg(iter_19_1.id)

		if var_19_3 and var_19_3.refresh_cycle == 1 then
			table.insert(var_19_2, iter_19_1)
		end
	end

	table.sort(var_19_2, function(arg_20_0, arg_20_1)
		return arg_20_0.id < arg_20_1.id
	end)

	return var_19_2
end

function var_0_0.GetShopDailyFreeGoodID(arg_21_0)
	local var_21_0 = 0
	local var_21_1 = arg_21_0:GetReturnCfgData().gift_pack_shopid
	local var_21_2 = ShopTools.FilterShopDataList(var_21_1)

	for iter_21_0, iter_21_1 in pairs(var_21_2) do
		local var_21_3 = getShopCfg(iter_21_1.id)

		if var_21_3 and var_21_3.refresh_cycle ~= 1 then
			var_21_0 = iter_21_1.id

			break
		end
	end

	return var_21_0
end

function var_0_0.GetDrawOverSign(arg_22_0)
	return var_0_14
end

function var_0_0.UpdateFindTime(arg_23_0)
	var_0_10 = var_0_10 - 1
end

function var_0_0.UpdatePicSign(arg_24_0, arg_24_1)
	var_0_12 = arg_24_1
end

function var_0_0.IsRegressionOpen(arg_25_0)
	if var_0_3 == 0 then
		return false
	end

	local var_25_0 = manager.time:GetServerTime()
	local var_25_1 = 86400 * arg_25_0:GetRegressDurationDays()

	return var_25_0 < var_0_2
end

function var_0_0.CheckIsBuyPayID(arg_26_0, arg_26_1)
	local var_26_0 = PassportConst:GetReturnDiscountTransPayID(arg_26_1)

	if var_0_18 and var_0_18[var_26_0] then
		return var_0_18[var_26_0].times > 0
	else
		return false
	end
end

function var_0_0.CheckIsCanBuyRuturnDiscount(arg_27_0, arg_27_1)
	if arg_27_0:CheckIsOpenDiscount() then
		return not arg_27_0:CheckIsBuyPayID(arg_27_1)
	else
		return false
	end
end

function var_0_0.CheckIsCanBuyPassportPayID(arg_28_0, arg_28_1)
	local var_28_0 = PassportData:GetId()

	if var_0_17 == 0 or var_0_17 == var_28_0 then
		return arg_28_0:CheckIsCanBuyRuturnDiscount(arg_28_1)
	else
		return false
	end
end

function var_0_0.CheckIsSamePassportVsID(arg_29_0)
	local var_29_0 = PassportData:GetId()

	if var_0_17 == 0 or var_0_17 == var_29_0 then
		return true
	else
		return false
	end
end

function var_0_0.CheckIsOpenRuturnPool(arg_30_0)
	return var_0_13 and not var_0_14
end

function var_0_0.GetOpenDrawSign(arg_31_0)
	return var_0_11
end

function var_0_0.CheckIsShowGift(arg_32_0)
	if arg_32_0:IsRegressionOpen() and var_0_12 == true then
		return true
	end

	return false
end

function var_0_0.CheckIsOpenDiscount(arg_33_0)
	local var_33_0 = manager.time:GetServerTime()

	if var_0_15 > 0 and var_33_0 < var_0_15 then
		return true
	else
		return false
	end
end

function var_0_0.CheckIsFirstBuyPassport(arg_34_0)
	local var_34_0 = false
	local var_34_1 = {
		211,
		212,
		213
	}

	for iter_34_0, iter_34_1 in pairs(var_34_1) do
		var_34_0 = arg_34_0:CheckIsBuyPayID(iter_34_1)

		if var_34_0 then
			return
		end
	end

	return not var_34_0
end

function var_0_0.IsCanFinishFindResTask(arg_35_0)
	local var_35_0 = arg_35_0:GetReturnCfgData().return_retrieve_task[1]
	local var_35_1 = AssignmentCfg[var_35_0].need
	local var_35_2 = TaskData2:GetTask(var_35_0)

	if var_35_2 and var_35_2.complete_flag == 0 and var_35_1 <= var_35_2.progress then
		return true
	else
		return false
	end
end

function var_0_0.IsFinishFindResTask(arg_36_0)
	local var_36_0 = arg_36_0:GetReturnCfgData().return_retrieve_task[1]
	local var_36_1 = AssignmentCfg[var_36_0].need
	local var_36_2 = TaskData2:GetTask(var_36_0)

	if var_36_2 and var_36_1 <= var_36_2.progress then
		return true
	else
		return false
	end
end

function var_0_0.IsSignReward(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetReturnCfgData().sign_id[arg_37_1]

	return not not table.indexof(var_0_8, var_37_0)
end

function var_0_0.UpdateSign(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:GetReturnCfgData().sign_id[arg_38_1]

	table.insert(var_0_8, var_38_0)

	var_0_7 = var_0_7 - 1
end

function var_0_0.GetSignIndex(arg_39_0)
	local var_39_0 = manager.time:GetTodayFreshTime()

	if var_0_3 == 0 then
		return 0
	end

	local var_39_1 = arg_39_0:GetReturnCfgData().sign_id

	if var_0_7 >= #var_39_1 then
		return #var_39_1
	end

	return var_0_7 + #var_0_8
end

function var_0_0.GetCanSignTimes(arg_40_0)
	return var_0_7
end

return var_0_0
