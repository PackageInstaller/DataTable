local var_0_0 = {}

var_0_0.URL = "ui://npkz19upu6h8u"

function var_0_0:__ctor()
	self.m_sceneList = self:getChild("sceneList")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_quitBtn = self:getChild("quitBtn")
	self.m_inTransition = self:getTransition("in")
	self.m_outTransition = self:getTransition("out")
end

return var_0_0
