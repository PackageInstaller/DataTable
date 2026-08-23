local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7ek02do"

function var_0_0:__ctor()
	self.m_infoBtnController = self:getController("infoBtn")
	self.m_twoSuitTitle = self:getChild("twoSuitTitle")
	self.m_twoAttr = self:getChild("twoAttr")
	self.m_fourSuitTitle = self:getChild("fourSuitTitle")
	self.m_fourAttr = self:getChild("fourAttr")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.InfoBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
