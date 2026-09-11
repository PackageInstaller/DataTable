local BloodCardEntraceView = class("BloodCardEntraceView", ReduxView)

function BloodCardEntraceView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardEnterUI"
end

function BloodCardEntraceView:UIParent()
	return manager.ui.uiMain.transform
end

function BloodCardEntraceView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function BloodCardEntraceView:AddListeners()
	self:AddBtnListener(self.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityCfg[self.activityID_].sub_activity_list[#ActivityCfg[self.activityID_].sub_activity_list], "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_6_0 = {
			isEnter = true,
			selectNpc = self.params_.optionParams[1]
		}

		var_6_0.isAllNpc = self.params_.optionParams[2] and self.params_.optionParams[2] == 1
		var_6_0.posX = self.params_.optionParams[3]
		var_6_0.posY = self.params_.optionParams[4]
		var_6_0.posZ = self.params_.optionParams[5]
		var_6_0.rotationX = self.params_.optionParams[6]
		var_6_0.rotationY = self.params_.optionParams[7]
		var_6_0.rotationZ = self.params_.optionParams[8]

		JumpTools.OpenPageByJump("/bloodCardSelectNpc", var_6_0)
	end)
	self:AddBtnListener(self.buildCardBtn_, nil, function()
		JumpTools.OpenPageByJump("/bloodCardBuild")
	end)
end

function BloodCardEntraceView:OnEnter()
	self.activityID_ = BloodCardData:GetMainActivityID()
	self.titleText_.text = ActivityTools.GetActivityTitleName(self.activityID_)
	_, self.stopTime_ = ActivityData:GetActivityTime(self.activityID_)

	local var_8_0 = true

	for iter_8_0, iter_8_1 in ipairs(BloodCardConst.guideStageList) do
		if not BloodCardData:GetStageHasPass(iter_8_1) then
			var_8_0 = false

			break
		end
	end

	SetActive(self.buildCardGo_, var_8_0)
	self:AddTimer()

	if BloodCardData:GetTaskActivityID(self.activityID_) ~= 0 then
		manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BloodCardData:GetTaskActivityID(self.activityID_))))
	end

	manager.redPoint:bindUIandKey(self.startBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID())))
end

function BloodCardEntraceView:OnEnterOver()
	BloodCardTools.CheckCacheUnlockCard()
end

function BloodCardEntraceView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLOOD_CARD_GAME_RULE")
end

function BloodCardEntraceView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()

	if BloodCardData:GetTaskActivityID(self.activityID_) ~= 0 then
		manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BloodCardData:GetTaskActivityID(self.activityID_))))
	end

	manager.redPoint:unbindUIandKey(self.startBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID())))
end

function BloodCardEntraceView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function BloodCardEntraceView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BloodCardEntraceView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end
end

function BloodCardEntraceView:Dispose()
	self:StopTimer()
	BloodCardEntraceView.super.Dispose(self)
end

return BloodCardEntraceView
