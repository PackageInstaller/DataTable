local var_0_0 = import("game.views.activity.Submodule.Xh3.water.programTasks.XH3rdWaterDialogTask")
local var_0_1 = class("XH3rdWaterSelectAssistantView", ReduxView)
local var_0_2 = 44

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPPlayUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.OnCtor(arg_3_0)
	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0.dialogTask_ = var_0_0.New()

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.roleStatusController_ = ControllerUtil.GetController(arg_5_0.characterContainer_, "roleStatus")
	arg_5_0.btnStatusController_ = ControllerUtil.GetController(arg_5_0.btnGo_.transform, "status")
	arg_5_0.stageController_ = ControllerUtil.GetController(arg_5_0.stageGo_.transform, "middle")
	arg_5_0.backSelectController_ = ControllerUtil.GetController(arg_5_0.notSelectBackGo_.transform, "select")
	arg_5_0.frontSelectController_ = ControllerUtil.GetController(arg_5_0.notSelectFrontGo_.transform, "select")
	arg_5_0.haveSelectController_ = ControllerUtil.GetController(arg_5_0.selectBtnGo_.transform, "select")
	arg_5_0.contributeView_ = XH3rdWaterSelfContributeItemView.New(arg_5_0.contributeGo_)
	arg_5_0.rewardItems_ = {
		XH3rdWaterMainRewardItemView.New(arg_5_0.reward1Go_),
		XH3rdWaterMainRewardItemView.New(arg_5_0.reward2Go_),
		XH3rdWaterMainRewardItemView.New(arg_5_0.reward3Go_),
		XH3rdWaterMainRewardItemView.New(arg_5_0.reward4Go_)
	}
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.selectBtn_, nil, function()
		local var_7_0 = arg_6_0.backSelectController_:GetSelectedState()

		if var_7_0 == "none" then
			return
		end

		local var_7_1
		local var_7_2

		if var_7_0 == "left" then
			var_7_1 = ActivityWaterData:GetCurrentCompetition(arg_6_0.activityId_, 1).competition_id
			var_7_2 = ActivityWaterData:GetCurrentCompetition(arg_6_0.activityId_, 2).competition_id
		else
			var_7_1 = ActivityWaterData:GetCurrentCompetition(arg_6_0.activityId_, 2).competition_id
			var_7_2 = ActivityWaterData:GetCurrentCompetition(arg_6_0.activityId_, 1).competition_id
		end

		local var_7_3 = HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_7_1].hero_id]
		local var_7_4 = HeroCfg[var_7_3.hero_id]
		local var_7_5 = HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_7_2].hero_id]
		local var_7_6 = HeroCfg[var_7_5.hero_id]
		local var_7_7 = ActivityWaterData:GetCurrentSchedule(arg_6_0.activityId_)
		local var_7_8 = string.format("%s·%s", var_7_4.name, var_7_4.suffix)
		local var_7_9 = string.format("%s·%s", var_7_6.name, var_7_6.suffix)

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("ACTIVITY_WATER_TIP_OPPOSITE_ROLE"), var_7_8, var_7_9),
			OkCallback = function()
				ActivityWaterAction.SelectAssistantRole(var_7_7.schedule_id, var_7_1)
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.character1Btn_, nil, function()
		if not ActivityWaterData:HaveSelectAssistantRole(arg_6_0.activityId_) then
			arg_6_0.dialogTask_:Disturb()
			arg_6_0:UpdateSelect("left")
		else
			arg_6_0.dialogTask_:NextSelectTalk()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.character2Btn_, nil, function()
		if not ActivityWaterData:HaveSelectAssistantRole(arg_6_0.activityId_) then
			arg_6_0.dialogTask_:Disturb()
			arg_6_0:UpdateSelect("right")
		else
			arg_6_0.dialogTask_:NextSelectTalk()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.inviteBtn_, nil, function()
		local var_11_0 = manager.time:GetServerHour()

		if var_11_0 < GameSetting.activity_water_online_open.value[1] or var_11_0 >= GameSetting.activity_water_online_open.value[2] then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.reviewBtn_, nil, function()
		JumpTools.OpenPageByJump("/xH3rdWaterReview", {
			activityID = arg_6_0.activityId_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/activityShop", {
			shopId = var_0_2,
			showShops = {
				var_0_2
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_6_0:AddBtnListener(arg_6_0.joinBtn_, nil, function()
		local var_14_0 = manager.time:GetServerHour()

		if var_14_0 < GameSetting.activity_water_online_open.value[1] or var_14_0 >= GameSetting.activity_water_online_open.value[2] then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			local var_14_1 = ActivityWaterData:GetCurrentScheduleActivityId(arg_6_0.activityId_)
			local var_14_2 = ActivityWaterData:GetOnlineStageId(arg_6_0.activityId_)
			local var_14_3 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_14_2, var_14_1)

			CooperationAction.StartMatching(var_14_2, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				var_14_3
			}, var_14_1)
		end

		arg_6_0:ShowMatching()
	end)
	arg_6_0:AddBtnListener(arg_6_0.cancelBtn_, nil, function()
		arg_6_0:HideMatching()
	end)
	arg_6_0:AddBtnListener(arg_6_0.roomBtn_, nil, function()
		local var_16_0 = manager.time:GetServerHour()

		if var_16_0 < GameSetting.activity_water_online_open.value[1] or var_16_0 >= GameSetting.activity_water_online_open.value[2] then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_16_1 = ActivityWaterData:GetCurrentScheduleActivityId(arg_6_0.activityId_)
			local var_16_2 = ActivityWaterData:GetOnlineStageId(arg_6_0.activityId_)
			local var_16_3 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_16_2, var_16_1)

			CooperationAction.CreateRoom(var_16_2, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				var_16_3
			}, var_16_1)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.assistanceBtn_, nil, function()
		arg_6_0.dialogTask_:Disturb()

		local var_17_0 = ActivityWaterData:GetCurrentAssistantRoleStageId(arg_6_0.activityId_)

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = var_17_0,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER,
			activityID = ActivityWaterData:GetCurrentScheduleActivityId(arg_6_0.activityId_),
			mainActivityID = arg_6_0.activityId_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0.dialogTask_:Disturb()
	end)
	arg_6_0.dialogTask_:SetOnDialogHandler(handler(arg_6_0, arg_6_0.OnSinglePlayerDialog), handler(arg_6_0, arg_6_0.OnSinglePlayerStop), handler(arg_6_0, arg_6_0.OnMultiPlayerDialog), handler(arg_6_0, arg_6_0.OnMultiPlayerStop))
end

function var_0_1.AddEventListeners(arg_19_0)
	arg_19_0:RegistEventListener(ACTIVITY_WATER_COMPETITION_UPDATE, function(arg_20_0)
		arg_19_0:UpdateView()
	end)
	arg_19_0:RegistEventListener(ACTIVITY_WATER_CLIENT_PROGRESS_UPDATE, function(arg_21_0)
		if arg_21_0 == arg_19_0.activityId_ then
			local var_21_0 = ActivityWaterData:GetCurrentAssistantRole(arg_19_0.activityId_)

			if var_21_0 ~= nil and var_21_0 > 0 then
				arg_19_0:UpdateSelectView()
			end
		end
	end)
end

function var_0_1.OnCoopreationInvitUpdate(arg_22_0)
	arg_22_0:UpdateInvite()
end

function var_0_1.OnSinglePlayerDialog(arg_23_0, arg_23_1, arg_23_2)
	SetActive(arg_23_0.selfChatGo_, true)

	local var_23_0 = ActivityWaterDialogCfg[arg_23_2]

	arg_23_0.selfChatLabel_.text = var_23_0.dialog_content
end

function var_0_1.OnMultiPlayerDialog(arg_24_0, arg_24_1)
	local var_24_0 = ActivityWaterDialogCfg[arg_24_1]
	local var_24_1 = ActivityWaterData:GetCurrentSchedule(arg_24_0.activityId_)
	local var_24_2 = ActivityWaterCompetitionCfg[var_24_1.competition_list[1].competition_id]

	if var_24_0.role_id == var_24_2.hero_id then
		SetActive(arg_24_0.chatGo1_, true)
		SetActive(arg_24_0.chatGo2_, false)

		arg_24_0.dialogText1_.text = var_24_0.dialog_content
	else
		SetActive(arg_24_0.chatGo1_, false)
		SetActive(arg_24_0.chatGo2_, true)

		arg_24_0.dialogText2_.text = var_24_0.dialog_content
	end
end

function var_0_1.OnSinglePlayerStop(arg_25_0)
	SetActive(arg_25_0.selfChatGo_, false)
end

function var_0_1.OnMultiPlayerStop(arg_26_0)
	SetActive(arg_26_0.chatGo1_, false)
	SetActive(arg_26_0.chatGo2_, false)
end

function var_0_1.OnTop(arg_27_0)
	arg_27_0:UpdateBar()

	if arg_27_0.matchingTimer_ ~= nil then
		SetActive(arg_27_0.popGo_, true)
	end
end

function var_0_1.OnBehind(arg_28_0)
	manager.windowBar:HideBar()

	if arg_28_0.matchingTimer_ ~= nil then
		SetActive(arg_28_0.popGo_, false)
	end
end

function var_0_1.UpdateBar(arg_29_0)
	local var_29_0 = ShopListCfg[var_0_2].cost_id[1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_29_0
	})
	manager.windowBar:SetBarCanAdd(var_29_0, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function var_0_1.StartTimer(arg_30_0)
	if arg_30_0.timer_ == nil then
		arg_30_0.timer_ = Timer.New(function()
			arg_30_0:UpdateTimer()
		end, 1, -1)
	end

	arg_30_0.timer_:Start()
	arg_30_0:UpdateTimer()
end

function var_0_1.StopTimer(arg_32_0)
	if arg_32_0.timer_ then
		arg_32_0.timer_:Stop()

		arg_32_0.timer_ = nil
	end
end

function var_0_1.UpdateTimer(arg_33_0)
	local var_33_0 = ActivityData:GetActivityData(arg_33_0.activityId_).stopTime
	local var_33_1 = manager.time:GetLostTimeStr2(var_33_0)

	arg_33_0.lastdayText_.text = var_33_1

	local var_33_2 = ShopListCfg[var_0_2]

	if var_33_2 then
		local var_33_3 = var_33_2.activity_id
		local var_33_4 = ActivityData:GetActivityData(var_33_3).stopTime

		arg_33_0.lastdaylabelText_.text = manager.time:GetLostTimeStr2(var_33_4)
	else
		arg_33_0.lastdaylabelText_.text = var_33_1
	end

	local var_33_5 = ActivityWaterData:GetCurrentSchedule(arg_33_0.activityId_)
	local var_33_6 = ActivityWaterCfg[var_33_5.schedule_id]
	local var_33_7 = ActivityData:GetActivityData(var_33_6.activity_id).stopTime

	arg_33_0.assistlastdayText_.text = manager.time:GetLostTimeStr2(var_33_7)
end

function var_0_1.ShowMatching(arg_34_0)
	SetActive(arg_34_0.popGo_, true)

	if arg_34_0.matchingTimer_ == nil then
		arg_34_0.matchingTimer_ = Timer.New(function()
			arg_34_0:OnMatchingTimer()
		end, 1, -1)
	end

	arg_34_0.curMatchingSeconds_ = 0

	arg_34_0.matchingTimer_:Start()

	arg_34_0.secondLabel_.text = "0s"
end

function var_0_1.HideMatching(arg_36_0)
	if arg_36_0.matchingTimer_ then
		arg_36_0.matchingTimer_:Stop()

		arg_36_0.matchingTimer_ = nil
	end

	arg_36_0.curMatchingSeconds_ = 0

	CooperationAction.CancelMatching()
	SetActive(arg_36_0.popGo_, false)
end

function var_0_1.OnMatchingTimer(arg_37_0)
	arg_37_0.curMatchingSeconds_ = arg_37_0.curMatchingSeconds_ + 1
	arg_37_0.secondLabel_.text = arg_37_0.curMatchingSeconds_ .. "s"
end

function var_0_1.OnEnter(arg_38_0)
	arg_38_0.activityId_ = arg_38_0.params_.activityID

	arg_38_0.dialogTask_:Init(arg_38_0.activityId_)

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.rewardItems_) do
		iter_38_1:OnEnter()
	end

	arg_38_0:AddEventListeners()
	arg_38_0:UpdateView()
	arg_38_0:UpdateInvite()

	if not ActivityWaterData:HaveSelectAssistantRole(arg_38_0.activityId_) then
		arg_38_0:UpdateSelect("none")
	end

	arg_38_0:StartTimer()
	arg_38_0.dialogTask_:OnEnter()

	if #ActivityWaterData:GetHistoryList(arg_38_0.params_.activityID) > 0 and ActivityWaterData:IsFirstEnter(arg_38_0.params_.activityID) then
		JumpTools.OpenPageByJump("/xH3rdWaterResult", {
			activityID = arg_38_0.params_.activityID
		})
	end

	manager.redPoint:bindUIandKey(arg_38_0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
end

function var_0_1.OnExit(arg_39_0)
	manager.redPoint:unbindUIandKey(arg_39_0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
	arg_39_0.dialogTask_:OnExit()

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.rewardItems_) do
		iter_39_1:OnExit()
	end

	arg_39_0:HideMatching()
	arg_39_0:StopTimer()
	arg_39_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_1.OnWaterResult(arg_40_0, arg_40_1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = arg_40_1
	})
end

function var_0_1.UpdateView(arg_41_0)
	local var_41_0 = ActivityWaterData:GetCurrentSchedule(arg_41_0.activityId_)
	local var_41_1 = var_41_0.competition_list[1]
	local var_41_2 = var_41_0.competition_list[2]
	local var_41_3 = ActivityWaterCompetitionCfg[var_41_1.competition_id]
	local var_41_4 = ActivityWaterCompetitionCfg[var_41_2.competition_id]
	local var_41_5 = HeroStandardSystemCfg[var_41_3.hero_id]
	local var_41_6 = HeroStandardSystemCfg[var_41_4.hero_id]
	local var_41_7 = HeroCfg[var_41_5.hero_id]
	local var_41_8 = HeroCfg[var_41_6.hero_id]

	arg_41_0.nameLabel1_.text = string.format("%s·%s", var_41_7.name, var_41_7.suffix)
	arg_41_0.nameLabel2_.text = string.format("%s·%s", var_41_8.name, var_41_8.suffix)
	arg_41_0.unselectNameLabel1_.text = string.format("%s·%s", var_41_7.name, var_41_7.suffix)
	arg_41_0.unselectNameLabel2_.text = string.format("%s·%s", var_41_8.name, var_41_8.suffix)
	arg_41_0.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(var_41_1.competition_id)

	arg_41_0.roleImage1_:SetNativeSize()

	arg_41_0.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(var_41_2.competition_id)

	arg_41_0.roleImage2_:SetNativeSize()

	if ActivityWaterData:HaveSelectAssistantRole(arg_41_0.activityId_) then
		arg_41_0.contributeView_:SetData(arg_41_0.activityId_)
		arg_41_0.btnStatusController_:SetSelectedState("assistance")
		arg_41_0.stageController_:SetSelectedState("select")
		arg_41_0:UpdateSelectView()
	else
		arg_41_0.btnStatusController_:SetSelectedState("select")
		arg_41_0.stageController_:SetSelectedState("notselect")
	end
end

function var_0_1.UpdateClientProgress(arg_42_0)
	local var_42_0 = ActivityWaterData:GetClientProgress(arg_42_0.activityId_)
	local var_42_1 = var_42_0[1]
	local var_42_2 = var_42_0[2]

	arg_42_0.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(var_42_1)
	arg_42_0.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(var_42_2)

	local var_42_3 = ActivityWaterData:GetCurrentSchedule(arg_42_0.activityId_)
	local var_42_4 = var_42_3.competition_list[1].competition_id
	local var_42_5 = ActivityWaterCompetitionCfg[var_42_4]
	local var_42_6 = var_42_3.competition_list[2].competition_id
	local var_42_7 = ActivityWaterCompetitionCfg[var_42_6]
	local var_42_8 = math.max(var_42_5.process_reward[#var_42_5.process_reward][1], var_42_7.process_reward[#var_42_7.process_reward][1])

	arg_42_0.progressTransform1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_42_1 / var_42_8 + 20)
	arg_42_0.progressTransform2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_42_2 / var_42_8 + 20)
end

function var_0_1.UpdateSelect(arg_43_0, arg_43_1)
	arg_43_0.dialogTask_:Disturb()
	arg_43_0.backSelectController_:SetSelectedState(arg_43_1)
	arg_43_0.frontSelectController_:SetSelectedState(arg_43_1)

	if arg_43_1 == "none" then
		arg_43_0.haveSelectController_:SetSelectedState("no")
		arg_43_0.roleStatusController_:SetSelectedState("noselect_none")
	else
		arg_43_0.haveSelectController_:SetSelectedState("yes")

		if arg_43_1 == "left" then
			arg_43_0.roleStatusController_:SetSelectedState("noselect_left")
		else
			arg_43_0.roleStatusController_:SetSelectedState("noselect_right")
		end
	end
end

function var_0_1.UpdateSelectView(arg_44_0)
	arg_44_0.openareaText_.text = string.format("%d:00~%d:00", GameSetting.activity_water_online_open.value[1], GameSetting.activity_water_online_open.value[2])
	arg_44_0.teamassisttipText_.text = GetTips("ACTIVITY_WATER_REWARD_MULTIPLE")
	arg_44_0.singleassisttipText_.text = GetTips("ACTIVITY_WATER_REWARD_SINGLE")

	local var_44_0 = ActivityWaterData:GetCurrentAssistantRole(arg_44_0.activityId_)
	local var_44_1 = ActivityWaterCompetitionCfg[var_44_0].process_reward

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		arg_44_0.rewardItems_[iter_44_0]:SetData(iter_44_0, arg_44_0.activityId_, iter_44_1)
	end

	if ActivityWaterData:GetCurrentAssistantIndex(arg_44_0.activityId_) == 1 then
		arg_44_0.roleStatusController_:SetSelectedState("select_left")
		arg_44_0.character1Btn_.gameObject.transform:SetAsLastSibling()
	elseif ActivityWaterData:GetCurrentAssistantIndex(arg_44_0.activityId_) == 2 then
		arg_44_0.roleStatusController_:SetSelectedState("select_right")
		arg_44_0.character2Btn_.gameObject.transform:SetAsLastSibling()
	else
		arg_44_0.roleStatusController_:SetSelectedState("noselect_none")
	end

	arg_44_0:UpdateClientProgress()

	local var_44_2 = ActivityWaterData:GetCurrentSelfProgress(arg_44_0.activityId_)

	arg_44_0.uplimitText_.text = string.format("%d/%d", var_44_2, ActivityWaterData:GetMaxSelfProgress())
end

function var_0_1.UpdateInvite(arg_45_0)
	return
end

function var_0_1.OnMainHomeViewTop(arg_46_0)
	return
end

function var_0_1.UIBackCount(arg_47_0)
	return 2
end

function var_0_1.Dispose(arg_48_0)
	arg_48_0:StopTimer()

	if arg_48_0.contributeView_ then
		arg_48_0.contributeView_:Dispose()

		arg_48_0.contributeView_ = nil
	end

	if arg_48_0.dialogTask_ then
		arg_48_0.dialogTask_:Dispose()

		arg_48_0.dialogTask_ = nil
	end

	if arg_48_0.rewardItems_ then
		for iter_48_0, iter_48_1 in pairs(arg_48_0.rewardItems_) do
			iter_48_1:Dispose()
		end

		arg_48_0.rewardItems_ = nil
	end

	var_0_1.super.Dispose(arg_48_0)
end

return var_0_1
