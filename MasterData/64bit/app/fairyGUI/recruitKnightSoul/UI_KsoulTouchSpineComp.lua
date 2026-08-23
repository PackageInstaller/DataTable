local var_0_0 = {}

var_0_0.URL = "ui://cw1w6t2bwczdp"

function var_0_0:__ctor()
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_touchEffect = self:getChild("touchEffect")
	self.m_openEffect = self:getChild("openEffect")
	self.m_jumpBtn = self:getChild("jumpBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
