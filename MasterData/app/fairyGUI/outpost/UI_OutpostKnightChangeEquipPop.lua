local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5kq1l7f1"

function var_0_0:__ctor()
	self.m_ieEmptyController = self:getController("ieEmpty")
	self.m_hasEquipController = self:getController("hasEquip")
	self.m_showTabController = self:getController("showTab")
	self.m_tabCtrlController = self:getController("tabCtrl")
	self.m_popPanel = self:getChild("popPanel")
	self.m_coinComp = self:getChild("coinComp")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_title = self:getChild("title")
	self.m_equipList = self:getChild("equipList")
	self.m_equipComp = self:getChild("equipComp")
	self.m_attrNameTxt = self:getChild("attrNameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_defValueTxt = self:getChild("defValueTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_attrList = self:getChild("attrList")
	self.m_placeLoader = self:getChild("placeLoader")
	self.m_content = self:getChild("content")
end

return var_0_0
