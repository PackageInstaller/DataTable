local var_0_0 = singletonClass("AccumulateSignData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {
		login_days = 0,
		version = 1,
		open_sign = true,
		award_ids = {}
	}
	var_0_2 = {
		version = 1,
		monthly_card_num = 0,
		passport_buy_list = {}
	}
end

function var_0_0.InitAccumulateSignData(arg_2_0, arg_2_1)
	var_0_1 = {
		version = arg_2_1.version,
		open_sign = arg_2_1.open_sign,
		login_days = arg_2_1.login_days,
		award_ids = arg_2_1.award_ids or {}
	}
end

function var_0_0.InitDiscountData(arg_3_0, arg_3_1)
	var_0_2 = {
		version = arg_3_1.version,
		monthly_card_num = arg_3_1.cumulative_buy_card_num,
		passport_buy_list = arg_3_1.cumulative_buy_battlepass_list
	}
end

function var_0_0.UpdateAwardID(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if not table.indexof(var_0_1.award_ids, iter_4_1) then
			table.insert(var_0_1.award_ids, iter_4_1)
		end
	end
end

function var_0_0.UpdateAccumulateViewOpen(arg_5_0, arg_5_1)
	var_0_1.open_sign = arg_5_1
end

function var_0_0.GetVersion(arg_6_0)
	return var_0_1.version
end

function var_0_0.GetMonthCardNumAndLv(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(GameSetting.monthlycard_sale.value) do
		if var_0_2.monthly_card_num >= iter_7_1[1] then
			var_7_0 = iter_7_1[1]
		end
	end

	return var_0_2.monthly_card_num, var_7_0
end

function var_0_0.GetPassportNumAndLv(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = #var_0_2.passport_buy_list
	local var_8_2 = var_8_1
	local var_8_3 = PassportData:GetId()

	for iter_8_0, iter_8_1 in ipairs(var_0_2.passport_buy_list) do
		if iter_8_1 == var_8_3 then
			var_8_2 = var_8_1 - 1

			break
		end
	end

	for iter_8_2, iter_8_3 in ipairs(GameSetting.battlepass_sale.value) do
		if var_8_2 >= iter_8_3[1] then
			var_8_0 = iter_8_3[1]
		end
	end

	return var_8_1, var_8_0
end

function var_0_0.GetLoginNum(arg_9_0)
	return var_0_1.login_days
end

function var_0_0.GetAccumulateRewards(arg_10_0)
	return var_0_1.award_ids
end

function var_0_0.GetIsOpened(arg_11_0)
	return var_0_1.open_sign
end

function var_0_0.GetRewardState(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(var_0_1.award_ids) do
		if iter_12_1 == arg_12_1 then
			return 2
		end
	end

	if AccumulateLoginCfg[arg_12_1].num <= var_0_1.login_days then
		return 0
	else
		return 1
	end
end

function var_0_0.GetMonthCardPaymentID(arg_13_0)
	local var_13_0, var_13_1 = var_0_0:GetMonthCardNumAndLv()

	if var_13_1 > 0 then
		return GameSetting.monthlycard_sale.value[var_13_1][2]
	else
		return 101
	end
end

function var_0_0.GetPassportPaymentID(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = var_0_0:GetPassportNumAndLv()

	if var_14_1 > 0 then
		if arg_14_1 == 1 then
			return GameSetting.battlepass_sale.value[var_14_1][2]
		elseif arg_14_1 == 2 then
			return GameSetting.battlepass_highlevel_sale.value[var_14_1][2]
		elseif arg_14_1 == 3 then
			return GameSetting.battlepass_upgrade_sale.value[var_14_1][2]
		end
	elseif arg_14_1 == 1 then
		return 201
	elseif arg_14_1 == 2 then
		return 202
	elseif arg_14_1 == 3 then
		return 203
	end
end

function var_0_0.GetCanReward(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(AccumulateLoginCfg.get_id_list_by_version[var_0_1.version]) do
		if var_0_0:GetRewardState(iter_15_1) == 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetProgress(arg_16_0, arg_16_1)
	local var_16_0 = AccumulateLoginCfg[arg_16_1].num
	local var_16_1 = 0
	local var_16_2 = AccumulateLoginCfg.get_id_list_by_version[var_0_1.version]
	local var_16_3 = table.indexof(var_16_2, arg_16_1)

	if var_16_3 > 1 then
		var_16_1 = AccumulateLoginCfg[var_16_2[var_16_3 - 1]].num
	end

	return (var_0_1.login_days - var_16_1) / (var_16_0 - var_16_1)
end

function var_0_0.GetShowProgress(arg_17_0)
	local var_17_0 = AccumulateLoginCfg.get_id_list_by_version[var_0_1.version]
	local var_17_1 = 0
	local var_17_2 = 1
	local var_17_3 = -1
	local var_17_4 = 1
	local var_17_5 = false

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_0 == 1 then
			var_17_2 = AccumulateLoginCfg[iter_17_1].num
			var_17_3 = iter_17_1
			var_17_4 = iter_17_0
		end

		local var_17_6 = AccumulateLoginCfg[iter_17_1]

		if var_0_1.login_days >= var_17_6.num then
			if var_0_0:GetRewardState(iter_17_1) == 0 then
				var_17_2 = var_17_6.num
				var_17_3 = iter_17_1
				var_17_4 = iter_17_0
				var_17_5 = false

				break
			end

			if var_17_0[iter_17_0 + 1] then
				var_17_3 = var_17_0[iter_17_0 + 1]
				var_17_4 = iter_17_0 + 1
				var_17_2 = AccumulateLoginCfg[var_17_3].num
				var_17_1 = var_17_6.num
			else
				var_17_3 = iter_17_1
				var_17_4 = iter_17_0
				var_17_2 = var_17_6.num
				var_17_1 = var_17_6.num
			end
		end
	end

	if var_0_0:GetRewardState(var_17_3) == 2 then
		var_17_5 = true
	end

	local var_17_7 = 1

	if var_17_1 < var_17_2 then
		var_17_7 = (var_0_1.login_days - var_17_1) / (var_17_2 - var_17_1)
	end

	return var_0_1.login_days, var_17_2, var_17_7, var_17_3, var_17_5, var_17_4
end

return var_0_0
