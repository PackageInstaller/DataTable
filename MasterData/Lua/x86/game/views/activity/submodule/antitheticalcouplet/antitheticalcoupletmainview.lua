local AntitheticalCoupletMainView = class("AntitheticalCoupletMainView", ReduxView)

function AntitheticalCoupletMainView:UIName()
	return AntitheticalCoupletTools.GetMainUIName(self.params_.activityID)
end

function AntitheticalCoupletMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AntitheticalCoupletMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AntitheticalCoupletMainView:InitUI()
	self:BindCfgUI()

	self.levelData_ = {}
	self.rewardList_ = {}
	self.levelList_ = ActivityCfg[self.params_.activityID].sub_activity_list or {}
	self.toggles_ = {}
	self.tglLock_ = {}
	self.toggleCon_ = {}
	self.cToggleCon_ = {}
	self.toggleTime_ = {}

	for iter_4_0, iter_4_1 in ipairs(self.levelList_) do
		self.toggles_[iter_4_0] = self["tgl_" .. iter_4_0]
		self.tglLock_[iter_4_0] = self["lock_" .. iter_4_0]
		self.toggleCon_[iter_4_0] = ControllerUtil.GetController(self.toggles_[iter_4_0].transform, "state")
		self.cToggleCon_[iter_4_0] = ControllerUtil.GetController(self.toggles_[iter_4_0].transform, "toggle")
		self.toggleTime_[iter_4_0] = self["tglTime_" .. iter_4_0]
	end

	self.rewardCon_ = ControllerUtil.GetController(self.gameObject_.transform, "reward")
	self.stateCon_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.titleCon_ = ControllerUtil.GetController(self.gameObject_.transform, "title")
end

function AntitheticalCoupletMainView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if ActivityData:GetActivityData(self.curId_):IsActivitying() then
			AntitheticalCoupletAction:GetReward(self.curId_)
		else
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_7_0 = manager.time:GetServerTime()
		local var_7_1 = self.levelData_[table.indexof(self.levelList_, self.curId_)]

		if var_7_0 >= var_7_1.startTime and var_7_0 < var_7_1.stopTime then
			manager.story:StartStoryById(ActivitySpringFestivalCoupletsCfg[self.curId_].story_id, function(arg_8_0)
				JumpTools.OpenPageByJump("/antitheticalCoupletResult", {
					activityID = self.activityID_,
					id = self.curId_
				})
			end, true)
		elseif var_7_0 >= var_7_1.stopTime then
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.reviewBtn_, nil, function()
		local var_9_0 = manager.time:GetServerTime()
		local var_9_1 = self.levelData_[table.indexof(self.levelList_, self.curId_)]

		if var_9_0 >= var_9_1.startTime and var_9_0 < var_9_1.stopTime then
			JumpTools.OpenPageByJump("/antitheticalCoupletResult", {
				isComplet = true,
				activityID = self.activityID_,
				id = self.curId_
			})
		elseif var_9_0 >= var_9_1.stopTime then
			ShowTips("TIME_OVER")
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_5_1, function(arg_10_0)
			if arg_10_0 then
				self.curId_ = self.levelList_[iter_5_0]

				self:RefreshReward()
				AntitheticalCoupletData:SetOpen(self.levelList_[iter_5_0])
			end
		end)
		self:AddBtnListener(self.tglLock_[iter_5_0], nil, function()
			if manager.time:GetServerTime() < self.levelData_[iter_5_0].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.levelData_[iter_5_0].startTime)))
			end
		end)
	end
end

function AntitheticalCoupletMainView:OnEnter()
	self:BindUIRedPoint()
	self:RefreshData()
	self:RefreshUI()
end

function AntitheticalCoupletMainView:RefreshData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime

	for iter_13_0, iter_13_1 in ipairs(self.levelList_) do
		self.levelData_[iter_13_0] = ActivityData:GetActivityData(iter_13_1)
	end
end

function AntitheticalCoupletMainView:RefreshUI()
	self:RefreshTime()
	self:RefreshList()
	self:RefreshReward()
end

function AntitheticalCoupletMainView:RefreshTime()
	local var_15_0
	local var_15_1 = manager.time:GetServerTime()

	self:StopTimer()
	self:RefreshLevelTime()

	if var_15_1 < self.startTime_ then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_15_0 = self.startTime_ - manager.time:GetServerTime()

			self:RefreshLevelTime()

			if var_15_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_15_1 < self.stopTime_ then
		self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		self.timer_ = Timer.New(function()
			var_15_0 = self.stopTime_ - manager.time:GetServerTime()

			self:RefreshLevelTime()

			if var_15_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function AntitheticalCoupletMainView:RefreshLevelTime()
	local var_18_0 = manager.time:GetServerTime()

	for iter_18_0, iter_18_1 in ipairs(self.levelList_) do
		if var_18_0 < self.levelData_[iter_18_0].startTime then
			self.toggles_[iter_18_0].interactable = false

			self.toggleCon_[iter_18_0]:SetSelectedState("lock")

			self.toggleTime_[iter_18_0].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(self.levelData_[iter_18_0].startTime))
		else
			self.toggles_[iter_18_0].interactable = true

			local var_18_1 = AntitheticalCoupletData:GetData(self.levelList_[iter_18_0])

			if var_18_1 and var_18_1.chooseID ~= 0 then
				self.toggleCon_[iter_18_0]:SetSelectedState("complete")
			else
				self.toggleCon_[iter_18_0]:SetSelectedState("nor")
			end
		end
	end
end

function AntitheticalCoupletMainView:RefreshList()
	self.curId_ = AntitheticalCoupletData:GetLastLevel(self.activityID_) or self.levelList_[1]

	local var_19_0 = table.indexof(self.levelList_, self.curId_)

	self.toggles_[var_19_0].isOn = true

	AntitheticalCoupletData:SetOpen(self.levelList_[var_19_0])
end

function AntitheticalCoupletMainView:RefreshReward()
	self.desc_.text = GetI18NText(ActivitySpringFestivalCoupletsCfg[self.curId_].desc)

	self.titleCon_:SetSelectedState((table.indexof(self.levelList_, self.curId_)))

	for iter_20_0, iter_20_1 in ipairs(ActivitySpringFestivalCoupletsCfg[self.curId_].reward_item_list) do
		if self.rewardList_[iter_20_0] then
			self.rewardList_[iter_20_0]:SetData(iter_20_1)
		else
			self.rewardList_[iter_20_0] = RewardPoolItem.New(self.rewardPanel_, iter_20_1, true, POP_SOURCE_ITEM)
		end
	end

	for iter_20_2 = #ActivitySpringFestivalCoupletsCfg[self.curId_].reward_item_list + 1, #self.rewardList_ do
		self.rewardList_[iter_20_2]:Show(false)
	end

	self.curData_ = AntitheticalCoupletData:GetData(self.curId_)

	self:RefreshRewardType()
	self:RefreshStateType()
end

function AntitheticalCoupletMainView:RefreshRewardType()
	if self.curData_ and self.curData_.isReward then
		self.rewardCon_:SetSelectedState("finish")
	elseif self.curData_ and self.curData_.chooseID ~= 0 then
		self.rewardCon_:SetSelectedState("complete")
	else
		self.rewardCon_:SetSelectedState("false")
	end
end

function AntitheticalCoupletMainView:RefreshStateType()
	if self.curData_ and self.curData_.chooseID ~= 0 then
		self.stateCon_:SetSelectedState("true")
	else
		self.stateCon_:SetSelectedState("false")
	end
end

function AntitheticalCoupletMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AntitheticalCoupletMainView:BindUIRedPoint()
	for iter_24_0, iter_24_1 in ipairs(self.levelList_) do
		manager.redPoint:bindUIandKey(self["tglPos_" .. iter_24_0], RedPointConst.ANTITHETICAL_COUPLET .. "_" .. iter_24_1, {
			x = 0,
			y = 0
		})
	end
end

function AntitheticalCoupletMainView:UnBindUIRedPoint()
	for iter_25_0, iter_25_1 in ipairs(self.levelList_) do
		manager.redPoint:unbindUIandKey(self["tglPos_" .. iter_25_0], RedPointConst.ANTITHETICAL_COUPLET .. "_" .. iter_25_1)
	end
end

function AntitheticalCoupletMainView:OnAntitheticalCoupletReward()
	self:RefreshRewardType()
end

function AntitheticalCoupletMainView:OnTop()
	local var_27_0 = AntitheticalCoupletTools.GetGameHelpKey(self.activityID_)

	if var_27_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_27_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function AntitheticalCoupletMainView:OnExit()
	self:StopTimer()
	self:UnBindUIRedPoint()
	manager.windowBar:HideBar()
	AntitheticalCoupletData:SaveLastSelect(self.activityID_, self.curId_)
end

function AntitheticalCoupletMainView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return AntitheticalCoupletMainView
