local MythicFinalRewardView = class("MythicFinalRewardView", ReduxView)

function MythicFinalRewardView:UIName()
	return "Widget/System/Challenge_Mythic/MythicRewardUI"
end

function MythicFinalRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function MythicFinalRewardView:OnCtor()
	return
end

function MythicFinalRewardView:Init()
	self:InitUI()
	self:AddListeners()
end

function MythicFinalRewardView:InitUI()
	self:BindCfgUI()

	self.controller_ = self.transform_:GetComponent("ControllerExCollection"):GetController("default0")
	self.hotrewardList_ = LuaList.New(handler(self, self.RefreashItem), self.uiList_, MythicFinalRewardItem)
end

function MythicFinalRewardView:OnEnter()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self.timetext_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr((MythicData:GetNextRefreshTime())))
		end, 1, -1)

		self.timer_:Start()
	end

	self.timetext_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr((MythicData:GetNextRefreshTime())))
	self.passtext_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_FOLLOW_TIPS"), MythicData:GetPassHotLevel())

	self:RefreashUI()
end

function MythicFinalRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MythicFinalRewardView:AddListeners()
	self:AddBtnListener(self.receiveallbtn_, nil, function()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function()
					MythicAction:GetAllFinalReward()
				end
			})
		else
			MythicAction:GetAllFinalReward()
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function MythicFinalRewardView:RefreashItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1)
end

function MythicFinalRewardView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function MythicFinalRewardView:OnMythicFinalGetReward()
	self:RefreashUI()
end

function MythicFinalRewardView:RefreashUI()
	if MythicData:GetPassHotLevel() > 0 then
		if MythicData:GetIsHaveRewardNotGet() then
			self.controller_:SetSelectedIndex(0)
		else
			self.controller_:SetSelectedIndex(1)
		end
	else
		self.controller_:SetSelectedIndex(1)
	end

	MythicData:SortRewards()
	self.hotrewardList_:StartScroll(#MythicFinalCfg.all)
end

function MythicFinalRewardView:Dispose()
	if self.hotrewardList_ then
		self.hotrewardList_:Dispose()

		self.hotrewardList_ = nil
	end

	self:StopTimer()
	MythicFinalRewardView.super.Dispose(self)
end

function MythicFinalRewardView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return MythicFinalRewardView
