local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obldv76"

function var_0_0:__ctor()
	self.m_numController = self:getController("num")
	self.m_haveBgController = self:getController("haveBg")
	self.m_numTxt = self:getChild("numTxt")
	self.m_headComp = self:getChild("headComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_dmgTxt = self:getChild("dmgTxt")
end

var_0_0.NumCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.HaveBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
