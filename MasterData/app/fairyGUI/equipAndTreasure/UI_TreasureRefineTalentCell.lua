local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7rhsd2i"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_nameText = self:getChild("nameText")
	self.m_valueText = self:getChild("valueText")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
