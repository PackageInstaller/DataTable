local var_0_0 = {}

var_0_0.URL = "ui://pbd24silf49a5o"

function var_0_0:__ctor()
	self.m_hideLevelController = self:getController("hideLevel")
	self.m_buffLoader = self:getChild("buffLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_eff = self:getChild("eff")
end

return var_0_0
