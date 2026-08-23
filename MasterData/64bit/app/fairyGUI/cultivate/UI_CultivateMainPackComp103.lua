local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83s7ud2l"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_upBgLoader = self:getChild("upBgLoader")
	self.m_downBgLoader = self:getChild("downBgLoader")
	self.m_knightComp = self:getChild("knightComp")
	self.m_titleBg = self:getChild("titleBg")
	self.m_titleTextIcon = self:getChild("titleTextIcon")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_recruitComp = self:getChild("recruitComp")
	self.m_shopComp = self:getChild("shopComp")
	self.m_passCardComp = self:getChild("passCardComp")
	self.m_taskComp = self:getChild("taskComp")
	self.m_giftComp = self:getChild("giftComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
