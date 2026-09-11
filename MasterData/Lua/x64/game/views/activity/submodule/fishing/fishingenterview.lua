local FishingEnterView = class("FishingEnterView", ReduxView)

function FishingEnterView:UIName()
	return "UI/Fishing/FishingEnterUI"
end

function FishingEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingEnterView:OnCtor()
	return
end

function FishingEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingEnterView:InitUI()
	self:BindCfgUI()
end

function FishingEnterView:AddUIListener()
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("fishingIllustrated", {})
	end)
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		if JumpTools.IsSystemOperationStoped(702) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_8_0 = JumpTools.IsSystemLocked(702)

		if 702 and var_8_0 then
			ShowTips(JumpTools.GetSystemLockedTip(702, var_8_0))

			return
		end

		JumpTools.OpenPageByJump("fishingExchange", {})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("fishingReward", {})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		print("goBtn")
		JumpTools.OpenPageByJump("/fishingGame", {})
	end)
end

function FishingEnterView:AddEventListeners()
	return
end

function FishingEnterView:OnTop()
	self:UpdateBar()
end

function FishingEnterView:OnBehind()
	manager.windowBar:HideBar()
end

function FishingEnterView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "fishingNote",
		type = "jump",
		params = {}
	})
end

function FishingEnterView:OnEnter()
	self:AddEventListeners()
	manager.redPoint:bindUIandKey(self.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(self.receiveRedPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(self.scoreRedPointContainer_, RedPointConst.FISHING_SCORE_REWARD, {
		x = 0,
		y = 0
	})
	FishingAction.GetReceiveInfo(ActivityConst.SUMMER_FISHING)
	FishingAction.ReadUnFinishRedPoint()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
	self:UpdateTimer()
end

function FishingEnterView:OnExit()
	manager.redPoint:unbindUIandKey(self.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD)
	manager.redPoint:unbindUIandKey(self.receiveRedPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD)
	manager.redPoint:unbindUIandKey(self.scoreRedPointContainer_, RedPointConst.FISHING_SCORE_REWARD)
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function FishingEnterView:UpdateTimer()
	local var_18_0 = ActivityData:GetActivityData(ActivityConst.SUMMER_FISHING)

	if manager.time:GetServerTime() >= var_18_0.stopTime then
		self.lastTimeLabel_.text = GetTips("TIME_OVER")

		return
	end

	self.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_18_0.stopTime)
end

function FishingEnterView:OnMainHomeViewTop()
	return
end

function FishingEnterView:Dispose()
	FishingEnterView.super.Dispose(self)
end

return FishingEnterView
