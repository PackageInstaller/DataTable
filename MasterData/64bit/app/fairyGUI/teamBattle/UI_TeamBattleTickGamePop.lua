local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lueup5l"

function var_0_0:__ctor()
	self.m_selectTagController = self:getController("selectTag")
	self.m_gameIcon = self:getChild("gameIcon")
	self.m_eventNameTxt = self:getChild("eventNameTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.SelectTagCtrl = {
	page2 = 0,
	page1 = 1,
	page0 = 2
}

return var_0_0
