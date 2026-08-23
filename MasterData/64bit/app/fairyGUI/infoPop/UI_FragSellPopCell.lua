local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnklzqgic2j"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_isEquipController = self:getController("isEquip")
	self.m_comIcon = self:getChild("comIcon")
end

var_0_0.ButtonCtrl = {
	up = 0,
	down = 1
}
var_0_0.IsEquipCtrl = {
	装备 = 1,
	碎片 = 0
}

return var_0_0
