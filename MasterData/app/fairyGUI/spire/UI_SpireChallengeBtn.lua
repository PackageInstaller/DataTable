local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1j"

function var_0_0:__ctor()
	self.m_isBossController = self:getController("isBoss")
end

var_0_0.IsBossCtrl = {
	boss = 1,
	normal = 0
}

return var_0_0
