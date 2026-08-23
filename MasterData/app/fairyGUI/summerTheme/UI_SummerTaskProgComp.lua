local var_0_0 = {}

var_0_0.URL = "ui://99hn30599mdbd"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_loopTransition = self:getTransition("loop")
end

var_0_0.TypeCtrl = {
	荷鲁斯活动 = 2,
	格里芬活动 = 1,
	蔚蓝假日 = 0
}

return var_0_0
