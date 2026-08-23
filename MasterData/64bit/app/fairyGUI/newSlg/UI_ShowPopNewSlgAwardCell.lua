local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kual9697p"

function var_0_0:__ctor()
	self.m_tpController = self:getController("tp")
	self.m_baseIcon = self:getChild("baseIcon")
end

var_0_0.TpCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
