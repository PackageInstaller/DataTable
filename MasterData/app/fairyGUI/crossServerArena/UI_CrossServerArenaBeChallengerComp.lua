local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis1u"

function var_0_0:__ctor()
	self.m_rankingController = self:getController("ranking")
	self.m_halfPhotoComp = self:getChild("halfPhotoComp")
	self.m_rankingBgLoader = self:getChild("rankingBgLoader")
	self.m_rankingTxt = self:getChild("rankingTxt")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_powerNumTxt = self:getChild("powerNumTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
end

var_0_0.RankingCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
