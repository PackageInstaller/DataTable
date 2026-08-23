local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9tvdg3k"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_colorController = self:getController("color")
	self.m_Img_dark = self:getChild("Img_dark")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
