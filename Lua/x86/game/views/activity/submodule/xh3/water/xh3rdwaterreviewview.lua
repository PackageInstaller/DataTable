local var_0_0 = class("XH3rdWaterReviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPReviewUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.leftSelectController_ = ControllerUtil.GetController(arg_5_0.leftRoleGo_.transform, "select")
	arg_5_0.leftWinController_ = ControllerUtil.GetController(arg_5_0.leftRoleGo_.transform, "win")
	arg_5_0.rightSelectController_ = ControllerUtil.GetController(arg_5_0.rightRoleGo_.transform, "select")
	arg_5_0.rightWinController_ = ControllerUtil.GetController(arg_5_0.rightRoleGo_.transform, "win")
	arg_5_0.receiveController_ = ControllerUtil.GetController(arg_5_0.receiveGo_.transform, "receive")
	arg_5_0.historyList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.uilistGo_, XH3rsWaterReviewItemView)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.historyDataList_[arg_6_1], arg_6_0.params_.activityID)
	arg_6_2:RegisterClickListener(function(arg_7_0, arg_7_1)
		arg_6_0:UpdateHistoryView(arg_7_0, arg_7_1)
		arg_6_0.historyList_:Refresh()
	end)
	arg_6_2:SetSelect(arg_6_1 == arg_6_0.curIndex_)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		ActivityWaterAction.GetWinReward(arg_8_0.data_.schedule_id)
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(ACTIVITY_WATER_WIN_REWARD_UPDATE, function()
		if arg_10_0.curIndex_ ~= nil then
			arg_10_0:UpdateHistoryView(arg_10_0.curIndex_, arg_10_0.data_)
		end

		arg_10_0.historyList_:Refresh()
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnWaterResult(arg_13_0, arg_13_1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = arg_13_1
	})
end

function var_0_0.OnBehind(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_15_0)
	local var_15_0 = 44
	local var_15_1 = ShopListCfg[var_15_0].cost_id[1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_15_1
	})
	manager.windowBar:SetBarCanAdd(var_15_1, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:AddEventListeners()

	arg_16_0.historyDataList_ = ActivityWaterData:GetHistoryList(arg_16_0.params_.activityID, true)

	table.sort(arg_16_0.historyDataList_, function(arg_17_0, arg_17_1)
		return arg_17_0.schedule_id < arg_17_1.schedule_id
	end)
	arg_16_0.historyList_:StartScroll(#arg_16_0.historyDataList_)

	if #arg_16_0.historyDataList_ > 0 then
		arg_16_0:UpdateHistoryView(1, arg_16_0.historyDataList_[1])
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateHistoryView(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.curIndex_ = arg_19_1
	arg_19_0.data_ = arg_19_2

	local var_19_0 = arg_19_2.competition_list[1]
	local var_19_1 = arg_19_2.competition_list[2]
	local var_19_2 = ActivityWaterCompetitionCfg[var_19_0.competition_id]
	local var_19_3 = ActivityWaterCompetitionCfg[var_19_1.competition_id]
	local var_19_4 = HeroStandardSystemCfg[var_19_2.hero_id]
	local var_19_5 = HeroStandardSystemCfg[var_19_3.hero_id]
	local var_19_6 = HeroCfg[var_19_4.hero_id]
	local var_19_7 = HeroCfg[var_19_5.hero_id]

	arg_19_0.nameLabel1_.text = string.format("%s·%s", var_19_6.name, var_19_6.suffix)
	arg_19_0.nameLabel2_.text = string.format("%s·%s", var_19_7.name, var_19_7.suffix)
	arg_19_0.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(var_19_0.competition_id)

	arg_19_0.roleImage1_:SetNativeSize()

	arg_19_0.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(var_19_1.competition_id)

	arg_19_0.roleImage2_:SetNativeSize()

	local var_19_8
	local var_19_9

	if arg_19_0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(arg_19_0.params_.activityID).schedule_id then
		local var_19_10 = ActivityWaterData:GetClientProgress(arg_19_0.params_.activityID)

		var_19_8 = var_19_10[1]
		var_19_9 = var_19_10[2]
	else
		var_19_8 = var_19_0.assistance_process
		var_19_9 = var_19_1.assistance_process
	end

	arg_19_0.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(var_19_8)
	arg_19_0.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(var_19_9)

	local var_19_11 = math.max(var_19_2.process_reward[#var_19_2.process_reward][1], var_19_3.process_reward[#var_19_3.process_reward][1])

	arg_19_0.progressBar1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_19_8 / var_19_11 + 20)
	arg_19_0.progressBar2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_19_9 / var_19_11 + 20)

	if arg_19_2.selected_contestant_id == var_19_0.competition_id then
		arg_19_0.leftSelectController_:SetSelectedState("yes")
		arg_19_0.rightSelectController_:SetSelectedState("no")
	elseif arg_19_2.selected_contestant_id == var_19_1.competition_id then
		arg_19_0.leftSelectController_:SetSelectedState("no")
		arg_19_0.rightSelectController_:SetSelectedState("yes")
	else
		arg_19_0.leftSelectController_:SetSelectedState("no")
		arg_19_0.rightSelectController_:SetSelectedState("no")
	end

	if arg_19_0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(arg_19_0.params_.activityID).schedule_id then
		SetActive(arg_19_0.receiveGo_, false)
		arg_19_0.leftWinController_:SetSelectedState("no")
		arg_19_0.rightWinController_:SetSelectedState("no")
	else
		SetActive(arg_19_0.receiveGo_, arg_19_2.is_success and arg_19_0.data_.is_success > 0)

		local var_19_12

		if var_19_9 < var_19_8 then
			arg_19_0.leftWinController_:SetSelectedState("yes")
			arg_19_0.rightWinController_:SetSelectedState("no")

			var_19_12 = string.format("%s·%s", var_19_6.name, var_19_6.suffix)
		elseif var_19_8 == var_19_9 then
			arg_19_0.leftWinController_:SetSelectedState("draw")
			arg_19_0.rightWinController_:SetSelectedState("draw")

			if arg_19_2.selected_contestant_id == var_19_0.competition_id then
				var_19_12 = string.format("%s·%s", var_19_6.name, var_19_6.suffix)
			elseif arg_19_2.selected_contestant_id == var_19_1.competition_id then
				var_19_12 = string.format("%s·%s", var_19_7.name, var_19_7.suffix)
			end
		else
			arg_19_0.leftWinController_:SetSelectedState("no")
			arg_19_0.rightWinController_:SetSelectedState("yes")

			var_19_12 = string.format("%s·%s", var_19_7.name, var_19_7.suffix)
		end

		arg_19_0.rewardTipLabel_.text = string.format(GetTips("ACTIVITY_WATER_TIP_REWARD_FROM"), var_19_12)

		if ActivityWaterData:HaveGotHistoryReward(arg_19_2.schedule_id) then
			arg_19_0.receiveController_:SetSelectedState("yes")
		else
			arg_19_0.receiveController_:SetSelectedState("no")
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.rewardContainer_)
	end
end

function var_0_0.OnMainHomeViewTop(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.historyList_ then
		arg_21_0.historyList_:Dispose()

		arg_21_0.historyList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
