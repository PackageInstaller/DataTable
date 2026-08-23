local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94nnig5x"

function var_0_0:__ctor()
	self.m_viewTypeController = self:getController("viewType")
	self.m_effComp = self:getChild("effComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
