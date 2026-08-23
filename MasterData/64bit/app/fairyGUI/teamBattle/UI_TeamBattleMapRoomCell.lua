local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lo3z8ed"

function var_0_0:__ctor()
	self.m_hasUserController = self:getController("hasUser")
	self.m_nameText = self:getChild("nameText")
	self.m_swithBtn = self:getChild("swithBtn")
	self.m_tipIcon1 = self:getChild("tipIcon1")
	self.m_tipIcon2 = self:getChild("tipIcon2")
	self.m_tipIcon3 = self:getChild("tipIcon3")
	self.m_tipIcon4 = self:getChild("tipIcon4")
	self.m_user1 = self:getChild("user1")
	self.m_user2 = self:getChild("user2")
	self.m_user3 = self:getChild("user3")
end

var_0_0.HasUserCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
