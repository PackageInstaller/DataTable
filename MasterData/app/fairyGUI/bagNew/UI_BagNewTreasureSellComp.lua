local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrw0zr5r"

function var_0_0:__ctor()
	self.m_isEquipController = self:getController("isEquip")
	self.m_comIcon = self:getChild("comIcon")
end

var_0_0.IsEquipCtrl = {
	碎片 = 0,
	装备 = 1
}

return var_0_0
