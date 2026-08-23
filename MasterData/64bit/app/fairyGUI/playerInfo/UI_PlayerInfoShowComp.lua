local var_0_0 = {}

var_0_0.URL = "ui://1hwemy6upnxx32"

function var_0_0:__ctor()
	self.m_isShowPetController = self:getController("isShowPet")
	self.m_titleShowComp = self:getChild("titleShowComp")
	self.m_knightShowComp = self:getChild("knightShowComp")
	self.m_petShowComp = self:getChild("petShowComp")
	self.m_uniteShowComp = self:getChild("uniteShowComp")
end

var_0_0.IsShowPetCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
