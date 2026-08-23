local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhn2r125"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_bgline1 = self:getChild("bgline1")
	self.m_bgline2 = self:getChild("bgline2")
	self.m_bgzs2 = self:getChild("bgzs2")
	self.m_bgzs1 = self:getChild("bgzs1")
	self.m_eff = self:getChild("eff")
	self.m_touchArea = self:getChild("touchArea")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
