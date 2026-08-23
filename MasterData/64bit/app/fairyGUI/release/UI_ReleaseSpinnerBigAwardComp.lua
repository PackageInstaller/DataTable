local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2mg6n1h"

function var_0_0:__ctor()
	self.m_isAwardController = self:getController("isAward")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_fragImg = self:getChild("fragImg")
	self.m_numTxt = self:getChild("numTxt")
	self.m_touchArea = self:getChild("touchArea")
	self.m_eff = self:getChild("eff")
end

return var_0_0
