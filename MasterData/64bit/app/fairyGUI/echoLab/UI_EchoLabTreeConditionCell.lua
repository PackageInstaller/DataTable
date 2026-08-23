local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1jth63h"

function var_0_0:__ctor()
	self.m_isReachController = self:getController("isReach")
	self.m_descText = self:getChild("descText")
	self.m_valueText = self:getChild("valueText")
end

var_0_0.IsReachCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
