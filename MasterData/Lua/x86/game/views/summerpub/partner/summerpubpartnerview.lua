local SummerPubPartnerView = class("SummerPubPartnerView", ReduxView)

function SummerPubPartnerView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Partner/Activity_SummerPub_PartnerUI"
end

function SummerPubPartnerView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerPubPartnerView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubPartnerView:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}
	self.clickFunc = handler(self, self.onClickItem)

	for iter_4_0 = 1, 10 do
		self.heroItemList_[iter_4_0] = SummerPubPartnerItem.New(self[string.format("heroItem%s_", iter_4_0)], iter_4_0, self.clickFunc)
	end
end

function SummerPubPartnerView:AddUIListeners()
	return
end

function SummerPubPartnerView:OnEnterOver()
	if self.params_.isBack then
		-- block empty
	else
		for iter_6_0, iter_6_1 in ipairs(self.heroItemList_) do
			iter_6_1:UpdateState()
		end
	end
end

function SummerPubPartnerView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SummerPubPartnerView:OnExit()
	manager.windowBar:HideBar()
end

function SummerPubPartnerView:onClickItem()
	manager.windowBar:HideBar()
end

function SummerPubPartnerView:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.heroItemList_) do
		iter_10_1:Dispose()
	end

	self.super.Dispose(self)
end

return SummerPubPartnerView
