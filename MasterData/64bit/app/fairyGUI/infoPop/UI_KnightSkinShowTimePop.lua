local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnda8fgibyn"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_hideUIController = self:getController("hideUI")
	self.m_spineComp = self:getChild("spineComp")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_skinTxt = self:getChild("skinTxt")
	self.m_knightTxt = self:getChild("knightTxt")
	self.m_nameGroup = self:getChild("nameGroup")
end

var_0_0.IsNewCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HideUICtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
