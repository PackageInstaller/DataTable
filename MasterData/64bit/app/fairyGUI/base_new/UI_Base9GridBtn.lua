local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepf83tibme"

function var_0_0:__ctor()
	self.m_hideTextController = self:getController("hideText")
	self.m_midIcon = self:getChild("midIcon")
end

var_0_0.HideTextCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
