local BattleFirstPassView = class("BattleFirstPassView", ReduxView)

function BattleFirstPassView:UIName()
	return ActivityTools.GetUIName(self.params_.activityID)
end

function BattleFirstPassView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleFirstPassView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BattleFirstPassView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, BattleFirstPassItem)
end

function BattleFirstPassView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.activityID_, self.battleList_[arg_5_1])
	arg_5_2:SetSelected(self:IsSelect(self.battleList_[arg_5_1]))
	arg_5_2:RegisterClickListener(function(arg_6_0)
		BattleFirstPassData:SetLastBattleID(self.activityID_, arg_6_0)
		self:SetCurBattleID(arg_6_0)
	end)
end

function BattleFirstPassView:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_8_0

		if self.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("ERROR_ACTIVITY_NOT_OPEN")

			do return end

			var_8_0 = {}
		end

		var_8_0.section = ActivityFirstClearCfg[self.curBattleID_].stage_id
		var_8_0.sectionType = ActivityTools.GetSectionType(self.activityID_)
		var_8_0.activityID = self.curBattleID_

		self:Go("/sectionSelectHero", var_8_0)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("firstPassRewardPop", {
			activityID = self.activityID_
		})
	end)
end

function BattleFirstPassView:OnEnter()
	self:GetActivityData()
	self:BindRedPointUI()
	self:RefreshUI()
	self:SetCurBattleID(BattleFirstPassData:GetLastBattleID(self.activityID_) or self.battleList_[1])
	self.scrollHelper_:StartScroll(#self.battleList_)
end

function BattleFirstPassView:GetActivityData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function BattleFirstPassView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.BATTLE_FIRST_PASS_REWARD .. self.activityID_)
end

function BattleFirstPassView:RefreshUI()
	self:RefreshTime()
	self:RefreshList()
end

function BattleFirstPassView:RefreshTime()
	local var_14_0
	local var_14_1 = manager.time:GetServerTime()

	self:StopActivityTimer()

	if var_14_1 < self.startTime_ then
		self.activityTimeCnt_.text = GetTips("ERROR_NOT_TIME")
		self.activityTimer_ = Timer.New(function()
			var_14_0 = self.startTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				self:StopActivityTimer()
				self:RefreshTime()
				self.scrollHelper_:StartScrollByPosition(#self.battleList_, self.scrollHelper_:GetScrolledPosition())

				return
			end
		end, 1, -1)

		self.activityTimer_:Start()
	elseif var_14_1 < self.stopTime_ then
		self.activityTimeCnt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		self.activityTimer_ = Timer.New(function()
			var_14_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				self:StopActivityTimer()
				self:RefreshTime()
				self.scrollHelper_:StartScrollByPosition(#self.battleList_, self.scrollHelper_:GetScrolledPosition())

				return
			end

			self.activityTimeCnt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		end, 1, -1)

		self.activityTimer_:Start()
	else
		self.activityTimeCnt_.text = GetTips("TIME_OVER")
	end
end

function BattleFirstPassView:RefreshList()
	self.battleList_ = BattleFirstPassData:GetBattleList(self.activityID_)
end

function BattleFirstPassView:SetCurBattleID(arg_18_1)
	self.curBattleID_ = arg_18_1
	self.title_.text = GetI18NText(ActivityFirstClearCfg[arg_18_1].name)

	for iter_18_0, iter_18_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_18_1:SetSelected(self:IsSelect((iter_18_1:GetID())))
	end
end

function BattleFirstPassView:IsSelect(arg_19_1)
	return self.curBattleID_ == arg_19_1
end

function BattleFirstPassView:StopActivityTimer()
	if self.activityTimer_ then
		self.activityTimer_:Stop()

		self.activityTimer_ = nil
	end
end

function BattleFirstPassView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.BATTLE_FIRST_PASS_REWARD .. self.activityID_)
end

function BattleFirstPassView:OnTop()
	local var_22_0 = ActivityTools.GetGameHelpKey(self.activityID_)

	if var_22_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_22_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function BattleFirstPassView:OnExit()
	self:StopActivityTimer()
	self:UnBindRedPointUI()

	for iter_23_0, iter_23_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_23_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function BattleFirstPassView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	BattleFirstPassView.super.Dispose(self)
end

return BattleFirstPassView
