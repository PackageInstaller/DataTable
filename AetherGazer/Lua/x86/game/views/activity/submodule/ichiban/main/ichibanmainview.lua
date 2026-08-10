local var_0_0 = class("IchiBanMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return IchiBanTools.GetMainUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.ichiBanLevelViewList_ = {}
	arg_3_0.showBtnController_ = arg_3_0.uiControllerEx_:GetController("showBtn")
	arg_3_0.lackController_ = arg_3_0.uiControllerEx_:GetController("lack")
	arg_3_0.showMaskController_ = arg_3_0.uiControllerEx_:GetController("default2")
	arg_3_0.xlController_ = arg_3_0.uiControllerEx_:GetController("xl_over")
	arg_3_0.lController_ = arg_3_0.uiControllerEx_:GetController("l_over")
	arg_3_0.mController_ = arg_3_0.uiControllerEx_:GetController("m_over")
	arg_3_0.sController_ = arg_3_0.uiControllerEx_:GetController("s_over")
	arg_3_0.ichiBanLeverOverController_ = {
		arg_3_0.xlController_,
		arg_3_0.lController_,
		arg_3_0.mController_,
		arg_3_0.sController_
	}
	arg_3_0.onRefreshHandler_ = handler(arg_3_0, arg_3_0.DisplayReward)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.mainActivityID

	local var_4_0 = IchiBanTools.GetCurrencyID(arg_4_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_4_0
	})
	manager.windowBar:SetBarCanClick(var_4_0, true)

	for iter_4_0, iter_4_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[arg_4_0.activityID_]) do
		arg_4_0.ichiBanLevelViewList_[iter_4_0] = arg_4_0.ichiBanLevelViewList_[iter_4_0] or IchiBanLevelView.New(arg_4_0[string.format("uiRank%s_", iter_4_0)])
	end

	local var_4_1 = ItemTools.getItemLittleSprite(var_4_0)

	arg_4_0.uiIcon1_.sprite = var_4_1
	arg_4_0.uiIcon2_.sprite = var_4_1
	arg_4_0.uiScrollView_.normalizedPosition = Vector2(0, 1)

	arg_4_0:RefreshUI()
	manager.notify:RegistListener(ICHIBAN_REFRESH, arg_4_0.onRefreshHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(ICHIBAN_REFRESH, arg_5_0.onRefreshHandler_)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.ichiBanLevelViewList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.onRefreshHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.ichiBanLevelViewList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.ichiBanLevelViewList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.uiRaffleBtn_, nil, function()
		if IchiBanTools.GetMaxRaffleCnt(arg_7_0.activityID_) <= 0 then
			ShowTips("ICHIBAN_LACK_CURRENCY")

			return
		end

		IchiBanAction.SendRaffle(arg_7_0.activityID_, 1, function()
			arg_7_0:ShowReward(data)
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.uiAllRaffleBtn_, nil, function()
		if IchiBanTools.GetMaxRaffleCnt(arg_7_0.activityID_) <= 0 then
			ShowTips("ICHIBAN_LACK_CURRENCY")

			return
		end

		IchiBanAction.SendRaffle(arg_7_0.activityID_, 0, function()
			arg_7_0:ShowReward(data)
		end)
	end)
end

function var_0_0.ShowReward(arg_12_0)
	JumpTools.OpenPageByJump("iChiBanRaffle", {
		activityID = arg_12_0.activityID_
	})
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshCommonUI()

	for iter_13_0, iter_13_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[arg_13_0.activityID_]) do
		arg_13_0.ichiBanLevelViewList_[iter_13_0]:SetData(iter_13_1)
	end

	arg_13_0:RefreshPaint()
	arg_13_0:RefreshOverState()
end

function var_0_0.RefreshCommonUI(arg_14_0)
	local var_14_0 = IchiBanTools.GetMaxRaffleCnt(arg_14_0.activityID_)

	arg_14_0.uiAllRaffleCntText_.text = string.format("X%s", var_14_0 <= 0 and 1 or var_14_0)

	local var_14_1 = IchiBanTools.GetUnRaffleCnt(arg_14_0.activityID_)

	arg_14_0.showBtnController_:SetSelectedState(tostring(var_14_1 > 0))
	arg_14_0.lackController_:SetSelectedState(tostring(var_14_0 <= 0))
end

function var_0_0.DisplayReward(arg_15_0)
	arg_15_0:RefreshCommonUI()

	for iter_15_0, iter_15_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[arg_15_0.activityID_]) do
		arg_15_0.ichiBanLevelViewList_[iter_15_0]:UpdateData()
	end

	IchiBanData:ClearUIData(arg_15_0.activityID_)

	if IchiBanTools.GetUnRaffleCnt(arg_15_0.activityID_) == 0 then
		local var_15_0

		Timer.New(function()
			arg_15_0:RefreshPaint(true)
		end, 0.5, 1):Start()
	end

	arg_15_0:RefreshOverState()
end

function var_0_0.RefreshPaint(arg_17_0, arg_17_1)
	local var_17_0 = IchiBanTools.GetCfg(arg_17_0.activityID_)

	if IchiBanTools.GetUnRaffleCnt(arg_17_0.activityID_) == 0 then
		arg_17_0.showMaskController_:SetSelectedState(arg_17_1 and "state1" or "state2")
	else
		arg_17_0.showMaskController_:SetSelectedState("state0")
	end
end

function var_0_0.RefreshOverState(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[arg_18_0.activityID_]) do
		local var_18_0 = IchiBanTools.IsGotAllLevelReward(iter_18_1)

		if arg_18_0.ichiBanLeverOverController_[iter_18_0] then
			arg_18_0.ichiBanLeverOverController_[iter_18_0]:SetSelectedIndex(var_18_0 and 1 or 0)
		end
	end
end

return var_0_0
