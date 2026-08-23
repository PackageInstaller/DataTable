local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mtk7x5"

function var_0_0:__ctor()
	self.m_fightStageTypeController = self:getController("fightStageType")
	self.m_bgComp = self:getChild("bgComp")
	self.m_effectLeftNode = self:getChild("effectLeftNode")
	self.m_effectRightNode = self:getChild("effectRightNode")
	self.m_titleComp = self:getChild("titleComp")
	self.m_warLeftRankComp = self:getChild("warLeftRankComp")
	self.m_fightProgressComp = self:getChild("fightProgressComp")
	self.m_chatComp = self:getChild("chatComp")
	self.m_scheduleComp = self:getChild("scheduleComp")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_cityBtn_1 = self:getChild("cityBtn_1")
	self.m_cityBtn_2 = self:getChild("cityBtn_2")
	self.m_myGuildCityBtn = self:getChild("myGuildCityBtn")
	self.m_myGuildCityComp = self:getChild("myGuildCityComp")
	self.m_cityComp_1 = self:getChild("cityComp_1")
	self.m_cityComp_2 = self:getChild("cityComp_2")
	self.m_warAwardBtn = self:getChild("warAwardBtn")
	self.m_seasonAwardBtn = self:getChild("seasonAwardBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_fightingCDTxt = self:getChild("fightingCDTxt")
	self.m_deployBtn = self:getChild("deployBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.FightStageTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
