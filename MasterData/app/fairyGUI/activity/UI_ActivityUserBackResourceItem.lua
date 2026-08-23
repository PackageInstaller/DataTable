local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wb6kjk8"

function var_0_0:__ctor()
	self.m_getStateController = self:getController("getState")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numText = self:getChild("numText")
	self.m_nameText = self:getChild("nameText")
	self.m_actionText = self:getChild("actionText")
	self.m_progBar = self:getChild("progBar")
	self.m_progText = self:getChild("progText")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
end

var_0_0.GetStateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
