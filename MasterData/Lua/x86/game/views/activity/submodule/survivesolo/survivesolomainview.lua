local SurviveSoloMainView = class("SurviveSoloMainView", ReduxView)

function SurviveSoloMainView:UIName()
	return SurviveSoloTools.GetMainUIName(self.params_.activityID)
end

function SurviveSoloMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SurviveSoloMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SurviveSoloMainView:InitUI()
	self:BindCfgUI()

	self.levelBtn_ = {}
	self.levelTime_ = {}
	self.levelText_ = {}
	self.openCon_ = {}
	self.clearCon_ = {}
	self.activityList_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.params_.activityID]

	for iter_4_0, iter_4_1 in ipairs(self.activityList_) do
		table.insert(self.levelBtn_, self["levelBtn_" .. iter_4_0])
		table.insert(self.levelTime_, self["levelTime_" .. iter_4_0])
		table.insert(self.levelText_, self["levelText_" .. iter_4_0])

		self.levelText_[iter_4_0].text = GetI18NText(BattleSoloSlayerCfg[ActivitySoloSlayerCfg[iter_4_1].stage_id].name)

		table.insert(self.openCon_, ControllerUtil.GetController(self["levelBtn_" .. iter_4_0].transform, "open"))
		table.insert(self.clearCon_, ControllerUtil.GetController(self["levelBtn_" .. iter_4_0].transform, "clear"))
	end

	self.levelData_ = {}
	self.indexCon_ = ControllerUtil.GetController(self.transform_, "index")

	if self.scrollView_ then
		self.positionCon_ = ControllerUtil.GetController(self.transform_, "position")
	end
end

function SurviveSoloMainView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self:SetIndex(0)
		end

		JumpTools.OpenPageByJump("surviveSoloReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self:SetIndex(0)
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(self.activityList_) do
		self:AddBtnListener(self.levelBtn_[iter_5_0], nil, function()
			local var_8_0 = manager.time:GetServerTime()

			if var_8_0 >= self.levelData_[iter_5_0].startTime and var_8_0 < self.levelData_[iter_5_0].stopTime then
				SurviveSoloData:SetLastIndex(self.activityID_, iter_5_0)
				self:SetIndex(iter_5_0)
			elseif var_8_0 < self.levelData_[iter_5_0].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.levelData_[iter_5_0].startTime)))
			else
				ShowTips("TIME_OVER")
			end
		end)
	end
end

function SurviveSoloMainView:OnEnter()
	self:GetActivityData()
	self:RefreshUI()
	self:BindUIRedPoint()
end

function SurviveSoloMainView:GetActivityData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime

	for iter_10_0, iter_10_1 in ipairs(self.activityList_) do
		self.levelData_[iter_10_0] = ActivityData:GetActivityData(iter_10_1)
	end
end

function SurviveSoloMainView:RefreshUI()
	self:RefreshLevel()
	self:RefreshTime()

	self.selectIndex_ = SurviveSoloData:GetLastIndex(self.activityID_)

	if self:IsOpenSectionView() then
		self:SetIndex(self.selectIndex_ or 0)
	else
		self:SetIndex(0)
	end

	if self.scrollView_ then
		self.positionCon_:SetSelectedState(self.selectIndex_ or 0)
	end
end

function SurviveSoloMainView:RefreshLevel()
	for iter_12_0, iter_12_1 in ipairs(self.activityList_) do
		local var_12_1 = SurviveSoloData:GetData(iter_12_1)

		if var_12_1 then
			self.clearCon_[iter_12_0]:SetSelectedState(var_12_1.time > 0 and "true" or "false")
		else
			self.clearCon_[iter_12_0]:SetSelectedState("false")
		end
	end
end

function SurviveSoloMainView:RefreshTime()
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()

	self:StopTimer()
	self:RefreshLevelTime()

	if var_13_1 < self.startTime_ then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_13_0 = self.startTime_ - manager.time:GetServerTime()

			self:RefreshLevelTime()

			if var_13_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_13_1 < self.stopTime_ then
		self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		self.timer_ = Timer.New(function()
			var_13_0 = self.stopTime_ - manager.time:GetServerTime()

			self:RefreshLevelTime()

			if var_13_0 <= 0 then
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

function SurviveSoloMainView:RefreshLevelTime()
	local var_16_0 = manager.time:GetServerTime()

	for iter_16_0, iter_16_1 in ipairs(self.activityList_) do
		if var_16_0 < self.levelData_[iter_16_0].startTime then
			self.openCon_[iter_16_0]:SetSelectedState("false")

			self.levelTime_[iter_16_0].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(self.levelData_[iter_16_0].startTime))
		else
			self.openCon_[iter_16_0]:SetSelectedState("true")
		end
	end
end

function SurviveSoloMainView:SetIndex(arg_17_1)
	self.selectIndex_ = arg_17_1

	if arg_17_1 ~= 0 and arg_17_1 ~= -1 then
		self:SetScrollEnable(false)
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_][arg_17_1], 0)
		JumpTools.OpenPageByJump("surviveSoloSectionInfo", {
			index = arg_17_1,
			section = ActivitySoloSlayerCfg[ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_][arg_17_1]].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO,
			activityID = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_][arg_17_1],
			repeat_id = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_][arg_17_1],
			backFunc = function()
				self:SetIndex(0)
			end
		})

		if self.scrollView_ then
			self.positionCon_:SetSelectedState(0)
			self.positionCon_:SetSelectedState(arg_17_1)
		end
	else
		self:SetScrollEnable(true)
	end

	self.indexCon_:SetSelectedState(arg_17_1)
end

function SurviveSoloMainView:SetScrollEnable(arg_19_1)
	if self.scrollView_ then
		self.scrollView_.enabled = arg_19_1
	end
end

function SurviveSoloMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SurviveSoloMainView:BindUIRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. self.activityID_)

	for iter_21_0, iter_21_1 in ipairs(self.activityList_) do
		manager.redPoint:bindUIandKey(self.levelBtn_[iter_21_0].gameObject.transform, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_21_1)
	end
end

function SurviveSoloMainView:UnbindUIRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. self.activityID_)

	for iter_22_0, iter_22_1 in ipairs(self.activityList_) do
		manager.redPoint:unbindUIandKey(self.levelBtn_[iter_22_0].gameObject.transform, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_22_1)
	end
end

function SurviveSoloMainView:IsOpenSectionView()
	return self:IsOpenRoute("surviveSoloSectionInfo")
end

function SurviveSoloMainView:OnTop()
	self:UpdataBar()
end

function SurviveSoloMainView:UpdataBar()
	local var_25_0 = SurviveSoloTools.GetGameHelpKey(self.params_.activityID)

	if var_25_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_25_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self:SetIndex(0)
			JumpTools.Back()
		else
			JumpTools.Back()
		end
	end)
end

function SurviveSoloMainView:OnExit()
	self:UnbindUIRedPoint()
	self:StopTimer()
	self:SetIndex(-1)

	if self.scrollView_ then
		self.positionCon_:SetSelectedState(-1)
	end

	manager.windowBar:HideBar()
end

function SurviveSoloMainView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return SurviveSoloMainView
