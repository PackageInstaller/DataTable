local RegressionSignNewPage = class("RegressionSignNewPage", (import("game.views.regression.pages.RegressionSignPage")))

function RegressionSignNewPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stSignInUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionSignNewPage:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, RegressionSignItem)
	self.descText_.text = GetTips("REGRESSION_SIGN_DESCRIPE")
end

function RegressionSignNewPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

return RegressionSignNewPage
