local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivr6sxbnd"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isOtherController = self:getController("isOther")
	self.m_isElementLeaderController = self:getController("isElementLeader")
	self.m_nameComp = self:getChild("nameComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_touchRect = self:getChild("touchRect")
	self.m_fragName = self:getChild("fragName")
	self.m_progTxt = self:getChild("progTxt")
	self.m_progBar = self:getChild("progBar")
	self.m_addBtn = self:getChild("addBtn")
	self.m_fragIcon = self:getChild("fragIcon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsOtherCtrl = {
	other = 1,
	normal = 0
}
var_0_0.IsElementLeaderCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
