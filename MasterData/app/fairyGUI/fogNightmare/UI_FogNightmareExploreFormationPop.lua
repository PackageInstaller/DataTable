local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ojop9fy"

function var_0_0:__ctor()
	self.m_hideBtnController = self:getController("hideBtn")
	self.m_showTipsController = self:getController("showTips")
	self.m_isShowLeftController = self:getController("isShowLeft")
	self.m_isShowRightController = self:getController("isShowRight")
	self.m_isShowAutoController = self:getController("isShowAuto")
	self.m_knightsComp = self:getChild("knightsComp")
	self.m_leftBottomComp = self:getChild("leftBottomComp")
	self.m_tabList = self:getChild("tabList")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_tips = self:getChild("tips")
	self.m_quickSwitchBtn = self:getChild("quickSwitchBtn")
	self.m_fightValuePreText = self:getChild("fightValuePreText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_tipsClickNode = self:getChild("tipsClickNode")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_autoBtn = self:getChild("autoBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HideBtnCtrl = {
	hide = 1,
	show = 0
}
var_0_0.ShowTipsCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowLeftCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowRightCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowAutoCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
