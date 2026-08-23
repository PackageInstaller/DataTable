local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lpd6b14"

function var_0_0:__ctor()
	self.m_descTxt = self:getChild("descTxt")
	self.m_picLoader = self:getChild("picLoader")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
