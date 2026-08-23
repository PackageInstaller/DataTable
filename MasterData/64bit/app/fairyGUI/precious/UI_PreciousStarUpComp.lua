local var_0_0 = {}

var_0_0.URL = "ui://671qywx2c9i11l"

function var_0_0:__ctor()
	self.m_fullStarController = self:getController("fullStar")
	self.m_curStarTxt = self:getChild("curStarTxt")
	self.m_nextStarTxt = self:getChild("nextStarTxt")
	self.m_fullStarTxt = self:getChild("fullStarTxt")
	self.m_starUpAttrComp = self:getChild("starUpAttrComp")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_touchPanel = self:getChild("touchPanel")
	self.m_talentGroup = self:getChild("talentGroup")
	self.m_starUpFragComp = self:getChild("starUpFragComp")
	self.m_privilegeDescTxt = self:getChild("privilegeDescTxt")
	self.m_challageTimeTxt = self:getChild("challageTimeTxt")
	self.m_additionTxt = self:getChild("additionTxt")
	self.m_privilegeArea = self:getChild("privilegeArea")
	self.m_privilegeGroup = self:getChild("privilegeGroup")
end

return var_0_0
