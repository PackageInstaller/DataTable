local XH3rdWaterResultView = class("XH3rdWaterResultView", ReduxView)

function XH3rdWaterResultView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPResult"
end

function XH3rdWaterResultView:UIParent()
	return manager.ui.uiMain.transform
end

function XH3rdWaterResultView:OnCtor()
	return
end

function XH3rdWaterResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterResultView:InitUI()
	self:BindCfgUI()

	self.leftSelectController_ = ControllerUtil.GetController(self.leftGo_.transform, "select")
	self.leftWinController_ = ControllerUtil.GetController(self.leftGo_.transform, "win")
	self.rightSelectController_ = ControllerUtil.GetController(self.rightGo_.transform, "select")
	self.rightWinController_ = ControllerUtil.GetController(self.rightGo_.transform, "win")
end

function XH3rdWaterResultView:AddUIListener()
	return
end

function XH3rdWaterResultView:AddEventListeners()
	return
end

function XH3rdWaterResultView:OnTop()
	self:UpdateBar()
end

function XH3rdWaterResultView:OnBehind()
	manager.windowBar:HideBar()
end

function XH3rdWaterResultView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(ActivityCfg[self.params_.activityID].sub_activity_list) do
			if ActivityCfg[iter_11_1].activity_template == ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE then
				table.insert(var_11_0, iter_11_1)
			end
		end

		local var_11_1 = table.indexof(var_11_0, ActivityWaterCfg[self.data_.schedule_id].activity_id)

		if var_11_1 then
			if var_11_1 == #var_11_0 then
				JumpTools.OpenPageByJump("/activityMain_2_2", {
					activityID = ActivityCfg.get_id_list_by_sub_activity_list[self.params_.activityID][1],
					subActivityID = self.params_.activityID
				})
			else
				JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
					activityID = self.params_.activityID
				})
			end
		else
			JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
				activityID = self.params_.activityID
			})
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
end

function XH3rdWaterResultView:OnEnter()
	self:AddEventListeners()

	self.historyDataList_ = ActivityWaterData:GetHistoryList(self.params_.activityID)

	table.sort(self.historyDataList_, function(arg_14_0, arg_14_1)
		return arg_14_0.schedule_id > arg_14_1.schedule_id
	end)

	self.data_ = self.historyDataList_[1]

	self:UpdateView()

	local var_13_0 = ActivityWaterData:GetCurrentSchedule(self.params_.activityID)
	local var_13_1 = 0

	if var_13_0 then
		var_13_1 = var_13_0.schedule_id
	end

	if var_13_1 ~= 0 then
		ActivityWaterAction.RequestCurrentSchedule(var_13_1)
	end
end

function XH3rdWaterResultView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function XH3rdWaterResultView:UpdateView()
	local var_16_0 = self.data_.competition_list[1]
	local var_16_1 = ActivityWaterCompetitionCfg[self.data_.competition_list[1].competition_id]
	local var_16_2 = ActivityWaterCompetitionCfg[self.data_.competition_list[2].competition_id]

	self.titleLabel_.text = string.format(GetTips("ACTIVITY_WATER_END_TITLE"), ActivityWaterCfg[self.data_.schedule_id].schedule_name)
	self.nameLabel1_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.competition_list[1].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.competition_list[1].competition_id].hero_id].hero_id].suffix)
	self.nameLabel2_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.competition_list[2].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.competition_list[2].competition_id].hero_id].hero_id].suffix)
	self.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(var_16_0.competition_id)

	self.roleImage1_:SetNativeSize()

	self.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(self.data_.competition_list[2].competition_id)

	self.roleImage2_:SetNativeSize()

	local var_16_3
	local var_16_4

	if self.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(self.params_.activityID) then
		local var_16_5 = ActivityWaterData:GetClientProgress(self.params_.activityID)

		var_16_3 = var_16_5[1]
		var_16_4 = var_16_5[2]
	else
		var_16_3 = var_16_0.assistance_process
		var_16_4 = self.data_.competition_list[2].assistance_process
	end

	self.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(var_16_3)
	self.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(var_16_4)

	local var_16_6 = math.max(var_16_1.process_reward[#var_16_1.process_reward][1], var_16_2.process_reward[#var_16_2.process_reward][1])

	self.progressBar1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_16_3 / var_16_6 + 20)
	self.progressBar2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_16_4 / var_16_6 + 20)

	self.tipLabel_.text = self.data_.is_success and self.data_.is_success > 0 and string.format(GetTips("ACTIVITY_WATER_END_TIP"), PlayerData:GetPlayerInfo().nick, (string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.selected_contestant_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.selected_contestant_id].hero_id].hero_id].suffix))) or ""

	if self.data_.selected_contestant_id == var_16_0.competition_id then
		self.leftSelectController_:SetSelectedState("yes")
		self.rightSelectController_:SetSelectedState("no")
	elseif self.data_.selected_contestant_id == var_16_0.competition_id then
		self.leftSelectController_:SetSelectedState("no")
		self.rightSelectController_:SetSelectedState("yes")
	else
		self.leftSelectController_:SetSelectedState("no")
		self.rightSelectController_:SetSelectedState("no")
	end

	if self.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(self.params_.activityID).schedule_id then
		self.leftWinController_:SetSelectedState("no")
		self.rightWinController_:SetSelectedState("no")
	elseif var_16_4 < var_16_3 then
		self.leftWinController_:SetSelectedState("yes")
		self.rightWinController_:SetSelectedState("no")
	elseif var_16_3 == var_16_4 then
		self.leftWinController_:SetSelectedState("draw")
		self.rightWinController_:SetSelectedState("draw")
	else
		self.leftWinController_:SetSelectedState("no")
		self.rightWinController_:SetSelectedState("yes")
	end
end

function XH3rdWaterResultView:OnMainHomeViewTop()
	return
end

function XH3rdWaterResultView:Dispose()
	XH3rdWaterResultView.super.Dispose(self)
end

return XH3rdWaterResultView
