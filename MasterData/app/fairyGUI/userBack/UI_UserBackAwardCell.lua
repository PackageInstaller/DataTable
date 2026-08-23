local var_0_0 = {}

var_0_0.URL = "ui://ermspfa5occrk"

function var_0_0:__ctor()
	self.m_awardStatusController = self:getController("awardStatus")
	self.m_icon = self:getChild("icon")
	self.m_awardCountTxt = self:getChild("awardCountTxt")
	self.m_dayLoader = self:getChild("dayLoader")
	self.m_maskImg = self:getChild("maskImg")
	self.m_effGetsm = self:getChild("effGetsm")
end

return var_0_0
