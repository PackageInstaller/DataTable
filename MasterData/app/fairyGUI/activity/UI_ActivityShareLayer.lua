local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wy8kt63"

function var_0_0:__ctor()
	self.m_cntController = self:getController("cnt")
	self.m_shotComp = self:getChild("shotComp")
	self.m_shareBtn3 = self:getChild("shareBtn3")
	self.m_shareBtn2 = self:getChild("shareBtn2")
	self.m_shareBtn1 = self:getChild("shareBtn1")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.CntCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
