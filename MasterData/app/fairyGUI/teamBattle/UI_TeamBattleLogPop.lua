local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lvhode1"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_closePnl = self:getChild("closePnl")
	self.m_eff = self:getChild("eff")
	self.m_logList = self:getChild("logList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
