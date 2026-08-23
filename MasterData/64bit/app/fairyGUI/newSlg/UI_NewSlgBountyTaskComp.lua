local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9rvr168mr"

function var_0_0:__ctor()
	self.m_armyController = self:getController("army")
	self.m_List_tasks = self:getChild("List_tasks")
end

var_0_0.ArmyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
