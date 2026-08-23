local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wb0gx5"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_baseIcon = self:getChild("baseIcon")
end

var_0_0.IsGetCtrl = {
	未领取 = 0,
	已领取 = 1
}

return var_0_0
