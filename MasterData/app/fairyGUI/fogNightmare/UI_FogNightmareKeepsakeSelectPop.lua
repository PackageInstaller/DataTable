local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88omw6pfl"

function var_0_0:__ctor()
	self.m_showTipController = self:getController("showTip")
	self.m_tipBubbleController = self:getController("tipBubble")
	self.m_isExtraController = self:getController("isExtra")
	self.m_autoSelectShowController = self:getController("autoSelectShow")
	self.m_isSweepController = self:getController("isSweep")
	self.m_switchComp = self:getChild("switchComp")
	self.m_keepsakeList = self:getChild("keepsakeList")
	self.m_suitTipText = self:getChild("suitTipText")
	self.m_suitListComp = self:getChild("suitListComp")
	self.m_txtInfo = self:getChild("txtInfo")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_randSealBtn = self:getChild("randSealBtn")
	self.m_skipBtn = self:getChild("skipBtn")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_txt_num = self:getChild("txt_num")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_title = self:getChild("title")
	self.m_tipBubbleTxt = self:getChild("tipBubbleTxt")
	self.m_tipBubbleGroup = self:getChild("tipBubbleGroup")
	self.m_mask = self:getChild("mask")
	self.m_testComp = self:getChild("testComp")
	self.m_waitNode = self:getChild("waitNode")
	self.m_autoTipText = self:getChild("autoTipText")
	self.m_autoIcon = self:getChild("autoIcon")
	self.m_stopBtn = self:getChild("stopBtn")
	self.m_sweepMask = self:getChild("sweepMask")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowTipCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TipBubbleCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsExtraCtrl = {
	extra = 1,
	normal = 0
}
var_0_0.AutoSelectShowCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsSweepCtrl = {
	sweep = 1,
	normal = 0
}

return var_0_0
