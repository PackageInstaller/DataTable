local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25egt14u"

function var_0_0:__ctor()
	self.m_qualityLoader1 = self:getChild("qualityLoader1")
	self.m_qualityLoader2 = self:getChild("qualityLoader2")
	self.m_qualityLoader3 = self:getChild("qualityLoader3")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descComp = self:getChild("descComp")
	self.m_flyTransition = self:getTransition("fly")
end

return var_0_0
