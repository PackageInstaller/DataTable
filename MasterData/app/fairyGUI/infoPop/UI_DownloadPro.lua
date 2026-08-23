local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bn7t9d1v5dssa"

function var_0_0:__ctor()
	self.m_txtPosController = self:getController("txtPos")
	self.m_proImg = self:getChild("proImg")
end

var_0_0.TxtPosCtrl = {
	top = 0,
	bottom = 1
}

return var_0_0
