local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wmudubv"

function var_0_0:__ctor()
	self.m_showAutoBuyController = self:getController("showAutoBuy")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_otherBtn = self:getChild("otherBtn")
	self.m_needText = self:getChild("needText")
	self.m_rechargeComp = self:getChild("rechargeComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_content = self:getChild("content")
end

var_0_0.ShowAutoBuyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
