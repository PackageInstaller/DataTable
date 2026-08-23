local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bniqddkk318"

function var_0_0:__ctor()
	self.m_activeController = self:getController("active")
	self.m_levelComp = self:getChild("levelComp")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_skillDescTxt = self:getChild("skillDescTxt")
	self.m_unlockTxt = self:getChild("unlockTxt")
end

var_0_0.ActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
