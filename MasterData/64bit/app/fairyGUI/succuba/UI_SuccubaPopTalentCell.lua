local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3mt"

function var_0_0:__ctor()
	self.m_activeController = self:getController("active")
	self.m_nameText = self:getChild("nameText")
	self.m_unLockTxt = self:getChild("unLockTxt")
	self.m_descText = self:getChild("descText")
end

return var_0_0
