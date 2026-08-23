local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9rvr168mr"

function var_0_0:__ctor()
	self.m_armyController = self:getController("army")
	self.m_List_tasks = self:getChild("List_tasks")
end

var_0_0.ArmyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
