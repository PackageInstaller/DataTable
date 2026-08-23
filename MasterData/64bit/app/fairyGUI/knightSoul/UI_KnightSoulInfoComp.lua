local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ul9lw73l"

function var_0_0:__ctor()
	self.m_bgDiLoader = self:getChild("bgDiLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_picBgLoader = self:getChild("picBgLoader")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_haveTxt = self:getChild("haveTxt")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_openTransition = self:getTransition("open")
end

return var_0_0
