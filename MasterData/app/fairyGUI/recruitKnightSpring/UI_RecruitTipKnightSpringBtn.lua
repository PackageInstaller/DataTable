local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapo2z5o"

function var_0_0:__ctor()
	self.m_recruitModeController = self:getController("recruitMode")
	self.m_hideKnightController = self:getController("hideKnight")
	self.m_btnGroupModeController = self:getController("btnGroupMode")
	self.m_showFeatureController = self:getController("showFeature")
	self.m_knightComp = self:getChild("knightComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityTextLoader = self:getChild("qualityTextLoader")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_nameText1 = self:getChild("nameText1")
	self.m_qualityTextLoader1 = self:getChild("qualityTextLoader1")
	self.m_elementLoader1 = self:getChild("elementLoader1")
	self.m_knightBtnGroup = self:getChild("knightBtnGroup")
	self.m_featureText1 = self:getChild("featureText1")
end

var_0_0.RecruitModeCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 6,
	page0 = 0,
	page3 = 5
}
var_0_0.HideKnightCtrl = {
	hide = 1,
	show = 0
}
var_0_0.BtnGroupModeCtrl = {
	right = 2,
	highRight = 7,
	left = 1,
	none = 0
}
var_0_0.ShowFeatureCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
