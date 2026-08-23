local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgi82h5ibja"

function var_0_0:__ctor()
	self.m_chooseTypeController = self:getController("chooseType")
end

var_0_0.ChooseTypeCtrl = {
	奖励 = 0,
	次数 = 1,
	其他 = 2
}

return var_0_0
