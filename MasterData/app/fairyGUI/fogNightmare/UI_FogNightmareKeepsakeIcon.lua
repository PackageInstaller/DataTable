local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxf4"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_scaleController = self:getController("scale")
	self.m_showLvController = self:getController("showLv")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_keepsakeIcon = self:getChild("keepsakeIcon")
	self.m_effIcon = self:getChild("effIcon")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_effEnterTransition = self:getTransition("effEnter")
	self.m_effEnter2Transition = self:getTransition("effEnter2")
end

var_0_0.QualityCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ScaleCtrl = {
	["80"] = 2,
	["90"] = 1,
	["100"] = 0,
	["70"] = 3
}
var_0_0.ShowLvCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
