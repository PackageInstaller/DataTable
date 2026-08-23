local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25j8ao4c"

function var_0_0:__ctor()
	self.m_selectTagController = self:getController("selectTag")
	self.m_eventNameTxt = self:getChild("eventNameTxt")
	self.m_eventNameTxt2 = self:getChild("eventNameTxt2")
	self.m_lastTimeTxt = self:getChild("lastTimeTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.SelectTagCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
