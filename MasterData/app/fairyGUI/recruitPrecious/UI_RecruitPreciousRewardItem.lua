local var_0_0 = {}

var_0_0.URL = "ui://hw835jy1u50cg"

function var_0_0:__ctor()
	self.m_isFragController = self:getController("isFrag")
	self.m_isNewController = self:getController("isNew")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_fragLoader = self:getChild("fragLoader")
	self.m_icon = self:getChild("icon")
	self.m_numText = self:getChild("numText")
	self.m_rewardEff = self:getChild("rewardEff")
	self.m_loopEff = self:getChild("loopEff")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_newImg = self:getChild("newImg")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
