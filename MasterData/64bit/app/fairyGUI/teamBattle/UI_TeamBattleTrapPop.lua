local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8le3d04g"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
