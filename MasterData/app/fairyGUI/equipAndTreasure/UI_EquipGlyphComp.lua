local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7qdh73s"

function var_0_0:__ctor()
	self.m_glyStateController = self:getController("glyState")
	self.m_haveEquipController = self:getController("haveEquip")
	self.m_textColorController = self:getController("textColor")
	self.m_strengDescComp = self:getChild("strengDescComp")
	self.m_glyFirstIcon = self:getChild("glyFirstIcon")
	self.m_glyNextIcon = self:getChild("glyNextIcon")
	self.m_attrsComp = self:getChild("attrsComp")
	self.m_attrGroup = self:getChild("attrGroup")
	self.m_sureBtn = self:getChild("sureBtn")
	self.m_btnTitle = self:getChild("btnTitle")
	self.m_costBg = self:getChild("costBg")
	self.m_costIcon = self:getChild("costIcon")
	self.m_ownMoneyText = self:getChild("ownMoneyText")
	self.m_costMoneyText = self:getChild("costMoneyText")
	self.m_btnGroup = self:getChild("btnGroup")
	self.m_equipInfoNode = self:getChild("equipInfoNode")
	self.m_noEquipTitle = self:getChild("noEquipTitle")
	self.m_infoTouchLayer = self:getChild("infoTouchLayer")
end

var_0_0.GlyStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HaveEquipCtrl = {
	有装备 = 1,
	没装备 = 0
}
var_0_0.TextColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
