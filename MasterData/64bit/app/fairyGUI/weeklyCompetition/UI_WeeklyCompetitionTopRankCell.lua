local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34ou53xr"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_bg = self:getChild("bg")
	self.m_effFirst = self:getChild("effFirst")
	self.m_iconComp = self:getChild("iconComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
