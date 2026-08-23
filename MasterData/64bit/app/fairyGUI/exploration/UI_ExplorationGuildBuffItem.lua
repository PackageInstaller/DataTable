local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25egt161"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_buffComp = self:getChild("buffComp")
	self.m_descText = self:getChild("descText")
	self.m_playerBtn = self:getChild("playerBtn")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_activeText = self:getChild("activeText")
	self.m_activeGroup = self:getChild("activeGroup")
	self.m_unactiveText = self:getChild("unactiveText")
	self.m_unactiveGroup = self:getChild("unactiveGroup")
	self.m_gotoBtn = self:getChild("gotoBtn")
end

var_0_0.IsActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
