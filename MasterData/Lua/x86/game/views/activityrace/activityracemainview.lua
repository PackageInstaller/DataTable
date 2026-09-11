local ActivityRaceMainView = class("ActivityRaceMainView", ReduxView)

function ActivityRaceMainView:UIName()
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceMainUI"
end

function ActivityRaceMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRaceMainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.switchItemList_ = {}

	for iter_3_0 = 1, self.switchPanelTrans_.childCount do
		self.switchItemList_[iter_3_0] = ActivityRaceSwitchItem.New(self.switchPanelTrans_:GetChild(iter_3_0 - 1).gameObject)
	end
end

function ActivityRaceMainView:InitUI()
	self:BindCfgUI()
end

function ActivityRaceMainView:AddUIListener()
	self:AddBtnListener(self.shopBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = ActivityShopCfg[self.activityID_]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[self.activityID_].activity_theme]) do
			table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
		end

		local var_6_2, var_6_3 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_2 then
			JumpTools.GoToSystem("/shop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("activityRaceRewardPanel", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self:Go("/activityRaceRank", {
			activityID = self.rankID_
		})
	end)
end

function ActivityRaceMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RACE_DESCRIPE")

	self.activityID_ = self.params_.activityID
	self.rankID_ = self.params_.rankID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RegisterRedPoint()
	self:RefreshUI()
	self:AddTimer()
end

function ActivityRaceMainView:OnExit()
	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in ipairs(self.switchItemList_) do
		iter_10_1:OnExit()
	end

	self:UnRegisterRedPoint()
	self:StopTimer()
end

function ActivityRaceMainView:Dispose()
	for iter_11_0, iter_11_1 in ipairs(self.switchItemList_) do
		iter_11_1:Dispose()
	end

	ActivityRaceMainView.super.Dispose(self)
end

function ActivityRaceMainView:RefreshUI()
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list

	for iter_12_0, iter_12_1 in ipairs(self.switchItemList_) do
		iter_12_1:SetData(self.activityID_, self.subActivityList_[iter_12_0])
	end

	self:RefreshDesc()

	self.scoreText_.text = ActivityRaceData:GetTotalScore(self.activityID_) or 0
end

function ActivityRaceMainView:RefreshDesc()
	self.descText_.text = GetTips("ACTIVITY_RACE_CONTENT")
end

function ActivityRaceMainView:AddTimer()
	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		for iter_15_0, iter_15_1 in ipairs(self.switchItemList_) do
			iter_15_1:RefreshLock()
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityRaceMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityRaceMainView:RegisterRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, self.activityID_))
end

function ActivityRaceMainView:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, self.activityID_))
end

return ActivityRaceMainView
