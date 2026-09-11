local ActivityWuluoVehicleMainView = class("ActivityWuluoVehicleMainView", ReduxView)

function ActivityWuluoVehicleMainView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_HomeUI"
end

function ActivityWuluoVehicleMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityWuluoVehicleMainView:Init()
	self:InitUI()
	self:AddUIListner()
end

function ActivityWuluoVehicleMainView:InitUI()
	self:BindCfgUI()

	self.bubbleController_ = self.transCon_:GetController("bubble")
	self.tabSelectControllerList_ = {}
	self.tabLockControllerList_ = {}

	for iter_4_0 = 1, BilliardGameConst.StageCount do
		self.tabSelectControllerList_[iter_4_0] = self["tabCon_" .. iter_4_0]:GetController("select")
		self.tabLockControllerList_[iter_4_0] = self["tabCon_" .. iter_4_0]:GetController("lock")
	end

	self.refreshVehicleHandler_ = handler(self, self.RefreshVehicle)
end

function ActivityWuluoVehicleMainView:AddUIListner()
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityWuluoVehicleTaskView")
	end)
	self:AddBtnListener(self.illuBtn_, nil, function()
		JumpTools.OpenPageByJump("activityWuluoVehicleIllustratePopView")
	end)
	self:AddBtnListener(self.ballInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityWuluoVehicleInfoPopView")
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.selectedStageCfg_ then
			LaunchBilliardGame_5_1(self.selectedStageCfg_.id, self.selectedVehicleId_)
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityWuluoVehicleLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
		})
	end)

	for iter_5_0 = 1, BilliardGameConst.StageCount do
		self:AddBtnListener(self["tabBtn_" .. iter_5_0], nil, function()
			self:OnSelectTab(iter_5_0)
		end)
	end
end

function ActivityWuluoVehicleMainView:OnEnter()
	self:RefreshView()
	self:RefreshRewardTime()
	self:OnSelectTab(#self.openStageList_)
	self:RefreshVehicle()
	self:RegistEventListener(WULUO_SELECT_VEHICLE_UPDATE, self.refreshVehicleHandler_)
	self:BindRedPoint()
	self:CheckPopView()
	self:ShowBubbleTips()
end

function ActivityWuluoVehicleMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityWuluoVehicleMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.illuBtn_.transform, RedPointConst.WULO_ILLUSTRATE)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
end

function ActivityWuluoVehicleMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.illuBtn_.transform, RedPointConst.WULO_ILLUSTRATE)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
end

function ActivityWuluoVehicleMainView:RefreshView()
	self.openStageList_ = VehicleBallData:GetOpenStageList()
	self.isLockList_ = {}

	for iter_16_0 = 1, BilliardGameConst.StageCount do
		self.isLockList_[iter_16_0] = table.indexof(self.openStageList_, MergeBallStageCfg.all[iter_16_0]) == false

		self.tabLockControllerList_[iter_16_0]:SetSelectedIndex(self.isLockList_[iter_16_0] and 1 or 0)
	end

	local var_16_0 = 0

	for iter_16_1, iter_16_2 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN]) do
		if TaskData2:GetTaskComplete(iter_16_2) then
			var_16_0 = var_16_0 + 1
		end
	end

	self.receivedTaskNumText_.text = string.format("%d/%d", var_16_0, #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN])
end

function ActivityWuluoVehicleMainView:RefreshRewardTime()
	local var_17_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)

	self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)

	SetActive(self.rewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK))

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)
			else
				SetActive(self.rewardBtn_.gameObject, false)
				self:LimitStopTimer()
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function ActivityWuluoVehicleMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function ActivityWuluoVehicleMainView:OnSelectTab(arg_20_1)
	if self.isLockList_[arg_20_1] then
		ShowTips("MERGE_BALL_STAGE_LOCKED")

		return
	end

	if self.selectedTabIndex_ ~= nil then
		self.tabSelectControllerList_[self.selectedTabIndex_]:SetSelectedIndex(0)
	end

	self.selectedTabIndex_ = arg_20_1

	self.tabSelectControllerList_[arg_20_1]:SetSelectedIndex(1)

	self.selectedStageCfg_ = MergeBallStageCfg[MergeBallStageCfg.all[arg_20_1]]
	self.titleText_.text = self.selectedStageCfg_.name
	self.descText_.text = self.selectedStageCfg_.desc
end

function ActivityWuluoVehicleMainView:RefreshVehicle()
	self.selectedVehicleId_ = VehicleBallData:GetSelectedVehicleId()

	if MergeBallVehicleCfg[self.selectedVehicleId_] then
		self.vehicleIcon_.sprite = pureGetSpriteWithoutAtlas(MergeBallVehicleCfg[self.selectedVehicleId_].icon)
	end
end

function ActivityWuluoVehicleMainView:CheckPopView()
	local var_22_0 = VehicleBallData:GetLastPassedStage()

	if var_22_0 ~= 0 and not getData("BilliardVehicle", "billiardVehiclePop" .. var_22_0) then
		SetActive(self.blockGo_, true)

		self.popTimer_ = Timer.New(function()
			if BilliardGameConst.ShowPopView[var_22_0] then
				if BilliardGameConst.ShowPopView[var_22_0][1] == BilliardGameConst.VehicleType.VEHICLE then
					JumpTools.OpenPageByJump("activityWuluoVehicleUnlockPopView", {
						vehicleID = BilliardGameConst.ShowPopView[var_22_0][2]
					})
				else
					JumpTools.OpenPageByJump("activityWuluoBuffUnlockPopView", {
						buffIDList = BilliardGameConst.ShowPopView[var_22_0][2]
					})
				end

				saveData("BilliardVehicle", "billiardVehiclePop" .. var_22_0, true)
			end

			SetActive(self.blockGo_, false)
		end, 1, 1)

		self.popTimer_:Start()
	end
end

function ActivityWuluoVehicleMainView:ShowBubbleTips()
	local var_24_0 = GameSetting.mergeball_home_bubble_cd.value[1]
	local var_24_1 = GameSetting.mergeball_home_bubble_cd.value[2]
	local var_24_2 = GameSetting.mergeball_home_bubble_tips.value

	self.bubbleCG_.alpha = 0

	if type(GameSetting.mergeball_home_bubble_tips.value) ~= "table" or #GameSetting.mergeball_home_bubble_tips.value == 0 or GameSetting.mergeball_home_bubble_cd.value[1] <= 0 then
		return
	end

	local function var_24_3()
		if type(var_24_2) ~= "table" or #var_24_2 == 0 then
			return
		end

		local var_25_0 = math.random(#var_24_2)

		if #var_24_2 > 1 then
			while var_25_0 == self.bubbleTipIndex_ do
				var_25_0 = math.random(#var_24_2)
			end
		end

		self.bubbleTipIndex_ = var_25_0
		self.bubbleText_.text = GetTips(var_24_2[var_25_0])

		self.bubbleAnim_:Play("show")
	end

	local function var_24_4()
		var_24_3()

		self.bubbleTimer_ = Timer.New(function()
			self.bubbleAnim_:Play("exit")

			self.bubbleHideTimer_ = Timer.New(function()
				var_24_4()
			end, var_24_1, 1)

			self.bubbleHideTimer_:Start()
		end, var_24_0, 1)

		self.bubbleTimer_:Start()
	end

	var_24_4()
end

function ActivityWuluoVehicleMainView:OnExit()
	self:LimitStopTimer()

	if self.bubbleTimer_ then
		self.bubbleTimer_:Stop()

		self.bubbleTimer_ = nil
	end

	if self.bubbleHideTimer_ then
		self.bubbleHideTimer_:Stop()

		self.bubbleHideTimer_ = nil
	end

	self.bubbleCG_.alpha = 0

	self:UnBindRedPoint()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function ActivityWuluoVehicleMainView:Dispose()
	ActivityWuluoVehicleMainView.super.Dispose(self)
end

return ActivityWuluoVehicleMainView
