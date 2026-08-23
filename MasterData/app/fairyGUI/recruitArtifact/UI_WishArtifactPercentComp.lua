local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dl359lgic5b"

function var_0_0:__ctor()
	self.m_hasExtPercentController = self:getController("hasExtPercent")
	self.m_basePercentText = self:getChild("basePercentText")
	self.m_extPercentText = self:getChild("extPercentText")
	self.m_totalText = self:getChild("totalText")
end

var_0_0.HasExtPercentCtrl = {
	has = 1,
	none = 0
}

return var_0_0
