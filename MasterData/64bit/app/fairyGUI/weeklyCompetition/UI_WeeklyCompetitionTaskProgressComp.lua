local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34oiurhb"

function var_0_0:__ctor()
	self.m_timeLineRenewEffect = self:getChild("timeLineRenewEffect")
	self.m_progressBar = self:getChild("progressBar")
	self.m_boxComp1 = self:getChild("boxComp1")
	self.m_boxComp2 = self:getChild("boxComp2")
	self.m_boxComp3 = self:getChild("boxComp3")
	self.m_icon = self:getChild("icon")
	self.m_progressValue = self:getChild("progressValue")
	self.m_bubbleComp = self:getChild("bubbleComp")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_nodeText = self:getChild("nodeText")
	self.m_levelUpEffect = self:getChild("levelUpEffect")
	self.m_expEffectComp = self:getChild("expEffectComp")
	self.m_inTransition = self:getTransition("in")
end

return var_0_0
