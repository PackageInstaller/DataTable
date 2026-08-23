local var_0_0 = {}

var_0_0.URL = "ui://454a48jpijb614bnnmp"

function var_0_0:__ctor()
	self.m_childComp = self:getChild("childComp")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
