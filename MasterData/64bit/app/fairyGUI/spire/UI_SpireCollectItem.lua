local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1t"

function var_0_0:__ctor()
	self.m_isNullController = self:getController("isNull")
	self.m_showItem = self:getChild("showItem")
end

var_0_0.IsNullCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
