local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7y815al5ibmb"

function var_0_0:__ctor()
	self.m_isDebugController = self:getController("isDebug")
	self.m_bg = self:getChild("bg")
	self.m_meshRoot = self:getChild("meshRoot")
	self.m_origin = self:getChild("origin")
	self.m_lineRoot = self:getChild("lineRoot")
	self.m_randomPosBtn = self:getChild("randomPosBtn")
	self.m_posInput = self:getChild("posInput")
	self.m_randomObstacleBtn = self:getChild("randomObstacleBtn")
	self.m_obstacleInput = self:getChild("obstacleInput")
	self.m_startBtn = self:getChild("startBtn")
	self.m_showLinesBtn = self:getChild("showLinesBtn")
	self.m_logText = self:getChild("logText")
	self.m_isDebugShowCheck = self:getChild("isDebugShowCheck")
end

var_0_0.IsDebugCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
