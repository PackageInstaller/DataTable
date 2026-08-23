local var_0_0 = {}

var_0_0.URL = "ui://99hn3059osz11spem3d"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_getTransition = self:getTransition("get")
	self.m_goTransition = self:getTransition("go")
end

var_0_0.StateCtrl = {
	任务未达到开启时间 = 6,
	已领取 = 5,
	可领取 = 2,
	前往 = 1,
	未开启 = 0
}

return var_0_0
