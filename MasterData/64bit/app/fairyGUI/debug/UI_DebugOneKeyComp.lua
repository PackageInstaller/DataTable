local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yq8o24d"

function var_0_0:__ctor()
	self.m_dungeonTypeController = self:getController("dungeonType")
	self.m_tabList = self:getChild("tabList")
	self.m_mainDungeonComp = self:getChild("mainDungeonComp")
	self.m_towerDungeonComp = self:getChild("towerDungeonComp")
end

var_0_0.DungeonTypeCtrl = {
	autoDaily = 4,
	tower = 1,
	main = 0,
	oneKeyCenter = 6,
	robot = 8,
	wush = 7,
	strom = 5
}

return var_0_0
