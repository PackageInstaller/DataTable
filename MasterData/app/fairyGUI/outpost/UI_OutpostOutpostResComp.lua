local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5ls4bx7fo"

function var_0_0:__ctor()
	self.m_isIconTipController = self:getController("isIconTip")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_icon = self:getChild("icon")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
