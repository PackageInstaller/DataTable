local var_0_0 = {}

var_0_0.URL = "ui://ij78oondpj8ph0"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_groupList = self:getChild("groupList")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_petList = self:getChild("petList")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_content = self:getChild("content")
end

var_0_0.EmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
