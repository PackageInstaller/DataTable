local var_0_0 = {}

var_0_0.URL = "ui://99hn3059l5qq1kk46g"

function var_0_0:__ctor()
	self.m_isGameController = self:getController("isGame")
	self.m_pauseGameController = self:getController("pauseGame")
	self.m_chessboardComp = self:getChild("chessboardComp")
	self.m_gemEffDad = self:getChild("gemEffDad")
	self.m_infoComp = self:getChild("infoComp")
	self.m_inGameComp = self:getChild("inGameComp")
	self.m_pauseComp = self:getChild("pauseComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
