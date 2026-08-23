local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2mg6n1a"

function var_0_0:__ctor()
	self.m_isEnoughController = self:getController("isEnough")
	self.m_costImg = self:getChild("costImg")
	self.m_numTxt = self:getChild("numTxt")
	self.m_effLoop = self:getChild("effLoop")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
