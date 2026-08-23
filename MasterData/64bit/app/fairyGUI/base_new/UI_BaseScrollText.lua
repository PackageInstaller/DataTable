local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephmzukk2u8"

function var_0_0:__ctor()
	self.m_scrollTypeController = self:getController("scrollType")
	self.m_titleCopy = self:getChild("titleCopy")
	self.m_lrScrollTransition = self:getTransition("lrScroll")
	self.m_hScrollTransition = self:getTransition("hScroll")
end

var_0_0.ScrollTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
