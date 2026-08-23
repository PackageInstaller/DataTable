local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eohqs4p"

function var_0_0:__ctor()
	self.m_userIcon = self:getChild("userIcon")
	self.m_userNameTxt = self:getChild("userNameTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
