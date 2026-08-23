local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vzqdx9bnoqi"

function var_0_0:__ctor()
	self.m_effEnter = self:getChild("effEnter")
	self.m_touchBg = self:getChild("touchBg")
	self.m_descTxt = self:getChild("descTxt")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
