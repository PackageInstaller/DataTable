local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepmdfj15"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.StyleCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
