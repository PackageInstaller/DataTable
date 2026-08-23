local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88o6jgp9rrty"

function var_0_0:__ctor()
	self.m_isFirstPassController = self:getController("isFirstPass")
	self.m_userIcon = self:getChild("userIcon")
	self.m_userNameText = self:getChild("userNameText")
	self.m_levelText = self:getChild("levelText")
end

var_0_0.IsFirstPassCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
