local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2riln6v"

function var_0_0:__ctor()
	self.m_sideTypeController = self:getController("sideType")
	self.m_weaponController = self:getController("weapon")
	self.m_elementalController = self:getController("elemental")
	self.m_effBG = self:getChild("effBG")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_skillNameText1 = self:getChild("skillNameText1")
	self.m_elementalIcon1 = self:getChild("elementalIcon1")
	self.m_effLightingdown = self:getChild("effLightingdown")
	self.m_weaponSkilllNameText1 = self:getChild("weaponSkilllNameText1")
	self.m_elementalIcon2 = self:getChild("elementalIcon2")
	self.m_effLightingup = self:getChild("effLightingup")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_effRoleSkill = self:getChild("effRoleSkill")
	self.m_effArmsDi = self:getChild("effArmsDi")
	self.m_artifactComp = self:getChild("artifactComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enterBTransition = self:getTransition("enterB")
end

var_0_0.SideTypeCtrl = {
	right = 1,
	left = 0
}
var_0_0.WeaponCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ElementalCtrl = {
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
