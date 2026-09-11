local RaceTrailEnterView_3_8 = class("RaceTrailEnterView_3_8", ReduxView)

function RaceTrailEnterView_3_8:UIName()
	return RaceTrialTools.GetPageUIName(self.params_.activityID)
end

function RaceTrailEnterView_3_8:UIParent()
	return manager.ui.uiMain.transform
end

function RaceTrailEnterView_3_8:Init()
	self:BindCfgUI()

	self.layzyInit = false
	self.scoreReward = CommonItemView.New(self.scoreReward_, true)
	self.recieveController = self.controllers_:GetController("scoreRewardState")

	self:AddUIListeners()
end

function RaceTrailEnterView_3_8:OnEnter()
	self.activityID = self.params_.activityID or ActivityConst.OSIRIS_TRIAL

	if not self.layzyInit then
		self:LazyInit()
	end

	self.battleItemList:StartScroll(#ActivityData:GetActivityData(self.activityID).subActivityIdList)
	self:BindRedPointUI()
	self:RefreshUI()
	self:ScrollToRecommendItem()
end

function RaceTrailEnterView_3_8:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
end

function RaceTrailEnterView_3_8:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPointUI()
	self.battleItemList:UpdateUIList(0)
end

function RaceTrailEnterView_3_8:LazyInit()
	self.layzyInit = true
	self.battleItemList = LuaList.New(handler(self, self.RenderItem), self.battleItemList_, RaceTrialTools.GetBattleItemClass(self.activityID))
end

function RaceTrailEnterView_3_8:Dispose()
	RaceTrailEnterView_3_8.super.Dispose(self)
	self.scoreReward:Dispose()
	self.battleItemList:Dispose()
end

function RaceTrailEnterView_3_8:AddUIListeners()
	self:AddBtnListenerScale(self.helpBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	self:AddBtnListener(self.firstRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = self.activityID
		})
	end)
	self:AddBtnListener(self.scoreRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialScoreReward", {
			mainActivityID = self.activityID
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		if self.curLv then
			RaceTrialAction:ReceiveAllScoreReward(self.activityID)
		end
	end)
end

function RaceTrailEnterView_3_8:OnPointReceive()
	self:RefreshScore()
end

function RaceTrailEnterView_3_8:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID))
	manager.redPoint:bindUIandKey(self.scoreRewardBtn_.transform, string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID))
end

function RaceTrailEnterView_3_8:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID))
	manager.redPoint:unbindUIandKey(self.scoreRewardBtn_.transform, string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, self.activityID))
end

function RaceTrailEnterView_3_8:RefreshUI()
	self:RefreshScore()
	self:RefreshList()
end

function RaceTrailEnterView_3_8:RefreshScore()
	local var_18_0 = RaceTrialData:GetCurLv(self.activityID)

	self.curLv = var_18_0

	local var_18_1 = RaceTrialData:GetTotalScore(self.activityID)

	self.curScore_.text = var_18_1
	self.needScore_.text = "/" .. ActivityPointRewardCfg[var_18_0].need

	self.scoreReward:SetData((rewardToItemTemplate(formatReward(ActivityPointRewardCfg[var_18_0].reward_item_list[1]), nil, true)))

	if RaceTrialData:GetScoreRewardByID(var_18_0).receive_flag then
		self.recieveController:SetSelectedState("recieved")
	elseif var_18_1 >= ActivityPointRewardCfg[var_18_0].need then
		self.recieveController:SetSelectedState("complete")
	else
		self.recieveController:SetSelectedState("incomplete")
	end
end

function RaceTrailEnterView_3_8:RefreshList()
	self.battleItemList:Refresh()
end

function RaceTrailEnterView_3_8:RenderItem(arg_20_1, arg_20_2)
	arg_20_2:RefreshUI(ActivityData:GetActivityData(self.activityID).subActivityIdList[arg_20_1], self.activityID)
end

local function var_0_1(arg_21_0)
	local var_21_0 = ActivityData:GetActivityData(arg_21_0.activityID).subActivityIdList
	local var_21_1 = 1

	for iter_21_0 = 1, #var_21_0 do
		if manager.redPoint:getTipBoolean(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_21_0.activityID, var_21_0[iter_21_0])) then
			return iter_21_0
		end

		local var_21_2 = (RaceTrialData:GetBattleData(var_21_0[iter_21_0]) or {}).point

		if ((not (RaceTrialData:GetBattleData(var_21_0[iter_21_0]) or {}).point or nil) and 0) < math.huge then
			var_21_1 = iter_21_0
		end
	end

	return var_21_1
end

function RaceTrailEnterView_3_8:ScrollToRecommendItem()
	self.battleItemList:ScrollToIndex(var_0_1(self))
end

return RaceTrailEnterView_3_8
