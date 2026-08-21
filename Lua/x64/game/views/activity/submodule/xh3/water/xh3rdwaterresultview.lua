local var_0_0 = class("XH3rdWaterResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPResult"
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

	arg_5_0.leftSelectController_ = ControllerUtil.GetController(arg_5_0.leftGo_.transform, "select")
	arg_5_0.leftWinController_ = ControllerUtil.GetController(arg_5_0.leftGo_.transform, "win")
	arg_5_0.rightSelectController_ = ControllerUtil.GetController(arg_5_0.rightGo_.transform, "select")
	arg_5_0.rightWinController_ = ControllerUtil.GetController(arg_5_0.rightGo_.transform, "win")
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.OnBehind(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		local var_11_0 = 0
		local var_11_1 = ActivityCfg[arg_10_0.params_.activityID]
		local var_11_2 = {}

		for iter_11_0, iter_11_1 in ipairs(var_11_1.sub_activity_list) do
			if ActivityCfg[iter_11_1].activity_template == ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE then
				var_11_0 = var_11_0 + 1

				table.insert(var_11_2, iter_11_1)
			end
		end

		local var_11_3 = ActivityWaterCfg[arg_10_0.data_.schedule_id]
		local var_11_4 = table.indexof(var_11_2, var_11_3.activity_id)

		if var_11_4 then
			if var_11_4 == #var_11_2 then
				local var_11_5 = ActivityCfg.get_id_list_by_sub_activity_list[arg_10_0.params_.activityID][1]

				JumpTools.OpenPageByJump("/activityMain_2_2", {
					activityID = var_11_5,
					subActivityID = arg_10_0.params_.activityID
				})
			else
				JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
					activityID = arg_10_0.params_.activityID
				})
			end
		else
			JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
				activityID = arg_10_0.params_.activityID
			})
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()

	arg_13_0.historyDataList_ = ActivityWaterData:GetHistoryList(arg_13_0.params_.activityID)

	table.sort(arg_13_0.historyDataList_, function(arg_14_0, arg_14_1)
		return arg_14_0.schedule_id > arg_14_1.schedule_id
	end)

	arg_13_0.data_ = arg_13_0.historyDataList_[1]

	arg_13_0:UpdateView()

	local var_13_0 = ActivityWaterData:GetCurrentSchedule(arg_13_0.params_.activityID)
	local var_13_1 = 0

	if var_13_0 then
		var_13_1 = var_13_0.schedule_id
	end

	if var_13_1 ~= 0 then
		ActivityWaterAction.RequestCurrentSchedule(var_13_1)
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_16_0)
	local var_16_0 = arg_16_0.data_
	local var_16_1 = ActivityWaterCfg[arg_16_0.data_.schedule_id]
	local var_16_2 = var_16_0.competition_list[1]
	local var_16_3 = var_16_0.competition_list[2]
	local var_16_4 = ActivityWaterCompetitionCfg[var_16_2.competition_id]
	local var_16_5 = ActivityWaterCompetitionCfg[var_16_3.competition_id]
	local var_16_6 = HeroStandardSystemCfg[var_16_4.hero_id]
	local var_16_7 = HeroStandardSystemCfg[var_16_5.hero_id]
	local var_16_8 = HeroCfg[var_16_6.hero_id]
	local var_16_9 = HeroCfg[var_16_7.hero_id]

	arg_16_0.titleLabel_.text = string.format(GetTips("ACTIVITY_WATER_END_TITLE"), var_16_1.schedule_name)
	arg_16_0.nameLabel1_.text = string.format("%s·%s", var_16_8.name, var_16_8.suffix)
	arg_16_0.nameLabel2_.text = string.format("%s·%s", var_16_9.name, var_16_9.suffix)
	arg_16_0.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(var_16_2.competition_id)

	arg_16_0.roleImage1_:SetNativeSize()

	arg_16_0.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(var_16_3.competition_id)

	arg_16_0.roleImage2_:SetNativeSize()

	local var_16_10
	local var_16_11

	if arg_16_0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(arg_16_0.params_.activityID) then
		local var_16_12 = ActivityWaterData:GetClientProgress(arg_16_0.params_.activityID)

		var_16_10 = var_16_12[1]
		var_16_11 = var_16_12[2]
	else
		var_16_10 = var_16_2.assistance_process
		var_16_11 = var_16_3.assistance_process
	end

	arg_16_0.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(var_16_10)
	arg_16_0.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(var_16_11)

	local var_16_13 = math.max(var_16_4.process_reward[#var_16_4.process_reward][1], var_16_5.process_reward[#var_16_5.process_reward][1])

	arg_16_0.progressBar1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_16_10 / var_16_13 + 20)
	arg_16_0.progressBar2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_16_11 / var_16_13 + 20)

	if var_16_0.is_success and var_16_0.is_success > 0 then
		local var_16_14 = ActivityWaterCompetitionCfg[var_16_0.selected_contestant_id]
		local var_16_15 = HeroStandardSystemCfg[var_16_14.hero_id]
		local var_16_16 = HeroCfg[var_16_15.hero_id]
		local var_16_17 = string.format("%s·%s", var_16_16.name, var_16_16.suffix)

		arg_16_0.tipLabel_.text = string.format(GetTips("ACTIVITY_WATER_END_TIP"), PlayerData:GetPlayerInfo().nick, var_16_17)
	else
		arg_16_0.tipLabel_.text = ""
	end

	if var_16_0.selected_contestant_id == var_16_2.competition_id then
		arg_16_0.leftSelectController_:SetSelectedState("yes")
		arg_16_0.rightSelectController_:SetSelectedState("no")
	elseif var_16_0.selected_contestant_id == var_16_2.competition_id then
		arg_16_0.leftSelectController_:SetSelectedState("no")
		arg_16_0.rightSelectController_:SetSelectedState("yes")
	else
		arg_16_0.leftSelectController_:SetSelectedState("no")
		arg_16_0.rightSelectController_:SetSelectedState("no")
	end

	if arg_16_0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(arg_16_0.params_.activityID).schedule_id then
		arg_16_0.leftWinController_:SetSelectedState("no")
		arg_16_0.rightWinController_:SetSelectedState("no")
	elseif var_16_11 < var_16_10 then
		arg_16_0.leftWinController_:SetSelectedState("yes")
		arg_16_0.rightWinController_:SetSelectedState("no")
	elseif var_16_10 == var_16_11 then
		arg_16_0.leftWinController_:SetSelectedState("draw")
		arg_16_0.rightWinController_:SetSelectedState("draw")
	else
		arg_16_0.leftWinController_:SetSelectedState("no")
		arg_16_0.rightWinController_:SetSelectedState("yes")
	end
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
