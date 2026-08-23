local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnpaahibr3"

function var_0_0:__ctor()
	self.m_timesController = self:getController("times")
	self.m_popPanel = self:getChild("popPanel")
	self.m_chooseNumComp = self:getChild("chooseNumComp")
	self.m_baseItem = self:getChild("baseItem")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_content = self:getChild("content")
end

var_0_0.TimesCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
