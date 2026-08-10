local var_0_0 = singletonClass("PassportData")
local var_0_1 = {
	id = 0,
	payLevel = 0,
	isStart = 0,
	nextRefreshTimestamp = 0,
	startTimestamp = 0,
	endTimestamp = 0,
	weeklyGainExp = 0,
	receiveInfo = {}
}

function var_0_0.Init(arg_1_0)
	var_0_1.id = 0
	var_0_1.payLevel = 0
	var_0_1.nextRefreshTimestamp = 0
	var_0_1.isStart = 0
	var_0_1.receiveInfo = {}
	var_0_1.weeklyGainExp = 0
	var_0_1.startTimestamp = 0
	var_0_1.endTimestamp = 0
end

function var_0_0.InitWithServerData(arg_2_0, arg_2_1)
	var_0_1.id = arg_2_1.battlepass_list_id
	var_0_1.payLevel = arg_2_1.pay_level
	var_0_1.nextRefreshTimestamp = arg_2_1.next_refresh_timestamp
	var_0_1.isStart = arg_2_1.is_start
	var_0_1.receiveInfo = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.receive_info) do
		if not var_0_1.receiveInfo[iter_2_1.id] then
			var_0_1.receiveInfo[iter_2_1.id] = {}
		end

		table.insert(var_0_1.receiveInfo[iter_2_1.id], {
			id = iter_2_1.id,
			isPay = iter_2_1.is_pay
		})
	end

	var_0_1.weeklyGainExp = arg_2_1.weekly_gain_exp
	var_0_1.startTimestamp = arg_2_1.start_timestamp
	var_0_1.endTimestamp = arg_2_1.end_timestamp

	manager.notify:Invoke(PASSPORT_INIT, 0)
end

function var_0_0.GetBonusSuccess(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.receiveInfo = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not var_0_1.receiveInfo[iter_3_1.id] then
			var_0_1.receiveInfo[iter_3_1.id] = {}
		end

		table.insert(var_0_1.receiveInfo[iter_3_1.id], {
			id = iter_3_1.id,
			isPay = iter_3_1.is_pay
		})
	end

	manager.notify:Invoke(GET_BONUS_SUCCESS, arg_3_1)
end

function var_0_0.HaveGetBonus(arg_4_0, arg_4_1)
	if var_0_1.receiveInfo[arg_4_1] then
		if var_0_1.payLevel == 0 then
			for iter_4_0, iter_4_1 in ipairs(var_0_1.receiveInfo[arg_4_1]) do
				if iter_4_1.isPay == 0 then
					return true
				end
			end

			return false
		else
			return var_0_1.receiveInfo[arg_4_1] ~= nil and #var_0_1.receiveInfo[arg_4_1] == 2
		end
	end

	return false
end

function var_0_0.HaveReceiveInfo(arg_5_0, arg_5_1)
	if var_0_1.receiveInfo[arg_5_1] and #var_0_1.receiveInfo[arg_5_1] > 0 then
		return true
	end

	return false
end

function var_0_0.MarkAllBonusGet(arg_6_0, arg_6_1)
	if var_0_1.id == 0 then
		return
	end

	var_0_1.receiveInfo = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.receive_info) do
		if not var_0_1.receiveInfo[iter_6_1.id] then
			var_0_1.receiveInfo[iter_6_1.id] = {}
		end

		table.insert(var_0_1.receiveInfo[iter_6_1.id], {
			id = iter_6_1.id,
			isPay = iter_6_1.is_pay
		})
	end

	manager.notify:Invoke(GET_BONUS_SUCCESS, 0)
end

function var_0_0.GetLevel(arg_7_0)
	local var_7_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)

	for iter_7_0 = arg_7_0:GetMaxLevel(), 1, -1 do
		if var_7_0 >= GameLevelSetting[iter_7_0].battlepass_lv_exp_sum then
			return iter_7_0
		end
	end

	return 0
end

function var_0_0.GetCurrentExp(arg_8_0)
	local var_8_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)
	local var_8_1 = arg_8_0:GetLevel()

	if var_8_1 == 0 then
		return var_8_0
	end

	return var_8_0 - GameLevelSetting[var_8_1].battlepass_lv_exp_sum
end

function var_0_0.GetUpgradeNeedExp(arg_9_0)
	local var_9_0 = arg_9_0:GetLevel()

	if var_9_0 >= arg_9_0:GetMaxLevel() then
		return GameLevelSetting[arg_9_0:GetMaxLevel()].battlepass_level_exp
	end

	return GameLevelSetting[var_9_0 + 1].battlepass_level_exp
end

function var_0_0.GetCurrentStatus(arg_10_0)
	local var_10_0 = arg_10_0:GetLevel()
	local var_10_1 = var_10_0 == arg_10_0:GetMaxLevel() and 0 or var_10_0 + 1
	local var_10_2 = 0

	if not arg_10_0:IsOpen() then
		return var_10_2, var_10_1
	end

	local var_10_3 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[var_0_1.id].battlepass_type]

	for iter_10_0, iter_10_1 in ipairs(var_10_3) do
		local var_10_4 = BattlePassCfg[iter_10_1]

		if iter_10_0 <= var_10_0 then
			if var_0_1.receiveInfo[iter_10_1] == nil or #var_0_1.receiveInfo[iter_10_1] == 0 then
				for iter_10_2, iter_10_3 in ipairs(var_10_4.reward_free) do
					var_10_2 = iter_10_0

					return var_10_2, var_10_1
				end

				if arg_10_0:GetPayLevel() > 0 then
					for iter_10_4, iter_10_5 in ipairs(var_10_4.reward_pay) do
						var_10_2 = iter_10_0

						return var_10_2, var_10_1
					end
				end
			elseif arg_10_0:GetPayLevel() > 0 and #var_0_1.receiveInfo[iter_10_1] == 1 and var_0_1.receiveInfo[iter_10_1][1].isPay == 0 then
				for iter_10_6, iter_10_7 in ipairs(var_10_4.reward_pay) do
					var_10_2 = iter_10_0

					return var_10_2, var_10_1
				end
			end
		end
	end

	return var_10_2, var_10_1
end

function var_0_0.GetCanGetBonusList(arg_11_0)
	local var_11_0 = arg_11_0:GetLevel()
	local var_11_1 = {}

	if not arg_11_0:IsOpen() then
		return var_11_1
	end

	local var_11_2 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[var_0_1.id].battlepass_type]

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = BattlePassCfg[iter_11_1]

		if iter_11_0 <= var_11_0 then
			if var_0_1.receiveInfo[iter_11_1] == nil then
				for iter_11_2, iter_11_3 in ipairs(var_11_3.reward_free) do
					table.insert(var_11_1, iter_11_3)
				end

				if arg_11_0:GetPayLevel() > 0 then
					for iter_11_4, iter_11_5 in ipairs(var_11_3.reward_pay) do
						table.insert(var_11_1, iter_11_5)
					end
				end
			elseif arg_11_0:GetPayLevel() > 0 and #var_0_1.receiveInfo[iter_11_1] == 1 and var_0_1.receiveInfo[iter_11_1][1].isPay == 0 then
				for iter_11_6, iter_11_7 in ipairs(var_11_3.reward_pay) do
					table.insert(var_11_1, iter_11_7)
				end
			end
		end
	end

	return var_11_1
end

function var_0_0.BuyedCard(arg_12_0, arg_12_1)
	if arg_12_1 == 201 then
		var_0_1.payLevel = 201
	elseif arg_12_1 == 202 then
		var_0_1.payLevel = 202
	elseif arg_12_1 == 203 then
		var_0_1.payLevel = 202
	end

	manager.notify:Invoke(PASSPORT_BUYED)
end

function var_0_0.GetRewardStatus(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = GameLevelSetting[arg_13_1]
	local var_13_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)
	local var_13_2 = arg_13_0:HaveGetBonus(arg_13_2)
	local var_13_3 = arg_13_0:GetPayLevel() > 0 and "pay" or "free"

	if var_13_2 then
		return var_13_3 .. "HaveGet"
	elseif var_13_1 >= var_13_0.battlepass_lv_exp_sum then
		if var_13_3 == "free" then
			return var_13_3 .. "CanGet"
		elseif arg_13_0:HaveReceiveInfo(arg_13_2) then
			return var_13_3 .. "HalfCanGet"
		else
			return var_13_3 .. "CanGet"
		end
	else
		return var_13_3 .. "CannotGet"
	end
end

function var_0_0.GetReceiveInfo(arg_14_0, arg_14_1)
	return var_0_1.receiveInfo[arg_14_1]
end

function var_0_0.GetPayLevel(arg_15_0)
	return var_0_1.payLevel
end

function var_0_0.GetExpWeekly(arg_16_0)
	return var_0_1.weeklyGainExp
end

function var_0_0.GetStartTimestamp(arg_17_0)
	return var_0_1.startTimestamp
end

function var_0_0.GetEndTimestamp(arg_18_0)
	return var_0_1.endTimestamp
end

function var_0_0.GetId(arg_19_0)
	return var_0_1.id
end

function var_0_0.GetCurrentActivityId(arg_20_0)
	return BattlePassListCfg[var_0_1.id].activity_id
end

function var_0_0.GetMaxLevel(arg_21_0)
	if var_0_1.id == 0 then
		return 10
	end

	return #BattlePassCfg.get_id_list_by_type[BattlePassListCfg[var_0_1.id].battlepass_type]
end

function var_0_0.AddWeeklyExp(arg_22_0, arg_22_1)
	var_0_1.weeklyGainExp = var_0_1.weeklyGainExp + arg_22_1
end

function var_0_0.IsOpen(arg_23_0)
	if var_0_1.id == 0 then
		return false
	end

	return var_0_1.isStart == 1
end

function var_0_0.IsUnlock(arg_24_0)
	return not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.PASSPORT_MAIN)
end

function var_0_0.GetNextRefreshTimestamp(arg_25_0)
	return var_0_1.nextRefreshTimestamp
end

function var_0_0.GetPassportType(arg_26_0)
	if arg_26_0:GetId() == PassportConst.VSN_42_PASSPORT_ID then
		return PassportConst.PASSPORT_ALL_TYPE.VSN_42
	end

	return PassportConst.PASSPORT_ALL_TYPE.DEFAULT
end

function var_0_0.HasDiscount(arg_27_0)
	local var_27_0 = PassportData:GetPayLevel()

	if var_27_0 >= PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL then
		return false, nil
	end

	local var_27_1 = arg_27_0:GetPassportType()

	if var_27_1 == PassportConst.PASSPORT_ALL_TYPE.VSN_42 then
		return true, "ACTIVITY_COLLAB_BP_DISCOUNT_TIPS"
	end

	local var_27_2 = PassportConst.PASSPORT_ALL_PAY_ID[var_27_1][PassportConst.PASSPORT_USER_TYPE.RETURN]

	if var_27_0 <= PassportConst.PASSPORT_USER_LEVEL.NOT_BUY then
		if RegressionDataNew:CheckIsCanBuyPassportPayID(var_27_2[1]) or RegressionDataNew:CheckIsCanBuyPassportPayID(var_27_2[2]) then
			return true, nil
		end
	elseif var_27_0 <= PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL and RegressionDataNew:CheckIsCanBuyPassportPayID(var_27_2[3]) then
		return true, nil
	end

	return false, nil
end

return var_0_0
