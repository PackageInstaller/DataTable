local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrek02kk318"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_adLv = self:getChild("adLv")
	self.m_adAttr = self:getChild("adAttr")
	self.m_adAttrGroup = self:getChild("adAttrGroup")
	self.m_rfLv = self:getChild("rfLv")
	self.m_rfAttr1 = self:getChild("rfAttr1")
	self.m_rfAttr2 = self:getChild("rfAttr2")
	self.m_rfNotUpgrade = self:getChild("rfNotUpgrade")
	self.m_rfAttrGroup = self:getChild("rfAttrGroup")
	self.m_magicalLv = self:getChild("magicalLv")
	self.m_magicalAttrList = self:getChild("magicalAttrList")
	self.m_magicalNotUpgrade = self:getChild("magicalNotUpgrade")
	self.m_magicalAttrGroup = self:getChild("magicalAttrGroup")
	self.m_resonanceAttrList = self:getChild("resonanceAttrList")
	self.m_resonanceNotUpgrade = self:getChild("resonanceNotUpgrade")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_resonLevelTxt = self:getChild("resonLevelTxt")
	self.m_resonanceAttrGroup = self:getChild("resonanceAttrGroup")
	self.m_glyNotUpgrade = self:getChild("glyNotUpgrade")
	self.m_glyLevel = self:getChild("glyLevel")
	self.m_glyAttr1 = self:getChild("glyAttr1")
	self.m_glyAttr2 = self:getChild("glyAttr2")
	self.m_glyAttrGroup = self:getChild("glyAttrGroup")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
