local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm3u"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_diffLoader = self:getChild("diffLoader")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_killerTxt = self:getChild("killerTxt")
	self.m_deadTxt = self:getChild("deadTxt")
end

var_0_0.IsDeadCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
