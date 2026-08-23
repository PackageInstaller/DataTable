local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepf7to1emigeq"

function var_0_0:__ctor()
	self.m_showBtnController = self:getController("showBtn")
	self.m_title = self:getChild("title")
	self.m_inTransition = self:getTransition("in")
	self.m_outTransition = self:getTransition("out")
end

var_0_0.ShowBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
