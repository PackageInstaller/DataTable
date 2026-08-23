local var_0_0 = {}

var_0_0.URL = "ui://h35b870bpozw1j"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_fullController = self:getController("full")
	self.m_showBtnStateController = self:getController("showBtnState")
	self.m_isShowBtnController = self:getController("isShowBtn")
	self.m_bg = self:getChild("bg")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_guildName = self:getChild("guildName")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_forceTxt = self:getChild("forceTxt")
	self.m_memberSize = self:getChild("memberSize")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_clickLoader = self:getChild("clickLoader")
	self.m_integrationBtn = self:getChild("integrationBtn")
end

return var_0_0
