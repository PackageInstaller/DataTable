local CoreVerificationChallengeIllustratedView = class("CoreVerificationChallengeIllustratedView", ReduxView)

function CoreVerificationChallengeIllustratedView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_BadgeUI"
end

function CoreVerificationChallengeIllustratedView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationChallengeIllustratedView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.items = {}
	self.list = CoreVerificationChallengeTools.GetBadgeCount()
end

function CoreVerificationChallengeIllustratedView:AddUIListener()
	return
end

function CoreVerificationChallengeIllustratedView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CoreVerificationChallengeIllustratedView:OnEnter()
	self:UpdateBar()

	for iter_6_0 = 1, #self.list do
		self.items[iter_6_0] = self.items[iter_6_0] or CoreVerificationChallengeIllustratedCycleItemView.New(Object.Instantiate(self.itemGo_, self.contentTrs_), iter_6_0)

		self.items[iter_6_0]:Refresh(iter_6_0)
	end

	for iter_6_1 = #self.list + 1, #self.items do
		self.items[iter_6_1]:Show(false)
	end

	if #self.list > 1 then
		self.scrollView_.horizontalNormalizedPosition = 1
	end
end

function CoreVerificationChallengeIllustratedView:OnExit()
	manager.windowBar:HideBar()
end

function CoreVerificationChallengeIllustratedView:Dispose()
	for iter_8_0 = 1, #self.list do
		self.items[iter_8_0]:Dispose()

		self.items[iter_8_0] = nil
	end

	CoreVerificationChallengeIllustratedView.super.Dispose(self)
end

return CoreVerificationChallengeIllustratedView
