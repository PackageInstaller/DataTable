local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1o"

function var_0_0:__ctor()
	self.m_army_typeController = self:getController("army_type")
	self.m_scaleController = self:getController("scale")
	self.m_showNameController = self:getController("showName")
	self.m_showLevelController = self:getController("showLevel")
	self.m_lvTxt = self:getChild("lvTxt")
end

var_0_0.Army_typeCtrl = {
	page3 = 2,
	page2 = 3,
	page1 = 1,
	page0 = 0,
	page4 = 4
}
var_0_0.ScaleCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowNameCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowLevelCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
