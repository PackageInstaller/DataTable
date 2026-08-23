local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1ddca3i"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_icon = self:getChild("icon")
	self.m_title = self:getChild("title")
	self.m_slotList = self:getChild("slotList")
	self.m_descTxt = self:getChild("descTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
