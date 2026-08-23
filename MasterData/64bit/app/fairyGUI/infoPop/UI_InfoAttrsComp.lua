local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnp0x6gibxe"

function var_0_0:__ctor()
	self.m_descTypeController = self:getController("descType")
	self.m_isHasAttrController = self:getController("isHasAttr")
	self.m_isResonanceController = self:getController("isResonance")
	self.m_titleComp = self:getChild("titleComp")
	self.m_attsList = self:getChild("attsList")
	self.m_emptyText = self:getChild("emptyText")
	self.m_attrsLevelDescTxt = self:getChild("attrsLevelDescTxt")
	self.m_glyIcon = self:getChild("glyIcon")
	self.m_infoBtn = self:getChild("infoBtn")
end

var_0_0.DescTypeCtrl = {
	雕纹 = 1,
	普通 = 0
}
var_0_0.IsHasAttrCtrl = {
	有 = 0,
	无 = 1
}
var_0_0.IsResonanceCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
