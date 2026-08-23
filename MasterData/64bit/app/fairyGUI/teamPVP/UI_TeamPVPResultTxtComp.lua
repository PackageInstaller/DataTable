local var_0_0 = {}

var_0_0.URL = "ui://akds0szaeh7w1c"

function var_0_0:__ctor()
	self.m_resultController = self:getController("result")
	self.m_colorController = self:getController("color")
	self.m_winBtnEff = self:getChild("winBtnEff")
end

return var_0_0
