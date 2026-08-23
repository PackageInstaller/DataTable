local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9fq3n68fi"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_List_item = self:getChild("List_item")
end

var_0_0.StateCtrl = {
	down = 1,
	up = 0
}

return var_0_0
