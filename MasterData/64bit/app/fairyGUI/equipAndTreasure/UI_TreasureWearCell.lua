local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjsr"

function var_0_0:__ctor()
	self.m_wearStateController = self:getController("wearState")
	self.m_showLinkController = self:getController("showLink")
	self.m_showAttrScoreController = self:getController("showAttrScore")
	self.m_scoreTipController = self:getController("scoreTip")
	self.m_bgImg = self:getChild("bgImg")
	self.m_treasureIcon = self:getChild("treasureIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_linkComp = self:getChild("linkComp")
	self.m_wearComp = self:getChild("wearComp")
	self.m_scoreTxt = self:getChild("scoreTxt")
end

var_0_0.WearStateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowLinkCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowAttrScoreCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ScoreTipCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
