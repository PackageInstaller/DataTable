local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6cfmu1kk40o"

function var_0_0:__ctor()
	self.m_inGameController = self:getController("inGame")
	self.m_pauseController = self:getController("pause")
	self.m_gameComp = self:getChild("gameComp")
	self.m_inGameComp = self:getChild("inGameComp")
	self.m_guessInfoComp = self:getChild("guessInfoComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_pauseComp = self:getChild("pauseComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.InGameCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.PauseCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
