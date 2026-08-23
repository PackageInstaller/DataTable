local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2m3et9k"

function var_0_0:__ctor()
	self.m_selectController = self:getController("select")
	self.m_buffController = self:getController("buff")
	self.m_icon = self:getChild("icon")
	self.m_number = self:getChild("number")
end

var_0_0.SelectCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BuffCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
