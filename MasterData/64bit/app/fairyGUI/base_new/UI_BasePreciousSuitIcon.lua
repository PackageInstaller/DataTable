local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepv90ekk2rv"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isOtherController = self:getController("isOther")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOtherCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
