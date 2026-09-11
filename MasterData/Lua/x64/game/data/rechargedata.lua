local var_0_0 = singletonClass("RechargeData")
local var_0_1 = {
	is_sign = 0,
	monthly_card_timestamp = 0,
	monthly_card_num = 0
}
local var_0_2 = {
	totalRechargeNum = 0,
	timeLimitRechargeNum = 0,
	timeLimitRechargeVersion = 0,
	rechargeVersion = 0,
	firstRechargeIdList = {},
	receiveTotalRechargeList = {},
	receiveTimeLimitRechargeList = {}
}

function var_0_0.Init(arg_1_0)
	var_0_1.monthly_card_num = 0
	var_0_1.monthly_card_timestamp = 0
	var_0_1.is_sign = 0
	var_0_2 = {
		totalRechargeNum = 0,
		timeLimitRechargeNum = 0,
		timeLimitRechargeVersion = 0,
		rechargeVersion = 0,
		firstRechargeIdList = {},
		receiveTotalRechargeList = {},
		receiveTimeLimitRechargeList = {}
	}
end

function var_0_0.InitWithServerData(arg_2_0, arg_2_1)
	var_0_1.monthly_card_num = arg_2_1.monthly_card_num
	var_0_1.monthly_card_timestamp = arg_2_1.monthly_card_timestamp
	var_0_1.is_sign = arg_2_1.is_sign
end

function var_0_0:InitTotalRechargeDataFromServer(arg_3_1)
	var_0_2.totalRechargeNum = arg_3_1.total_recharge_num
	var_0_2.receiveTotalRechargeList = arg_3_1.receive_total_recharge_list
	var_0_2.rechargeVersion = arg_3_1.total_recharge_version
	var_0_2.timeLimitRechargeNum = arg_3_1.time_limit_recharge_num
	var_0_2.timeLimitRechargeVersion = arg_3_1.now_time_limit_version
	var_0_2.receiveTimeLimitRechargeList = arg_3_1.receive_time_limit_recharge_list

	self:InitLastVersion()
end

function var_0_0.InitFirstChargeDataFromServer(arg_4_0, arg_4_1)
	var_0_2.firstRechargeIdList = arg_4_1.first_recharge_id_list
end

function var_0_0.IsSignToday(arg_5_0)
	return var_0_1.is_sign == 1
end

function var_0_0.HaveMonthCard(arg_6_0)
	local var_6_0

	if var_0_1.monthly_card_timestamp > 0 then
		if TimeMgr.GetInstance():GetServerTime() >= var_0_1.monthly_card_timestamp then
			var_6_0 = false

			goto label_6_0
		end
	end

	::label_6_0::

	return true
end

function var_0_0.SignToday(arg_7_0)
	var_0_1.is_sign = 1
end

function var_0_0.ResetSign(arg_8_0)
	var_0_1.is_sign = 0
end

function var_0_0.GetCardNum(arg_9_0)
	return var_0_1.monthly_card_num
end

function var_0_0.GetMonthCardDeadTime(arg_10_0)
	return var_0_1.monthly_card_timestamp
end

function var_0_0.MarkBonusGet(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(var_0_2.receiveTotalRechargeList, iter_11_1)
	end
end

function var_0_0.MarkVersionBonusGet(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		table.insert(var_0_2.receiveTimeLimitRechargeList, iter_12_1)
	end
end

function var_0_0.InitLastVersion(arg_13_0)
	local var_13_0 = var_0_2.rechargeVersion

	for iter_13_0, iter_13_1 in pairs(TotalRechargeCfg.get_id_list_by_version) do
		var_13_0 = math.max(var_13_0, iter_13_0)
	end

	var_0_0.targetVersion_ = var_13_0
end

function var_0_0.UpdateVersionToTarget(arg_14_0)
	var_0_2.rechargeVersion = var_0_0.targetVersion_
end

function var_0_0.GetTargetVersion(arg_15_0)
	return var_0_0.targetVersion_
end

function var_0_0.GetTotalRechargeNum(arg_16_0)
	return var_0_2.totalRechargeNum
end

function var_0_0.GetVersionRechargeNum(arg_17_0)
	return var_0_2.timeLimitRechargeNum
end

function var_0_0.GetTotalRechargeVersion(arg_18_0)
	return var_0_2.rechargeVersion or 1
end

function var_0_0.GetTimeLimitRechargeVersion(arg_19_0)
	return var_0_2.timeLimitRechargeVersion or 1
end

function var_0_0.GetTotalReceiveTotalRechargeList(arg_20_0)
	return var_0_2.receiveTotalRechargeList
end

function var_0_0.HaveGetTotalRechargeBonus(arg_21_0, arg_21_1)
	if var_0_0.targetVersion_ == var_0_2.rechargeVersion then
		return table.indexof(var_0_2.receiveTotalRechargeList, arg_21_1) ~= false
	else
		local var_21_0 = TotalRechargeCfg[arg_21_1].num
		local var_21_1 = false

		for iter_21_0, iter_21_1 in ipairs(var_0_2.receiveTotalRechargeList) do
			if TotalRechargeCfg[iter_21_1].num == var_21_0 then
				var_21_1 = true

				break
			end
		end

		return var_21_1
	end
end

function var_0_0.HaveGetTimeLimitRechargeBonus(arg_22_0, arg_22_1)
	if not table.indexof(var_0_2.receiveTimeLimitRechargeList, arg_22_1) then
		return false
	end

	return true
end

function var_0_0.HaveRecharged(arg_23_0, arg_23_1)
	if not table.indexof(var_0_2.firstRechargeIdList, arg_23_1) then
		return false
	end

	return true
end

function var_0_0.RecordTotalRecharge(arg_24_0, arg_24_1)
	var_0_2.totalRechargeNum = var_0_2.totalRechargeNum + PaymentCfg[arg_24_1].total_point
	var_0_2.timeLimitRechargeNum = var_0_2.timeLimitRechargeNum + PaymentCfg[arg_24_1].total_point

	manager.notify:Invoke(TOTAL_RECHARGE_UPDATE, arg_24_1)
	SDKTools.SetRechargePublicAttribute()
	print("totalRechargeData.totalRechargeNum" .. tostring(var_0_2.totalRechargeNum))
	SendMessageManagerToSDK("charge_Total", {
		total = var_0_2.totalRechargeNum
	})
end

function var_0_0.RecordRecharge(arg_25_0, arg_25_1)
	if not table.indexof(var_0_2.firstRechargeIdList, arg_25_1) then
		table.insert(var_0_2.firstRechargeIdList, arg_25_1)
	end

	manager.notify:Invoke(RECHARGE_UPDATE, arg_25_1)
end

function var_0_0:HaveUngetRechargeBonus()
	for iter_26_0, iter_26_1 in ipairs(var_0_0:GetNowRewardList()) do
		if var_0_2.totalRechargeNum >= TotalRechargeCfg[iter_26_1].num and not self:HaveGetTotalRechargeBonus(iter_26_1) then
			return true
		end
	end

	for iter_26_2, iter_26_3 in ipairs(VersionRechargeCfg.get_id_list_by_version[var_0_2.timeLimitRechargeVersion] or {}) do
		if var_0_2.timeLimitRechargeNum >= VersionRechargeCfg[iter_26_3].num and not self:HaveGetTimeLimitRechargeBonus(iter_26_3) then
			return true
		end
	end

	return false
end

function var_0_0:GetMonthCardLastDay()
	local var_27_0 = math.floor((self:GetMonthCardDeadTime() - TimeMgr.GetInstance():GetServerTime()) / 86400)

	if var_27_0 < 0 then
		var_27_0 = 0
	end

	return var_27_0
end

function var_0_0.GetNowRewardList(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(TotalRechargeCfg.get_id_list_by_num) do
		table.insert(var_28_0, {
			num = iter_28_0,
			reward = iter_28_1
		})
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		return arg_29_0.num < arg_29_1.num
	end)

	local var_28_1 = {}

	for iter_28_2, iter_28_3 in ipairs(var_28_0) do
		table.insert(var_28_1, iter_28_3.reward[#iter_28_3.reward])
	end

	return var_28_1
end

return var_0_0
