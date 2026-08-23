local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wm6mjh1"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_fragImg = self:getChild("fragImg")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_nameTxt = self:getChild("nameTxt")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
