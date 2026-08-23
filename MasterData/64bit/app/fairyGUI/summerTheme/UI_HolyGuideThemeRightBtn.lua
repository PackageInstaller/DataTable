local var_0_0 = {}

var_0_0.URL = "ui://99hn3059bn6fkk30t"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_englishTitle = self:getChild("englishTitle")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	结束 = 2,
	开启 = 1,
	未开启 = 0
}

return var_0_0
