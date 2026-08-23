local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9tvpg68dw"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_title2 = self:getChild("title2")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
