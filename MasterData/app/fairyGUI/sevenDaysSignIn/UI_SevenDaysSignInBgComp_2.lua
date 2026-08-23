local var_0_0 = {}

var_0_0.URL = "ui://83derwdwd4q91c"

function var_0_0:__ctor()
	self.m_bigAwardNumController = self:getController("bigAwardNum")
	self.m_checkComp_1_1 = self:getChild("checkComp_1_1")
	self.m_checkComp_2_1 = self:getChild("checkComp_2_1")
	self.m_checkComp_2_2 = self:getChild("checkComp_2_2")
	self.m_awardDescTxt = self:getChild("awardDescTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
