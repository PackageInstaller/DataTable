local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ol4md9rrr6"

function var_0_0:__ctor()
	self.m_isShowLeftController = self:getController("isShowLeft")
	self.m_isShowRightController = self:getController("isShowRight")
	self.m_knightsComp = self:getChild("knightsComp")
	self.m_tabList = self:getChild("tabList")
	self.m_leftBottomComp = self:getChild("leftBottomComp")
	self.m_fightValuePreText = self:getChild("fightValuePreText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_levelText = self:getChild("levelText")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowLeftCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowRightCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
