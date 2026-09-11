local BloodCardMatchPopView = class("BloodCardMatchPopView", ReduxView)

function BloodCardMatchPopView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMatchmakingUI"
end

function BloodCardMatchPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BloodCardMatchPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BloodCardMatchPopView:InitUI()
	self:BindCfgUI()

	self.cancelHandler_ = handler(self, function()
		self:Back()
	end)
	self.successHandler_ = handler(self, function()
		self:Back()
	end)
end

function BloodCardMatchPopView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		BloodCardAction:SendCancelMultiGameMatching()
		self.cancelHandler_()
	end)
end

function BloodCardMatchPopView:OnEnter()
	self.matchingTimer = 0
	self.timeText_.text = self.matchingTimer .. "s"

	self:AddTimer()
	manager.notify:RegistListener(BLOOD_CARD_MATCHING_SUCCESS, self.successHandler_)
	manager.notify:RegistListener(BLOOD_CARD_MATCHING_CANCEL, self.cancelHandler_)
end

function BloodCardMatchPopView:AddTimer()
	self.timer_ = Timer.New(function()
		self.matchingTimer = self.matchingTimer + 1
		self.timeText_.text = self.matchingTimer .. "s"
	end, 1, -1, true)

	self.timer_:Start()
end

function BloodCardMatchPopView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.notify:RemoveListener(BLOOD_CARD_MATCHING_SUCCESS, self.successHandler_)
	manager.notify:RemoveListener(BLOOD_CARD_MATCHING_CANCEL, self.cancelHandler_)
end

function BloodCardMatchPopView:Dispose()
	BloodCardMatchPopView.super.Dispose(self)
end

return BloodCardMatchPopView
