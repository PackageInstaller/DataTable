local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7mp5v9m"

function var_0_0:__ctor()
	self.m_isOtherController = self:getController("isOther")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityImg = self:getChild("qualityImg")
	self.m_attrComp = self:getChild("attrComp")
	self.m_masterBtn = self:getChild("masterBtn")
	self.m_unloadBtn = self:getChild("unloadBtn")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_devBtn = self:getChild("devBtn")
	self.m_devRedPointComp = self:getChild("devRedPointComp")
	self.m_oneKeyEquipStrengthenBtn = self:getChild("oneKeyEquipStrengthenBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsOtherCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
