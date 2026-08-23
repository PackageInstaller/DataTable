local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepv90ekk2ru"

function var_0_0:__ctor()
	self.m_IsExpandController = self:getController("IsExpand")
	self.m_showStateController = self:getController("showState")
	self.m_preciousSuitList = self:getChild("preciousSuitList")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsExpandCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowStateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
