local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjss"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_isOtherController = self:getController("isOther")
	self.m_attrComp = self:getChild("attrComp")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_devBtn = self:getChild("devBtn")
	self.m_devRedPointComp = self:getChild("devRedPointComp")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_masterBtn = self:getChild("masterBtn")
	self.m_unloadBtn = self:getChild("unloadBtn")
	self.m_lockBtn = self:getChild("lockBtn")
end

var_0_0.IsLockCtrl = {
	未锁 = 1,
	已锁 = 2,
	无锁 = 0
}
var_0_0.IsOtherCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
