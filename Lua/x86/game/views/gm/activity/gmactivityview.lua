local var_0_0 = class("GMActivityView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.activityItemList_ = {}
	arg_1_0.optionDataList_ = OptionDataList.New()
	arg_1_0.themeDataList_ = {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(ActivityCfg.get_id_list_by_activity_theme) do
		if iter_1_0 ~= 0 then
			table.insert(var_1_0, iter_1_0)
		end
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_1 < arg_2_0
	end)

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		arg_1_0.optionDataList_.options:Add(OptionData.New(tostring(iter_1_3)))
		table.insert(arg_1_0.themeDataList_, iter_1_3)
	end

	arg_1_0.themeDropDown_.options = arg_1_0.optionDataList_.options

	arg_1_0:InitTimeInput()
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:RefreshItem()
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	arg_5_0.optionDataList_.options:Clear()

	arg_5_0.optionDataList_ = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activityItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.activityItemList_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddToggleListener(arg_6_0.selectAllToggle_, function(arg_7_0)
		arg_6_0:SelectAllItem(arg_7_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		if #GMData:GetActivityList() <= 0 then
			ShowTips("CHOOSE_UPDATE_ACTIVITY")

			return
		end

		local var_8_0 = tonumber(arg_6_0.startYearInput_.text)
		local var_8_1 = tonumber(arg_6_0.startMonthInput_.text)
		local var_8_2 = tonumber(arg_6_0.startDayInput_.text)
		local var_8_3 = tonumber(arg_6_0.startHourInput_.text)
		local var_8_4 = tonumber(arg_6_0.startMinuterInput_.text)
		local var_8_5 = tonumber(arg_6_0.startSecondInput_.text)
		local var_8_6 = manager.time:Table2ServerTime({
			year = var_8_0,
			month = var_8_1,
			day = var_8_2,
			hour = var_8_3,
			min = var_8_4,
			sec = var_8_5
		})
		local var_8_7 = tonumber(arg_6_0.endYearInput_.text)
		local var_8_8 = tonumber(arg_6_0.endMonthInput_.text)
		local var_8_9 = tonumber(arg_6_0.endDayInput_.text)
		local var_8_10 = tonumber(arg_6_0.endHourInput_.text)
		local var_8_11 = tonumber(arg_6_0.endMinuterInput_.text)
		local var_8_12 = tonumber(arg_6_0.endSecondInput_.text)
		local var_8_13 = manager.time:Table2ServerTime({
			year = var_8_7,
			month = var_8_8,
			day = var_8_9,
			hour = var_8_10,
			min = var_8_11,
			sec = var_8_12
		})

		for iter_8_0, iter_8_1 in ipairs(GMData:GetActivityList()) do
			local var_8_14 = string.format("$ wjhd set %s %s %s", iter_8_1, var_8_6, var_8_13)

			manager.net:Push(27100, {
				content = var_8_14
			})
			print(var_8_14)
		end
	end)
	arg_6_0:AddToggleListener(arg_6_0.themeDropDown_, function(arg_9_0)
		arg_6_0:RefreshItem()
	end)
	arg_6_0:AddBtnListener(arg_6_0.refreshBtn_, nil, function()
		arg_6_0:RefreshItem()
	end)
end

function var_0_0.RefreshItem(arg_11_0)
	local var_11_0 = arg_11_0.themeDataList_[arg_11_0.themeDropDown_.value + 1]
	local var_11_1 = ActivityCfg.get_id_list_by_activity_theme[var_11_0]

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		arg_11_0.activityItemList_[iter_11_0] = arg_11_0.activityItemList_[iter_11_0] or GMActivityItem.New(arg_11_0.itemGo_, arg_11_0.itemParent_)

		arg_11_0.activityItemList_[iter_11_0]:SetData(iter_11_1)
	end

	for iter_11_2 = #arg_11_0.activityItemList_, #var_11_1 + 1, -1 do
		arg_11_0.activityItemList_[iter_11_2]:Dispose()

		arg_11_0.activityItemList_[iter_11_2] = nil
	end
end

function var_0_0.SelectAllItem(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.activityItemList_) do
		iter_12_1:SelectItem(arg_12_1)
	end
end

function var_0_0.InitTimeInput(arg_13_0)
	local var_13_0 = manager.time:GetServerTime()
	local var_13_1 = tonumber(os.date("%Y", var_13_0))
	local var_13_2 = tonumber(os.date("%m", var_13_0))
	local var_13_3 = tonumber(os.date("%d", var_13_0))
	local var_13_4 = tonumber(os.date("%H", var_13_0))
	local var_13_5 = tonumber(os.date("%M", var_13_0))
	local var_13_6 = tonumber(os.date("%S", var_13_0))

	arg_13_0.startYearInput_.text = var_13_1
	arg_13_0.startMonthInput_.text = var_13_2
	arg_13_0.startDayInput_.text = var_13_3
	arg_13_0.startHourInput_.text = var_13_4
	arg_13_0.startMinuterInput_.text = var_13_5
	arg_13_0.startSecondInput_.text = var_13_6
	arg_13_0.endYearInput_.text = var_13_1
	arg_13_0.endMonthInput_.text = var_13_2
	arg_13_0.endDayInput_.text = var_13_3 + 1
	arg_13_0.endHourInput_.text = var_13_4
	arg_13_0.endMinuterInput_.text = var_13_5
	arg_13_0.endSecondInput_.text = var_13_6
end

return var_0_0
