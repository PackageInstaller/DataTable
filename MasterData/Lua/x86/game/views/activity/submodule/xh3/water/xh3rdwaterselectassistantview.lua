local XH3rdWaterDialogTask = import("game.views.activity.Submodule.Xh3.water.programTasks.XH3rdWaterDialogTask")
local XH3rdWaterSelectAssistantView = class("XH3rdWaterSelectAssistantView", ReduxView)
local var_0_2 = 44

function XH3rdWaterSelectAssistantView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPPlayUI"
end

function XH3rdWaterSelectAssistantView:UIParent()
	return manager.ui.uiMain.transform
end

function XH3rdWaterSelectAssistantView:OnCtor()
	return
end

function XH3rdWaterSelectAssistantView:Init()
	self.dialogTask_ = XH3rdWaterDialogTask.New()

	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterSelectAssistantView:InitUI()
	self:BindCfgUI()

	self.roleStatusController_ = ControllerUtil.GetController(self.characterContainer_, "roleStatus")
	self.btnStatusController_ = ControllerUtil.GetController(self.btnGo_.transform, "status")
	self.stageController_ = ControllerUtil.GetController(self.stageGo_.transform, "middle")
	self.backSelectController_ = ControllerUtil.GetController(self.notSelectBackGo_.transform, "select")
	self.frontSelectController_ = ControllerUtil.GetController(self.notSelectFrontGo_.transform, "select")
	self.haveSelectController_ = ControllerUtil.GetController(self.selectBtnGo_.transform, "select")
	self.contributeView_ = XH3rdWaterSelfContributeItemView.New(self.contributeGo_)
	self.rewardItems_ = {
		XH3rdWaterMainRewardItemView.New(self.reward1Go_),
		XH3rdWaterMainRewardItemView.New(self.reward2Go_),
		XH3rdWaterMainRewardItemView.New(self.reward3Go_),
		XH3rdWaterMainRewardItemView.New(self.reward4Go_)
	}
end

function XH3rdWaterSelectAssistantView:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		local var_7_0 = self.backSelectController_:GetSelectedState()

		if var_7_0 == "none" then
			return
		end

		local var_7_1
		local var_7_2

		if var_7_0 == "left" then
			var_7_1 = ActivityWaterData:GetCurrentCompetition(self.activityId_, 1).competition_id
			var_7_2 = ActivityWaterData:GetCurrentCompetition(self.activityId_, 2).competition_id
		end

		local var_7_4

		do
			var_7_1 = ActivityWaterData:GetCurrentCompetition(self.activityId_, 2).competition_id
			var_7_2 = ActivityWaterData:GetCurrentCompetition(self.activityId_, 1).competition_id

			local var_7_3 = ActivityWaterData:GetCurrentSchedule(self.activityId_)

			var_7_4 = {
				title = GetTips("PROMPT")
			}
		end

		var_7_4.content = string.format(GetTips("ACTIVITY_WATER_TIP_OPPOSITE_ROLE"), string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_7_1].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_7_1].hero_id].hero_id].suffix), (string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_7_2].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_7_2].hero_id].hero_id].suffix)))

		function var_7_4.OkCallback()
			ActivityWaterAction.SelectAssistantRole(var_7_3.schedule_id, var_7_1)
		end

		ShowMessageBox(var_7_4)
	end)
	self:AddBtnListener(self.character1Btn_, nil, function()
		if not ActivityWaterData:HaveSelectAssistantRole(self.activityId_) then
			self.dialogTask_:Disturb()
			self:UpdateSelect("left")
		else
			self.dialogTask_:NextSelectTalk()
		end
	end)
	self:AddBtnListener(self.character2Btn_, nil, function()
		if not ActivityWaterData:HaveSelectAssistantRole(self.activityId_) then
			self.dialogTask_:Disturb()
			self:UpdateSelect("right")
		else
			self.dialogTask_:NextSelectTalk()
		end
	end)
	self:AddBtnListener(self.inviteBtn_, nil, function()
		local var_11_0 = manager.time:GetServerHour()

		if var_11_0 < GameSetting.activity_water_online_open.value[1] or var_11_0 >= GameSetting.activity_water_online_open.value[2] then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
		})
	end)
	self:AddBtnListener(self.reviewBtn_, nil, function()
		JumpTools.OpenPageByJump("/xH3rdWaterReview", {
			activityID = self.activityId_
		})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/activityShop", {
			shopId = var_0_2,
			showShops = {
				var_0_2
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.joinBtn_, nil, function()
		local var_14_0 = manager.time:GetServerHour()

		if var_14_0 < GameSetting.activity_water_online_open.value[1] or var_14_0 >= GameSetting.activity_water_online_open.value[2] then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			local var_14_1 = ActivityWaterData:GetCurrentScheduleActivityId(self.activityId_)
			local var_14_2 = ActivityWaterData:GetOnlineStageId(self.activityId_)

			CooperationAction.StartMatching(var_14_2, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				(CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_14_2, var_14_1))
			}, var_14_1)
		end

		self:ShowMatching()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:HideMatching()
	end)
	self:AddBtnListener(self.roomBtn_, nil, function()
		local var_16_0 = manager.time:GetServerHour()

		if var_16_0 < GameSetting.activity_water_online_open.value[1] or var_16_0 >= GameSetting.activity_water_online_open.value[2] then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_16_1 = ActivityWaterData:GetCurrentScheduleActivityId(self.activityId_)
			local var_16_2 = ActivityWaterData:GetOnlineStageId(self.activityId_)

			CooperationAction.CreateRoom(var_16_2, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				(CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_16_2, var_16_1))
			}, var_16_1)
		end
	end)
	self:AddBtnListener(self.assistanceBtn_, nil, function()
		self.dialogTask_:Disturb()
		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = ActivityWaterData:GetCurrentAssistantRoleStageId(self.activityId_),
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER,
			activityID = ActivityWaterData:GetCurrentScheduleActivityId(self.activityId_),
			mainActivityID = self.activityId_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self.dialogTask_:Disturb()
	end)
	self.dialogTask_:SetOnDialogHandler(handler(self, self.OnSinglePlayerDialog), handler(self, self.OnSinglePlayerStop), handler(self, self.OnMultiPlayerDialog), handler(self, self.OnMultiPlayerStop))
end

function XH3rdWaterSelectAssistantView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_WATER_COMPETITION_UPDATE, function(arg_20_0)
		self:UpdateView()
	end)
	self:RegistEventListener(ACTIVITY_WATER_CLIENT_PROGRESS_UPDATE, function(arg_21_0)
		if arg_21_0 == self.activityId_ then
			local var_21_0 = ActivityWaterData:GetCurrentAssistantRole(self.activityId_)

			if var_21_0 ~= nil and var_21_0 > 0 then
				self:UpdateSelectView()
			end
		end
	end)
end

function XH3rdWaterSelectAssistantView:OnCoopreationInvitUpdate()
	self:UpdateInvite()
end

function XH3rdWaterSelectAssistantView:OnSinglePlayerDialog(arg_23_1, arg_23_2)
	SetActive(self.selfChatGo_, true)

	self.selfChatLabel_.text = ActivityWaterDialogCfg[arg_23_2].dialog_content
end

function XH3rdWaterSelectAssistantView:OnMultiPlayerDialog(arg_24_1)
	if ActivityWaterDialogCfg[arg_24_1].role_id == ActivityWaterCompetitionCfg[ActivityWaterData:GetCurrentSchedule(self.activityId_).competition_list[1].competition_id].hero_id then
		SetActive(self.chatGo1_, true)
		SetActive(self.chatGo2_, false)

		self.dialogText1_.text = ActivityWaterDialogCfg[arg_24_1].dialog_content
	else
		SetActive(self.chatGo1_, false)
		SetActive(self.chatGo2_, true)

		self.dialogText2_.text = ActivityWaterDialogCfg[arg_24_1].dialog_content
	end
end

function XH3rdWaterSelectAssistantView:OnSinglePlayerStop()
	SetActive(self.selfChatGo_, false)
end

function XH3rdWaterSelectAssistantView:OnMultiPlayerStop()
	SetActive(self.chatGo1_, false)
	SetActive(self.chatGo2_, false)
end

function XH3rdWaterSelectAssistantView:OnTop()
	self:UpdateBar()

	if self.matchingTimer_ ~= nil then
		SetActive(self.popGo_, true)
	end
end

function XH3rdWaterSelectAssistantView:OnBehind()
	manager.windowBar:HideBar()

	if self.matchingTimer_ ~= nil then
		SetActive(self.popGo_, false)
	end
end

function XH3rdWaterSelectAssistantView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ShopListCfg[var_0_2].cost_id[1]
	})
	manager.windowBar:SetBarCanAdd(ShopListCfg[var_0_2].cost_id[1], true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function XH3rdWaterSelectAssistantView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
	self:UpdateTimer()
end

function XH3rdWaterSelectAssistantView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function XH3rdWaterSelectAssistantView:UpdateTimer()
	local var_33_0 = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(self.activityId_).stopTime)

	self.lastdayText_.text = var_33_0
	self.lastdaylabelText_.text = ShopListCfg[var_0_2] and manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ShopListCfg[var_0_2].activity_id).stopTime) or var_33_0
	self.assistlastdayText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id].activity_id).stopTime)
end

function XH3rdWaterSelectAssistantView:ShowMatching()
	SetActive(self.popGo_, true)

	if self.matchingTimer_ == nil then
		self.matchingTimer_ = Timer.New(function()
			self:OnMatchingTimer()
		end, 1, -1)
	end

	self.curMatchingSeconds_ = 0

	self.matchingTimer_:Start()

	self.secondLabel_.text = "0s"
end

function XH3rdWaterSelectAssistantView:HideMatching()
	if self.matchingTimer_ then
		self.matchingTimer_:Stop()

		self.matchingTimer_ = nil
	end

	self.curMatchingSeconds_ = 0

	CooperationAction.CancelMatching()
	SetActive(self.popGo_, false)
end

function XH3rdWaterSelectAssistantView:OnMatchingTimer()
	self.curMatchingSeconds_ = self.curMatchingSeconds_ + 1
	self.secondLabel_.text = self.curMatchingSeconds_ .. "s"
end

function XH3rdWaterSelectAssistantView:OnEnter()
	self.activityId_ = self.params_.activityID

	self.dialogTask_:Init(self.activityId_)

	for iter_38_0, iter_38_1 in ipairs(self.rewardItems_) do
		iter_38_1:OnEnter()
	end

	self:AddEventListeners()
	self:UpdateView()
	self:UpdateInvite()

	if not ActivityWaterData:HaveSelectAssistantRole(self.activityId_) then
		self:UpdateSelect("none")
	end

	self:StartTimer()
	self.dialogTask_:OnEnter()

	if #ActivityWaterData:GetHistoryList(self.params_.activityID) > 0 and ActivityWaterData:IsFirstEnter(self.params_.activityID) then
		JumpTools.OpenPageByJump("/xH3rdWaterResult", {
			activityID = self.params_.activityID
		})
	end

	manager.redPoint:bindUIandKey(self.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
end

function XH3rdWaterSelectAssistantView:OnExit()
	manager.redPoint:unbindUIandKey(self.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
	self.dialogTask_:OnExit()

	for iter_39_0, iter_39_1 in ipairs(self.rewardItems_) do
		iter_39_1:OnExit()
	end

	self:HideMatching()
	self:StopTimer()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function XH3rdWaterSelectAssistantView:OnWaterResult(arg_40_1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = arg_40_1
	})
end

function XH3rdWaterSelectAssistantView:UpdateView()
	local var_41_0 = ActivityWaterData:GetCurrentSchedule(self.activityId_)

	self.nameLabel1_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[1].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[1].competition_id].hero_id].hero_id].suffix)
	self.nameLabel2_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[2].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[2].competition_id].hero_id].hero_id].suffix)
	self.unselectNameLabel1_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[1].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[1].competition_id].hero_id].hero_id].suffix)
	self.unselectNameLabel2_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[2].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[var_41_0.competition_list[2].competition_id].hero_id].hero_id].suffix)
	self.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(var_41_0.competition_list[1].competition_id)

	self.roleImage1_:SetNativeSize()

	self.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(var_41_0.competition_list[2].competition_id)

	self.roleImage2_:SetNativeSize()

	if ActivityWaterData:HaveSelectAssistantRole(self.activityId_) then
		self.contributeView_:SetData(self.activityId_)
		self.btnStatusController_:SetSelectedState("assistance")
		self.stageController_:SetSelectedState("select")
		self:UpdateSelectView()
	else
		self.btnStatusController_:SetSelectedState("select")
		self.stageController_:SetSelectedState("notselect")
	end
end

function XH3rdWaterSelectAssistantView:UpdateClientProgress()
	local var_42_0 = ActivityWaterData:GetClientProgress(self.activityId_)

	self.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(var_42_0[1])
	self.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(var_42_0[2])

	local var_42_1 = ActivityWaterData:GetCurrentSchedule(self.activityId_)
	local var_42_2 = math.max(ActivityWaterCompetitionCfg[var_42_1.competition_list[1].competition_id].process_reward[#ActivityWaterCompetitionCfg[var_42_1.competition_list[1].competition_id].process_reward][1], ActivityWaterCompetitionCfg[var_42_1.competition_list[2].competition_id].process_reward[#ActivityWaterCompetitionCfg[var_42_1.competition_list[2].competition_id].process_reward][1])

	self.progressTransform1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_42_0[1] / var_42_2 + 20)
	self.progressTransform2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_42_0[2] / var_42_2 + 20)
end

function XH3rdWaterSelectAssistantView:UpdateSelect(arg_43_1)
	self.dialogTask_:Disturb()
	self.backSelectController_:SetSelectedState(arg_43_1)
	self.frontSelectController_:SetSelectedState(arg_43_1)

	if arg_43_1 == "none" then
		self.haveSelectController_:SetSelectedState("no")
		self.roleStatusController_:SetSelectedState("noselect_none")
	else
		self.haveSelectController_:SetSelectedState("yes")

		if arg_43_1 == "left" then
			self.roleStatusController_:SetSelectedState("noselect_left")
		else
			self.roleStatusController_:SetSelectedState("noselect_right")
		end
	end
end

function XH3rdWaterSelectAssistantView:UpdateSelectView()
	self.openareaText_.text = string.format("%d:00~%d:00", GameSetting.activity_water_online_open.value[1], GameSetting.activity_water_online_open.value[2])
	self.teamassisttipText_.text = GetTips("ACTIVITY_WATER_REWARD_MULTIPLE")
	self.singleassisttipText_.text = GetTips("ACTIVITY_WATER_REWARD_SINGLE")

	for iter_44_0, iter_44_1 in ipairs(ActivityWaterCompetitionCfg[ActivityWaterData:GetCurrentAssistantRole(self.activityId_)].process_reward) do
		self.rewardItems_[iter_44_0]:SetData(iter_44_0, self.activityId_, iter_44_1)
	end

	if ActivityWaterData:GetCurrentAssistantIndex(self.activityId_) == 1 then
		self.roleStatusController_:SetSelectedState("select_left")
		self.character1Btn_.gameObject.transform:SetAsLastSibling()
	elseif ActivityWaterData:GetCurrentAssistantIndex(self.activityId_) == 2 then
		self.roleStatusController_:SetSelectedState("select_right")
		self.character2Btn_.gameObject.transform:SetAsLastSibling()
	else
		self.roleStatusController_:SetSelectedState("noselect_none")
	end

	self:UpdateClientProgress()

	self.uplimitText_.text = string.format("%d/%d", ActivityWaterData:GetCurrentSelfProgress(self.activityId_), ActivityWaterData:GetMaxSelfProgress())
end

function XH3rdWaterSelectAssistantView:UpdateInvite()
	return
end

function XH3rdWaterSelectAssistantView:OnMainHomeViewTop()
	return
end

function XH3rdWaterSelectAssistantView:UIBackCount()
	return 2
end

function XH3rdWaterSelectAssistantView:Dispose()
	self:StopTimer()

	if self.contributeView_ then
		self.contributeView_:Dispose()

		self.contributeView_ = nil
	end

	if self.dialogTask_ then
		self.dialogTask_:Dispose()

		self.dialogTask_ = nil
	end

	if self.rewardItems_ then
		for iter_48_0, iter_48_1 in pairs(self.rewardItems_) do
			iter_48_1:Dispose()
		end

		self.rewardItems_ = nil
	end

	XH3rdWaterSelectAssistantView.super.Dispose(self)
end

return XH3rdWaterSelectAssistantView
