local var_0_0 = {}

var_0_0.URL = "ui://ij78oondfvog3"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_title = self:getChild("title")
end

var_0_0.IsActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
