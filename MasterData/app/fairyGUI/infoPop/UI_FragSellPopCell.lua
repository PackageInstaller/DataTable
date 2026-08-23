local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnklzqgic2j"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_isEquipController = self:getController("isEquip")
	self.m_comIcon = self:getChild("comIcon")
end

var_0_0.ButtonCtrl = {
	down = 1,
	up = 0
}
var_0_0.IsEquipCtrl = {
	碎片 = 0,
	装备 = 1
}

return var_0_0
