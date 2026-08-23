local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wy8kt61"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_icon = self:getChild("icon")
	self.m_rewardEffComp = self:getChild("rewardEffComp")
end

var_0_0.StatusCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
