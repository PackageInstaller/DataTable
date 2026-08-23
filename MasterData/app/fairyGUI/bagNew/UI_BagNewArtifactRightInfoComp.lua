local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qritsp63"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_infoBaseComp = self:getChild("infoBaseComp")
	self.m_relatedKnight = self:getChild("relatedKnight")
	self.m_starComp = self:getChild("starComp")
	self.m_enhanceLable = self:getChild("enhanceLable")
	self.m_adLv = self:getChild("adLv")
	self.m_adAttr1 = self:getChild("adAttr1")
	self.m_adAttr2 = self:getChild("adAttr2")
	self.m_adAttr3 = self:getChild("adAttr3")
	self.m_adAttr4 = self:getChild("adAttr4")
	self.m_adAttrGroup = self:getChild("adAttrGroup")
	self.m_progNumText = self:getChild("progNumText")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_skillTitleLable = self:getChild("skillTitleLable")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_descTxt = self:getChild("descTxt")
	self.m_skillGroup = self:getChild("skillGroup")
	self.m_developBtn = self:getChild("developBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
