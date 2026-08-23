local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wbvyo1h"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_getAwardTimeTxt = self:getChild("getAwardTimeTxt")
	self.m_contentTxt = self:getChild("contentTxt")
	self.m_currencyNumTxt = self:getChild("currencyNumTxt")
	self.m_currencyIconLoader = self:getChild("currencyIconLoader")
	self.m_indexTxt = self:getChild("indexTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_resupplyDescTxt = self:getChild("resupplyDescTxt")
	self.m_getBtn = self:getChild("getBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
