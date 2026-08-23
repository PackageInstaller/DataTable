local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qritsp61"

function var_0_0:__ctor()
	self.m_starNumController = self:getController("starNum")
	self.m_isWearController = self:getController("isWear")
	self.m_isStarUpController = self:getController("isStarUp")
	self.m_iconComp = self:getChild("iconComp")
	self.m_selectIcon = self:getChild("selectIcon")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_starComp = self:getChild("starComp")
end

var_0_0.StarNumCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}
var_0_0.IsWearCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsStarUpCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
