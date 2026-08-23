local var_0_0 = {}

var_0_0.URL = "ui://671qywx2etaz2i"

function var_0_0:__ctor()
	self.m_maxController = self:getController("max")
	self.m_nameComp = self:getChild("nameComp")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_pieceProgBar = self:getChild("pieceProgBar")
	self.m_pieceAddBtn = self:getChild("pieceAddBtn")
	self.m_fragName = self:getChild("fragName")
	self.m_needNumTxt = self:getChild("needNumTxt")
	self.m_haveNumTxt = self:getChild("haveNumTxt")
	self.m_touchRect = self:getChild("touchRect")
	self.m_fragGroup = self:getChild("fragGroup")
end

return var_0_0
