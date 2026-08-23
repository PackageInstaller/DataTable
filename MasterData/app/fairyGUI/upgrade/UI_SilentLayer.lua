local var_0_0 = {}

var_0_0.URL = "ui://4kvnuk1ftj0k9"

function var_0_0:__ctor()
	self.m_isPauseController = self:getController("isPause")
	self.m_isAwardController = self:getController("isAward")
	self.m_isOsController = self:getController("isOs")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_leftGroup = self:getChild("leftGroup")
	self.m_tipText = self:getChild("tipText")
	self.m_pauseText = self:getChild("pauseText")
	self.m_progBgImg = self:getChild("progBgImg")
	self.m_progImg = self:getChild("progImg")
	self.m_pauseBtn = self:getChild("pauseBtn")
	self.m_gemGameBtn = self:getChild("gemGameBtn")
	self.m_awardPos = self:getChild("awardPos")
	self.m_downLoadTxt = self:getChild("downLoadTxt")
	self.m_preBtn = self:getChild("preBtn")
	self.m_nextBtn = self:getChild("nextBtn")
end

return var_0_0
