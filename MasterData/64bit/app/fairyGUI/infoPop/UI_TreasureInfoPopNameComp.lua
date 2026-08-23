local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bns36ugibxs"

function var_0_0:__ctor()
	self.m_isOwnController = self:getController("isOwn")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_pieceProgBar = self:getChild("pieceProgBar")
	self.m_pieceAddBtn = self:getChild("pieceAddBtn")
	self.m_fragName = self:getChild("fragName")
	self.m_needNumTxt = self:getChild("needNumTxt")
	self.m_haveNumTxt = self:getChild("haveNumTxt")
	self.m_fragGroup = self:getChild("fragGroup")
end

var_0_0.IsOwnCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
