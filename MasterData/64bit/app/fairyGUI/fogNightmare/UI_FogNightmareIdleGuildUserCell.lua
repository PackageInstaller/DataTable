local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88o6jgp9rru0"

function var_0_0:__ctor()
	self.m_isFirstPassController = self:getController("isFirstPass")
	self.m_userComp = self:getChild("userComp")
end

var_0_0.IsFirstPassCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
