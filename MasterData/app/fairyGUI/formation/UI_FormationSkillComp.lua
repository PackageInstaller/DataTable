local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99a1hm2"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill3 = self:getChild("skill3")
	self.m_skill4 = self:getChild("skill4")
	self.m_touchMask = self:getChild("touchMask")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
