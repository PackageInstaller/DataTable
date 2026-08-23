local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ewxk3p"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_statusController = self:getController("status")
	self.m_Comp_icon = self:getChild("Comp_icon")
end

return var_0_0
