local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obl1fx1s"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_itemIcon = self:getChild("itemIcon")
end

var_0_0.IsGetCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
