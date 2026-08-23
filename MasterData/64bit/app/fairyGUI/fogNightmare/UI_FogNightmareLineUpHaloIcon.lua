local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ocp2jrrot"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_showCampController = self:getController("showCamp")
	self.m_campLoad = self:getChild("campLoad")
end

var_0_0.IsActiveCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowCampCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
