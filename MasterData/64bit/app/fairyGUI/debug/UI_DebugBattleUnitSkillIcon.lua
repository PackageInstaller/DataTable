local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ym1jz5ibiv"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_addPic = self:getChild("addPic")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
