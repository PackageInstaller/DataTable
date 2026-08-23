local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkofajmibzk"

function var_0_0:__ctor()
	self.m_isFirstController = self:getController("isFirst")
	self.m_iconComp = self:getChild("iconComp")
	self.m_title = self:getChild("title")
end

return var_0_0
