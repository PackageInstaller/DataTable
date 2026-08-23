local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1x"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_iconScaleController = self:getController("iconScale")
	self.m_iconComp = self:getChild("iconComp")
end

return var_0_0
