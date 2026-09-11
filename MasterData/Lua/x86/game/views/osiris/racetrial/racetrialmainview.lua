local RaceTrialMainView = class("RaceTrialMainView", ReduxView)

function RaceTrialMainView:UIName()
	return RaceTrialTools.GetMainUIName(self.params_.activityID)
end

function RaceTrialMainView:UIParent()
	return manager.ui.uiMain.transform
end

function RaceTrialMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialMainView:InitUI()
	self:BindCfgUI()

	self.battleList_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, self:GetBattleItemClass())
	self.receiveCon_ = ControllerUtil.GetController(self.transform_, "receiveCon")
	self.scoreRewardItem_ = CommonItem.New(self.CommonItemGo_)

	self.scoreRewardItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, self.reward_)
	end)
end

function RaceTrialMainView:GetBattleItemClass()
	return RaceTrialTools.GetBattleItemClass(self.activityID_)
end

function RaceTrialMainView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(self.battleList_[arg_7_1], self.activityID_)
end

function RaceTrialMainView:AddUIListeners()
	self:AddBtnListener(self.firstRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.scoreRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialScoreReward", {
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveScoreReward(self.curLv_)
	end)
	self:AddBtnListener(self.DivineBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("heroRaceTrialDetails")
	end)
end

function RaceTrialMainView:OnEnter()
	self.activityID_ = self.params_.activityID or ActivityConst.OSIRIS_TRIAL

	self:BindRedPointUI()
	self:RefreshUI()
end

function RaceTrialMainView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.params_.activityID))
end

function RaceTrialMainView:RefreshUI()
	self:GetCurLv()
	self:RefreshTimeCnt()
	self:RefreshList()
	self:RefreshScoreItem()
end

function RaceTrialMainView:GetCurLv()
	self.curLv_ = RaceTrialData:GetCurLv(self.activityID_)
	self.data_ = RaceTrialData:GetScoreRewardByID(self.curLv_)
end

function RaceTrialMainView:RefreshTimeCnt()
	local var_17_0
	local var_17_1 = self:GetActivityStartTime()
	local var_17_2 = self:GetActivityEndTime()
	local var_17_3 = manager.time:GetServerTime()

	self:StopTimer()

	if var_17_3 < var_17_1 then
		var_17_0 = var_17_1 - var_17_3
		self.timeCntText_.text = GetTips("ERROR_ACTIVITY_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_17_0 = var_17_1 - manager.time:GetServerTime()

			if var_17_0 <= 0 then
				self:StopTimer()
				self:RefreshUI()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_17_3 < var_17_2 then
		var_17_0 = var_17_2 - var_17_3
		self.timeCntText_.text = self:GetTimeText(var_17_2 - var_17_3)
		self.timer_ = Timer.New(function()
			var_17_0 = var_17_2 - manager.time:GetServerTime()

			if var_17_0 <= 0 then
				self:StopTimer()
				self:RefreshUI()

				return
			end

			self.timeCntText_.text = self:GetTimeText(var_17_0)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeCntText_.text = GetTips("TIME_OVER")
	end
end

function RaceTrialMainView:GetActivityStartTime()
	return RaceTrialData:GetRaceTrialStartTime(self.activityID_)
end

function RaceTrialMainView:GetActivityEndTime()
	return RaceTrialData:GetRaceTrialEndTime(self.activityID_)
end

function RaceTrialMainView:GetTimeText(arg_22_1)
	return arg_22_1 / 86400 >= 1 and math.ceil(arg_22_1 / 86400) .. GetTips("DAY") or arg_22_1 / 3600 >= 1 and math.ceil(arg_22_1 / 3600) .. GetTips("HOUR") or arg_22_1 / 60 >= 1 and math.ceil(arg_22_1 / 60) .. GetTips("MINUTE") or 1 .. GetTips("MINUTE")
end

function RaceTrialMainView:RefreshList()
	self.battleList_ = ActivityData:GetActivityData(self.activityID_).subActivityIdList

	self.scrollHelper_:StartScrollByPosition(#self.battleList_, (Vector2(getData(string.format("RaceTrial_%d", self.activityID_), "scrollPosX"), 1)))
end

function RaceTrialMainView:RefreshScoreItem()
	self.rewardCfg_ = ActivityPointRewardCfg[self.curLv_]

	local var_24_0 = RaceTrialData:GetTotalScore(self.activityID_)

	self.scoreNeedText_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. self.rewardCfg_.need
	self.scoreText_.text = var_24_0 .. "/" .. self.rewardCfg_.need
	self.progressBar_.fillAmount = var_24_0 / self.rewardCfg_.need
	self.reward_ = self.rewardCfg_.reward_item_list[1]

	self.scoreRewardItem_:RefreshData(formatReward(self.rewardCfg_.reward_item_list[1]))

	if self.data_.receive_flag then
		self.receiveCon_:SetSelectedState("received")
	elseif var_24_0 >= self.rewardCfg_.need then
		self.receiveCon_:SetSelectedState("complete")
	else
		self.receiveCon_:SetSelectedState("incomplete")
	end
end

function RaceTrialMainView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.params_.activityID))
end

function RaceTrialMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
end

function RaceTrialMainView:OnPointReceive()
	self:GetCurLv()
	self:RefreshScoreItem()
end

function RaceTrialMainView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPointUI()

	for iter_28_0, iter_28_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_28_1:OnExit()
	end

	self.scoreRewardItem_:OnExit()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	saveData(string.format("RaceTrial_%d", self.activityID_), "scrollPosX", self.scrollHelper_:GetScrolledPosition().x)
end

function RaceTrialMainView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.scoreRewardItem_:Dispose()
	RaceTrialMainView.super.Dispose(self)
end

return RaceTrialMainView
