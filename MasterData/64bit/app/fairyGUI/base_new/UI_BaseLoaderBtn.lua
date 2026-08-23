local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepmtubibk7"

function var_0_0:__ctor()
	self.m_txtShowController = self:getController("txtShow")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TxtShowCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
