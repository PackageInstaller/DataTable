local var_0_0 = class("SkinTrialActivityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/OsirisUI/OsirisSkinTrialMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skinItemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	arg_4_0:RefreshUI()
	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	arg_5_0:StopTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.skinItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.skinItemList_ = nil
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.skinTrialIDList_ = arg_7_0:GetskinTrialIDList()

	arg_7_0:RefreshSkinItem()
end

function var_0_0.RefreshSkinItem(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.skinTrialIDList_) do
		if arg_8_0.skinItemList_[iter_8_0] then
			arg_8_0.skinItemList_[iter_8_0]:SetSkinTrialID(iter_8_1)
		else
			arg_8_0.skinItemList_[iter_8_0] = arg_8_0:GetItemClass().New(arg_8_0.skinItem_, arg_8_0.skinItemPanel_, iter_8_1, arg_8_0.activityID_)
		end
	end

	for iter_8_2 = #arg_8_0.skinItemList_, #arg_8_0.skinTrialIDList_ + 1, -1 do
		arg_8_0.skinItemList_[iter_8_2]:Dispose()

		arg_8_0.skinItemList_[iter_8_2] = nil
	end
end

function var_0_0.GetskinTrialIDList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = ActivityData:GetActivityData(arg_9_0.activityID_).subActivityIdList

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_9_1]

		for iter_9_2, iter_9_3 in ipairs(var_9_2) do
			table.insert(var_9_0, iter_9_3)
		end
	end

	return var_9_0
end

function var_0_0.AddTimer(arg_10_0)
	if manager.time:GetServerTime() >= arg_10_0.stopTime_ then
		arg_10_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.skinTrialIDList_) do
		if arg_10_0.skinItemList_[iter_10_0] and arg_10_0.skinItemList_[iter_10_0].RefreshTime ~= nil then
			arg_10_0.skinItemList_[iter_10_0]:RefreshTime()
		end
	end

	arg_10_0.textTime_.text = string.format(GetTips("LEFT_TIME"), GetI18NText(manager.time:GetLostTimeStr(arg_10_0.stopTime_)))
	arg_10_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_10_0.stopTime_ then
			arg_10_0:StopTimer()

			arg_10_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		for iter_11_0, iter_11_1 in ipairs(arg_10_0.skinTrialIDList_) do
			if arg_10_0.skinItemList_[iter_11_0] and arg_10_0.skinItemList_[iter_11_0].RefreshTime ~= nil then
				arg_10_0.skinItemList_[iter_11_0]:RefreshTime()
			end
		end

		arg_10_0.textTime_.text = string.format(GetTips("LEFT_TIME"), GetI18NText(manager.time:GetLostTimeStr(arg_10_0.stopTime_)))
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.GetItemClass(arg_13_0)
	return SkinTrialActivityItem
end

return var_0_0
