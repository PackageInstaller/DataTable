local var_0_0 = {}

var_0_0.URL = "ui://cw1w6t2bwczdm"

function var_0_0:__ctor()
	self.m_hasExtPercentController = self:getController("hasExtPercent")
	self.m_getDesc = self:getChild("getDesc")
	self.m_basePercentText = self:getChild("basePercentText")
	self.m_extPercentText = self:getChild("extPercentText")
	self.m_totalText = self:getChild("totalText")
end

return var_0_0
