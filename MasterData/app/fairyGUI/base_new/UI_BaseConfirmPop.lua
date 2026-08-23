local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepho93ibpj"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showCheckController = self:getController("showCheck")
	self.m_titleTypeController = self:getController("titleType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_descText = self:getChild("descText")
	self.m_descText1 = self:getChild("descText1")
	self.m_ownFreeGoldTxt = self:getChild("ownFreeGoldTxt")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_midNode = self:getChild("midNode")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_costComp = self:getChild("costComp")
	self.m_content = self:getChild("content")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowCheckCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TitleTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
