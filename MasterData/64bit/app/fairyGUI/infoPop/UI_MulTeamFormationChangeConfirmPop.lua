local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnx7nfgic3i"

function var_0_0:__ctor()
	self.m_showStateController = self:getController("showState")
	self.m_popPanel = self:getChild("popPanel")
	self.m_iconList = self:getChild("iconList")
	self.m_skillList = self:getChild("skillList")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_content = self:getChild("content")
end

var_0_0.ShowStateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
