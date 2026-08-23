local var_0_0 = {}

var_0_0.URL = "ui://foyq921sm0ri99"

function var_0_0:__ctor()
	self.m_showTypeController = self:getController("showType")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_addSize = self:getChild("addSize")
	self.m_addTime = self:getChild("addTime")
end

var_0_0.ShowTypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
