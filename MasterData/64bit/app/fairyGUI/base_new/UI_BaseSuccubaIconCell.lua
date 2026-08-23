local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepjr2h1emigk1"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isOtherController = self:getController("isOther")
	self.m_succubaIcon = self:getChild("succubaIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
