local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2syz76l"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_effUniteBg = self:getChild("effUniteBg")
	self.m_iconBg = self:getChild("iconBg")
	self.m_icon = self:getChild("icon")
	self.m_iconSpineDad = self:getChild("iconSpineDad")
	self.m_nameText1 = self:getChild("nameText1")
	self.m_effUnite = self:getChild("effUnite")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.QualityCtrl = {
	page0 = 0,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1
}

return var_0_0
