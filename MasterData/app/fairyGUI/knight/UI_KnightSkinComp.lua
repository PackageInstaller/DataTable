local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivp3dmbmn"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_activeStatusController = self:getController("activeStatus")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_skinNameText = self:getChild("skinNameText")
	self.m_cvNameText = self:getChild("cvNameText")
	self.m_painterNameText = self:getChild("painterNameText")
	self.m_skinList = self:getChild("skinList")
	self.m_operationBtn = self:getChild("operationBtn")
	self.m_attrTxt = self:getChild("attrTxt")
	self.m_attrGroup = self:getChild("attrGroup")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
	self.m_knightQualityLoader = self:getChild("knightQualityLoader")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page6 = 6,
	page3 = 3
}
var_0_0.ActiveStatusCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
