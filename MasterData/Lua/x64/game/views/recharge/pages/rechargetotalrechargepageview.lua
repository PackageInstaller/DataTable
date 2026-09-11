local RechargeTotalRechargePageView = class("RechargeTotalRechargePageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeTotalRechargePageView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RechargeTotalRechargeItem)
end

function RechargeTotalRechargePageView:indexItem(arg_2_1, arg_2_2)
	return
end

function RechargeTotalRechargePageView:AddUIListener()
	return
end

function RechargeTotalRechargePageView:OnTop()
	return
end

function RechargeTotalRechargePageView:OnEnter()
	return
end

function RechargeTotalRechargePageView:OnExit()
	return
end

function RechargeTotalRechargePageView:Hide()
	RechargeTotalRechargePageView.super.Hide(self)
end

function RechargeTotalRechargePageView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RechargeTotalRechargePageView.super.Dispose(self)
end

return RechargeTotalRechargePageView
