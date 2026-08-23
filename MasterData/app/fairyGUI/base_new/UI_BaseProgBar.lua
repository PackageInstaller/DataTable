local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepke2z1d"

function var_0_0:__ctor()
	self.m_progTypeController = self:getController("progType")
	self.m_hideTextController = self:getController("hideText")
	self.m_hideBgController = self:getController("hideBg")
	self.m_bg = self:getChild("bg")
end

var_0_0.ProgTypeCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.HideTextCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
