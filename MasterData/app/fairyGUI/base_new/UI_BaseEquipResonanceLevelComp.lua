local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepfc69ag"

function var_0_0:__ctor()
	self.m_levelController = self:getController("level")
	self.m_icon = self:getChild("icon")
end

var_0_0.LevelCtrl = {
	page2 = 2,
	page8 = 8,
	page1 = 1,
	page9 = 9,
	page0 = 0,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3
}

return var_0_0
