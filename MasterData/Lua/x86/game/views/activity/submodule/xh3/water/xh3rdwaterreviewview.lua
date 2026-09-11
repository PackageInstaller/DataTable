local XH3rdWaterReviewView = class("XH3rdWaterReviewView", ReduxView)

function XH3rdWaterReviewView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPReviewUI"
end

function XH3rdWaterReviewView:UIParent()
	return manager.ui.uiMain.transform
end

function XH3rdWaterReviewView:OnCtor()
	return
end

function XH3rdWaterReviewView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterReviewView:InitUI()
	self:BindCfgUI()

	self.leftSelectController_ = ControllerUtil.GetController(self.leftRoleGo_.transform, "select")
	self.leftWinController_ = ControllerUtil.GetController(self.leftRoleGo_.transform, "win")
	self.rightSelectController_ = ControllerUtil.GetController(self.rightRoleGo_.transform, "select")
	self.rightWinController_ = ControllerUtil.GetController(self.rightRoleGo_.transform, "win")
	self.receiveController_ = ControllerUtil.GetController(self.receiveGo_.transform, "receive")
	self.historyList_ = LuaList.New(handler(self, self.IndexItem), self.uilistGo_, XH3rsWaterReviewItemView)
end

function XH3rdWaterReviewView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.historyDataList_[arg_6_1], self.params_.activityID)
	arg_6_2:RegisterClickListener(function(arg_7_0, arg_7_1)
		self:UpdateHistoryView(arg_7_0, arg_7_1)
		self.historyList_:Refresh()
	end)
	arg_6_2:SetSelect(arg_6_1 == self.curIndex_)
end

function XH3rdWaterReviewView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityWaterAction.GetWinReward(self.data_.schedule_id)
	end)
end

function XH3rdWaterReviewView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_WATER_WIN_REWARD_UPDATE, function()
		if self.curIndex_ ~= nil then
			self:UpdateHistoryView(self.curIndex_, self.data_)
		end

		self.historyList_:Refresh()
	end)
end

function XH3rdWaterReviewView:OnTop()
	self:UpdateBar()
end

function XH3rdWaterReviewView:OnWaterResult(arg_13_1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = arg_13_1
	})
end

function XH3rdWaterReviewView:OnBehind()
	manager.windowBar:HideBar()
end

function XH3rdWaterReviewView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ShopListCfg[44].cost_id[1]
	})
	manager.windowBar:SetBarCanAdd(ShopListCfg[44].cost_id[1], true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function XH3rdWaterReviewView:OnEnter()
	self:AddEventListeners()

	self.historyDataList_ = ActivityWaterData:GetHistoryList(self.params_.activityID, true)

	table.sort(self.historyDataList_, function(arg_17_0, arg_17_1)
		return arg_17_0.schedule_id < arg_17_1.schedule_id
	end)
	self.historyList_:StartScroll(#self.historyDataList_)

	if #self.historyDataList_ > 0 then
		self:UpdateHistoryView(1, self.historyDataList_[1])
	end
end

function XH3rdWaterReviewView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function XH3rdWaterReviewView:UpdateHistoryView(arg_19_1, arg_19_2)
	self.curIndex_ = arg_19_1
	self.data_ = arg_19_2

	local var_19_0 = arg_19_2.competition_list[1]
	local var_19_1 = arg_19_2.competition_list[2]
	local var_19_2 = ActivityWaterCompetitionCfg[arg_19_2.competition_list[1].competition_id]
	local var_19_3 = ActivityWaterCompetitionCfg[arg_19_2.competition_list[2].competition_id]
	local var_19_4 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[arg_19_2.competition_list[1].competition_id].hero_id].hero_id]
	local var_19_5 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[arg_19_2.competition_list[2].competition_id].hero_id].hero_id]

	self.nameLabel1_.text = string.format("%s·%s", HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[arg_19_2.competition_list[1].competition_id].hero_id].hero_id].name, HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[arg_19_2.competition_list[1].competition_id].hero_id].hero_id].suffix)
	self.nameLabel2_.text = string.format("%s·%s", var_19_5.name, var_19_5.suffix)
	self.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(var_19_0.competition_id)

	self.roleImage1_:SetNativeSize()

	self.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(var_19_1.competition_id)

	self.roleImage2_:SetNativeSize()

	local var_19_6
	local var_19_7

	if self.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(self.params_.activityID).schedule_id then
		local var_19_8 = ActivityWaterData:GetClientProgress(self.params_.activityID)

		var_19_6 = var_19_8[1]
		var_19_7 = var_19_8[2]
	else
		var_19_6 = var_19_0.assistance_process
		var_19_7 = var_19_1.assistance_process
	end

	self.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(var_19_6)
	self.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(var_19_7)

	local var_19_9 = math.max(var_19_2.process_reward[#var_19_2.process_reward][1], var_19_3.process_reward[#var_19_3.process_reward][1])

	self.progressBar1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_19_6 / var_19_9 + 20)
	self.progressBar2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * var_19_7 / var_19_9 + 20)

	if arg_19_2.selected_contestant_id == var_19_0.competition_id then
		self.leftSelectController_:SetSelectedState("yes")
		self.rightSelectController_:SetSelectedState("no")
	elseif arg_19_2.selected_contestant_id == var_19_1.competition_id then
		self.leftSelectController_:SetSelectedState("no")
		self.rightSelectController_:SetSelectedState("yes")
	else
		self.leftSelectController_:SetSelectedState("no")
		self.rightSelectController_:SetSelectedState("no")
	end

	if self.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(self.params_.activityID).schedule_id then
		SetActive(self.receiveGo_, false)
		self.leftWinController_:SetSelectedState("no")
		self.rightWinController_:SetSelectedState("no")
	else
		SetActive(self.receiveGo_, (arg_19_2.is_success or nil) and self.data_.is_success > 0)

		local var_19_11

		if var_19_7 < var_19_6 then
			self.leftWinController_:SetSelectedState("yes")
			self.rightWinController_:SetSelectedState("no")

			var_19_11 = string.format("%s·%s", var_19_4.name, var_19_4.suffix)
		elseif var_19_6 == var_19_7 then
			self.leftWinController_:SetSelectedState("draw")
			self.rightWinController_:SetSelectedState("draw")

			if arg_19_2.selected_contestant_id == var_19_0.competition_id then
				var_19_11 = string.format("%s·%s", var_19_4.name, var_19_4.suffix)
			elseif arg_19_2.selected_contestant_id == var_19_1.competition_id then
				var_19_11 = string.format("%s·%s", var_19_5.name, var_19_5.suffix)
			end
		else
			self.leftWinController_:SetSelectedState("no")
			self.rightWinController_:SetSelectedState("yes")

			var_19_11 = string.format("%s·%s", var_19_5.name, var_19_5.suffix)
		end

		self.rewardTipLabel_.text = string.format(GetTips("ACTIVITY_WATER_TIP_REWARD_FROM"), var_19_11)

		if ActivityWaterData:HaveGotHistoryReward(arg_19_2.schedule_id) then
			self.receiveController_:SetSelectedState("yes")
		else
			self.receiveController_:SetSelectedState("no")
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rewardContainer_)
	end
end

function XH3rdWaterReviewView:OnMainHomeViewTop()
	return
end

function XH3rdWaterReviewView:Dispose()
	if self.historyList_ then
		self.historyList_:Dispose()

		self.historyList_ = nil
	end

	XH3rdWaterReviewView.super.Dispose(self)
end

return XH3rdWaterReviewView
