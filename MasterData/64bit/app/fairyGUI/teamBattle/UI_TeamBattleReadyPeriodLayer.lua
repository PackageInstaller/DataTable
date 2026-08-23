local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lpd6bw"

function var_0_0:__ctor()
	self.m_teamStateController = self:getController("teamState")
	self.m_previewComp = self:getChild("previewComp")
	self.m_preBg = self:getChild("preBg")
	self.m_preBtn = self:getChild("preBtn")
	self.m_nextBg = self:getChild("nextBg")
	self.m_nextBtn = self:getChild("nextBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_joinBtn = self:getChild("joinBtn")
	self.m_createBtn = self:getChild("createBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.TeamStateCtrl = {
	openState = 2,
	waitState = 1,
	none = 0
}

return var_0_0
