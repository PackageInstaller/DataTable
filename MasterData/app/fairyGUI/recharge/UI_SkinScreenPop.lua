local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wl8lm77"

function var_0_0:__ctor()
	self.m_touchBg = self:getChild("touchBg")
	self.m_selectComp = self:getChild("selectComp")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
