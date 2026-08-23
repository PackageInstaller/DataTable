local var_0_0 = {}

var_0_0.URL = "ui://ij78oondpj8pgx"

function var_0_0:__ctor()
	self.m_showEquipCompController = self:getController("showEquipComp")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_level = self:getChild("level")
	self.m_maxLevel = self:getChild("maxLevel")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_skillTitle = self:getChild("skillTitle")
	self.m_skillIcon_1 = self:getChild("skillIcon_1")
	self.m_skillIcon_2 = self:getChild("skillIcon_2")
	self.m_skillIcon_3 = self:getChild("skillIcon_3")
	self.m_attrTitle = self:getChild("attrTitle")
	self.m_equipComp = self:getChild("equipComp")
	self.m_changePetBtn = self:getChild("changePetBtn")
	self.m_developBtn = self:getChild("developBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_enter_cutTransition = self:getTransition("enter_cut")
end

var_0_0.ShowEquipCompCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
