local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83e6av28"

function var_0_0:__ctor()
	self.m_colorGraph1 = self:getChild("colorGraph1")
	self.m_colorGraph2 = self:getChild("colorGraph2")
	self.m_bigImgLoader = self:getChild("bigImgLoader")
	self.m_titleTextIcon = self:getChild("titleTextIcon")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_recruitComp = self:getChild("recruitComp")
	self.m_shopComp = self:getChild("shopComp")
	self.m_passCardComp = self:getChild("passCardComp")
	self.m_taskComp = self:getChild("taskComp")
	self.m_libaozcIcon = self:getChild("libaozcIcon")
	self.m_giftComp = self:getChild("giftComp")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
