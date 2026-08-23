local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bngn1tlgichl"

function var_0_0:__ctor()
	self.m_hasPrivilegeController = self:getController("hasPrivilege")
	self.m_iconComp = self:getChild("iconComp")
	self.m_privilegeTitleText = self:getChild("privilegeTitleText")
	self.m_privilegeDesText = self:getChild("privilegeDesText")
	self.m_suitNameText = self:getChild("suitNameText")
	self.m_smallIcon1 = self:getChild("smallIcon1")
	self.m_smallIcon2 = self:getChild("smallIcon2")
	self.m_smallIcon3 = self:getChild("smallIcon3")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasPrivilegeCtrl = {
	normal = 0,
	privilege = 1
}

return var_0_0
