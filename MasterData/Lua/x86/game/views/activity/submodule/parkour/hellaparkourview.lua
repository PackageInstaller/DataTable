local HellaParkourView = class("HellaParkourView", ReduxView)

function HellaParkourView:UIName()
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourUI"
end

function HellaParkourView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaParkourView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaParkourView:InitUI()
	self:BindCfgUI()
end

function HellaParkourView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		if ActivityData:GetActivityIsOpen(self.parkour_activity_id) then
			JumpTools.OpenPageByJump("hellaParkourReward", {
				parkour_activity_id = self.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		if ActivityData:GetActivityIsOpen(self.parkour_activity_id) then
			JumpTools.OpenPageByJump("/hellaParkourEntrust", {
				parkour_activity_id = self.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.m_loseBtn, nil, function()
		if ActivityData:GetActivityIsOpen(self.parkour_activity_id) then
			JumpTools.OpenPageByJump("/hellaParkourLose", {
				parkour_activity_id = self.parkour_activity_id
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function HellaParkourView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_PARKOUR_DESCRIPE")
end

function HellaParkourView:OnEnter()
	self.parkour_activity_id = self.params_.parkour_activity_id or 61101

	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_REWARD, self.parkour_activity_id))
	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, self.parkour_activity_id))
	manager.redPoint:bindUIandKey(self.m_loseBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, self.parkour_activity_id))
end

function HellaParkourView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_REWARD, self.parkour_activity_id))
	manager.redPoint:unbindUIandKey(self.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, self.parkour_activity_id))
	manager.redPoint:unbindUIandKey(self.m_loseBtn.transform, string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, self.parkour_activity_id))
end

function HellaParkourView:RefreshTime()
	local var_13_0 = ActivityData:GetActivityData(self.parkour_activity_id)

	self.m_timer.text = var_13_0 and var_13_0:IsActivitying() and GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr(var_13_0.stopTime) or GetTips("TIME_OUT")
end

return HellaParkourView
