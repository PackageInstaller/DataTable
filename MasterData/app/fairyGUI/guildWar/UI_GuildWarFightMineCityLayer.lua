local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mopb91u"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_stageController = self:getController("stage")
	self.m_contentComp = self:getChild("contentComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_cityNameTxt = self:getChild("cityNameTxt")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_quickOpeBtn = self:getChild("quickOpeBtn")
	self.m_playTimeComp = self:getChild("playTimeComp")
	self.m_stageComp = self:getChild("stageComp")
	self.m_chatComp = self:getChild("chatComp")
	self.m_arrowImg = self:getChild("arrowImg")
	self.m_arrowImg2 = self:getChild("arrowImg2")
	self.m_enterTransition = self:getTransition("enter")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StageCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
