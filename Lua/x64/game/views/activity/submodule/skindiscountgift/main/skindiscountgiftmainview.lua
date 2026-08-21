local var_0_0 = class("SkinDiscountGiftMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeSkinEventUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.signController_ = arg_3_0.signControllerEx_:GetController("state")
	arg_3_0.signItemList_ = {}
	arg_3_0.discountItemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SKIN_DISCOUNT_GIFT_DESC")

	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.signActivityID_ = SkinDiscountGiftTools.GetSignActivityID(arg_4_0.activityID_)

	arg_4_0:RefreshSignItemList()
	arg_4_0:RefreshDiscountItemList()
	arg_4_0:AutoGetReward()
	SkinDiscountGiftAction.ClearRedPointNewTag(arg_4_0.activityID_)
	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	arg_5_0:StopTimer()
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.signItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.signItemList_ = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.discountItemList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.discountItemList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.RefreshSignItemList(arg_8_0)
	local var_8_0 = 1

	for iter_8_0, iter_8_1 in ipairs(ActivityCumulativeSignCfg[arg_8_0.signActivityID_].config_list) do
		arg_8_0.signItemList_[iter_8_0] = arg_8_0.signItemList_[iter_8_0] or SkinDiscountGiftMainSignItem.New(arg_8_0[string.format("signRewardGo%s_", iter_8_0)])

		arg_8_0.signItemList_[iter_8_0]:SetData(arg_8_0.signActivityID_, iter_8_0, iter_8_1)

		if SkinDiscountGiftTools.GetSignState(arg_8_0.signActivityID_, iter_8_0) ~= ActivityConst.SIGN_STATE.NONE then
			var_8_0 = iter_8_0
		end
	end

	arg_8_0.signController_:SetSelectedState(string.format("state%s", var_8_0 - 1))
end

function var_0_0.RefreshDiscountItemList(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(ActivitySkinDiscountCfg.get_id_list_by_activity_id[arg_9_0.activityID_]) do
		arg_9_0.discountItemList_[iter_9_0] = arg_9_0.discountItemList_[iter_9_0] or SkinDiscountGiftMainItem.New(arg_9_0[string.format("discountGo%s_", iter_9_0)])

		arg_9_0.discountItemList_[iter_9_0]:SetData(iter_9_1)
	end
end

function var_0_0.AutoGetReward(arg_10_0)
	arg_10_0.signIndex_ = SignTools.GetSevenDaySignIndex(arg_10_0.signActivityID_)
end

function var_0_0.OnSign(arg_11_0, arg_11_1)
	if isSuccess(arg_11_1.result) then
		if arg_11_0.signIndex_ <= 0 then
			return
		end

		local var_11_0 = arg_11_1.item_list

		getReward2(var_11_0)
		arg_11_0:RefreshSignItemList()
	end
end

function var_0_0.AddTimer(arg_12_0)
	arg_12_0:StopTimer()

	local var_12_0 = ActivityData:GetActivityData(arg_12_0.activityID_).stopTime

	arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_12_0)
	arg_12_0.timer_ = Timer.New(function()
		arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_12_0)
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

return var_0_0
