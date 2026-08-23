local var_0_0 = {}

var_0_0.URL = "ui://npkz19up10q3u15"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isNominateController = self:getController("isNominate")
	self.m_placeHolder = self:getChild("placeHolder")
	self.m_assistantSpine = self:getChild("assistantSpine")
	self.m_groupList = self:getChild("groupList")
	self.m_runBanner = self:getChild("runBanner")
	self.m_knightList = self:getChild("knightList")
	self.m_nominateBtn = self:getChild("nominateBtn")
	self.m_skinComp = self:getChild("skinComp")
	self.m_changePosBtn = self:getChild("changePosBtn")
	self.m_changeBgBtn = self:getChild("changeBgBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsNominateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
