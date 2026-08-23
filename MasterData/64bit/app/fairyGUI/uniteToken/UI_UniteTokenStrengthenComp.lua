local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxscpe3g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_specialController = self:getController("special")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_maxLevelTxt = self:getChild("maxLevelTxt")
	self.m_strengDescComp1 = self:getChild("strengDescComp1")
	self.m_strengDescComp2 = self:getChild("strengDescComp2")
	self.m_strengDescComp3 = self:getChild("strengDescComp3")
	self.m_strengDescComp4 = self:getChild("strengDescComp4")
	self.m_touchPanel = self:getChild("touchPanel")
	self.m_levelTipsBtn = self:getChild("levelTipsBtn")
	self.m_talentNameTxt = self:getChild("talentNameTxt")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_starComp = self:getChild("starComp")
	self.m_costComp = self:getChild("costComp")
	self.m_oneCost = self:getChild("oneCost")
	self.m_costComp2 = self:getChild("costComp2")
	self.m_costComp1 = self:getChild("costComp1")
	self.m_towCost = self:getChild("towCost")
	self.m_strengthABtn = self:getChild("strengthABtn")
	self.m_strengthTBtn = self:getChild("strengthTBtn")
	self.m_strengthOBtn = self:getChild("strengthOBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SpecialCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
