local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o9j768p8"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_entranceLoader = self:getChild("entranceLoader")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
