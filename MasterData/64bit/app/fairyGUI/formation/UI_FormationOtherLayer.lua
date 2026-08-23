local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99cz1wkk2ow"

function var_0_0:__ctor()
	self.m_mainStateController = self:getController("mainState")
	self.m_mainComp = self:getChild("mainComp")
	self.m_preComp = self:getChild("preComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.MainStateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
