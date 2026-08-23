local var_0_0 = {}

var_0_0.URL = "ui://7nx6gocgdg2c3g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_descTxt = self:getChild("descTxt")
	self.m_gotoRechargeBtn = self:getChild("gotoRechargeBtn")
	self.m_title = self:getChild("title")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
