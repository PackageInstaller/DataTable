local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7ce"

function var_0_0:__ctor()
	self.m_haveController = self:getController("have")
	self.m_itemIcon = self:getChild("itemIcon")
end

var_0_0.HaveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
