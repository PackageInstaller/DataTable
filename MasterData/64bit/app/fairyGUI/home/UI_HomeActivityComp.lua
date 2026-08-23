local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibhm"

function var_0_0:__ctor()
	self.m_isShowMainQuestController = self:getController("isShowMainQuest")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_hotSaleBtn = self:getChild("hotSaleBtn")
	self.m_activityBtn = self:getChild("activityBtn")
	self.m_dailyRecruitBtn = self:getChild("dailyRecruitBtn")
	self.m_firstRechargeBtn = self:getChild("firstRechargeBtn")
	self.m_phoenixGiftBtn = self:getChild("phoenixGiftBtn")
	self.m_activityList = self:getChild("activityList")
end

var_0_0.IsShowMainQuestCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
