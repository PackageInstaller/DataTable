local GMActivityView = class("GMActivityView", ReduxView)

function GMActivityView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.activityItemList_ = {}
	self.optionDataList_ = OptionDataList.New()
	self.themeDataList_ = {}

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
		self.optionDataList_.options:Add(OptionData.New(tostring(iter_1_3)))
		table.insert(self.themeDataList_, iter_1_3)
	end

	self.themeDropDown_.options = self.optionDataList_.options

	self:InitTimeInput()
end

function GMActivityView:OnEnter()
	self:RefreshItem()
end

function GMActivityView:OnExit()
	return
end

function GMActivityView:Dispose()
	GMActivityView.super.Dispose(self)
	self.optionDataList_.options:Clear()

	self.optionDataList_ = nil

	for iter_5_0, iter_5_1 in ipairs(self.activityItemList_) do
		iter_5_1:Dispose()
	end

	self.activityItemList_ = nil
end

function GMActivityView:AddListeners()
	self:AddToggleListener(self.selectAllToggle_, function(arg_7_0)
		self:SelectAllItem(arg_7_0)
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_8_0

		if #GMData:GetActivityList() <= 0 then
			ShowTips("CHOOSE_UPDATE_ACTIVITY")

			do return end

			var_8_0 = {}
		end

		var_8_0.year = tonumber(self.startYearInput_.text)
		var_8_0.month = tonumber(self.startMonthInput_.text)
		var_8_0.day = tonumber(self.startDayInput_.text)
		var_8_0.hour = tonumber(self.startHourInput_.text)
		var_8_0.min = tonumber(self.startMinuterInput_.text)
		var_8_0.sec = tonumber(self.startSecondInput_.text)

		local var_8_1 = manager.time:Table2ServerTime(var_8_0)
		local var_8_2 = manager.time:Table2ServerTime({
			year = tonumber(self.endYearInput_.text),
			month = tonumber(self.endMonthInput_.text),
			day = tonumber(self.endDayInput_.text),
			hour = tonumber(self.endHourInput_.text),
			min = tonumber(self.endMinuterInput_.text),
			sec = tonumber(self.endSecondInput_.text)
		})

		for iter_8_0, iter_8_1 in ipairs(GMData:GetActivityList()) do
			local var_8_3 = string.format("$ wjhd set %s %s %s", iter_8_1, var_8_1, var_8_2)

			manager.net:Push(27100, {
				content = var_8_3
			})
			print(var_8_3)
		end
	end)
	self:AddToggleListener(self.themeDropDown_, function(arg_9_0)
		self:RefreshItem()
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		self:RefreshItem()
	end)
end

function GMActivityView:RefreshItem()
	for iter_11_0, iter_11_1 in ipairs(ActivityCfg.get_id_list_by_activity_theme[self.themeDataList_[self.themeDropDown_.value + 1]]) do
		self.activityItemList_[iter_11_0] = self.activityItemList_[iter_11_0] or GMActivityItem.New(self.itemGo_, self.itemParent_)

		self.activityItemList_[iter_11_0]:SetData(iter_11_1)
	end

	for iter_11_2 = #self.activityItemList_, #ActivityCfg.get_id_list_by_activity_theme[self.themeDataList_[self.themeDropDown_.value + 1]] + 1, -1 do
		self.activityItemList_[iter_11_2]:Dispose()

		self.activityItemList_[iter_11_2] = nil
	end
end

function GMActivityView:SelectAllItem(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.activityItemList_) do
		iter_12_1:SelectItem(arg_12_1)
	end
end

function GMActivityView:InitTimeInput()
	local var_13_0 = manager.time:GetServerTime()
	local var_13_1 = tonumber(os.date("%Y", var_13_0))
	local var_13_2 = tonumber(os.date("%m", var_13_0))
	local var_13_3 = tonumber(os.date("%d", var_13_0))
	local var_13_4 = tonumber(os.date("%H", var_13_0))
	local var_13_5 = tonumber(os.date("%M", var_13_0))
	local var_13_6 = tonumber(os.date("%S", var_13_0))

	self.startYearInput_.text = var_13_1
	self.startMonthInput_.text = var_13_2
	self.startDayInput_.text = var_13_3
	self.startHourInput_.text = var_13_4
	self.startMinuterInput_.text = var_13_5
	self.startSecondInput_.text = var_13_6
	self.endYearInput_.text = var_13_1
	self.endMonthInput_.text = var_13_2
	self.endDayInput_.text = var_13_3 + 1
	self.endHourInput_.text = var_13_4
	self.endMinuterInput_.text = var_13_5
	self.endSecondInput_.text = var_13_6
end

return GMActivityView
