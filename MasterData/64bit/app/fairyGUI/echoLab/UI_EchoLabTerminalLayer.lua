local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1ddca3f"

function var_0_0:__ctor()
	self.m_coreComp = self:getChild("coreComp")
	self.m_embryo1Comp = self:getChild("embryo1Comp")
	self.m_embryo2Comp = self:getChild("embryo2Comp")
	self.m_embryo3Comp = self:getChild("embryo3Comp")
	self.m_embryo4Comp = self:getChild("embryo4Comp")
	self.m_embryo5Comp = self:getChild("embryo5Comp")
	self.m_eff = self:getChild("eff")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
