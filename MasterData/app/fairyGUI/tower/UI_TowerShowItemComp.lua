local var_0_0 = {}

var_0_0.URL = "ui://foyq921shirr3h"

function var_0_0:__ctor()
	self.m_isNullController = self:getController("isNull")
	self.m_showItem = self:getChild("showItem")
end

var_0_0.IsNullCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
