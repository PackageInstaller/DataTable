local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46pdhas"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_title = self:getChild("title")
	self.m_iconGroup = self:getChild("iconGroup")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_tipQualityIcon = self:getChild("tipQualityIcon")
	self.m_exDescTxt = self:getChild("exDescTxt")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
