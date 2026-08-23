local var_0_0 = {}

var_0_0.URL = "ui://0vs2yqm8tnf217"

function var_0_0:__ctor()
	self.m_wishStateController = self:getController("wishState")
	self.m_knightPic = self:getChild("knightPic")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_tipText = self:getChild("tipText")
end

return var_0_0
