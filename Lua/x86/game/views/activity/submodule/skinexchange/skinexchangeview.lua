local var_0_0 = class("SkinExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SkinExchangeTool.GetMainUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.costList_ = {}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, SkinExchangeCostItem)
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.costList_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if arg_6_0.activityData_:IsActivitying() then
			local var_7_0, var_7_1 = SkinExchangeTool.IsCanExchange(arg_6_0.activityID_)

			if var_7_0 then
				SkinExchangeAction:ExchangeSkin(arg_6_0.activityID_)
			else
				ShowTips(var_7_1)
			end
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:GetActivityData()
	arg_8_0:RefreshData()
	arg_8_0:BindRedPointUI()
end

function var_0_0.GetActivityData(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.activityData_ = ActivityData:GetActivityData(arg_9_0.activityID_)
	arg_9_0.startTime_ = arg_9_0.activityData_.startTime
	arg_9_0.stopTime_ = arg_9_0.activityData_.stopTime
end

function var_0_0.RefreshData(arg_10_0)
	arg_10_0:RefreshCost()
	arg_10_0:RefreshState()
	arg_10_0:RefreshTime()
end

function var_0_0.RefreshCost(arg_11_0)
	arg_11_0.cfg_ = ActivitySkinExchangeCfg[arg_11_0.activityID_]
	arg_11_0.costList_ = arg_11_0.cfg_.cost

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.costList_)
end

function var_0_0.RefreshState(arg_12_0)
	if SkinExchangeData:GetState(arg_12_0.activityID_) == 1 then
		arg_12_0.stateCon_:SetSelectedState("finish")
	else
		arg_12_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshTime(arg_13_0)
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()

	arg_13_0:StopTimer()

	if var_13_1 < arg_13_0.startTime_ and arg_13_0.activityData_.state == 0 then
		arg_13_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_13_0.timer_ = Timer.New(function()
			var_13_0 = arg_13_0.startTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	elseif var_13_1 >= arg_13_0.startTime_ and arg_13_0.activityData_.state == 0 then
		arg_13_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_13_0.timer_ = Timer.New(function()
			arg_13_0:StopTimer()
			arg_13_0:RefreshTime()
		end, 10, 1)

		arg_13_0.timer_:Start()
	elseif var_13_1 < arg_13_0.stopTime_ then
		arg_13_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_13_0.stopTime_, true)
		arg_13_0.timer_ = Timer.New(function()
			var_13_0 = arg_13_0.stopTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end

			arg_13_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_13_0.stopTime_, true)
		end, 1, -1)

		arg_13_0.timer_:Start()
	else
		arg_13_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.OnActivitySkinExchange(arg_17_0)
	arg_17_0:RefreshData()
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

function var_0_0.BindRedPointUI(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.btn_.transform, RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. arg_19_0.activityID_)
end

function var_0_0.UnBindRedPointUI(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.btn_.transform, RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. arg_20_0.activityID_)
end

function var_0_0.OnTop(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.cfg_.cost) do
		table.insert(var_21_0, iter_21_1[1])
	end

	local var_21_1 = {
		BACK_BAR,
		HOME_BAR
	}

	table.insertto(var_21_1, var_21_0)
	manager.windowBar:SwitchBar(var_21_1)

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		manager.windowBar:SetBarCanAdd(iter_21_3, true)
	end
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:StopTimer()
	arg_22_0:UnBindRedPointUI()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
