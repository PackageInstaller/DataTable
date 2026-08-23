local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulamy9n"

function var_0_0:__ctor()
	self.m_isOwnController = self:getController("isOwn")
	self.m_typeController = self:getController("type")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_knightCutComp = self:getChild("knightCutComp")
	self.m_qualityFg = self:getChild("qualityFg")
	self.m_eff = self:getChild("eff")
	self.m_group = self:getChild("group")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_act = self:getChild("act")
	self.m_activateTransition = self:getTransition("activate")
end

return var_0_0
