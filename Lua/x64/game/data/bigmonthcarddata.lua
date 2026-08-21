local var_0_0 = singletonClass("BigMonthCardData")
local var_0_1 = {
	sign_days = 0,
	is_expire_tip = 0,
	template_id = 0,
	monthly_card_timestamp = 0,
	is_sign = 0,
	have_sign = {},
	daily_record = {}
}
local var_0_2 = false

function var_0_0.Init(arg_1_0)
	var_0_1.monthly_card_timestamp = 0
	var_0_1.is_sign = 0
	var_0_1.sign_days = 0
	var_0_1.have_sign = {}
	var_0_1.daily_record = {}
	var_0_1.is_expire_tip = 0
	var_0_1.template_id = 0
	var_0_2 = false
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1.monthly_card_timestamp = arg_2_1.buy_timestamp
	var_0_1.is_sign = arg_2_1.is_sign
	var_0_1.sign_days = arg_2_1.total_sign_times
	var_0_1.have_sign = arg_2_1.total_sign_receive_list
	var_0_1.is_expire_tip = arg_2_1.is_expire_tip
	var_0_1.template_id = arg_2_1.template_id

	arg_2_0:InitRecord(arg_2_1.daily_record)
end

function var_0_0.UpdateIsSign(arg_3_0, arg_3_1)
	var_0_1.is_sign = arg_3_1
end

function var_0_0.UpdateSignData(arg_4_0, arg_4_1)
	var_0_1.sign_days = arg_4_1
end

function var_0_0.InitRecord(arg_5_0, arg_5_1)
	var_0_1.daily_record = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		var_0_1.daily_record[iter_5_1.index] = iter_5_1.times
	end
end

function var_0_0.IsSignToday(arg_6_0)
	return var_0_1.is_sign == 1
end

function var_0_0.HaveMonthCard(arg_7_0)
	return var_0_1.monthly_card_timestamp > 0 and TimeMgr.GetInstance():GetServerTime() < arg_7_0:GetMonthCardDeadTime()
end

function var_0_0.SignToday(arg_8_0)
	var_0_1.is_sign = 1
	var_0_1.sign_days = var_0_1.sign_days + 1
end

function var_0_0.SignAccumulate(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return
	end

	if #arg_9_1 == 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if table.indexof(var_0_1.have_sign, iter_9_1) then
			break
		end

		table.insert(var_0_1.have_sign, iter_9_1)
	end
end

function var_0_0.IsNeedAccumulatSign(arg_10_0)
	local var_10_0 = var_0_1.template_id

	if var_10_0 == 0 then
		return false
	end

	local var_10_1 = false
	local var_10_2 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_10_0]

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_3 = BigMonthCardAccumulationCfg[iter_10_1]

		if var_0_1.sign_days >= var_10_3.accumulation and not table.indexof(var_0_1.have_sign, iter_10_1) then
			var_10_1 = true

			break
		end
	end

	return var_10_1
end

function var_0_0.ResetSign(arg_11_0)
	var_0_1.is_sign = 0
end

function var_0_0.GetMonthCardDeadTime(arg_12_0)
	local var_12_0
	local var_12_1 = var_0_1.monthly_card_timestamp

	if tonumber(manager.time:STimeDescS(var_12_1, "!%H")) < GameSetting.refresh_time1.value[1][1] then
		local var_12_2 = tonumber(manager.time:STimeDescS(var_12_1 - 86400, "!%Y"))
		local var_12_3 = tonumber(manager.time:STimeDescS(var_12_1 - 86400, "!%m"))
		local var_12_4 = tonumber(manager.time:STimeDescS(var_12_1 - 86400, "!%d"))
		local var_12_5 = {
			year = var_12_2,
			month = var_12_3,
			day = var_12_4,
			hour = GameSetting.refresh_time1.value[1][1],
			min = GameSetting.refresh_time1.value[1][2],
			sec = GameSetting.refresh_time1.value[1][3]
		}

		var_12_0 = manager.time:Table2ServerTime(var_12_5)
	else
		local var_12_6 = tonumber(manager.time:STimeDescS(var_12_1, "!%Y"))
		local var_12_7 = tonumber(manager.time:STimeDescS(var_12_1, "!%m"))
		local var_12_8 = tonumber(manager.time:STimeDescS(var_12_1, "!%d"))
		local var_12_9 = {
			year = var_12_6,
			month = var_12_7,
			day = var_12_8,
			hour = GameSetting.refresh_time1.value[1][1],
			min = GameSetting.refresh_time1.value[1][2],
			sec = GameSetting.refresh_time1.value[1][3]
		}

		var_12_0 = manager.time:Table2ServerTime(var_12_9)
	end

	return var_12_0 + (GameSetting.big_monthly_card_duration.value[1] + 1) * 86400
end

function var_0_0.GetSignDays(arg_13_0)
	return var_0_1.sign_days
end

function var_0_0.GetHaveSign(arg_14_0)
	return var_0_1.have_sign
end

function var_0_0.SetRecord(arg_15_0, arg_15_1)
	arg_15_0:InitRecord(arg_15_1.daily_record)
end

function var_0_0.GetRecord(arg_16_0)
	return var_0_1.daily_record
end

function var_0_0.GetMonthCardLastDay(arg_17_0)
	local var_17_0 = arg_17_0:GetMonthCardDeadTime() - TimeMgr.GetInstance():GetServerTime()
	local var_17_1 = math.floor(var_17_0 / 86400) - var_0_1.is_sign

	if var_17_1 < 0 then
		var_17_1 = 0
	end

	return var_17_1
end

function var_0_0.LoginPopFlag(arg_18_0)
	if not var_0_2 then
		var_0_2 = true

		return var_0_2
	end

	return false
end

function var_0_0.IsExpireTip(arg_19_0)
	return var_0_1.is_expire_tip
end

function var_0_0.SetIsExpireTip(arg_20_0)
	var_0_1.is_expire_tip = 0
end

function var_0_0.GetTemplateId(arg_21_0)
	return var_0_1.template_id
end

return var_0_0
