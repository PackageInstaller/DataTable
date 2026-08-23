local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivldwnfrey"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillName = self:getChild("skillName")
	self.m_skillDesc = self:getChild("skillDesc")
end

var_0_0.IsMaxCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
