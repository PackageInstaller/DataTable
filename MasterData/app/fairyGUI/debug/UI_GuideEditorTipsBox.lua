local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ya6om5ibhp"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_rect = self:getChild("rect")
	self.m_circel = self:getChild("circel")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 4,
	page1 = 1
}

return var_0_0
