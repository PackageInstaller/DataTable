local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9whxt68rv"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_newPoint = self:getChild("newPoint")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
