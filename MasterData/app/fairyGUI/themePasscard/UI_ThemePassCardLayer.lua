local var_0_0 = {}

var_0_0.URL = "ui://tpt7g5qxpadud"

function var_0_0:__ctor()
	self.m_isEasyController = self:getController("isEasy")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_listBgLoader = self:getChild("listBgLoader")
	self.m_rewardList = self:getChild("rewardList")
	self.m_easyGetBtn = self:getChild("easyGetBtn")
	self.m_easyBtnText = self:getChild("easyBtnText")
	self.m_textLoader = self:getChild("textLoader")
	self.m_timeBgHolder = self:getChild("timeBgHolder")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_changePhaseList = self:getChild("changePhaseList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsEasyCtrl = {
	easy = 1,
	normal = 0
}

return var_0_0
