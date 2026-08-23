local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2sb3wst15vt"

function var_0_0:__ctor()
	self.m_hideTitleController = self:getController("hideTitle")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.HideTitleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
