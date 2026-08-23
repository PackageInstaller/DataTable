local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smu7uc"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_isMyRegionController = self:getController("isMyRegion")
	self.m_allScoreTxt = self:getChild("allScoreTxt")
	self.m_allRankTxt = self:getChild("allRankTxt")
end

return var_0_0
