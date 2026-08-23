local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yiv9jwhmj"

function var_0_0:__ctor()
	self.m_picComp = self:getChild("picComp")
	self.m_bg1 = self:getChild("bg1")
	self.m_bg2 = self:getChild("bg2")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
