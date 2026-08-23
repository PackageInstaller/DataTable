local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei2d"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_icon = self:getChild("icon")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_eff = self:getChild("eff")
	self.m_numTxt = self:getChild("numTxt")
	self.m_enter3Transition = self:getTransition("enter3")
end

return var_0_0
