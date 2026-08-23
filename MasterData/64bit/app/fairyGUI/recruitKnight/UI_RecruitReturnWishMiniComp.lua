local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ytne3lgic70"

function var_0_0:__ctor()
	self.m_isSelectedController = self:getController("isSelected")
	self.m_wishIcon = self:getChild("wishIcon")
	self.m_switchBtn = self:getChild("switchBtn")
end

var_0_0.IsSelectedCtrl = {
	normal = 0,
	selected = 1
}

return var_0_0
