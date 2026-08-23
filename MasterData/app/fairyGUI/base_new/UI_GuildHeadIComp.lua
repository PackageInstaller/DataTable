local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneps3cr1i"

function var_0_0:__ctor()
	self.m_isShowDescController = self:getController("isShowDesc")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_signIcon = self:getChild("signIcon")
	self.m_desc = self:getChild("desc")
	self.m_useDescGroup = self:getChild("useDescGroup")
end

var_0_0.IsShowDescCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
