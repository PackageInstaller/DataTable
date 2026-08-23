local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52woq5i7m"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_picLoader = self:getChild("picLoader")
	self.m_knight1 = self:getChild("knight1")
	self.m_knight2 = self:getChild("knight2")
	self.m_gotoBtn = self:getChild("gotoBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
