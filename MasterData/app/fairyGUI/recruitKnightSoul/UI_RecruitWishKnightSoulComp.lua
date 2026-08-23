local var_0_0 = {}

var_0_0.URL = "ui://cw1w6t2bwczdi"

function var_0_0:__ctor()
	self.m_wishStateController = self:getController("wishState")
	self.m_colorController = self:getController("color")
	self.m_memberPic = self:getChild("memberPic")
	self.m_tipText = self:getChild("tipText")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameText = self:getChild("nameText")
end

return var_0_0
