local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8edx2x4r"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isMySelfController = self:getController("isMySelf")
	self.m_userIcon = self:getChild("userIcon")
	self.m_addValTxt = self:getChild("addValTxt")
	self.m_userNameTxt = self:getChild("userNameTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_rebornTimeTxt = self:getChild("rebornTimeTxt")
	self.m_lineUpLoader = self:getChild("lineUpLoader")
end

return var_0_0
