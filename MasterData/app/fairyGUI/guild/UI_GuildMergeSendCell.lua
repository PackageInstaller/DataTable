local var_0_0 = {}

var_0_0.URL = "ui://h35b870bbpqe5p"

function var_0_0:__ctor()
	self.m_showBgController = self:getController("showBg")
	self.m_isOnlineController = self:getController("isOnline")
	self.m_showViewController = self:getController("showView")
	self.m_userComp = self:getChild("userComp")
	self.m_userName = self:getChild("userName")
	self.m_level = self:getChild("level")
	self.m_job = self:getChild("job")
	self.m_fightValue = self:getChild("fightValue")
	self.m_totalNum = self:getChild("totalNum")
	self.m_dayNum = self:getChild("dayNum")
	self.m_onlineState = self:getChild("onlineState")
	self.m_selectBtn = self:getChild("selectBtn")
end

return var_0_0
