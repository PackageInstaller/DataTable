local var_0_0 = {}

var_0_0.URL = "ui://ij78oondl332dn"

function var_0_0:__ctor()
	self.m_isMainController = self:getController("isMain")
	self.m_showEquipCompController = self:getController("showEquipComp")
	self.m_showKnightTissueController = self:getController("showKnightTissue")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_groupBtn = self:getChild("groupBtn")
	self.m_level = self:getChild("level")
	self.m_maxLevel = self:getChild("maxLevel")
	self.m_skillTitle = self:getChild("skillTitle")
	self.m_skillsComp = self:getChild("skillsComp")
	self.m_attrTitle = self:getChild("attrTitle")
	self.m_equipComp = self:getChild("equipComp")
	self.m_assctTitle = self:getChild("assctTitle")
	self.m_assctComp = self:getChild("assctComp")
	self.m_changeKnightBtn = self:getChild("changeKnightBtn")
	self.m_changeDressBtn = self:getChild("changeDressBtn")
	self.m_knightTissueBtn = self:getChild("knightTissueBtn")
	self.m_developBtn = self:getChild("developBtn")
	self.m_artifactBtn = self:getChild("artifactBtn")
	self.m_haloComp = self:getChild("haloComp")
	self.m_urGuide = self:getChild("urGuide")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_enter_cutTransition = self:getTransition("enter_cut")
end

var_0_0.IsMainCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowEquipCompCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowKnightTissueCtrl = {
	不显示 = 0,
	显示 = 1
}

return var_0_0
