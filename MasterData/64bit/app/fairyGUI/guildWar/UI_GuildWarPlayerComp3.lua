local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mopb921"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isMineController = self:getController("isMine")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_userIcon = self:getChild("userIcon")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsMineCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
