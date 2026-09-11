local RaceTrialMainView_2_1 = class("RaceTrialMainView_2_1", ActivityMainBasePanel)

function RaceTrialMainView_2_1:GetUIName()
	return RaceTrialTools.GetMainUIName(self.activityID_)
end

function RaceTrialMainView_2_1:Init()
	self:InitUI()
	self:AddListeners()
end

function RaceTrialMainView_2_1:InitUI()
	self:BindCfgUI()

	self.battleList_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, self:GetBattleItemClass())
	self.receiveCon_ = ControllerUtil.GetController(self.transform_, "receiveCon")
	self.scoreRewardItem_ = CommonItem.New(self.CommonItemGo_)

	self.scoreRewardItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, self.reward_)
	end)

	self.receivePointRewardHandler_ = handler(self, self.OnReceivePoint)
end

function RaceTrialMainView_2_1:GetBattleItemClass()
	return RaceTrialTools.GetBattleItemClass(self.activityID_)
end

function RaceTrialMainView_2_1:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.battleList_[arg_6_1], self.activityID_)
end

function RaceTrialMainView_2_1:AddListeners()
	self:AddBtnListener(self.firstRewardBtn_, nil, function()
		if not self:IsActivityTime(self.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.scoreRewardBtn_, nil, function()
		if not self:IsActivityTime(self.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("volumeRaceTrialScoreRewardPop", {
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not self:IsActivityTime(self.activityID_) then
			return
		end

		RaceTrialAction:ReceiveScoreReward(self.curLv_)
	end)
	self:AddBtnListener(self.DivineBtn_, nil, function()
		if not self:IsActivityTime(self.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("volumeHeroRaceTrialDetails")
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
		})
	end)
end

function RaceTrialMainView_2_1:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)

	if arg_13_1 == true then
		self:RefreshUI()
		self:BindRedPointUI()
		self:RegistEventListener(RACE_TRIAL_POINT_RECEIVE, self.receivePointRewardHandler_)
	else
		for iter_13_0, iter_13_1 in pairs(self.scrollHelper_:GetItemList()) do
			iter_13_1:OnExit()
		end

		self.scoreRewardItem_:OnExit()
		saveData(string.format("RaceTrial_%d", self.activityID_), "scrollPosX", self.scrollHelper_:GetScrolledPosition().x)
		self:UnBindRedPointUI()
		self:RemoveAllEventListener()
	end
end

function RaceTrialMainView_2_1:OnReceivePoint()
	self:GetCurLv()
	self:RefreshScoreItem()
end

function RaceTrialMainView_2_1:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID_))
end

function RaceTrialMainView_2_1:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID_))
end

function RaceTrialMainView_2_1:RefreshUI()
	self:GetCurLv()
	self:RefreshList()
	self:RefreshScoreItem()
end

function RaceTrialMainView_2_1:GetCurLv()
	self.curLv_ = RaceTrialData:GetCurLv(self.activityID_)
	self.data_ = RaceTrialData:GetScoreRewardByID(self.curLv_)
end

function RaceTrialMainView_2_1:RefreshList()
	self.battleList_ = ActivityData:GetActivityData(self.activityID_).subActivityIdList

	self.scrollHelper_:StartScrollByPosition(#self.battleList_, (Vector2(getData(string.format("RaceTrial_%d", self.activityID_), "scrollPosX"), 1)))
end

function RaceTrialMainView_2_1:RefreshScoreItem()
	self.rewardCfg_ = ActivityPointRewardCfg[self.curLv_]

	local var_20_0 = RaceTrialData:GetTotalScore(self.activityID_)

	self.curScoreText_.text = var_20_0
	self.needScoreText_.text = "/" .. self.rewardCfg_.need
	self.reward_ = self.rewardCfg_.reward_item_list[1]

	self.scoreRewardItem_:RefreshData(formatReward(self.rewardCfg_.reward_item_list[1]))

	if self.data_.receive_flag then
		self.receiveCon_:SetSelectedState("received")
	elseif var_20_0 >= self.rewardCfg_.need then
		self.receiveCon_:SetSelectedState("complete")
	else
		self.receiveCon_:SetSelectedState("incomplete")
	end
end

function RaceTrialMainView_2_1:OnPointReceive()
	self:GetCurLv()
	self:RefreshScoreItem()
end

function RaceTrialMainView_2_1:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.scoreRewardItem_:Dispose()

	self.receivePointRewardHandler_ = nil

	RaceTrialMainView_2_1.super.Dispose(self)
end

return RaceTrialMainView_2_1
