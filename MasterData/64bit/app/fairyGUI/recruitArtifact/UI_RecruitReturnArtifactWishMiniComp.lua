local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8diqtt12uytqh"

function var_0_0:__ctor()
	self.m_isSelectedController = self:getController("isSelected")
	self.m_wishIcon = self:getChild("wishIcon")
end

var_0_0.IsSelectedCtrl = {
	selected = 1,
	normal = 0
}

return var_0_0
