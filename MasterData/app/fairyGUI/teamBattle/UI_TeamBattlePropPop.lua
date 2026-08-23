local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lulde3v"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bagList = self:getChild("bagList")
	self.m_picBgLoader = self:getChild("picBgLoader")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_haveTxt = self:getChild("haveTxt")
	self.m_decComp = self:getChild("decComp")
	self.m_content = self:getChild("content")
end

return var_0_0
