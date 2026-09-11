local ValentineGameTestView = class("ValentineGameTestView", ReduxView)

function ValentineGameTestView:UIName()
	return ValentineGameTools.GetTestUIName(self.params_.activityID)
end

function ValentineGameTestView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameTestView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameTestView:InitUI()
	self:BindCfgUI()

	self.levelData_ = {}
	self.rewardItems_ = {}
	self.levelBtn_ = {}
	self.levelText_ = {}
	self.levelStateCon_ = {}
	self.levelCompleteCon_ = {}

	for iter_4_0 = 1, #ActivityCfg[self.params_.activityID].sub_activity_list do
		self.levelBtn_[iter_4_0] = self["level_" .. iter_4_0]
		self.levelText_[iter_4_0] = self["levelText_" .. iter_4_0]
		self.levelStateCon_[iter_4_0] = ControllerUtil.GetController(self.levelBtn_[iter_4_0].transform, "state")
		self.levelCompleteCon_[iter_4_0] = ControllerUtil.GetController(self.levelBtn_[iter_4_0].transform, "complet")
	end

	self.rewardItems_ = {
		ValentineGameSPRewardItem.New(self.rewardGo_1),
		ValentineGameSPRewardItem.New(self.rewardGo_2),
		(ValentineGameSPRewardItem.New(self.rewardGo_3))
	}
	self.stateCon_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.indexCon_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
end

function ValentineGameTestView:AddUIListeners()
	for iter_5_0 = 1, #ActivityCfg[self.params_.activityID].sub_activity_list do
		self:AddBtnListener(self.levelBtn_[iter_5_0], nil, function()
			if manager.time:GetServerTime() < self.levelData_[iter_5_0].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.levelData_[iter_5_0].startTime)))
			else
				ValentineGameData:SetLastLevel(self.activityID_, self.list_[iter_5_0])

				self.curIndex_ = iter_5_0

				self:RefreshLevelTime()
				self:RefreshReward()
			end
		end)
	end

	self:AddBtnListener(self.goBtn_, nil, function()
		local var_7_0 = manager.time:GetServerTime()

		if var_7_0 >= self.levelData_[self.curIndex_].startTime and var_7_0 < self.levelData_[self.curIndex_].stopTime then
			JumpTools.OpenPageByJump("/valentineGameLoading", {
				mainActivityID = self.activityID_,
				activityID = self.list_[self.curIndex_]
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		local var_8_0 = manager.time:GetServerTime()

		if var_8_0 >= self.levelData_[self.curIndex_].startTime and var_8_0 < self.levelData_[self.curIndex_].stopTime then
			ValentineGameAction:GetReward(self.list_[self.curIndex_])
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function ValentineGameTestView:OnEnter()
	self:RefreshData()
	self:RefreshUI()
	self:BindUIRedPoint()
end

function ValentineGameTestView:RefreshData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.list_ = ActivityCfg[self.params_.activityID].sub_activity_list

	for iter_10_0, iter_10_1 in ipairs(self.list_) do
		self.levelData_[iter_10_0] = ActivityData:GetActivityData(iter_10_1)
	end
end

function ValentineGameTestView:RefreshUI()
	self.curIndex_ = table.indexof(self.list_, (ValentineGameData:GetLastLevel(self.activityID_))) or 1

	self:RefreshTime()
	self:RefreshList()
	self:RefreshReward()
end

function ValentineGameTestView:RefreshTime()
	local var_12_0
	local var_12_1 = manager.time:GetServerTime()

	self:StopTimer()
	self:RefreshLevelTime()

	if var_12_1 < self.startTime_ then
		self.timer_ = Timer.New(function()
			var_12_0 = self.startTime_ - manager.time:GetServerTime()

			self:RefreshLevelTime()

			if var_12_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_12_1 < self.stopTime_ then
		self.timer_ = Timer.New(function()
			var_12_0 = self.stopTime_ - manager.time:GetServerTime()

			self:RefreshLevelTime()

			if var_12_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function ValentineGameTestView:RefreshLevelTime()
	local var_15_0 = manager.time:GetServerTime()

	for iter_15_0, iter_15_1 in ipairs(self.list_) do
		if var_15_0 < self.levelData_[iter_15_0].startTime then
			self.levelStateCon_[iter_15_0]:SetSelectedState("lock")
			self.levelCompleteCon_[iter_15_0]:SetSelectedState("false")

			self.levelText_[iter_15_0].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(self.levelData_[iter_15_0].startTime))
		elseif iter_15_0 ~= self.curIndex_ then
			self.levelStateCon_[iter_15_0]:SetSelectedState("normal")
		else
			self.levelStateCon_[iter_15_0]:SetSelectedState("selected")
		end
	end
end

function ValentineGameTestView:RefreshList()
	for iter_16_0, iter_16_1 in ipairs(self.list_) do
		local var_16_0 = ValentineGameData:GetData(iter_16_1)

		if var_16_0 and var_16_0.isClear then
			self.levelCompleteCon_[iter_16_0]:SetSelectedState("true")
		else
			self.levelCompleteCon_[iter_16_0]:SetSelectedState("false")
		end
	end
end

function ValentineGameTestView:RefreshReward()
	self.indexCon_:SetSelectedState(self.curIndex_)
	ValentineGameData:SetNotNewOpen(self.list_[self.curIndex_])

	for iter_17_0, iter_17_1 in ipairs(ActivityValentineCfg[self.list_[self.curIndex_]].reward_item_list) do
		self.rewardItems_[iter_17_0]:SetData(iter_17_1)
	end

	for iter_17_2 = #ActivityValentineCfg[self.list_[self.curIndex_]].reward_item_list + 1, #self.rewardItems_ do
		self.rewardItems_[iter_17_2]:Show(false)
	end

	local var_17_0 = ValentineGameData:GetData(self.list_[self.curIndex_])

	if var_17_0 and var_17_0.isReward then
		self:SetPoint(var_17_0.point, ActivityValentineCfg[self.list_[self.curIndex_]])
		self.stateCon_:SetSelectedState("received")
	elseif var_17_0 and var_17_0.isClear then
		self:SetPoint(var_17_0.point, ActivityValentineCfg[self.list_[self.curIndex_]])
		self.stateCon_:SetSelectedState("complete")
	else
		self.testText_.text = GetI18NText(ActivityValentineCfg[self.list_[self.curIndex_]].desc)

		self.stateCon_:SetSelectedState("test")
	end
end

function ValentineGameTestView:SetPoint(arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = ValentineGameTools.GetPointRule(self.params_.activityID)

	if arg_18_1 <= var_18_0 then
		self.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_1")
		self.completeText_.text = GetI18NText(arg_18_2.result_desc[1])
	elseif arg_18_1 <= var_18_1 then
		self.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_2")
		self.completeText_.text = GetI18NText(arg_18_2.result_desc[2])
	else
		self.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_3")
		self.completeText_.text = GetI18NText(arg_18_2.result_desc[3])
	end
end

function ValentineGameTestView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameTestView:BindUIRedPoint()
	for iter_20_0, iter_20_1 in ipairs(self.list_) do
		manager.redPoint:bindUIandKey(self.levelBtn_[iter_20_0].transform, RedPointConst.VALENTINE_GAME .. "_" .. iter_20_1)
	end
end

function ValentineGameTestView:UnBindUIRedPoint()
	for iter_21_0, iter_21_1 in ipairs(self.list_) do
		manager.redPoint:unbindUIandKey(self.levelBtn_[iter_21_0].transform, RedPointConst.VALENTINE_GAME .. "_" .. iter_21_1)
	end
end

function ValentineGameTestView:OnValentineGameReward()
	self:RefreshReward()
end

function ValentineGameTestView:OnTop()
	local var_23_0 = ValentineGameTools.GetGameHelpKey(self.activityID_)

	if var_23_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_23_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function ValentineGameTestView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()

	for iter_24_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_24_0]:OnExit()
	end

	self:UnBindUIRedPoint()
end

function ValentineGameTestView:Dispose()
	self:RemoveAllListeners()

	for iter_25_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_25_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ValentineGameTestView
