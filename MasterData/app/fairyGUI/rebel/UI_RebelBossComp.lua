local var_0_0 = {}

var_0_0.URL = "ui://4bs6g4l5d8ng3"

function var_0_0:__ctor()
	self.m_mineController = self:getController("mine")
	self.m_holdComp = self:getChild("holdComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_hpPerTxt = self:getChild("hpPerTxt")
	self.m_hpProg = self:getChild("hpProg")
	self.m_coolComp = self:getChild("coolComp")
	self.m_deadTxt = self:getChild("deadTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
